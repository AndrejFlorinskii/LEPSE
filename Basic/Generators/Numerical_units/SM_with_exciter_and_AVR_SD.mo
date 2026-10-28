within ;
model SM_with_exciter_and_AVR_SD

  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[78,-4; 98,16],
    layer="icon",
    Placement(transformation(extent={{90,-10},{110,10}},
                                                       rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  parameter Real TgenOff=1000 "Time of generator's disconnection, s"
  annotation(Dialog(tab="General"));
  parameter Real dTgenOff=10 "Duration of generator's disconnection, s"
  annotation(Dialog(tab="General"));
  parameter Real Pg=100 "Active power, MW"
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Ut=20 "ARV voltage reference value, kV"
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Pnom=100 "Nominal maschine active power"
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Ugnom=20 "Nominal stator voltage, kV"
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Sbaz=1000 "Bazis power, MWA"
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Xd_p=1.869 "D-axis synchronous reactance, p.u."
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Xq_p=1.869 "Q-axis synchronous reactance, p.u."
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Xs_p=0.194 "Leakage reactance of stator winding, p.u."
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real X1d_p=0.3016 "D-axis transient reactance, p.u."
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real X2q_p=0.2337 "Q-axis subtransient reactance, p.u."
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real X2d_p=0.2337 "D-axis subtransient reactance, p.u."
  annotation(Dialog(tab="Synchronous machine"));
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
  parameter Real Aimp=1 "Fast turbine valving control amplitude, p.u."
  annotation(Dialog(tab="Turbine"));
  parameter Real Mtmin=0 "Turbine minimum-loading coefficient, p.u."
  annotation(Dialog(tab="Turbine"));
  parameter Real Timp=1000 "Fast turbine valving control on-time, s"
  annotation(Dialog(tab="Turbine"));
  parameter Real dTimp=0.2 "Fast turbine valving control duration, s"
  annotation(Dialog(tab="Turbine"));
  parameter Real TauC_down=5 "Time constant of servo motor after valving control end, s"
  annotation(Dialog(tab="Turbine"));
  parameter Real TkzOn=1000 "Generators dropping on-time, s"
  annotation(Dialog(tab="General"));
  parameter Real Pg_new=100 "New power of HPP, MW"
  annotation(Dialog(tab="General"));
  parameter Real Kemax=2.0 "Multiplicity of forcing on, p.u."
  annotation(Dialog(tab="Exciter"));
  parameter Real Kemin=-0.6 "Multiplicity of forcing off, p.u."
  annotation(Dialog(tab="Exciter"));
  parameter Real K0u=-10 "Voltage deviation control coefficient"
  annotation(Dialog(tab="AVR"));
  parameter Real K1u=0 "Voltage derivative control coefficient"
  annotation(Dialog(tab="AVR"));
  parameter Real K0w=0 "Frequency deviation control coefficient"
  annotation(Dialog(tab="AVR"));
  parameter Real K1if=0 "Rotor current derivative control coefficient"
  annotation(Dialog(tab="AVR"));
  parameter Real K1w=0 "Frequency derivative control coefficient"
  annotation(Dialog(tab="AVR"));
  parameter Real Uforc=0.85 "Voltage of field forcing input"
  annotation(Dialog(tab="Forcing"));
  parameter Real Udeforc=0.9 "Voltage of field forcing removing"
  annotation(Dialog(tab="Forcing"));
  parameter Real Tforcedelay=0.1 "Delay of field forcing removing"
  annotation(Dialog(tab="Forcing"));
  parameter Real DL0=0
  annotation(Dialog(tab="AVR"));
  parameter Real Tokp=0.05 "The main channel of regulation time constant"
  annotation(Dialog(tab="AVR"));
  parameter Real cosfi_nom=0.85 "Nominal maschine power coefficient, p.u."
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real n_gen=1 "Number of generators"
  annotation(Dialog(tab="General"));

  parameter Boolean displayPowerFlow=true "Display power flow"
  annotation(Dialog(tab="General"));

  parameter Real fbaz=G.sysData.fbaz "Bazic frequency, Hz"
   annotation(Dialog(tab="General"));
  parameter LEPSE.Data.PQ_CapabilityTable pq_table=LEPSE.Data.TVV_500_2
    annotation (Dialog(tab="Synchronous machine"));
  LEPSE.Basic.Excitation_systems.Regulators.AVR_SD AVR(
    K0u=K0u,
    K1u=K1u,
    K0w=K0w,
    K1w=K1w,
    K1if=K1if,
    Uforc=Uforc,
    Udeforc=Udeforc,
    Tforcedelay=Tforcedelay,
    DL0=DL0,
    Umax=Umax,
    Umin=Umin,
    Tokp=Tokp,
    Qgen=G.Qgen,
    Qmax=G.Qmax,
    Qmin=G.Qmin,
    inService=inService,
    inService_1=inService_1)
    annotation (Placement(transformation(extent={{-174,-32},{-96,44}})));
  parameter Boolean inService=true "Reactive power limiter condition"
  annotation(Dialog(tab="AVR"));
  LEPSE.Basic.Excitation_systems.Exciters.Exciter exciter(
    Te=Te,
    Kemax=Kemax,
    Kemin=Kemin,
    selfExcitation=selfExcitation,
    Kig_exc=Kig_exc,
    Kif_exc=Kif_exc,
    Ku_exc=Ku_exc)
    annotation (Placement(transformation(extent={{-78,-20},{-24,18}})));
  LEPSE.Basic.Generators.Numerical_units.SM_without_exciter G(
    TgenOff=TgenOff,
    dTgenOff=dTgenOff,
    Kd=Kd,
    Sbaz=Sbaz,
    fbaz=fbaz,
    Pg=Pg,
    Ut=Ut,
    Pnom=Pnom,
    Ugnom=Ugnom,
    cosfi_nom=cosfi_nom,
    Xd_p=Xd_p,
    Xq_p=Xq_p,
    Xs_p=Xs_p,
    X1d_p=X1d_p,
    X2d_p=X2d_p,
    X2q_p=X2q_p,
    Tj_p=Tj_p,
    Td0=Td0,
    T2d_p=T2d_p,
    T2q_p=T2q_p,
    Sigma=Sigma,
    TauC_up=TauC_up,
    TregOff=TregOff,
    TregOn=TregOn,
    Mtmax=Mtmax,
    Mtmin=Mtmin,
    Aimp=Aimp,
    Timp=Timp,
    dTimp=dTimp,
    TauC_down=TauC_down,
    TkzOn=TkzOn,
    Pg_new=Pg_new)
    annotation (Placement(transformation(extent={{-18,-46},{74,46}})));
  parameter Real Te=0.02 "Exciter time constant, s"
  annotation(Dialog(tab="Exciter"));
  parameter Boolean selfExcitation=true "Sign of self‑excitation (dependence on Ut)"
  annotation(Dialog(tab="Exciter"));
  parameter Real Umax=6 "AVR upper limit"
  annotation(Dialog(tab="AVR"));
  parameter Real Umin=-6 "AVR lower limit"
  annotation(Dialog(tab="AVR"));
  parameter Boolean inService_1=true "AVR_signal limiter condition"
  annotation(Dialog(tab="AVR"));
  parameter Real Kd=0 "damping coefficient"
  annotation(Dialog(tab="Synchronous machine"));
  parameter Real Kig_exc=1.0
  annotation(Dialog(tab="Exciter"));
  parameter Real Kif_exc=1.0
  annotation(Dialog(tab="Exciter"));
  parameter Real Ku_exc=1.0
  annotation(Dialog(tab="Exciter"));
equation

  connect(AVR.dV1_pin, AVR.dV_pin) annotation (Line(
      points={{-174.325,13.6},{-174.325,25}},
      color={255,255,0},
      thickness=0.5));
  connect(exciter.dEr_pin, AVR.out_pin) annotation (Line(
      points={{-78,3.94},{-92,3.94},{-92,2.96},{-95.675,2.96}},
      color={255,255,0},
      thickness=0.5));
  connect(exciter.Er_pin, G.Ef_pin) annotation (Line(
      points={{-24,-1},{-24,0},{-18,0}},
      color={255,255,0},
      thickness=0.5));
  connect(G.Stator_pin, inp) annotation (Line(points={{74,0},{100,0}},
                       color={28,108,200}));

  connect(G.dIg_pin, exciter.dIg_pin) annotation (Line(
      points={{75.84,46},{76,46},{76,54},{-84,54},{-84,8.88},{-78,8.88}},
      color={255,255,0},
      thickness=0.5));
  connect(G.Er0_pin, exciter.Er0_pin) annotation (Line(
      points={{64.8,46},{64.8,56},{-86,56},{-86,-1},{-78,-1}},
      color={255,255,0},
      thickness=0.5));
  connect(G.dIf_pin, exciter.dIf_pin) annotation (Line(
      points={{40.88,46},{40.88,58},{-88,58},{-88,-11.26},{-78,-11.26}},
      color={255,255,0},
      thickness=0.5));
  connect(G.Ugen_pin, exciter.Ut_pin) annotation (Line(
      points={{-8.8,46},{-80,46},{-80,22},{-82,22},{-82,-5.56},{-78,-5.56}},
      color={255,255,0},
      thickness=0.5));
  connect(G.Ut_pin, AVR.Ut_pin) annotation (Line(
      points={{53.76,46},{53.76,62},{-180,62},{-180,-25.92},{-174,-25.92}},
      color={255,255,0},
      thickness=0.5));
  connect(G.dUtr_pin, AVR.dV_pin) annotation (Line(
      points={{3.16,46},{3.16,60},{-176,60},{-176,48},{-178,48},{-178,25},{-174.325,
          25}},
      color={255,255,0},
      thickness=0.5));
  connect(G.dWf_pin, AVR.dfU_pin) annotation (Line(
      points={{28,46},{28,64},{-182,64},{-182,-9.2},{-174.325,-9.2}},
      color={255,255,0},
      thickness=0.5));
  connect(G.dIf_pin, AVR.dif1_pin) annotation (Line(
      points={{40.88,46},{40.88,58},{-88,58},{-88,-38},{-178,-38},{-178,-18.32},
          {-174.325,-18.32}},
      color={255,255,0},
      thickness=0.5));
  connect(G.dWu_pin, AVR.dfsys_pin) annotation (Line(
      points={{16.04,46},{16.04,66},{-184,66},{-184,-12},{-178,-12},{-178,2.2},{
          -174.325,2.2}},
      color={255,255,0},
      thickness=0.5));
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-180,-100},{100,100}},
        grid={2,2},
        initialScale=0),
      graphics={
        Text(extent={{-78,96},{74,70}},
          textColor={0,0,0},
          textString="%name"),
        Line(points={{94,0},{60,0}}, color={0,0,0},
          thickness=1),
        Text(
          textString=DynamicSelect("P MW", String(G.Pgen, significantDigits=3) + " MW"),
          visible=displayPowerFlow,
          extent={{-96,-70},{102,-108}},
          textColor={0,168,6}),
        Text(
          textString=DynamicSelect("Q MVar", String(G.Qgen, significantDigits=3) + " MVar"),
          visible=displayPowerFlow,
          extent={{-94,-100},{104,-138}},
          textColor={102,44,145}),
        Line(
          points={{-52,20},{-52,-20},{-20,-40}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-52,20},{-20,40}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-20,40},{-20,-40}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-20,0},{20,0}},
          color={0,0,0},
          thickness=1),
        Ellipse(
          extent={{20,20},{60,-20}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None),
        Ellipse(
          extent={{-5,6},{5,-6}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={35,-8.88178e-16},
          rotation=180),
        Ellipse(
          extent={{-5,6},{5,-6}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={45,0},
          rotation=360),
        Line(
          points={{-52,0},{-78,0}},
          color={0,0,0},
          thickness=1),
        Rectangle(
          extent={{-80,60},{80,-60}},
          lineColor={28,108,200},
          lineThickness=1,
          pattern=LinePattern.Dash)},
      Ellipse(extent=[-74, 72; 72, -58]),
      Text(extent=[-44, 54; 46, 20], string="Gen."),
      Text(extent=[-50, 22; 50, -4], string="with ARV"),
      Text(extent=[-78, -58; 74, -84], string="%name"),
      Line(points=[80, 6; 72, 6]),
      Text(extent=[-50, -4; 50, -30], string="control")),
    Window(
      x=0.28,
      y=0.01,
      width=0.6,
      height=0.88),
    Documentation(info="<html>
<p>Generator model with automatic excitation (SD) control. </p>
<p>Модель синхронного генератора с подключенным АРВ сильного действия. </p>
</html>"),
    Diagram(coordinateSystem(extent={{-180,-100},{100,100}})));
end SM_with_exciter_and_AVR_SD;
