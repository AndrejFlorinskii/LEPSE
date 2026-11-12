within ;
model Transformer
  outer LEPSE.Basic.SysData sysData;

  parameter Boolean inService = true "Transformer topological condition"
  annotation(Dialog(tab="General"));
  parameter Real R_off = 1000000
  annotation(Dialog(tab="G-model parameters"));
  parameter Real G_off = 1e-5 "transverse grounding conductivity, p.u."
  annotation(Dialog(tab="G-model parameters"));

  parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA"
  annotation(Dialog(tab="General"));
  Real kt "transformation coeffitient, p.u.";
  parameter Real k_step=0.015 "OLTC step"
  annotation(Dialog(tab="OLTC"));
  parameter Integer n_step=0 "current OLTC position"
  annotation(Dialog(tab="OLTC"));
  parameter Real Unom=330 "Nominal transformer voltage, kV"
  annotation(Dialog(tab="General"));
  parameter Real Rtrans=0.001 "Active resistance of T-model, Ω"
  annotation(Dialog(tab="G-model parameters"));
  parameter Real Xtrans=0.01 "Reactance of T-model, Ω"
  annotation(Dialog(tab="G-model parameters"));
  parameter Real Btrans=40 "Reactive conductivity of T-model, mkS"
  annotation(Dialog(tab="G-model parameters"));
  //---------------------------------------------
  parameter Real TtOff=1000 "Time of transformer disconnection, s"
  annotation(Dialog(tab="General"));
  parameter Real dTtOff=10 "Duration of transformer disconnection, s"
  annotation(Dialog(tab="General"));
  parameter Real Koff=100000 "Degree of transformer disconnection, s"
  annotation(Dialog(tab="General"));

  parameter Boolean displayPowerFlow=true "Display power flow"
  annotation(Dialog(tab="General"));
  //---------------------------------------------

  Real U1d "D-axis voltage at the beginning of transformer";
  Real U1q "Q-axis voltage at the beginning of transformer";
  Real U2d "D-axis voltage at the end of transformer";
  Real U2q "Q-axis voltage at the end of transformer";
  Real U1m "Full voltage at the beginning of transformer";
  Real U2m "Full voltage at the end of transformer";

  flow Real I1d "D-axis current at the beginning of transformer";
  flow Real I1q "Q-axis current at the beginning of transformer";
  flow Real I2d "D-axis current at the end of transformer";
  flow Real I2q "Q-axis current at the end of transformer";
  Real Idl "D-axis inductive current of T-model";
  Real Iql "Q-axis inductive current of T-model";
  Real I1m "Full current at the beginning of transformer";
  Real I2m "Full current at the end of transformer";

  Real P1 "active power at the beginning of transformer";
  Real Q1 "reactive power at the beginning of transformer";
  Real P2 "active power at the end of transformer";
  Real Q2 "reactive power at the end of transformer";
  Real Rt "actual active resistance of transformer";
  Real Xt "actual reactive resistance of transformer";
  Real Bt "actual reactive conductivity of transformer";
  Real G_gnd "calculation grounding conductivity";

  Real DU1 "angle at the beginning of transformer";
  Real DU2 "angle at the end of transformer";

  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[-88,0; -68,20],
    layer="icon",
    Placement(transformation(extent={{-110,-4},{-90,16}},
                                                        rotation=0),
        iconTransformation(extent={{-110,-4},{-90,16}})));
  LEPSE.Interfaces.Pin_v2 out annotation (
    extent=[70,0; 90,20],
    layer="icon",
    Placement(transformation(extent={{90,-4},{110,16}},
                                                      rotation=0),
        iconTransformation(extent={{90,-4},{110,16}})));
