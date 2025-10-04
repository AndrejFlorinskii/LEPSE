within Basic;
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

  Real U1d "D-axis voltage at the beginning of HVline";
  Real U1q "Q-axis voltage at the beginning of HVline";
  Real U2d "D-axis voltage at the end of HVline";
  Real U2q "Q-axis voltage at the end of HVline";
  Real I12d "D-axis current in the middle of HVline";
  Real I12q "Q-axis current in the middle of HVline";
  Real I12m "Full current in the middle of HVline";
  Real U1m "Full voltage at the beginning of HVline";
  Real U2m "Full voltage at the end of HVline";

  flow Real I1d "D-axis current at the beginning of HVline";
  flow Real I1q "Q-axis current at the beginning of HVline";
  flow Real I2d "D-axis current at the end of HVline";
  flow Real I2q "Q-axis current at the end of HVline";

  Real Idc1 "D-axis capacitive current at the beginning of HVline";
  Real Iqc1 "Q-axis capacitive current at the beginning of HVline";
  Real Idc2 "D-axis capacitive current at the end of HVline";
  Real Iqc2 "Q-axis capacitive current at the end of HVline";
  Real DU1 "angle at the beginning of HVline";
  Real DU2 "angle at the end of HVline";
  Real P1 "active power at the beginning of HVline";
  Real Q1 "reactive power at the beginning of HVline";
  Real P2 "active power at the end of HVline";
  Real Q2 "reactive power at the end of HVline";
  Real RL "actual active resistance of HVline";
  Real XL "actual reactive resistance of HVline";
  Real BL1 "capacitive conductivity at the beginning of HVline";
  Real BL2 "capacitive conductivity at the end of HVline";

  LEPSE.Interfaces.Pin_v2 inp annotation (extent=[-86,40; -66,60],
      Placement(transformation(extent={{-108,30},{-88,50}},rotation=0),
        iconTransformation(extent={{-108,30},{-88,50}})));
  LEPSE.Interfaces.Pin_v2 out annotation (extent=[68,42; 88,62], Placement(
        transformation(extent={{90,30},{110,50}},rotation=0),
        iconTransformation(extent={{90,30},{110,50}})));
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

  ////---connector2---
  out.Vd = U2d;
  out.Vq = U2q;
  out.Id = I2d;
  out.Iq = I2q;

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
          extent={{-36,54},{36,26}},
          lineColor={0,0,255},
          lineThickness=1.0),
        Rectangle(
          extent={{-74,6},{-46,-46}},
          lineColor={0,0,255},
          lineThickness=1.0),
        Rectangle(
          extent={{46,6},{74,-46}},
          lineColor={0,0,255},
          lineThickness=1.0),
        Line(
          points={{-60,-46},{-60,-66}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-74,-66},{-46,-66}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{60,-46},{60,-66}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{46,-66},{74,-66}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-60,6},{-60,40}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-36,40},{-90,40}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{60,6},{60,40}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{94,40},{36,40}},
          color={0,0,255},
          thickness=1.0),
        Text(extent={{-64,96},{64,64}},
          textColor={0,0,0},
          textString="%name"),
        Text(
          textString=String(P1),
          extent={{-96,-78},{102,-116}},
          textColor={0,0,0})},
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
