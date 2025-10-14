within Basic;
model Electrical_Braking_Series
  parameter Real Rline=0.2 "Active resistance of electrical braking device";
  //---------------------------------------------
  parameter Real TLineOff=1000 "Time of electrical braking";
  parameter Real dTLineOff=10 "Duration of electrical braking";
  //---------------------------------------------

  Real U1d "D-axis voltage at the beginning of series electrical braking";
  Real U1q "Q-axis voltage at the beginning of series electrical braking";
  Real U2d "D-axis voltage at the end of series electrical braking";
  Real U2q "Q-axis voltage at the end of series electrical braking";
  Real I12d "D-axis current of series electrical braking";
  Real I12q "Q-axis current of series electrical braking";
  Real I12m "Full current of series electrical braking";
  Real U1m "Full voltage at the beginning of series electrical braking";
  Real U2m "Full voltage at the end of series electrical braking";
  Real RL "Actual resistanse of series electrical braking";
  LEPSE.Interfaces.Pin_v2 inp annotation (extent=[-98,0; -78,20], Placement(
        transformation(extent={{-110,-26},{-90,-6}},
                                                  rotation=0),
        iconTransformation(extent={{-110,-26},{-90,-6}})));
  LEPSE.Interfaces.Pin_v2 out annotation (extent=[78,0; 98,20], Placement(
        transformation(extent={{90,-26},{110,-6}},
                                                rotation=0),
        iconTransformation(extent={{90,-26},{110,-6}})));
equation
  // the algorithm of series electrical braking start
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
          extent={{-38,0},{42,-32}},
          lineColor={0,0,255},
          lineThickness=1.0,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-38,-16},{-92,-16}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{94,-16},{42,-16}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-58,-16},{-58,14},{-18,14}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{22,14},{62,14},{62,-16}},
          color={0,0,255},
          thickness=1.0),
        Rectangle(
          extent={{-18,22},{22,20}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{24,12},{20,16}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-16,12},{-20,16}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(extent={{-98,70},{102,30}},
          textColor={0,0,0},
          textString="%name")},
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
end Electrical_Braking_Series;
