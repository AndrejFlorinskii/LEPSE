within ;
model logical_switch
  parameter Real a1;
  parameter Real a2;
  parameter Real a3;
  parameter Real a4;
  Real T_force_off;

  LEPSE.Basic.Single_Pin inp1 annotation (
    extent=[-94,14; -74,66],
    layer="icon",
    Placement(transformation(extent={{-96,14},{-76,66}}, rotation=0),
        iconTransformation(extent={{-96,14},{-76,66}})));
  LEPSE.Basic.Single_Pin inp2 annotation (
    extent=[-94,-66; -74,-14],
    layer="icon",
    Placement(transformation(extent={{-96,-54},{-76,-2}}, rotation=0),
        iconTransformation(extent={{-96,-54},{-76,-2}})));
  LEPSE.Basic.Single_Pin inp2inf annotation (
    extent=[-94,-66; -74,-14],
    layer="icon",
    Placement(transformation(
        extent={{-10,-26},{10,26}},
        rotation=90,
        origin={0,-106}), iconTransformation(
        extent={{-10,-26},{10,26}},
        rotation=90,
        origin={0,-106})));
  LEPSE.Basic.Single_Pin out annotation (
    extent=[74,-26; 94,26],
    layer="icon",
    Placement(transformation(extent={{74,-26},{94,26}}, rotation=0)));
  LEPSE.Basic.Single_Pin inp1inf annotation (Placement(transformation(extent={{
            -26,88},{24,108}}), iconTransformation(extent={{-26,88},{24,108}})));
initial equation
  pre(T_force_off) = 0;
equation
  when abs(inp1inf.Signal) < (inp2inf.Signal - a2) then
    T_force_off = time;
  end when;
  out.Signal =if (abs(inp1inf.Signal) > (inp2inf.Signal - a1)) then (inp1.Signal)
     else (if (abs(inp1inf.Signal) > (inp2inf.Signal - a2)) then (inp1.Signal)
     else (if (time < T_force_off + a4) then (inp1.Signal) else (inp2.Signal)));
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-120},{100,120}},
        grid={2,2},
        initialScale=0),
      graphics={
        Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={244,125,35}),
        Line(
          points={{-52,40},{-80,40}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-50,-28},{-78,-28}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{76,0},{42,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-162,80}},
          color={162,29,33},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{-8,0},{-48,40}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{14,0},{-8,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{48,0},{14,0}},
          color={28,108,200},
          thickness=0.5),
        Text(extent={{-158,-112},{162,-152}},
                                          textString=
                                              "%name"),
        Line(
          points={{10,6},{-8,6}},
          color={28,108,200},
          thickness=0.5,
          origin={6,-90},
          rotation=90),
        Line(
          points={{0,90},{0,80}},
          color={28,108,200},
          thickness=0.5)},
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
    Diagram(coordinateSystem(extent={{-100,-120},{100,120}})),
    Documentation(info="<html>
<p>The model of the logic key of the automatic excitation regulator</p>
</html>"));
end logical_switch;
