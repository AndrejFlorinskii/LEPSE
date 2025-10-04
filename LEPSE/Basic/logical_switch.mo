within Basic;
model logical_switch
  parameter Real a1 "Uforc, Voltage of field forcing input";
  parameter Real a2 "Udeforc, Voltage of field forcing removing";
  parameter Real a3 "K0U, Voltage deviation control coefficient";
  parameter Real a4 "Tforcedelay, Delay of field forcing removing";
  Real T_force_on "moment of time, when forcing starts";

  LEPSE.Interfaces.Single_Pin inp1 annotation (
    extent=[-94,14; -74,66],
    layer="icon",
    Placement(transformation(extent={{-110,8},{-90,60}}, rotation=0),
        iconTransformation(extent={{-110,8},{-90,60}})));
  LEPSE.Interfaces.Single_Pin inp2 annotation (
    extent=[-94,-66; -74,-14],
    layer="icon",
    Placement(transformation(extent={{-110,-62},{-90,-10}},
                                                          rotation=0),
        iconTransformation(extent={{-110,-62},{-90,-10}})));
  LEPSE.Interfaces.Single_Pin inp2inf annotation (
    extent=[-94,-66; -74,-14],
    layer="icon",
    Placement(transformation(
        extent={{-10,-26},{10,26}},
        rotation=90,
        origin={2,-118}), iconTransformation(
        extent={{-10,-26},{10,26}},
        rotation=90,
        origin={2,-118})));
  LEPSE.Interfaces.Single_Pin out annotation (
    extent=[74,-26; 94,26],
    layer="icon",
    Placement(transformation(extent={{90,-34},{110,18}},rotation=0),
        iconTransformation(extent={{90,-34},{110,18}})));
  LEPSE.Interfaces.Single_Pin inp1inf annotation (Placement(transformation(
          extent={{-24,110},{26,130}}), iconTransformation(extent={{-24,110},{
            26,130}})));

initial equation
  pre(T_force_on) = 0;

  // the condition of forcing's start
equation
  when abs(inp1inf.Signal) < (inp2inf.Signal - a2) then
    T_force_on = time;
  end when;

  // the value of output signal
  out.Signal = if (abs(inp1inf.Signal) > (inp2inf.Signal - a1)) then (inp1.Signal)
     else (if (abs(inp1inf.Signal) > (inp2inf.Signal - a2)) then (inp1.Signal)
     else (if (time < T_force_on + a4) then (inp1.Signal) else (inp2.Signal)));

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
          extent={{-58,74},{62,-86}},
          lineColor={0,0,255},
          lineThickness=1,
          fillPattern=FillPattern.Forward,
          fillColor={244,125,35}),
        Line(
          points={{-46,34},{-94,34}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-48,-34},{-94,-34}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{98,-6},{44,-6}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-162,80}},
          color={162,29,33},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{-6,-6},{-46,34}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{16,-6},{-6,-6}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{50,-6},{16,-6}},
          color={0,0,255},
          thickness=1),
        Text(extent={{-158,176},{162,136}},
          textColor={0,0,0},
          textString="%name"),
        Line(
          points={{10,6},{-16,6}},
          color={0,0,255},
          thickness=1,
          origin={8,-96},
          rotation=90),
        Line(
          points={{0,118},{0,74}},
          color={0,0,255},
          thickness=1)},
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
