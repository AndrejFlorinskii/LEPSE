within ;
model Constant_Conductivity_Load
  outer LEPSE.Basic.SysData sysData;

  parameter Boolean inService = true "Load topological condition";

  parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
  parameter Real Unom=330 "Nominal load voltage, kV";
  parameter Real Pn=10 "Active load, MW";
  parameter Real Qn=1 "Reactive load, MVar";
  parameter Real Gn(fixed=false) "Active load, S";
  parameter Real Bn(fixed=false) "Reactive load, S";
  //-------------------------------------------------------------
  parameter Real TloadOff=1000 "Time of load disconnection, s";
  parameter Real dTloadOff=10 "Duration of load disconnection, s";
  parameter Real Koff=0.7 "Degree of load disconnection, p.u.";

  parameter Boolean displayPowerFlow = true;
  //-------------------------------------------------------------
  Real Udn "D-axis voltage of load";
  Real Uqn "Q-axis voltage of load";
  Real Iqn "D-axis current of load";
  Real Idn "Q-axis current of load";
  Real Pn_fact "Active power of load fact";
  Real Qn_fact "Reactive power of load fact";
  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[-10,76; 10,96],
    layer="icon",
    Placement(transformation(extent={{-10,88},{10,108}},rotation=0),
        iconTransformation(extent={{-10,88},{10,108}})));
initial equation
  // calculating conductivity from power
  Gn = if not inService then 0.00001 else
  Pn/Sbaz;
  Bn = if not inService then -0.00001 else
  -Qn/Sbaz;

equation

  // active and reactive load
  Pn_fact = (Uqn*Iqn + Udn*Idn)*Sbaz;
  Qn_fact = (-Uqn*Idn + Udn*Iqn)*Sbaz;

  //the algorithm of triping load
  Idn = if time >= TloadOff and time < TloadOff + dTloadOff then Koff*(Udn*
    Gn + Uqn*Bn) else Udn*Gn + Uqn*Bn;
  Iqn = if time >= TloadOff and time < TloadOff + dTloadOff then Koff*(Uqn*
    Gn - Udn*Bn) else Uqn*Gn - Udn*Bn;

  //-----connector-----
  inp.Vd = Udn;
  inp.Vq = Uqn;

  inp.Id = -Idn;
  inp.Iq = -Iqn;

  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.31,
      y=0.4,
      width=0.6,
      height=0.6),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0),
      graphics={
        Line(
          points={{80,-60},{-80,-60}},
          color={0,0,0},
          thickness=1),
        Text(extent={{-98,-62},{102,-98}},
          textColor={0,0,0},
          textString="%name"),
          Text(
          textString=DynamicSelect("Pn MW", String(Pn_fact, significantDigits=3) + " MW"),
          visible=displayPowerFlow,
          extent={{-94,-102},{104,-140}},
          textColor={0,168,6}),
        Text(
          textString=DynamicSelect("Qn MVar", String(Qn_fact, significantDigits=3) + " MVar"),
          visible=displayPowerFlow,
          extent={{-94,-140},{104,-178}},
          textColor={102,44,145}),
        Line(
          points={{-80,0},{-80,-60}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{80,20},{80,-60}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-80,0},{-40,20}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-40,0},{0,20}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{0,0},{40,20}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{40,0},{80,20}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-40,20},{-40,0}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{0,20},{0,0}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{40,20},{40,0}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-60,-20},{-20,-20}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-60,-40},{-20,-40}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-60,-20},{-60,-40}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-20,-20},{-20,-40}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{20,-20},{60,-20}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{20,-40},{60,-40}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{20,-20},{20,-40}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{60,-20},{60,-40}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-74,2},{-70,60}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-50,16},{-54,60}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-54,60},{-70,60}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-60,70},{-58,80},{-56,84},{-62,70},{-66,72},{-54,90}},
          pattern=LinePattern.None,
          thickness=1),
        Line(
          points={{-6,54},{38,46}},
          pattern=LinePattern.None,
          thickness=1),
        Line(
          points={{-58,82},{-60,70}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-48,76},{-60,70}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-58,92},{-58,82}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-52,98},{-58,92}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-40,100},{-52,98}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-26,100},{-40,100}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-26,100},{-20,96}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-42,82},{-48,76}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-36,84},{-42,82}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-24,84},{-36,84}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-20,90},{-24,84}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-20,96},{-20,90}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-40,60},{40,-20}},
          lineColor={255,0,0},
          lineThickness=3.5,
          visible=DynamicSelect(not inService, not inService)),
        Line(
          points={{-40,-20},{40,60}},
          lineColor={255,0,0},
          lineThickness=3.5,
          visible=DynamicSelect(not inService, not inService)),
        Text(
          extent={{-34,-15},{36,-81}},
          textColor={238,0,0},
          textString="DISC",
          visible=DynamicSelect(not inService, not inService))},
      Rectangle(extent=[-20, 60; 20, -40], style(thickness=2)),
      Line(points=[0, -40; 0, -60], style(thickness=2)),
      Line(points=[-20, -60; 20, -60], style(thickness=2)),
      Line(points=[0, 80; 0, 60], style(thickness=2)),
      Text(extent=[-100, -64; 100, -100], string="%name")),
    Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">A load model defined as a constant conductivity. </span></p>
<p><span style=\"background-color: #ffffff;\">Модель нагрузки постоянной проводимости. </span></p>
</html>"));
end Constant_Conductivity_Load;