equation
  // transformation coeffitient calculation
  kt = 1.0 - k_step*n_step;

  // the algorithm of triping transformer
  Rt = if not inService then R_off else
  (if time >= TtOff and time < TtOff + dTtOff then Koff*Rtrans*kt^(2)*Sbaz/Unom^(2) else Rtrans*kt^(2)*Sbaz/Unom^(2));
  Xt = if not inService then R_off else
  (if time >= TtOff and time < TtOff + dTtOff then Koff*Xtrans*kt^(2)*Sbaz/Unom^(2) else Xtrans*kt^(2)*Sbaz/Unom^(2));
  Bt = if not inService then 0 else
  (if (time >= TtOff and time < TtOff + dTtOff) then (Btrans/Sbaz*Unom^(2)/10^(6)/Koff/kt^(2)) else Btrans/Sbaz*Unom^(2)/10^(6)/kt^(2));
  G_gnd = if not inService then G_off else 0.0;

  // series impedance between nodes
  U1q = kt*U2q + Rt*I2q - Xt*I2d;
  U1d = kt*U2d + Rt*I2d + Xt*I2q;

  // line inductances
  Idl = U1q*Bt + U1d*G_gnd;
  Iql = -U1d*Bt + U1q*G_gnd;

  // balance of current
  I1d = Idl + I2d;
  I1q = Iql + I2q;

  // measurements
  I1m = (sqrt(I1d^2 + I1q^2))*Sbaz/Unom/sqrt(3);
  I2m = (sqrt(I2d^2 + I2q^2))*Sbaz/Unom/sqrt(3);
  U1m = (sqrt(U1d^2 + U1q^2))*Unom;
  U2m = (sqrt(U2d^2 + U2q^2))*Unom;
  DU1 = atan2(U1d, U1q);
  DU2 = atan2(U2d, U2q);

  // powers
  P1 = (-inp.Vq*inp.Iq -inp.Vd*inp.Id)*Sbaz;
  Q1 = (inp.Vq*inp.Id -inp.Vd*inp.Iq)*Sbaz;
  P2 = (out.Vq*out.Iq + out.Vd*out.Id)*Sbaz;
  Q2 = (-out.Vq*out.Id + out.Vd*out.Iq)*Sbaz;

  //------connectors-----
  inp.Vd = U1d;
  inp.Vq = U1q;

  out.Vd = U2d;
  out.Vq = U2q;

  inp.Id = -I1d;
  inp.Iq = -I1q;

  out.Id = kt*I2d;
  out.Iq = kt*I2q;

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
        extent={{-100,-120},{100,120}},
        grid={2,2},
        initialScale=0),
      graphics={
        Text(extent={{-64,126},{66,98}},
          textColor={0,0,0},
          textString="%name"),
        Text(
          textString=DynamicSelect("P MW",
          if P1>=0 then
            String(P1, significantDigits=3) + " MW →"
          else
            String(abs(P1), significantDigits=3) + " MW ←"),
          visible=displayPowerFlow,
          extent={{-98,-56},{102,-96}},
          textColor={0,168,6}),
        Text(
          textString=DynamicSelect("Q MVar",
          if Q1>=0 then
            String(Q1, significantDigits=3) + " MVar →"
          else
            String(abs(Q1), significantDigits=3) + " MVar ←"),
          visible=displayPowerFlow,
          extent={{-96,-88},{102,-126}},
          textColor={102,44,145}),
        Text(
          textString=String(n_step),
          visible=displayPowerFlow,
          extent={{-66,72},{-2,40}},
          textColor={0,0,0}),
        Line(
          points={{0,66},{0,-48}},
          color={0,0,0},
          thickness=1.5),
        Rectangle(
          extent={{-50,72},{50,-56}},
          lineColor={0,0,255},
          lineThickness=1.0),
        Line(
          points={{-14,6},{-94,6}},
          color={0,0,0},
          thickness=1.5),
        Ellipse(
          extent={{-9.5,9.5},{9.5,-9.5}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={16.5,16.5},
          rotation=270),
        Ellipse(
          extent={{-9.5,9.5},{9.5,-9.5}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={16.5,34.5},
          rotation=270),
        Ellipse(
          extent={{-9.5,9.5},{9.5,-9.5}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={16.5,52.5},
          rotation=270),
        Ellipse(
          extent={{-9.5,9.5},{9.5,-9.5}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={16.5,-3.5},
          rotation=270),
        Ellipse(
          extent={{-9.5,9.5},{9.5,-9.5}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={16.5,-21.5},
          rotation=270),
        Ellipse(
          extent={{-9.5,9.5},{9.5,-9.5}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={16.5,-39.5},
          rotation=270),
        Ellipse(
          extent={{-9.5,9.5},{9.5,-9.5}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={-15.5,16.5},
          rotation=90),
        Ellipse(
          extent={{-9.5,9.5},{9.5,-9.5}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={-15.5,34.5},
          rotation=90),
        Ellipse(
          extent={{-9.5,9.5},{9.5,-9.5}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={-15.5,-3.5},
          rotation=90),
        Ellipse(
          extent={{-9.5,9.5},{9.5,-9.5}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={-15.5,-21.5},
          rotation=90),
        Line(
          points={{94,6},{16,6}},
          color={0,0,0},
          thickness=1.5),
        Rectangle(
          extent={{-2,86},{2,72}},
          lineColor={0,0,255},
          lineThickness=1.0,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,86},{-26,72}},
          lineColor={0,0,255},
          lineThickness=1.0,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,86},{32,72}},
          lineColor={0,0,255},
          lineThickness=1.0,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-52,92},{-40,80}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-48,72},{-48,80}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-42,72},{-42,82}},
          color={0,0,255},
          thickness=1),
        Text(
          extent={{20,-34},{48,-58}},
          textColor={0,0,0},
          textString="HV"),
        Text(
          extent={{-48,-34},{-20,-58}},
          textColor={0,0,0},
          textString="LV"),
        Line(
          points={{-40,60},{40,-20}},
          lineColor={255,0,0},
          lineThickness=3.5,
          visible=DynamicSelect(not inService, not inService)),
        Line(
          points={{-40,-20},{40,60}},
          lineColor={255,0,0},
          lineThickness=3.5,
          visible=DynamicSelect(not inService, not inService)),
        Text(
          extent={{-34,-10},{36,-66}},
          textColor={238,0,0},
          textString="DISC",
          visible=DynamicSelect(not inService, not inService))},
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
<p>The model of a two-winding transformer. </p>
<p>Модель двухобмоточного трансформатора. </p>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-120},{100,120}})));
end Transformer;
