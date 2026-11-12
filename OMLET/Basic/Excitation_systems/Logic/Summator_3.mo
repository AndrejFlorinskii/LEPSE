within ;
model Summator_3
  LEPSE.Interfaces.Signal_pin inp1 annotation (
    extent=[-94,14; -74,66],
    layer="icon",
    Placement(transformation(extent={{-110,34},{-90,86}},rotation=0),
        iconTransformation(extent={{-110,34},{-90,86}})));
  LEPSE.Interfaces.Signal_pin inp2 annotation (
    extent=[-94,-66; -74,-14],
    layer="icon",
    Placement(transformation(extent={{-110,-28},{-90,24}}, rotation=0),
        iconTransformation(extent={{-110,-28},{-90,24}})));
  LEPSE.Interfaces.Signal_pin out annotation (
    extent=[74,-26; 94,26],
    layer="icon",
    Placement(transformation(extent={{90,-26},{110,26}},rotation=0),
        iconTransformation(extent={{90,-26},{110,26}})));
  LEPSE.Interfaces.Signal_pin inp3 annotation (
    extent=[-94,-66; -74,-14],
    layer="icon",
    Placement(transformation(extent={{-110,-28},{-90,24}}, rotation=0),
        iconTransformation(extent={{-110,-86},{-90,-34}})));
equation
  // the sum of 2 input signals
  out.Signal = inp1.Signal + inp2.Signal + inp3.Signal;
  connect(inp2, inp2) annotation (Line(
      points={{-100,-2},{-100,-2}},
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
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0),
      graphics={
        Rectangle(
          extent={{-60,98},{60,-98}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Forward),
        Line(
          points={{-60,60},{-94,60}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-60,-60},{-96,-60}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{96,0},{60,0}},
          color={0,0,255},
          thickness=1),
        Rectangle(
          extent={{-50,62},{-14,58}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Rectangle(
          extent={{-34,80},{-30,40}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Rectangle(
          extent={{-34,-40},{-30,-80}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Rectangle(
          extent={{-50,-58},{-14,-62}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Line(
          points={{-60,0},{-94,0}},
          color={0,0,255},
          thickness=1),
        Rectangle(
          extent={{-34,20},{-30,-20}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Rectangle(
          extent={{-50,2},{-14,-2}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineThickness=1)},
      Rectangle(extent=[-60, 80; 60, -80], style(
          color=73,
          thickness=2,
          fillColor=7,
          fillPattern=7)),
      Line(points=[-60, 40; -76, 40], style(thickness=2)),
      Line(points=[-60, -40; -76, -40], style(thickness=2)),
      Line(points=[76, 0; 60, 0], style(thickness=2)),
      Rectangle(extent=[-50, 42; -14, 38], style(fillColor=0)),
      Rectangle(extent=[-34, 60; -30, 20], style(fillColor=0)),
      Rectangle(extent=[-34, -20; -30, -60], style(fillColor=0)),
      Rectangle(extent=[-50, -38; -14, -42], style(fillColor=0))),
    Window(
      x=0.29,
      y=0.02,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p>The adder model with 3 inputs. </p>
<p>Модель сумматора с 3 входами. </p>
</html>"));
end Summator_3;
