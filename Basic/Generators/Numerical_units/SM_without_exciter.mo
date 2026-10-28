within ;
model SM_without_exciter
  outer LEPSE.Basic.SysData sysData;

  // PQ-diagram parameter
  parameter LEPSE.Data.PQ_CapabilityTable
  pq_table = LEPSE.Data.TVV_500_2;

  parameter Real TgenOff=1000 "Time of generator's disconnection, s"
   annotation(Dialog(tab="General"));
  parameter Real dTgenOff=10 "Duration of generator's disconnection, s"
   annotation(Dialog(tab="General"));
  parameter Real Kd=0 "damping coefficient"
  annotation(Dialog(tab="Synchronous machine"));

  //------------------------------------------------------------------------------------
  parameter Real Sbaz=sysData.Sbaz "Bazic power, MWA"
  annotation(Dialog(tab="General"));
  parameter Real fbaz=sysData.fbaz "Bazic frequency, Hz"
  annotation(Dialog(tab="General"));
  parameter Real Pg=500 "Active power, MW"
  annotation(Dialog(tab="General"));
  parameter Real Qg(fixed=false) "Reactive power, MVAR";
  parameter Real Ut=20 "ARV voltage reference value, kV"
  annotation(Dialog(tab="General"));
  parameter Real Pnom=500 "Nominal maschine active power, MW"
  annotation(Dialog(tab="General"));
  parameter Real Ugnom=20 "Nominal stator voltage, kV"
  annotation(Dialog(tab="General"));
  parameter Real cosfi_nom=0.85 "Nominal maschine power coefficient, p.u."
  annotation(Dialog(tab="General"));
  parameter Real Ignom(fixed=false) "stator nomunal current, kA";

   // Limitation variables
  Real Qmax "Current limit of overexcitation, MVar";
  Real Qmin "Current limit of underexcitation, MVar";

  // Auxiliary variables for the interpolator (Modelica syntax requirement)
  Real P_clipped_max "Sliced P for Qmax interpolation";
  Real P_clipped_min "Sliced P for Qmin interpolation";
  Integer i_max_dummy;
  Integer i_min_dummy;

  //------------------------------------------------------------------------------------
  parameter Real Xd_p=1.869 "D-axis synchronous reactance, p.u."
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Xq_p=1.869 "Q-axis synchronous reactance, p.u."
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Xs_p=0.194 "Leakage reactance of stator winding, p.u."
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real X1d_p=0.3016 "D-axis transient reactance, p.u."
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real X2d_p=0.2337 "D-axis subtransient reactance, p.u."
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real X2q_p=0.2337 "Q-axis subtransient reactance, p.u."
  annotation(Dialog(tab="Synchronous machine"));
  Real Rf_p "Active resistance of field winding, p.u.";
  Real R1d_p "Active resistance of d-axis damper winding, p.u.";
  Real R1q_p "Active resistance of q-axis damper winding, p.u.";
  parameter Real Tj_p=7 "Inertia coefficient, s"
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Td0=10 "D-axis transient time constant, s"
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real T2d_p=0.02 "D-axis subtransient time constant, s"
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real T2q_p=0.05 "Q-axis subtransient time constant, s"
  annotation(Dialog(tab="Synchronous machine"));

  parameter Real Sigma=0.0475 "Turbine statism coefficient, p.u."
  annotation(Dialog(tab="Turbine"));
  parameter Real TauC_up=0.8 "Time constant of servo motor while valving control, s"
  annotation(Dialog(tab="Turbine"));
  parameter Real TregOff=50 "Turbine speed regulator off-time, s"
  annotation(Dialog(tab="Turbine"));

  parameter Real TregOn=1000 "Turbine speed regulator on-time, s"
  annotation(Dialog(tab="Turbine"));
  parameter Real Mtmax=1.1 "Turbine overloading coefficient, p.u."
  annotation(Dialog(tab="Turbine"));
  parameter Real Mtmin=0 "Turbine minimum-loading coefficient, p.u."
  annotation(Dialog(tab="Turbine"));

  parameter Real Aimp=1 "Fast turbine valving control amplitude, p.u."
  annotation(Dialog(tab="Turbine"));
  parameter Real Timp=1000 "Fast turbine valving control on-time, s"
  annotation(Dialog(tab="Turbine"));
  parameter Real dTimp=0.2 "Fast turbine valving control duration, s"
  annotation(Dialog(tab="Turbine"));
  parameter Real TauC_down=5 "Time constant of servo motor after valving control end, s"
  annotation(Dialog(tab="Turbine"));

  parameter Real TkzOn=1000 "Generators dropping on-time, s"
  annotation(Dialog(tab="General"));
  parameter Real Pg_new=100 "New power of power plant, MW"
  annotation(Dialog(tab="General"));

  //------------------------------------------------------------------------------------
  Real dUtr "voltage deviation";
  Real dWu "frequency deviation";
  Real dIf "current deviation";
  Real dWf "frequency deviation";
  Real Er "exciter electromotive force";
  constant Real PI=4*atan(1) "PI-constant";
  parameter Real Wc=2*PI*fbaz "frequency of electric current fluctuations";
  parameter Real Xt=0.0 "resistance of step-up transformer and line to IB";

  // Parameters of power system elements
  constant Real Ra=0 "active resistance of generator stator winding";
  constant Real Rt=0 "active resistance of transformer";
  parameter Real EQ(fixed=false) "Auxiliaire EMF of salient-pole generator";
  parameter Real Dg(fixed=false) "Generator power angle";
  parameter Real Uq(fixed=false) "D-axis ARV voltage reference value";
  parameter Real Ud(fixed=false) "Q-axis ARV voltage reference value";
  parameter Real Id(fixed=false) "D-axis stator current value";
  parameter Real Iq(fixed=false) "Q-axis stator current value";
  parameter Real Eiq(fixed=false) "synchronous stator EMF";
  parameter Real Ir(fixed=false) "field winding current";
  parameter Real Uf(fixed=false) "field winding voltage";
  parameter Real Eq(fixed=false) "EMF of generator";
  parameter Real Er0(fixed=false) "EMF of generator initial value";
  parameter Real PsiR(fixed=false) "field winding flow coupling initial value";
  parameter Real PsiRD(fixed=false) "D-axis damper winding flow coupling initial value";
  parameter Real PsiRQ(fixed=false) "Q-axis damper winding flow coupling initial value";

  Real Uf_full "field winding voltage actual value";
  Real Xad "D-axis resistance to mutual induction";
  Real Xaq "Q-axis resistance to mutual induction";
  Real X2dt "D-axis subtransient reactance of generator and transformer";
  Real X2qt "Q-axis subtransient reactance of generator and transformer";
  Real Rs "Sum resistance of stator winding and step-up transformer";
  Real Xsf "Leakage reactance of field winding";
  Real Xs1d "D-axis leakage reactance of damping winding";
  Real Xs1q "Q-axis leakage reactance of damping winding";
  Real X1 "interim reactance в„–1";
  Real X2 "interim reactance в„–2";
  Real X3 "interim reactance в„–3";
  Real Ugen "generator full voltage actual value, kV";
  Real Igen "generator stator current value, kA";
  parameter Real Mu0(fixed=false) "Turbine rotation moment initial value";
  Real Ro;
  Real Mu "Turbine valve position / moment";
  Real Mt_pp "Turbine rotation moment actual value";
  Real Pgen "Generator active power actual value";
  Real Qgen "Generator reactive power actual value";
  Real UdG;
  Real UqG;
  Real IdG;
  Real IqG;
  input Real DeltaIJ;
  input Real Ssys "system slip";

  //------------------------------------------------------------------
  // Integrated Variables
  Real Yr "field winding flow coupling actual value";
  Real Yrd "D-axis damper winding flow coupling actual value";
  Real Yrq "Q-axis damper winding flow coupling actual value";
  Real s "generator slip";
  Real DGi "Generator power angle initial value";
  Real Me "electrical moment";
  Real Yad "D-axis flow coupling of mutual inductance";
  Real Yaq "Q-axis flow coupling of mutual inductance";
  Real iq "Q-axis generator stator winding current actual value";
  Real id "D-axis generator stator winding current actual value";
  Real ir "D-axis generator field winding current actual value";
  Real ird "D-axis generator damper winding current actual value";
  Real irq "Q-axis generator damper winding current actual value";
  Real ud "D-axis generator voltage actual value";
  Real uq "Q-axis generator voltage actual value";
  Real E11d "EMF, connected with d-axis damper winding";
  Real E11q "EMF, connected with q-axis damper winding";
  Real TauC "Time constant of servo motor actual value";
  Real MT_MAX "Turbine overloading coefficient actual value";
  Real MT_MIN "Turbine minimum-loading coefficient actual value";
  Real Xd "D-axis synchronous reactance actual value";
  Real Xq "Q-axis synchronous reactance actual value";
  Real Xs "Leakage reactance actual value";
  Real X1d "D-axis transient reactance actual value";
  Real X2d "D-axis subtransient reactance actual value";
  Real X2q "Q-axis subtransient reactance actual value";
  Real Rf "Active resistance of field winding actual value";
  Real R1d "Active resistance of d-axis damper winding actual value";
  Real R1q "Active resistance of q-axis damper winding actual value";
  Real Tj "Inertia coefficient actual value";
  Real f "frequency";
  parameter Real Ut_pu(fixed=false) "stator voltage, p.u.";
  parameter Real Pg_pu(fixed=false) "Active power, p.u.";
  parameter Real Qg_pu(fixed=false) "Reactive power, p.u.";

  LEPSE.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
      Placement(transformation(extent={{90,-10},{110,10}},
                                                         rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  LEPSE.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
      Placement(transformation(extent={{-110,-10},{-90,10}},
                                                           rotation=0),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  LEPSE.Interfaces.Signal_pin dUtr_pin annotation (
    extent=[-60,66; -40,86],
    layer="icon",
    Placement(transformation(extent={{-64,90},{-44,110}},rotation=0),
        iconTransformation(extent={{-64,90},{-44,110}})));
  LEPSE.Interfaces.Signal_pin dWu_pin annotation (
    extent=[-26,66; -6,86],
    layer="icon",
    Placement(transformation(extent={{-36,90},{-16,110}},rotation=0),
        iconTransformation(extent={{-36,90},{-16,110}})));
  LEPSE.Interfaces.Signal_pin dWf_pin annotation (
    extent=[6,66; 26,86],
    layer="icon",
    Placement(transformation(extent={{-10,90},{10,110}},
                                                       rotation=0),
        iconTransformation(extent={{-10,90},{10,110}})));
  LEPSE.Interfaces.Signal_pin dIf_pin annotation (
    extent=[40,66; 60,86],
    layer="icon",
    Placement(transformation(extent={{18,90},{38,110}},
                                                      rotation=0),
        iconTransformation(extent={{18,90},{38,110}})));
  LEPSE.Interfaces.Signal_pin Ut_pin
    annotation (Placement(transformation(extent={{46,90},{66,110}}),
        iconTransformation(extent={{46,90},{66,110}})));
  LEPSE.Interfaces.Signal_pin Er0_pin annotation (Placement(transformation(
          extent={{70,90},{90,110}}), iconTransformation(extent={{70,90},{90,
            110}})));
  LEPSE.Interfaces.Signal_pin Ugen_pin annotation (Placement(transformation(
          extent={{-90,90},{-70,110}}), iconTransformation(extent={{-90,90},{-70,
            110}})));
  LEPSE.Interfaces.Signal_pin dIg_pin annotation (Placement(transformation(
          extent={{94,90},{114,110}}), iconTransformation(extent={{94,90},{114,
            110}})));
initial equation
  // additional variables in p.u.
  Ut_pu = Ut/Ugnom;
  Pg_pu = Pg/Sbaz;
  Qg_pu = Qg/Sbaz;
  Ignom = Pnom/cosfi_nom/sqrt(3)/Ugnom;

  Pg=Pgen;
  Qg=min(Qmax, max(Qmin, Qgen));

  // equations of currents, voltages, and flux densities
  s = 0;

  EQ = sqrt((Ut_pu + ((Ra + Rt)*Pg_pu + (Xq + Xt)*Qg_pu)/Ut_pu)^2 + (((Xq + Xt)*Pg_pu - (Ra + Rt)*Qg_pu)/Ut_pu)^2);
  Dg = atan((((Xq + Xt)*Pg_pu - (Ra + Rt)*Qg_pu)/Ut_pu)/(Ut_pu + ((Ra + Rt)*Pg_pu + (Xq + Xt)*Qg_pu)/Ut_pu));

  Uq = Ut_pu*cos(Dg);
  Ud = -Ut_pu*sin(Dg);

  Id = ((Uq - EQ)*(Xq + Xt) - (Ra + Rt)*Ud)/((Ra + Rt)^2 + (Xq + Xt)^2);
  Iq = (-Ud - (Ra + Rt)*Id)/(Xq + Xt);
  Mu0 = EQ*Iq;
  Mu = Mu0;

  Eiq = Uq - Id*(Xs + Xt) + (Ra + Rt)*Iq;
  Ir = -Id + Eiq/Xad;
  Uf = Ir*Rf;
  Eq = Ir*Xad;
  Er0 = Eq;
  PsiR = Eiq + Xsf*Ir;
  PsiRQ = -Ud - Iq*(Xs + Xt) - Id*(Ra + Rt);
  PsiRD = Eiq;

  DGi = Dg;
  Yr = PsiR;
  Yrd = PsiRD;
  Yrq = PsiRQ;

equation

  // 1. EXTRAPOLATION PROTECTION (We limit Pgen to table boundaries so that math doesn't fly away)
  P_clipped_max = max(pq_table.P_max[1], min(Pgen, pq_table.P_max[end]));
  P_clipped_min = max(pq_table.P_min[1], min(Pgen, pq_table.P_min[end]));

   // 2. AUTOMATIC INTERPOLATION AT EACH CALCULATION STEP
  // The interpolate function returns a tuple (value of I, index_interval)
  (Qmax, i_max_dummy) = Modelica.Math.Vectors.interpolate(
    pq_table.P_max,
    pq_table.Qmax,
    P_clipped_max);

  (Qmin, i_min_dummy) = Modelica.Math.Vectors.interpolate(
    pq_table.P_min,
    pq_table.Qmin,
    P_clipped_min);

  //-------------Calculated parameters of system----------------
  Xad = Xd - Xs;
  Xaq = Xq - Xs;
  X2dt = X2d + Xt;
  X2qt = X2q + Xt;
  Rs = Ra + Rt;
  Xsf = 1/(1/(X1d - Xs) - 1/Xad);
  Xs1d = 1/(1/(X2d - Xs) - 1/Xad - 1/Xsf);
  Xs1q = 1/(1/(X2q - Xs) - 1/Xaq);
  X1 = (X2d - Xs)/Xsf;
  X2 = (X2d - Xs)/Xs1d;
  X3 = (X2q - Xs)/Xs1q;
  //--------------------------------------------------------------------------------
  Tj = if time < TkzOn then Tj_p*Pnom/Sbaz else Tj_p*Pnom/Sbaz*Pg_new/Pg;

  Xd = if time < TkzOn then Xd_p*Sbaz/Pnom*cosfi_nom else Xd_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
  Xq = if time < TkzOn then Xq_p*Sbaz/Pnom*cosfi_nom else Xq_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
  Xs = if time < TkzOn then Xs_p*Sbaz/Pnom*cosfi_nom else Xs_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
  X1d = if time < TkzOn then X1d_p*Sbaz/Pnom*cosfi_nom else X1d_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
  X2d = if time < TkzOn then X2d_p*Sbaz/Pnom*cosfi_nom else X2d_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
  X2q = if time < TkzOn then X2q_p*Sbaz/Pnom*cosfi_nom else X2q_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;

  Rf_p = (Xad+Xsf)/Wc/Td0;
  R1d_p = (Xs1d+(1/((1/Xad)+(1/Xsf)+(1/Xs))))/Wc/T2d_p;
  R1q_p = (Xs1q+(1/((1/Xaq)+(1/Xsf))))/Wc/T2q_p;
  Rf = if time < TkzOn then Rf_p else Rf_p*Pg/Pg_new;
  R1d = if time < TkzOn then R1d_p else R1d_p*Pg/Pg_new;
  R1q = if time < TkzOn then R1q_p else R1q_p*Pg/Pg_new;
  //--------------------------------------------------------------------------------
  der(DGi) = Wc*s;

  Uf_full = Rf*Er/Xad;

  der(Yr) = Wc*(Uf_full - Rf*ir);
  der(Yrd) = -Wc*R1d*ird;
  der(Yrq) = -Wc*R1q*irq;
  der(s) = (Mt_pp - Me - Kd*s)/Tj;

  Ro = if time >= Timp and time < Timp + dTimp then -Aimp else -Mu + Mu0 - s
    /Sigma;

  TauC = if time < Timp + dTimp then TauC_up else TauC_down;

  der(Mu) = if time >= TregOff and time < TregOn then Ro/10e6 else Ro/TauC;
  //--------------------------------------------------------------------------------
  MT_MIN = if time < TkzOn then Mtmin*Pg_pu else Pg_new/Sbaz - 0.01;
  MT_MAX = if time < TkzOn then Mtmax*Pg_pu else Pg_new/Sbaz + 0.01;

  Mt_pp = if Mu >= MT_MIN and Mu <= MT_MAX then Mu else if Mu > MT_MAX then
    MT_MAX else MT_MIN;
  //--------------------------------------------------------------------------------

  Me = Yad*iq - Yaq*id;
  ir = (Yr - Yad)/Xsf;
  ird = (Yrd - Yad)/Xs1d;
  irq = (Yrq - Yaq)/Xs1q;
  id = if time >= TgenOff and time < TgenOff + dTgenOff then 0 else ((uq -
    E11q)*X2qt - Rs*(ud + E11d))/(X2dt*X2qt + Rs^2);
  iq = if time >= TgenOff and time < TgenOff + dTgenOff then 0 else (-ud -
    E11d - Rs*id)/X2qt;
  E11d = X3*Yrq;
  E11q = X1*Yr + X2*Yrd;
  Yad = E11q + id*(X2d - Xs);
  Yaq = E11d + iq*(X2q - Xs);
  Ugen = (sqrt(ud^2 + uq^2))*Ugnom;
  Igen = (sqrt(IqG^2 + IdG^2))*Sbaz/sqrt(3)/Ugnom;
  dUtr = sqrt(ud^2 + uq^2) - Ut_pu;
  dWu = Wc*Ssys;
  dWf = if UqG <> 0.0 then atan2(UdG, UqG) else atan2(UdG, 0.001);
  dIf = ir - Ir;
  //----------------------------------------
  Pgen = (uq*iq + ud*id)*Sbaz;
  Qgen = (-uq*id + ud*iq)*Sbaz;
  //-----------------------------------------------------------
  uq = UqG*cos(DeltaIJ) - UdG*sin(DeltaIJ);
  ud = UqG*sin(DeltaIJ) + UdG*cos(DeltaIJ);
  //-----------------------------------------------------------
  IqG = iq*cos(DeltaIJ) + id*sin(DeltaIJ);
  IdG = id*cos(DeltaIJ) - iq*sin(DeltaIJ);
  //-----------------------------------------------------------
  f = Wc*(1-s)/2/PI;

  //------connectors------

  //--Stator--
  Stator_pin.Vd = UdG;
  Stator_pin.Vq = UqG;

  Stator_pin.Id = IdG;
  Stator_pin.Iq = IqG;

  //---input-rotor--field--voltage---
  Er = Ef_pin.Signal;

  //----to--excitation--system---
  dUtr_pin.Signal = dUtr;
  dWu_pin.Signal = dWu;
  dWf_pin.Signal = dWf;
  dIf_pin.Signal = dIf;
  Ut_pin.Signal = Ut_pu;
  Er0_pin.Signal = Er0;
  Ugen_pin.Signal = sqrt(ud^2 + uq^2);
  dIg_pin.Signal = sqrt(IqG^2 + IdG^2) - sqrt(Id^2 + Iq^2);
  connect(dUtr_pin, dUtr_pin) annotation (Line(
      points={{-54,100},{-54,100}},
      color={255,255,0},
      thickness=0.5));

  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.06,
      y=0.07,
      width=0.6,
      height=0.77),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0), graphics),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0),
      graphics={
        Ellipse(
          extent={{-66,66},{70,-64}},
          lineColor={0,0,255},
          lineThickness=1),
        Text(extent={{-36,36},{40,-38}},  textString=
                                               "SM"),
        Text(extent={{-74,-56},{86,-98}},
          textColor={0,0,0},
          textString="%name"),
        Line(
          points={{-66,0},{-94,0}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{96,0},{70,0}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-46,48},{-54,60},{-54,94}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-26,60},{-26,96}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{0,66},{0,98}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{48,48},{56,60},{56,94}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{28,62},{28,94}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{62,32},{80,58},{80,92}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-60,30},{-80,58},{-80,92}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{70,12},{104,58},{104,92}},
          color={0,0,255},
          thickness=1)},
      Ellipse(extent=[-60, 62; 60, -58], style(thickness=2)),
      Text(extent=[-38, 38; 38, -36], string="SM"),
      Text(extent=[-80, -58; 80, -100], string="%name"),
      Line(points=[-60, 2; -72, 2], style(thickness=2)),
      Line(points=[70, 2; 60, 2], style(thickness=2))),
              __Dymola_Commands(editCall=plot(
            {"L0709_1.P1","L0709_1.U1m"},
            legends={"Calibration L0709_1.P1","Calibration L0709_1.U1m"},
            colors={{255,0,0},{255,0,0}}) "Calibration_U"), Documentation(
        info="<html>
<p>Synchronous generator without exciter model. </p>
<p>Модель синхронного генератора с исключенным возбудителем. </p>
</html>"),
    uses(Modelica(version="4.0.0")));
end SM_without_exciter;
