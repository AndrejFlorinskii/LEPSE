within Basic;
model Synch_Machine
  parameter Real TgenOff=1000 "Time of generator's disconnection";
  parameter Real dTgenOff=10 "Duration of generator's disconnection";

  //------------------------------------------------------------------------------------
  parameter Real Pg=0.85 "Active power";
  parameter Real Qg=0.527 "Reactive power";
  parameter Real Ut=1 "ARV voltage reference value";

  //------------------------------------------------------------------------------------
  parameter Real Xd_p=1.869 "D-axis synchronous reactance";
  parameter Real Xq_p=1.869 "Q-axis synchronous reactance";
  parameter Real Xs_p=0.194 "Leakage reactance of stator winding";
  parameter Real X1d_p=0.3016 "D-axis transient reactance";
  parameter Real X2d_p=0.2337 "D-axis subtransient reactance";
  parameter Real X2q_p=0.2337 "Q-axis subtransient reactance";
  parameter Real Rf_p=904e-6 "Active resistance of field winding";
  parameter Real R1d_p=3.688e-3 "Active resistance of d-axis damper winding";
  parameter Real R1q_p=2.77e-3 "Active resistance of q-axis damper winding";
  parameter Real Tj_p=7 "Inertia coefficient";

  parameter Real Sigma=0.0475 "Turbine statism coefficient";
  parameter Real TauC_up=0.8 "Time constant of servo motor while valving control";
  parameter Real TregOff=50 "Turbine speed regulator off-time";

  parameter Real TregOn=1000 "Turbine speed regulator on-time";
  parameter Real Mtmax=1.1 "Turbine overloading coefficient";
  parameter Real Mtmin=0 "Turbine minimum-loading coefficient";

  parameter Real Aimp=1 "Fast turbine valving control amplitude";
  parameter Real Timp=1000 "Fast turbine valving control on-time";
  parameter Real dTimp=0.2 "Fast turbine valving control duration";
  parameter Real TauC_down=5 "Time constant of servo motor after valving control end";

  parameter Real TkzOn=1000 "HPP generators dropping on-time";
  parameter Real Pg_new=0.85 "New power of HPP";
  parameter Real Kemax=2.0 "Multiplicity of forcing on";
  parameter Real Kemin=-0.6 "Multiplicity of forcing off";

  //------------------------------------------------------------------------------------
  Real dUtr "voltage deviation";
  Real dWu "frequency deviation";
  Real dIf "current deviation";
  Real dEr "Electromotive force (EMF) deviation";
  Real dWf "frequency deviation";
  constant Real PI=4*atan(1) "PI-constant";
  constant Real Wc=100*PI "frequency of electric current fluctuations";
  constant Real Xt=0 "resistance of step-up transformer";

  // Parameters of power system elements
  constant Real Ra=0 "active resistance of generator stator winding";
  constant Real Rt=0 "active resistance of transformer";
  Real EQ "Auxiliaire EMF of salient-pole generator";
  Real Dg "Generator power angle";
  Real Uq "D-axis ARV voltage reference value";
  Real Ud "Q-axis ARV voltage reference value";
  Real Id "D-axis stator current value";
  Real Iq "Q-axis stator current value";
  Real Mt "Turbine rotation moment";
  Real Eiq;
  Real Ir "field winding current";
  Real Uf "field winding voltage";
  Real Eq "EMF of generator";
  Real Er0 "EMF of generator initial value";
  Real PsiR "field winding flow coupling initial value";
  Real PsiRD "D-axis damper winding flow coupling initial value";
  Real PsiRQ "Q-axis damper winding flow coupling initial value";
  Real Er_max "upper bound of EMF of generator";
  Real Er_min "lower bound of EMF of generator";
  Real Uf_full "field winding voltage actual value";
  Real Xad "D-axis resistance to mutual induction";
  Real Xaq "Q-axis resistance to mutual induction";
  Real X2dt "D-axis subtransient reactance of generator and transformer";
  Real X2qt "Q-axis subtransient reactance of generator and transformer";
  Real Rs "Sum resistance of stator winding and step-up transformer";
  Real Xsf "Leakage reactance of field winding";
  Real Xs1d "D-axis leakage reactance of damping winding";
  Real Xs1q "Q-axis leakage reactance of damping winding";
  Real X1 "interim reactance №1";
  Real X2 "interim reactance №2";
  Real X3 "interim reactance №3";
  Real Ugen "generator full voltage actual value";
  Real Mu0 "Turbine rotation moment initial value";
  Real Ro;
  Real Mu;
  Real Mt_pp "Turbine rotation moment actual value";
  Real Pgen "Generator active power actual value";
  Real Qgen "Generator reactive power actual value";
  Real UdG;
  Real UqG;
  Real IdG;
  Real IqG;
  Real DeltaIJ;
  Real Ssys "system slip";
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
  Real E11d;
  Real E11q;
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
  LEPSE.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
      Placement(transformation(extent={{90,-10},{110,10}},
                                                         rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  LEPSE.Interfaces.Single_Pin Ef_pin annotation (extent=[-90,-8; -70,12],
      Placement(transformation(extent={{-110,-10},{-90,10}},
                                                           rotation=0),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  LEPSE.Interfaces.Single_Pin dUtr_pin annotation (
    extent=[-60,66; -40,86],
    layer="icon",
    Placement(transformation(extent={{-64,90},{-44,110}},rotation=0),
        iconTransformation(extent={{-64,90},{-44,110}})));
  LEPSE.Interfaces.Single_Pin dWu_pin annotation (
    extent=[-26,66; -6,86],
    layer="icon",
    Placement(transformation(extent={{-36,90},{-16,110}},rotation=0),
        iconTransformation(extent={{-36,90},{-16,110}})));
  LEPSE.Interfaces.Single_Pin dWf_pin annotation (
    extent=[6,66; 26,86],
    layer="icon",
    Placement(transformation(extent={{-10,90},{10,110}},
                                                       rotation=0),
        iconTransformation(extent={{-10,90},{10,110}})));
  LEPSE.Interfaces.Single_Pin dIf_pin annotation (
    extent=[40,66; 60,86],
    layer="icon",
    Placement(transformation(extent={{18,90},{38,110}},
                                                      rotation=0),
        iconTransformation(extent={{18,90},{38,110}})));
  LEPSE.Interfaces.Single_Pin Ut_pin
    annotation (Placement(transformation(extent={{46,90},{66,110}}),
        iconTransformation(extent={{46,90},{66,110}})));
equation
  // equations of currents, voltages, and flux densities
  when initial() then
    EQ = sqrt((Ut + ((Ra + Rt)*Pg + (Xq + Xt)*Qg)/Ut)^2 + (((Xq + Xt)*Pg - (
      Ra + Rt)*Qg)/Ut)^2);
    Dg = atan((((Xq + Xt)*Pg - (Ra + Rt)*Qg)/Ut)/(Ut + ((Ra + Rt)*Pg + (Xq
       + Xt)*Qg)/Ut));
    //----------------------
    Uq = Ut*cos(Dg);
    Ud = -Ut*sin(Dg);
    //----------------------
    Id = ((Uq - EQ)*(Xq + Xt) - (Ra + Rt)*Ud)/((Ra + Rt)^2 + (Xq + Xt)^2);
    Iq = (-Ud - (Ra + Rt)*Id)/(Xq + Xt);
    Mt = EQ*Iq;
    Mu0 = Mt;
    Eiq = Uq - Id*(Xs + Xt) + (Ra + Rt)*Iq;
    Ir = -Id + Eiq/Xad;
    Uf = Ir*Rf;
    Eq = Ir*Xad;
    Er0 = Eq;
    PsiR = Eiq + Xsf*Ir;
    PsiRQ = -Ud - Iq*(Xs + Xt) - Id*(Ra + Rt);
    PsiRD = Eiq;
    Er_max = Kemax*Er0;
    Er_min = Kemin*Er0;

    //-------Initialization State Variables------------------
    reinit(DGi, Dg);
    reinit(s, 0);
    reinit(Yr, PsiR);
    reinit(Yrd, PsiRD);
    reinit(Yrq, PsiRQ);
    reinit(Mu, Mu0);
  end when;

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
  Tj = if time < TkzOn then Tj_p else Tj_p*Pg_new/Pg;

  Xd = if time < TkzOn then Xd_p else Xd_p*Pg/Pg_new;
  Xq = if time < TkzOn then Xq_p else Xq_p*Pg/Pg_new;
  Xs = if time < TkzOn then Xs_p else Xs_p*Pg/Pg_new;
  X1d = if time < TkzOn then X1d_p else X1d_p*Pg/Pg_new;
  X2d = if time < TkzOn then X2d_p else X2d_p*Pg/Pg_new;
  X2q = if time < TkzOn then X2q_p else X2q_p*Pg/Pg_new;

  Rf = if time < TkzOn then Rf_p else Rf_p*Pg/Pg_new;
  R1d = if time < TkzOn then R1d_p else R1d_p*Pg/Pg_new;
  R1q = if time < TkzOn then R1q_p else R1q_p*Pg/Pg_new;
  //--------------------------------------------------------------------------------
  der(DGi) = Wc*s;

  Uf_full = if (Uf*Xad/Rf + dEr) > Er_max then Er_max*Rf/Xad else if (Uf*Xad
    /Rf + dEr) < Er_min then Er_min*Rf/Xad else Uf + Rf*dEr/Xad;

  der(Yr) = Wc*(Uf_full - Rf*ir);
  der(Yrd) = -Wc*R1d*ird;
  der(Yrq) = -Wc*R1q*irq;
  der(s) = (Mt_pp - Me)/Tj;

  Ro = if time >= Timp and time < Timp + dTimp then -Aimp else -Mu + Mu0 - s
    /Sigma;

  TauC = if time < Timp + dTimp then TauC_up else TauC_down;

  der(Mu) = if time >= TregOff and time < TregOn then Ro/10e6 else Ro/TauC;
  //--------------------------------------------------------------------------------
  MT_MIN = if time < TkzOn then Mtmin*Pg else Pg_new - 0.01;
  MT_MAX = if time < TkzOn then Mtmax*Pg else Pg_new + 0.01;

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
  Ugen = sqrt(ud^2 + uq^2);
  dUtr = sqrt(ud^2 + uq^2) - Ut;
  dWu = Wc*Ssys;
  dWf = if UqG <> 0 then atan2(UdG, UqG) else atan2(UdG, 0.001);
  dIf = ir - Ir;
  //----------------------------------------
  Pgen = uq*iq + ud*id;
  Qgen = -uq*id + ud*iq;
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
  Ef_pin.Signal = dEr;

  //----to--excitation--system---
  dUtr_pin.Signal = dUtr;
  dWu_pin.Signal = dWu;
  dWf_pin.Signal = dWf;
  dIf_pin.Signal = dIf;
  Ut_pin.Signal = Ut;
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
          points={{-58,0},{-94,0}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{96,0},{62,0}},
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
          points={{28,60},{28,94}},
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
<p>Synchronous generator model</p>
</html>"));
end Synch_Machine;
