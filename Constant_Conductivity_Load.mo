within ;
model Constant_Conductivity_Load
  parameter Real Gn=0.7 "Active load";
  parameter Real Bn=-0.35 "Reactive load";
  //-------------------------------------------------------------
  parameter Real TloadOff=1000 "Time of load disconnection";
  parameter Real dTloadOff=10 "Duration of load disconnection";
  parameter Real Koff=0.7 "Degree of load disconnection";
  //-------------------------------------------------------------
  Real Udn;
  Real Uqn;
  Real Iqn;
  Real Idn;
  Real Pn;
  Real Qn;
  LEPSE.Basic.Pin_v2 inp annotation (
    extent=[-10,76; 10,96],
    layer="icon",
    Placement(transformation(extent={{-10,76},{10,96}}, rotation=0)));
equation
  Pn = Uqn*Iqn + Udn*Idn;
  Qn = -Uqn*Idn + Udn*Iqn;
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
        Rectangle(
          extent={{-20,60},{20,-40}},
          lineColor={28,108,200},
          lineThickness=1.0),
        Line(
          points={{0,-40},{0,-60}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{-20,-60},{20,-60}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{0,80},{0,60}},
          color={28,108,200},
          thickness=1.0),
        Text(extent={{-100,-64},{100,-100}}, textString=
                                                 "%name")},
      Rectangle(extent=[-20, 60; 20, -40], style(thickness=2)),
      Line(points=[0, -40; 0, -60], style(thickness=2)),
      Line(points=[-20, -60; 20, -60], style(thickness=2)),
      Line(points=[0, 80; 0, 60], style(thickness=2)),
      Text(extent=[-100, -64; 100, -100], string="%name")),
    Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">A load model defined as a constant conductivity</span></p>
</html>"));
end Constant_Conductivity_Load;
