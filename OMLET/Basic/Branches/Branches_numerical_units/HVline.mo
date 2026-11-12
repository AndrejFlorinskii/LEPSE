within ;
model HVline
  outer LEPSE.Basic.SysData sysData;

  parameter Boolean inService = true "HVline topological condition"
  annotation(Dialog(tab="General"));
  parameter Real R_off = 1e8 "disconnecrion resistance, p.u."
  annotation(Dialog(tab="P-model parameters"));
  parameter Real G_off = 1e-5 "transverse grounding conductivity, p.u."
  annotation(Dialog(tab="P-model parameters"));

  parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA"
  annotation(Dialog(tab="General"));
  parameter Real Unom=330 "Nominal line voltage, kV"
  annotation(Dialog(tab="General"));
  parameter Real Rline=0.01 "Active resistance of Pi-model, Ω"
  annotation(Dialog(tab="P-model parameters"));
  parameter Real Xline=0.1 "Reactance of Pi-model, Ω"
  annotation(Dialog(tab="P-model parameters"));
  parameter Real Bline1=0 "Reactive conductivity of Pi-model beginning, mkS"
  annotation(Dialog(tab="P-model parameters"));
  parameter Real Bline2=0 "Reactive conductivity of Pi-model end, mkS"
  annotation(Dialog(tab="P-model parameters"));
  //---------------------------------------------
  parameter Real TLineOff=1000 "Time of line disconnection, s"
  annotation(Dialog(tab="General"));
  parameter Real dTLineOff=10 "Duration of line disconnection, s"
  annotation(Dialog(tab="General"));
  parameter Real Koff=2 "Degree of line disconnection, p.u."
  annotation(Dialog(tab="General"));
  parameter Real TLineOff_1=2000 "Time of line second disconnection, s"
  annotation(Dialog(tab="General"));
  parameter Real dTLineOff_1=20 "Duration of line second disconnection, s"
  annotation(Dialog(tab="General"));
  parameter Real Koff_1=4 "Degree of line second disconnection, p. u."
  annotation(Dialog(tab="General"));

  parameter Boolean displayPowerFlow=true "Display power flow"
  annotation(Dialog(tab="General"));
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
  Real G_gnd1 "calculation grounding conductivity";
  Real G_gnd2 "calculation grounding conductivity";

  LEPSE.Interfaces.Pin_v2 inp annotation (extent=[-86,40; -66,60],
      Placement(transformation(extent={{-108,-12},{-88,8}},rotation=0),
        iconTransformation(extent={{-108,-12},{-88,8}})));
  LEPSE.Interfaces.Pin_v2 out annotation (extent=[68,42; 88,62], Placement(
        transformation(extent={{90,-12},{110,8}},rotation=0),
        iconTransformation(extent={{90,-12},{110,8}})));
