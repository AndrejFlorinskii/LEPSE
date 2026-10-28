within ;
model SM_with_AVR_SD

  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[78,-4; 98,16],
    layer="icon",
    Placement(transformation(extent={{90,-10},{110,10}},
                                                       rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  parameter Real TgenOff=1000 "Time of generator's disconnection, s";
  parameter Real dTgenOff=10 "Duration of generator's disconnection, s";
  parameter Real Pg=100 "Active power, MW";
  parameter Real Ut=20 "ARV voltage reference value, kV";
  parameter Real Pnom=100 "Nominal maschine active power";
  parameter Real Ugnom=20 "Nominal stator voltage, kV";
  parameter Real Sbaz=1000 "Bazis power, MWA";
  parameter Real Xd_p=1.869 "D-axis synchronous reactance, p.u.";
  parameter Real Xq_p=1.869 "Q-axis synchronous reactance, p.u.";
  parameter Real Xs_p=0.194 "Leakage reactance of stator winding, p.u.";
  parameter Real Tj_p=7 "Inertia coefficient, s";
  parameter Real X2q_p=0.2337 "Q-axis subtransient reactance, p.u.";
  parameter Real X2d_p=0.2337 "D-axis subtransient reactance, p.u.";
  parameter Real X1d_p=0.3016 "D-axis transient reactance, p.u.";
  parameter Real Td0=10 "D-axis transient time constant, s";
  parameter Real T2d_p=0.02 "D-axis subtransient time constant, s";
  parameter Real T2q_p=0.05 "Q-axis subtransient time constant, s";
  parameter Real Sigma=0.0475 "Turbine statism coefficient, p.u.";
  parameter Real TauC_up=0.8 "Time constant of servo motor while valving control, s";
  parameter Real TregOff=50 "Turbine speed regulator off-time, s";
  parameter Real TregOn=1000 "Turbine speed regulator on-time, s";
  parameter Real Mtmax=1.1 "Turbine overloading coefficient, p.u.";
  parameter Real Aimp=1 "Fast turbine valving control amplitude, p.u.";
  parameter Real Mtmin=0 "Turbine minimum-loading coefficient, p.u.";
  parameter Real Timp=1000 "Fast turbine valving control on-time, s";
  parameter Real dTimp=0.2 "Fast turbine valving control duration, s";
  parameter Real TauC_down=5 "Time constant of servo motor after valving control end, s";
  parameter Real TkzOn=1000 "HPP generators dropping on-time, s";
  parameter Real Pg_new=100 "New power of HPP, MW";
  parameter Real Kemax=2.0 "Multiplicity of forcing on, p.u.";
  parameter Real Kemin=-0.6 "Multiplicity of forcing off, p.u.";
  parameter Real K0u=-10 "Voltage deviation control coefficient";
  parameter Real K1u=0 "Voltage derivative control coefficient";
  parameter Real K0w=0 "Frequency deviation control coefficient";
  parameter Real K1if=0 "Rotor current derivative control coefficient";
  parameter Real K1w=0 "Frequency derivative control coefficient";
  parameter Real Uforc=0.85 "Voltage of field forcing input";
  parameter Real Udeforc=0.9 "Voltage of field forcing removing";
  parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
  parameter Real DL0=0;
  parameter Real Tokp=0.05 "The main channel of regulation time constant";
  parameter Real cosfi_nom=0.85 "Nominal maschine power coefficient, p.u.";
  parameter Real n_gen=1 "Number of generators";

  parameter Boolean displayPowerFlow=true "Display power flow";
  LEPSE.Basic.Generators.Numerical_units.SM G(
    pq_table=pq_table,
    TgenOff=TgenOff,
    dTgenOff=dTgenOff,
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
    Pg_new=Pg_new,
    Kemax=Kemax,
    Kemin=Kemin)
    annotation (Placement(transformation(extent={{-16,-58},{76,40}})));

  parameter Real fbaz=G.sysData.fbaz "Bazic frequency, Hz";
  parameter LEPSE.Data.PQ_CapabilityTable pq_table=LEPSE.Data.TVV_500_2;
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
    Qgen=G.Qgen,
    Qmax=G.Qmax,
    Qmin=G.Qmin,
    inService=inService)
    annotation (Placement(transformation(extent={{-128,-30},{-50,46}})));
  parameter Boolean inService=true "Excitation limiter condition";
equation

  connect(G.Stator_pin, inp) annotation (Line(points={{76,-9},{76,-10},{86,
          -10},{86,0},{100,0}}, color={28,108,200}));

  connect(G.Ef_pin, AVR.out_pin) annotation (Line(
      points={{-16,-9},{-16,-10},{-44,-10},{-44,4.96},{-49.675,4.96}},
      color={255,255,0},
      thickness=0.5));
  connect(G.Ut_pin, AVR.Ut_pin) annotation (Line(
      points={{55.76,40},{55.76,68},{-142,68},{-142,-23.92},{-128,-23.92}},
      color={255,255,0},
      thickness=0.5));
  connect(G.dIf_pin, AVR.dif1_pin) annotation (Line(
      points={{42.88,40},{42.88,64},{-140,64},{-140,-16.32},{-128.325,-16.32}},
      color={255,255,0},
      thickness=0.5));

  connect(G.dWf_pin, AVR.dfU_pin) annotation (Line(
      points={{30,40},{30,60},{-138,60},{-138,-7.2},{-128.325,-7.2}},
      color={255,255,0},
      thickness=0.5));
  connect(G.dWu_pin, AVR.dfsys_pin) annotation (Line(
      points={{18.04,40},{18.04,56},{-136,56},{-136,4.2},{-128.325,4.2}},
      color={255,255,0},
      thickness=0.5));
  connect(G.dUtr_pin, AVR.dV_pin) annotation (Line(
      points={{5.16,40},{5.16,52},{-134,52},{-134,27},{-128.325,27}},
      color={255,255,0},
      thickness=0.5));
  connect(AVR.dV1_pin, AVR.dV_pin) annotation (Line(
      points={{-128.325,15.6},{-128.325,27}},
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
        extent={{-140,-100},{100,100}},
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
<p>Generator model with automatic excitation control SD. </p>
<p>Модель синхронного генератора с подключенным АРВ сильного действия. </p>
</html>"),
    Diagram(coordinateSystem(extent={{-140,-100},{100,100}})));
end SM_with_AVR_SD;
