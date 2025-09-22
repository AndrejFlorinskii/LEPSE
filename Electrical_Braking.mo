within ;
model Electrical_Braking
  parameter Real Rline=0.2 "Active resistance of electrical breaking device";
  //---------------------------------------------
  parameter Real TLineOff=1000 "Time of electrical breaking";
  parameter Real dTLineOff=10 "Duration of electrical breaking";
  //---------------------------------------------
  Real U1d;
  Real U1q;
  Real U2d;
  Real U2q;
  Real I12d;
  Real I12q;
  Real I12m;
  Real U1m;
  Real U2m;
  Real RL;
  LEPSE.Basic.Pin_v2 inp annotation (extent=[-98,0; -78,20], Placement(
        transformation(extent={{-98,0},{-78,20}}, rotation=0)));
  LEPSE.Basic.Pin_v2 out annotation (extent=[78,0; 98,20], Placement(
        transformation(extent={{78,0},{98,20}}, rotation=0)));
equation
  //---------the algorithm of triping transmission line--------
  RL = if time >= TLineOff and time < TLineOff + dTLineOff then Rline else 0;
  //---------series impedance between nodes--------------------
  U1q = U2q + RL*I12q;
  U1d = U2d + RL*I12d;
  //---------measurements--------------------------------------
  I12m = sqrt(I12d^2 + I12q^2);
  U1m = sqrt(U1d^2 + U1q^2);
  U2m = sqrt(U2d^2 + U2q^2);
  //-----connectors------
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
      x=0.28,
      y=0.09,
      width=0.6,
      height=0.6),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0), graphics),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0),
      graphics={
        Rectangle(
          extent={{-40,20},{40,0}},
          lineColor={28,108,200},
          lineThickness=1.0,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,10},{-80,10}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{80,10},{40,10}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{-60,10},{-60,40},{-20,40}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{20,40},{60,40},{60,10}},
          color={28,108,200},
          thickness=1.0),
        Rectangle(
          extent={{-20,48},{20,46}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{22,38},{18,42}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-18,38},{-22,42}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(extent={{-100,-8},{100,-48}}, textString=
                                               "%name")},
      Rectangle(extent=[-40, 20; 40, 0], style(thickness=2, fillColor=8)),
      Line(points=[-40, 10; -80, 10], style(thickness=2)),
      Line(points=[80, 10; 40, 10], style(thickness=2)),
      Line(points=[-60, 10; -60, 40; -20, 40], style(thickness=2)),
      Line(points=[20, 40; 60, 40; 60, 10], style(thickness=2)),
      Rectangle(extent=[-20, 48; 20, 46], style(fillColor=0)),
      Ellipse(extent=[22, 38; 18, 42], style(fillColor=0)),
      Ellipse(extent=[-18, 38; -22, 42], style(fillColor=0)),
      Text(extent=[-100, -8; 100, -48], string="%name")),
    Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">Model of series electric braking device</span></p>
</html>"));
end Electrical_Braking;
