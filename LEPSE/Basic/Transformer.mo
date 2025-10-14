within Basic;
model Transformer
  parameter Real Rline=0.001 "Active resistance of T-model";
  parameter Real Xline=0.01 "Reactance of T-model";
  //---------------------------------------------
  parameter Real TtOff=1000 "Time of transformer disconnection";
  parameter Real dTtOff=10 "Duration of transformer disconnection";
  parameter Real Koff=100000 "Degree of transformer disconnection";
  //---------------------------------------------

  Real U1d "D-axis voltage at the beginning of HVline";
  Real U1q "Q-axis voltage at the beginning of HVline";
  Real U2d "D-axis voltage at the end of HVline";
  Real U2q "Q-axis voltage at the end of HVline";
  Real I12d "D-axis current in the middle of HVline";
  Real I12q "Q-axis current in the middle of HVline";
  Real I12m "Full current in the middle of HVline";
  Real U1m "Full voltage at the beginning of HVline";
  Real U2m "Full voltage at the end of HVline";
  Real P1 "active power at the beginning of HVline";
  Real Q1 "reactive power at the beginning of HVline";
  Real P2 "active power at the end of HVline";
  Real Q2 "reactive power at the end of HVline";
  Real RL "actual active resistance of HVline";
  Real XL "actual reactive resistance of HVline";

  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[-88,0; -68,20],
    layer="icon",
    Placement(transformation(extent={{-108,0},{-88,20}},rotation=0),
        iconTransformation(extent={{-108,0},{-88,20}})));
  LEPSE.Interfaces.Pin_v2 out annotation (
    extent=[70,0; 90,20],
    layer="icon",
    Placement(transformation(extent={{88,0},{108,20}},rotation=0),
        iconTransformation(extent={{88,0},{108,20}})));
equation
  // the algorithm of triping transmission line
  RL = if time >= TtOff and time < TtOff + dTtOff then Koff*Rline else Rline;
  XL = if time >= TtOff and time < TtOff + dTtOff then Koff*Xline else Xline;

  // series impedance between nodes
  U1q = U2q + RL*I12q - XL*I12d;
  U1d = U2d + RL*I12d + XL*I12q;

  // measurements
  I12m = sqrt(I12d^2 + I12q^2);
  U1m = sqrt(U1d^2 + U1q^2);
  U2m = sqrt(U2d^2 + U2q^2);

  // powers
  P1 = U1q*I12q + U1d*I12d;
  Q1 = -U1q*I12d + U1d*I12q;
  P2 = U2q*I12q + U2d*I12d;
  Q2 = -U2q*I12d + U2d*I12q;

  //------connectors-----
  inp.Vd = U1d;
  inp.Vq = U1q;

  out.Vd = U2d;
  out.Vq = U2q;

  inp.Id = -I12d;
  inp.Iq = -I12q;

  out.Id = I12d;
  out.Iq = I12q;

  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.31,
      y=0.28,
      width=0.5,
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
          points={{0,60},{0,-40}},
          color={0,0,0},
          thickness=1.5),
        Rectangle(
          extent={{-60,74},{60,-54}},
          lineColor={0,0,255},
          lineThickness=1.0),
        Line(
          points={{-20,10},{-90,10}},
          color={0,0,0},
          thickness=1.5),
        Line(
          points={{92,10},{22,10}},
          color={0,0,0},
          thickness=1.0),
        Text(extent={{-64,104},{66,76}},
          textColor={0,0,0},
          textString="%name"),
        Line(
          points={{-20,34},{-8,38},{-4,46},{-8,54},{-20,58}},
          color={0,0,0},
          thickness=1.0),
        Line(
          points={{22,10},{10,14},{6,22},{10,30},{20,32}},
          color={0,0,0},
          thickness=1.0),
        Line(
          points={{22,32},{10,36},{6,44},{10,52},{22,56}},
          color={0,0,0},
          thickness=1.0),
        Line(
          points={{-20,10},{-8,14},{-4,22},{-8,30},{-20,34}},
          color={0,0,0},
          thickness=1.0),
        Line(
          points={{-20,-14},{-8,-10},{-4,-2},{-8,6},{-20,10}},
          color={0,0,0},
          thickness=1.0),
        Line(
          points={{-20,-38},{-8,-34},{-4,-26},{-8,-18},{-20,-14}},
          color={0,0,0},
          thickness=1.0),
        Line(
          points={{22,-12},{10,-8},{6,0},{10,8},{20,10}},
          color={0,0,0},
          thickness=1.0),
        Line(
          points={{22,-34},{10,-30},{6,-22},{10,-14},{20,-12}},
          color={0,0,0},
          thickness=1.0),
        Text(
          textString=String(P1),
          extent={{-98,-60},{100,-98}},
          textColor={0,0,0})},
      Line(points=[0, 60; 0, -40], style(color=0, thickness=4)),
      Rectangle(extent=[-50, 70; 50, -50], style(color=73, thickness=2)),
      Line(points=[-20, 10; -70, 10], style(color=0, thickness=2)),
      Line(points=[72, 10; 22, 10], style(color=0, thickness=2)),
      Text(extent=[-64, -54; 66, -82], string="%name"),
      Line(points=[-20, 34; -8, 38; -4, 46; -8, 54; -20, 58], style(color=0,
              thickness=2)),
      Line(points=[22, 10; 10, 14; 6, 22; 10, 30; 20, 32], style(color=0,
            thickness=2)),
      Line(points=[22, 32; 10, 36; 6, 44; 10, 52; 22, 56], style(color=0,
            thickness=2)),
      Line(points=[-20, 10; -8, 14; -4, 22; -8, 30; -20, 34], style(color=0,
              thickness=2)),
      Line(points=[-20, -14; -8, -10; -4, -2; -8, 6; -20, 10], style(color=0,
              thickness=2)),
      Line(points=[-20, -38; -8, -34; -4, -26; -8, -18; -20, -14], style(
            color=0, thickness=2)),
      Line(points=[22, -12; 10, -8; 6, 0; 10, 8; 20, 10], style(color=0,
            thickness=2)),
      Line(points=[22, -34; 10, -30; 6, -22; 10, -14; 20, -12], style(color=
              0, thickness=2))),
    Documentation(info="<html>
<p>The model of a two-winding transformer</p>
</html>"));
end Transformer;