equation
  // the algorithm of triping transmission line
  RL = if not inService then R_off else
  (if (time >= TLineOff and time < TLineOff + dTLineOff) then (Koff*Rline*Sbaz/Unom^(2))
    else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Koff_1*Rline*Sbaz/Unom^(2)) else (Rline*Sbaz/Unom^(2))));
  XL = if not inService then R_off else
  (if (time >= TLineOff and time < TLineOff + dTLineOff) then (Koff*Xline*Sbaz/Unom^(2))
    else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Koff_1*Xline*Sbaz/Unom^(2)) else (Xline*Sbaz/Unom^(2))));
  BL1 = if not inService then 0 else
  (if (time >= TLineOff and time < TLineOff + dTLineOff) then (Bline1/Sbaz*Unom^(2)/10^(6)/Koff)
    else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Bline1/Sbaz*Unom^(2)/10^(6)/Koff_1) else (Bline1/Sbaz*Unom^(2)/10^(6))));
  BL2 = if not inService then 0 else
  (if (time >= TLineOff and time < TLineOff + dTLineOff) then (Bline2/Sbaz*Unom^(2)/10^(6)/Koff)
    else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Bline2/Sbaz*Unom^(2)/10^(6)/Koff_1) else (Bline2/Sbaz*Unom^(2)/10^(6))));
  G_gnd1 = if not inService then G_off else 0.0;
  G_gnd2 = if not inService then G_off else 0.0;

  // series impedance between nodes
  U1q = U2q + RL*I12q - XL*I12d;
  U1d = U2d + RL*I12d + XL*I12q;

  // line capacitances
  Idc1 = U1q*BL1 + U1d*G_gnd1;
  Iqc1 = -U1d*BL1 + U1q*G_gnd1;
  Idc2 = U2q*BL2 + U2d*G_gnd2;
  Iqc2 = -U2d*BL2 + U2q*G_gnd2;

  // balance of current
  I1d = Idc1 + I12d;
  I1q = Iqc1 + I12q;
  I12d = Idc2 + I2d;
  I12q = Iqc2 + I2q;

  // measurements
  I12m = (sqrt(I12d^2 + I12q^2))*Sbaz/Unom/sqrt(3);
  U1m = (sqrt(U1d^2 + U1q^2))*Unom;
  U2m = (sqrt(U2d^2 + U2q^2))*Unom;
  DU1 = atan2(U1d, U1q);
  DU2 = atan2(U2d, U2q);

  // powers
  P1 = (U1q*I1q + U1d*I1d)*Sbaz;
  Q1 = (-U1q*I1d + U1d*I1q)*Sbaz;
  P2 = (U2q*I2q + U2d*I2d)*Sbaz;
  Q2 = (-U2q*I2d + U2d*I2q)*Sbaz;

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

        // ТЕКСТ "ОТКЛ" (опционально)

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
        extent={{-100,-140},{100,100}},
        grid={2,2},
        initialScale=0), graphics),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-140},{100,100}},
        grid={2,2},
        initialScale=0),
      graphics={
        Rectangle(
          extent={{32,32},{36,26}},
          lineColor={0,0,255},
          lineThickness=1.0,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,62},{-30,-60}},
          color={0,0,255},
          thickness=1.0),
        Text(extent={{-64,96},{64,64}},
          textColor={0,0,0},
          textString="%name"),
        Text(
          textString=DynamicSelect("P MW",
          if P1>=0 then
            String(P1, significantDigits=3) + " MW →"
          else
            String(abs(P1), significantDigits=3) + " MW ←"),
          visible=displayPowerFlow,
          extent={{-96,-70},{102,-108}},
          textColor={0,168,6}),
        Text(
          textString=DynamicSelect("Q MVar",
          if Q1>=0 then
            String(Q1, significantDigits=3) + " MVar →"
          else
            String(abs(Q1), significantDigits=3) + " MVar ←"),
          visible=displayPowerFlow,
          extent={{-94,-96},{104,-134}},
          textColor={102,44,145}),
        Line(
          points={{0,62},{32,-60}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{24,-32},{-30,-60}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-18,-10},{24,-32}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-18,-10},{14,6}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{14,6},{-10,20}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{8,30},{-10,20}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-6,40},{8,30}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-48,0},{50,0}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-28,40},{30,40}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-28,40},{-40,32}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{40,32},{30,40}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-48,0},{-60,-8}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{60,-8},{50,0}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-40,32},{40,32}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-60,-8},{60,-8}},
          color={0,0,255},
          thickness=1.0),
        Rectangle(
          extent={{-60,-60},{60,-66}},
          lineColor={0,0,255},
          lineThickness=1.0,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-36,32},{-32,26}},
          lineColor={0,0,255},
          lineThickness=1.0,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-56,-8},{-52,-14}},
          lineColor={0,0,255},
          lineThickness=1.0,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{52,-8},{56,-14}},
          lineColor={0,0,255},
          lineThickness=1.0,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-48,-8},{-48,0}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{50,-8},{50,0}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-28,32},{-28,40}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-40,0},{-48,-8}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-32,-8},{-32,0}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-24,0},{-32,-8}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-16,-8},{-16,0}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-8,0},{-16,-8}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{0,-8},{0,0}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{8,0},{0,-8}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{16,-8},{16,0}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{24,0},{16,-8}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{32,-8},{32,0}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{40,0},{32,-8}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-20,40},{-28,32}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-12,32},{-12,40}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{-4,40},{-12,32}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{4,32},{4,40}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{12,40},{4,32}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{20,32},{20,40}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{28,40},{20,32}},
          color={0,0,255},
          thickness=1.0),
        Ellipse(
          extent={{-2,64},{2,60}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,40},{40,-40}},
          lineColor={255,0,0},
          lineThickness=3.5,
          visible=DynamicSelect(not inService, not inService)),
        Line(
          points={{-40,-40},{40,40}},
          lineColor={255,0,0},
          lineThickness=3.5,
          visible=DynamicSelect(not inService, not inService)),
        Text(
          extent={{-34,-20},{36,-76}},
          textColor={238,0,0},
          textString="DISC",
          visible=DynamicSelect(not inService, not inService))},
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
<p><span style=\"background-color: #ffffff;\">The Pi-model of a high voltage power transmission line. </span></p>
<p><span style=\"background-color: #ffffff;\">П-образная модель линии электропередачи. </span></p>
</html>"));
end HVline;
