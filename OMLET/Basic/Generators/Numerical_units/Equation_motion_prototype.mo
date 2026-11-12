within Numerical_units;
model Equation_motion_prototype
  outer LEPSE.Basic.SysData sysData;

  // PQ-diagram parameter
  parameter LEPSE.Data.PQ_CapabilityTable
  pq_table = LEPSE.Data.TVV_500_2;

   parameter Real TgenOff=1000 "Time of generator's disconnection, s"
   annotation(Dialog(tab="General"));
  parameter Real dTgenOff=10 "Duration of generator's disconnection, s"
   annotation(Dialog(tab="General"));
   parameter Real Kd=5 "damping coefficient"
  annotation(Dialog(tab="Synchronous machine"));

  //------------------------------------------------------------------------------------
  parameter Real Sbaz=sysData.Sbaz "Bazis power, MWA"
  annotation(Dialog(tab="General"));
  parameter Real fbaz=sysData.fbaz "Bazic frequency, Hz"
  annotation(Dialog(tab="General"));
  parameter Real Pg = 500 "Active power, MW"
  annotation(Dialog(tab="General"));
  parameter Real Qg(fixed=false) "Reactive power";
  parameter Real Ut=20 "ARV voltage reference value"
  annotation(Dialog(tab="General"));
  parameter Real Pnom=500 "Set PV-generator power"
  annotation(Dialog(tab="General"));
  parameter Real Ugnom=20 "Nominal voltage"
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

  parameter Real X1d_p=0.05 "D-axis transient reactance"
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Tj_p=7 "Inertia coefficient"
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Mtmax=1.1 "Turbine overloading coefficient"
  annotation(Dialog(tab="Turbine"));
  parameter Real Mtmin=0 "Turbine minimum-loading coefficient"
  annotation(Dialog(tab="Turbine"));
  parameter Real TregOff=50 "Turbine speed regulator off-time, s"
  annotation(Dialog(tab="Turbine"));

  //------------------------------------------------------------------------------------
  constant Real PI=4*atan(1) "PI-constant";
  parameter Real Wc=2*PI*fbaz "frequency of electric current fluctuations";

  // Parameters of power system elements
  parameter Real EQ(fixed=false) "Auxiliaire EMF of salient-pole generator";
  parameter Real Dg(fixed=false) "Generator power angle";
  parameter Real Uq(fixed=false) "D-axis ARV voltage reference value";
  parameter Real Ud(fixed=false) "Q-axis ARV voltage reference value";
  parameter Real Id(fixed=false) "D-axis stator current value";
  parameter Real Iq(fixed=false) "Q-axis stator current value";

  Real Ugen "generator full voltage actual value";
  Real Igen "generator stator current value, kA";
  Real Mt_pp "Turbine rotation moment actual value";
  Real Pgen "Generator active power actual value";
  Real Qgen "Generator reactive power actual value";
  Real UdG;
  Real UqG;
  Real IdG;
  Real IqG;
  parameter Real Mu0(fixed=false);
  input Real DeltaIJ;
  input Real Ssys "system slip";
  //------------------------------------------------------------------
  // Integrated Variables

  Real s "generator slip";
  Real su;
  Real DGi "Generator power angle initial value";
  Real Me "electrical moment";
  Real iq "Q-axis generator stator winding current actual value";
  Real id "D-axis generator stator winding current actual value";
  Real ud "D-axis generator voltage actual value";
  Real uq "Q-axis generator voltage actual value";
  Real X1d "D-axis transient reactance actual value";

  Real Tj "Inertia coefficient actual value";
  Real f "frequency";
  parameter Real Ut_pu(fixed=false) "stator voltage, p.u.";
  parameter Real Pg_pu(fixed=false) "Active power, p.u.";
  parameter Real Qg_pu(fixed=false) "Reactive power, p.u.";
  LEPSE.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
      Placement(transformation(extent={{90,-10},{110,10}},
                                                         rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  LEPSE.Interfaces.Signal_pin Mt_pin annotation (Placement(transformation(
          extent={{-112,-10},{-92,10}}), iconTransformation(extent={{-112,-10},
            {-92,10}})));
  LEPSE.Interfaces.Signal_pin slip_pin annotation (Placement(transformation(
          extent={{-10,92},{10,112}}), iconTransformation(extent={{-10,92},{10,
            112}})));

  LEPSE.Interfaces.Signal_pin Mu0_pin annotation (Placement(transformation(
          extent={{30,92},{50,112}}), iconTransformation(extent={{32,90},{52,
            110}})));
initial equation
  // additional variables in p.u.
  Ut_pu = Ut/Ugnom;
  Pg_pu = Pg/Sbaz;
  Qg_pu = Qg/Sbaz;
  Ignom = Pnom/cosfi_nom/sqrt(3)/Ugnom;

  Pg = Pgen;
  Qg=min(Qmax, max(Qmin, Qgen));

  // equations of currents, voltages, and flux densities
  DGi = Dg;
  s = 0;
  Mu0 = EQ*Iq;

  EQ = sqrt((Ut_pu + X1d*Qg_pu/Ut_pu)^2 + (X1d*Pg_pu/Ut_pu)^2);
  Dg = atan(X1d*Pg_pu/(Ut_pu^2 + X1d*Qg_pu));
    //----------------------
  Uq = Ut_pu*cos(Dg);
  Ud = -Ut_pu*sin(Dg);
    //----------------------
  Id = (Uq - EQ)/X1d;
  Iq = (-Ud)/X1d;

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

  Tj = Tj_p*Pnom/Sbaz;

  X1d = X1d_p*Sbaz/Pnom*cosfi_nom;
  //--------------------------------------------------------------------------------
  der(DGi) = Wc*s;
  der(-DeltaIJ-DGi) = Wc*su;
  der(s) = (Mt_pp/(1+s) - Me/(1+s) - Kd/2*s)/Tj;

  //--------------------------------------------------------------------------------

  Me = (uq*iq + ud*id);

  id = if time >= TgenOff and time < TgenOff + dTgenOff then 0 else (uq-EQ)/X1d;
  iq = if time >= TgenOff and time < TgenOff + dTgenOff then 0 else -ud/X1d;

  //----------------------------------------
  Pgen = (uq*iq + ud*id)*Sbaz;
  Qgen = (-uq*id + ud*iq)*Sbaz;

  Ugen = (sqrt(ud^2 + uq^2))*Ugnom;
  Igen = (sqrt(IqG^2 + IdG^2))*Sbaz/sqrt(3)/Ugnom;
  //-----------------------------------------------------------
  uq = UqG*cos(DeltaIJ) - UdG*sin(DeltaIJ);
  ud = UqG*sin(DeltaIJ) + UdG*cos(DeltaIJ);
  //-----------------------------------------------------------
  IqG = iq*cos(DeltaIJ) + id*sin(DeltaIJ);
  IdG = id*cos(DeltaIJ) - iq*sin(DeltaIJ);
  //-----------------------------------------------------------
  f = Wc*(1-s)/2/PI;

  //--Stator--
  Stator_pin.Vd = UdG;
  Stator_pin.Vq = UqG;

  Stator_pin.Id = IdG;
  Stator_pin.Iq = IqG;

  //---input-rotor--field--voltage---
  Mt_pp = max(Mtmin, min(Mtmax,Mt_pin.Signal))  "таким хитрым образом выбирается сигнал с регулятора, если он не ограничен Mtmax, Mtmin";
  Mu0 = Mu0_pin.Signal;

  slip_pin.Signal = if time >= TregOff then 0 else s;

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
          points={{96,0},{70,0}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{0,66},{0,100}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-66,0},{-102,0}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{28,62},{40,98}},
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
<p>Infinite bus mashine model. </p>
<p>Модель генератора шин бесконечной мощности. </p>
</html>"));
end Equation_motion_prototype;
