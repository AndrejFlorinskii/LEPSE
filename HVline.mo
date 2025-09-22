within ;
model HVline
  parameter Real Rline=0.01 "Active resistance of Pi-model";
  parameter Real Xline=0.1 "Reactance of Pi-model";
  parameter Real Bline1=0 "Reactive conductivity of Pi-model beginning";
  parameter Real Bline2=0 "Reactive conductivity of Pi-model end";
  //---------------------------------------------
  parameter Real TLineOff=1000 "Time of line disconnection";
  parameter Real dTLineOff=10 "Duration of line disconnection";
  parameter Real Koff=2 "Degree of line disconnection";
  parameter Real TLineOff_1=2000 "Time of line second disconnection";
  parameter Real dTLineOff_1=20 "Duration of line second disconnection";
  parameter Real Koff_1=4 "Degree of line second disconnection";
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
  flow Real I1d;
  flow Real I1q;
  flow Real I2d;
  flow Real I2q;
  Real Idc1;
  Real Iqc1;
  Real Idc2;
  Real Iqc2;
  Real DU1;
  Real DU2;
  Real P1;
  Real Q1;
  Real P2;
  Real Q2;
  Real RL;
  Real XL;
  Real BL1;
  Real BL2;
  LEPSE.Basic.Pin_v2 inp annotation (extent=[-86,40; -66,60], Placement(
        transformation(extent={{-86,40},{-66,60}}, rotation=0)));
  LEPSE.Basic.Pin_v2 out annotation (extent=[68,42; 88,62], Placement(
        transformation(extent={{68,42},{88,62}}, rotation=0)));
equation
  // the algorithm of triping transmission line
  RL = if (time >= TLineOff and time < TLineOff + dTLineOff) then (Koff*Rline)
    else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Koff_1*Rline) else (Rline));
  XL = if (time >= TLineOff and time < TLineOff + dTLineOff) then (Koff*Xline)
    else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Koff_1*Xline) else (Xline));
  BL1 = if (time >= TLineOff and time < TLineOff + dTLineOff) then (Bline1/Koff)
    else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Bline1/Koff_1) else (Bline1));
  BL2 = if (time >= TLineOff and time < TLineOff + dTLineOff) then (Bline2/Koff)
    else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Bline2/Koff_1) else (Bline2));
  // series impedance between nodes
  U1q = U2q + RL*I12q - XL*I12d;
  U1d = U2d + RL*I12d + XL*I12q;
  // line capacitances
  Idc1 = U1q*BL1;
  Iqc1 = -U1d*BL1;
  Idc2 = U2q*BL2;
  Iqc2 = -U2d*BL2;
  // balance of current
  I1d = Idc1 + I12d;
  I1q = Iqc1 + I12q;
  I12d = Idc2 + I2d;
  I12q = Iqc2 + I2q;
  // measurements
  I12m = sqrt(I12d^2 + I12q^2);
  U1m = sqrt(U1d^2 + U1q^2);
  U2m = sqrt(U2d^2 + U2q^2);
  DU1 = atan2(U1d, U1q);
  DU2 = atan2(U2d, U2q);
  // powers
  P1 = U1q*I1q + U1d*I1d;
  Q1 = -U1q*I1d + U1d*I1q;
  P2 = U2q*I2q + U2d*I2d;
  Q2 = -U2q*I2d + U2d*I2q;
  //---connector1---
  inp.Vd = U1d;
  inp.Vq = U1q;
  inp.Id = -I1d;
  inp.Iq = -I1q;
  //connect(inp.Vd, U1d);
  //connect(inp.Vq, U1q);
  //connect(inp.Id, I1d);
  //connect(inp.Iq, I1q);
  ////---connector2---
  out.Vd = U2d;
  out.Vq = U2q;
  out.Id = I2d;
  out.Iq = I2q;
  //connect(out.Vd, U2d);
  //connect(out.Vq, U2q);
  //connect(out.Id, I2d);
  //connect(out.Iq, I2q);
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.13,
      y=0.17,
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
          extent={{-30,60},{30,40}},
          lineColor={28,108,200},
          lineThickness=1.0),
        Rectangle(
          extent={{-60,20},{-40,-20}},
          lineColor={28,108,200},
          lineThickness=1.0),
        Rectangle(
          extent={{40,20},{60,-20}},
          lineColor={28,108,200},
          lineThickness=1.0),
        Line(
          points={{-50,-20},{-50,-40}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{-60,-40},{-40,-40}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{50,-20},{50,-40}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{40,-40},{60,-40}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{-50,20},{-50,50}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{-30,50},{-70,50}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{50,20},{50,52}},
          color={28,108,200},
          thickness=1.0),
        Line(
          points={{70,52},{30,52}},
          color={28,108,200},
          thickness=1.0),
        Text(extent={{-64,-48},{64,-80}}, textString=
                                              "%name")},
      Rectangle(extent=[-30, 60; 30, 40], style(thickness=2)),
      Rectangle(extent=[-60, 20; -40, -20], style(thickness=2)),
      Rectangle(extent=[40, 20; 60, -20], style(thickness=2)),
      Line(points=[-50, -20; -50, -40], style(thickness=2)),
      Line(points=[-60, -40; -40, -40], style(thickness=2)),
      Line(points=[50, -20; 50, -40], style(thickness=2)),
      Line(points=[40, -40; 60, -40], style(thickness=2)),
      Line(points=[-50, 20; -50, 50], style(thickness=2)),
      Line(points=[-30, 50; -70, 50], style(thickness=2)),
      Line(points=[50, 20; 50, 52], style(thickness=2)),
      Line(points=[70, 52; 30, 52], style(thickness=2)),
      Text(extent=[-64, -48; 64, -80], string="%name")),
    Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">The simplest model of a high voltage power transmission line</span></p>
</html>"));
end HVline;
