within Basic;
model ShortCircuitShunt
  parameter Real Bn=-100000 "Reactive conductivity of short sircuit";
  parameter Real Gn=-100000 "Active conductivity of short sircuit";
  parameter Real Yn = sqrt( Bn^(2) + Gn^(2)) "Total conductivity of short sircuit";
  //-----------------------------------
  parameter Real TkzOn=1000 "Time of short sircuit";
  parameter Real dTkzOn=0.12 "Duration of short sircuit";
  //-----------------------------------

  Real id "D-axis current of short-circuit";
  Real iq "Q-axis current of short-circuit";
  Real Ud  "D-axis voltage of short-circuit";
  Real Uq "Q-axis voltage of short-circuit";
  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[-10,38; 10,58],
    layer="icon",
    Placement(transformation(extent={{-10,88},{10,108}},rotation=0),
        iconTransformation(extent={{-10,88},{10,108}})));
equation
  // short-circuit current
  id = if time >= TkzOn and time < TkzOn + dTkzOn then Bn*Uq + Gn*Ud else 0;
  iq = if time >= TkzOn and time < TkzOn + dTkzOn then -Bn*Ud + Gn*Uq else 0;

  //-----connector-----
  inp.Vd = Ud;
  inp.Vq = Uq;

  inp.Id = -id;
  inp.Iq = -iq;

  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.29,
      y=0.11,
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
          points={{-20,-10},{20,-10}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{0,-10},{0,90}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{34,54},{6,24},{30,24},{0,-10}},
          color={255,0,0},
          thickness=1,
          arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-56,-28},{58,-56}},
          textColor={0,0,0},
          textString="%name")},
      Line(points=[-20, -60; 20, -60], style(thickness=4)),
      Line(points=[0, -60; 0, 40], style(thickness=4)),
      Line(points=[34, 4; 6, -26; 30, -26; 0, -60], style(
          color=41,
          thickness=4,
          arrow=1)),
      Text(extent=[-54, -64; 60, -92], string="%name")),
    Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">Short-Circuit Shunt Model</span></p>
</html>"));
end ShortCircuitShunt;
