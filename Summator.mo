within ;
model Summator
  LEPSE.Basic.Single_Pin inp1 annotation (
    extent=[-94,14; -74,66],
    layer="icon",
    Placement(transformation(extent={{-94,14},{-74,66}}, rotation=0)));
  LEPSE.Basic.Single_Pin inp2 annotation (
    extent=[-94,-66; -74,-14],
    layer="icon",
    Placement(transformation(extent={{-94,-66},{-74,-14}}, rotation=0)));
  LEPSE.Basic.Single_Pin out annotation (
    extent=[74,-26; 94,26],
    layer="icon",
    Placement(transformation(extent={{74,-26},{94,26}}, rotation=0)));
equation
  out.Signal = inp1.Signal + inp2.Signal;
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
          extent={{-60,80},{60,-80}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Forward),
        Line(
          points={{-60,40},{-76,40}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-60,-40},{-76,-40}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{76,0},{60,0}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-50,42},{-14,38}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-34,60},{-30,20}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-34,-20},{-30,-60}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,-38},{-14,-42}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)},
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
<p>The adder model</p>
</html>"));
end Summator;
