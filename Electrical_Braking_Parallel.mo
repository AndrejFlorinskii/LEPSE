within ;
model Electrical_Braking_Parallel
  parameter Real Rline=0.2 "Active resistance of electrical breaking device";
  //---------------------------------------------
  parameter Real TLineOff=1000 "Time of electrical breaking";
  parameter Real dTLineOff=10 "Duration of electrical breaking";
  //---------------------------------------------
  Real Ud;
  Real Uq;
  Real I12d;
  Real I12q;
  Real I12m;
  Real Um;
  LEPSE.Basic.Pin_v2 inp annotation (
    extent=[-10,78; 10,98],
    layer="icon",
    Placement(transformation(extent={{-10,78},{10,98}}, rotation=0)));
equation
  //--------------------------------------------------------------------------
  I12d = if time >= TLineOff and time < TLineOff + dTLineOff then Ud/Rline
     else 0;
  I12q = if time >= TLineOff and time < TLineOff + dTLineOff then Uq/Rline
     else 0;
  //---------measurements-----------------------------------------------------
  I12m = sqrt(I12d^2 + I12q^2);
  Um = sqrt(Ud^2 + Uq^2);
  //-----connector-----
  inp.Vd = Ud;
  inp.Vq = Uq;

  inp.Id = -I12d;
  inp.Iq = -I12q;
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.25,
      y=0.18,
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
          extent={{-20,40},{20,-40}},
          lineColor={28,108,200},
          lineThickness=1.0,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-20,-60},{20,-60}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{0,-60},{0,-40}},
          color={28,108,200},
          thickness=1.0),
        Rectangle(
          extent={{-10,70},{10,50}},
          lineColor={28,108,200},
          lineThickness=1.0,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,40},{0,50}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{0,70},{0,80}},
          color={28,108,200},
          thickness=1.0),
        Text(extent={{-100,-62},{100,-100}}, textString=
                                                 "%name")},
      Rectangle(extent=[-20, 40; 20, -40], style(thickness=2, fillColor=8)),
      Line(points=[-20, -60; 20, -60], style(thickness=2)),
      Line(points=[0, -60; 0, -40], style(thickness=2)),
      Rectangle(extent=[-10, 70; 10, 50], style(thickness=2, fillColor=8)),
      Line(points=[0, 40; 0, 50], style(thickness=2)),
      Line(points=[0, 70; 0, 80], style(thickness=2)),
      Text(extent=[-100, -62; 100, -100], string="%name")),
    Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">Model of parallel electric braking device</span></p>
</html>"));
end Electrical_Braking_Parallel;
