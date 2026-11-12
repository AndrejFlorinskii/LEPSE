within Basic;
package Transformers

  package Transformers_numerical_units
    model Transformer
      outer SysData sysData;

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

    model Autotransformer
      outer SysData sysData;

      parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA"
      annotation(Dialog(tab="General"));
      Real kt_hm "transformation coeffitient high - middle voltage, p.u.";
      parameter Real k_step=0.015 "OLTC step"
      annotation(Dialog(tab="OLTC"));
      parameter Integer n_step=0 "current OLTC position"
      annotation(Dialog(tab="OLTC"));
      parameter Real Unom_HV=330 "Nominal transformer voltage, kV"
      annotation(Dialog(tab="General"));
      parameter Real Unom_MV=110 "Nominal transformer voltage, kV"
      annotation(Dialog(tab="General"));
      parameter Real Unom_LV=10 "Nominal transformer voltage, kV"
      annotation(Dialog(tab="General"));
      parameter Real Rline_HV=0.001 "Active resistance of high voltage side, Ω"
      annotation(Dialog(tab="3‑ray model parameters"));
      parameter Real Xline_HV=0.01 "Reactance of of high voltage side, Ω"
      annotation(Dialog(tab="3‑ray model parameters"));
      parameter Real Rline_MV=0.001 "Active resistance of middle voltage side, Ω"
      annotation(Dialog(tab="3‑ray model parameters"));
      parameter Real Xline_MV=0.01 "Reactance of middle voltage side, Ω"
      annotation(Dialog(tab="3‑ray model parameters"));
      parameter Real Rline_LV=0.001 "Active resistance of low voltage side, Ω"
      annotation(Dialog(tab="3‑ray model parameters"));
      parameter Real Xline_LV=0.01 "Reactance of low voltage side, Ω"
      annotation(Dialog(tab="3‑ray model parameters"));
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

      Real U1d_HV "D-axis voltage at the beginning of HV side";
      Real U1q_HV "Q-axis voltage at the beginning of HV side";
      Real U1d_MV "D-axis voltage at the beginning of MV side";
      Real U1q_MV "Q-axis voltage at the beginning of MV side";
      Real U1d_LV "D-axis voltage at the beginning of LV side";
      Real U1q_LV "Q-axis voltage at the beginning of LV side";
      Real U2d_HV "D-axis voltage at the end of HV side";
      Real U2q_HV "Q-axis voltage at the end of HV side";
      Real U2d_MV "D-axis voltage at the end of MV side";
      Real U2q_MV "Q-axis voltage at the end of MV side";
      Real U2d_LV "D-axis voltage at the end of LV side";
      Real U2q_LV "Q-axis voltage at the end of LV side";
      Real I12d_HV "D-axis current in the middle of HV side";
      Real I12q_HV "Q-axis current in the middle of HV side";
      Real I12d_MV "D-axis current in the middle of MV side";
      Real I12q_MV "Q-axis current in the middle of MV side";
      Real I12d_LV "D-axis current in the middle of LV side";
      Real I12q_LV "Q-axis current in the middle of LV side";
      Real I12m_HV "Full current in the middle of HV side";
      Real I12m_MV "Full current in the middle of MV side";
      Real I12m_LV "Full current in the middle of LV side";
      Real U1m_HV "Full voltage at the beginning of HV side";
      Real U1m_MV "Full voltage at the beginning of MV side";
      Real U1m_LV "Full voltage at the beginning of LV side";
      Real U2m_HV "Full voltage at the end of HV side";
      Real U2m_MV "Full voltage at the end of MV side";
      Real U2m_LV "Full voltage at the end of LV side";
      Real P1_HV "active power at the beginning of HV side";
      Real P1_MV "active power at the beginning of MV side";
      Real P1_LV "active power at the beginning of LV side";
      Real Q1_HV "reactive power at the beginning of HV side";
      Real Q1_MV "reactive power at the beginning of MV side";
      Real Q1_LV "reactive power at the beginning of LV side";
      Real P2_HV "active power at the end of HV sid";
      Real P2_MV "active power at the end of MV side";
      Real P2_LV "active power at the end of LV side";
      Real Q2_HV "reactive power at the end of HV side";
      Real Q2_MV "reactive power at the end of MV side";
      Real Q2_LV "reactive power at the end of LV side";
      Real RL_HV "actual active resistance of HV side";
      Real RL_MV "actual active resistance of MV side";
      Real RL_LV "actual active resistance of LV side";
      Real XL_HV "actual reactive resistance of HV side";
      Real XL_MV "actual reactive resistance of MV side";
      Real XL_LV "actual reactive resistance of LV side";

      LEPSE.Interfaces.Pin_v2 HV_pin annotation (
        extent=[-88,0; -68,20],
        layer="icon",
        Placement(transformation(extent={{-110,-4},{-90,16}}, rotation=0),
            iconTransformation(extent={{-110,-4},{-90,16}})));
      LEPSE.Interfaces.Pin_v2 MV_pin annotation (
        extent=[70,0; 90,20],
        layer="icon",
        Placement(transformation(extent={{90,20},{110,40}}, rotation=0),
            iconTransformation(extent={{90,20},{110,40}})));
      LEPSE.Interfaces.Pin_v2 LV_pin annotation (
        extent=[-88,0; -68,20],
        layer="icon",
        Placement(transformation(extent={{-10,-108},{10,-88}}, rotation=0),
            iconTransformation(extent={{88,-90},{108,-70}})));
    equation
      // transformation coeffitient calculation
      kt_hm = 1.0 + k_step*n_step;

      // the algorithm of triping transmission line
      RL_HV = if time >= TtOff and time < TtOff + dTtOff then Koff*Rline_HV*Sbaz/Unom_HV^(2) else Rline_HV*Sbaz/Unom_HV^(2);
      XL_HV = if time >= TtOff and time < TtOff + dTtOff then Koff*Xline_HV*Sbaz/Unom_HV^(2) else Xline_HV*Sbaz/Unom_HV^(2);
      RL_MV = if time >= TtOff and time < TtOff + dTtOff then Koff*Rline_MV*kt_hm^(2)*Sbaz/Unom_HV^(2) else Rline_MV*kt_hm^(2)*Sbaz/Unom_HV^(2);
      XL_MV = if time >= TtOff and time < TtOff + dTtOff then Koff*Xline_MV*kt_hm^(2)*Sbaz/Unom_HV^(2) else Xline_MV*kt_hm^(2)*Sbaz/Unom_HV^(2);
      RL_LV = if time >= TtOff and time < TtOff + dTtOff then Koff*Rline_LV*Sbaz/Unom_HV^(2) else Rline_LV*Sbaz/Unom_HV^(2);
      XL_LV = if time >= TtOff and time < TtOff + dTtOff then Koff*Xline_LV*Sbaz/Unom_HV^(2) else Xline_LV*Sbaz/Unom_HV^(2);

      // series impedance between nodes
      U1q_HV = U2q_HV + RL_HV*I12q_HV - XL_HV*I12d_HV;
      U1d_HV = U2d_HV + RL_HV*I12d_HV + XL_HV*I12q_HV;
      kt_hm*U1q_MV = U2q_MV + RL_MV*I12q_MV - XL_MV*I12d_MV;
      kt_hm*U1d_MV = U2d_MV + RL_MV*I12d_MV + XL_MV*I12q_MV;
      U1q_LV = U2q_LV + RL_LV*I12q_LV - XL_LV*I12d_LV;
      U1d_LV = U2d_LV + RL_LV*I12d_LV + XL_LV*I12q_LV;

      //connections of HV, MV and LV sides
      U2q_HV = U1q_MV;
      U2d_HV = U1d_MV;
      U2q_HV = U1q_LV;
      U2d_HV = U1d_LV;

      I12d_HV = I12d_MV + I12d_LV;
      I12q_HV = I12q_MV + I12q_LV;

      // measurements
      I12m_HV = (sqrt(I12d_HV^2 + I12q_HV^2))*Sbaz/Unom_HV/sqrt(3);
      I12m_MV = (sqrt(I12d_MV^2 + I12q_MV^2))*Sbaz/Unom_MV/sqrt(3);
      I12m_LV = (sqrt(I12d_LV^2 + I12q_LV^2))*Sbaz/Unom_LV/sqrt(3);

      U1m_HV = (sqrt(U1d_HV^2 + U1q_HV^2))*Unom_HV;
      U2m_HV = (sqrt(U2d_HV^2 + U2q_HV^2))*Unom_HV;

      U1m_MV = (sqrt(U1d_MV^2 + U1q_MV^2))*Unom_MV;
      U2m_MV = (sqrt(U2d_MV^2 + U2q_MV^2))*Unom_MV;

      U1m_LV = (sqrt(U1d_LV^2 + U1q_LV^2))*Unom_LV;
      U2m_LV = (sqrt(U2d_LV^2 + U2q_LV^2))*Unom_LV;

      // powers
      P1_HV = (HV_pin.Vq*HV_pin.Iq + HV_pin.Vd*HV_pin.Id)*Sbaz;
      Q1_HV = (-HV_pin.Vq*HV_pin.Id + HV_pin.Vd*HV_pin.Iq)*Sbaz;

      P2_HV = (U2q_HV*I12q_HV + U2d_HV*I12d_HV)*Sbaz;
      Q2_HV = (-U2q_HV*I12d_HV + U2d_HV*I12q_HV)*Sbaz;

      P1_MV = (U1q_MV*I12q_MV + U1d_MV*I12d_MV)*Sbaz;
      Q1_MV = (-U1q_MV*I12d_MV + U1d_MV*I12q_MV)*Sbaz;

      P2_MV = (-MV_pin.Vq*MV_pin.Iq - MV_pin.Vd*MV_pin.Id)*Sbaz;
      Q2_MV = (MV_pin.Vq*MV_pin.Id - MV_pin.Vd*MV_pin.Iq)*Sbaz;

      P1_LV = (U1q_LV*I12q_LV + U1d_LV*I12d_LV)*Sbaz;
      Q1_LV = (-U1q_LV*I12d_LV + U1d_LV*I12q_LV)*Sbaz;

      P2_LV = (-LV_pin.Vq*LV_pin.Iq - LV_pin.Vd*LV_pin.Id)*Sbaz;
      Q2_LV = (LV_pin.Vq*LV_pin.Id - LV_pin.Vd*LV_pin.Iq)*Sbaz;

      //------connectors-----
      HV_pin.Vd = U1d_HV;
      HV_pin.Vq = U1q_HV;

      MV_pin.Vd = U2d_MV;
      MV_pin.Vq = U2q_MV;

      LV_pin.Vd = U2d_LV;
      LV_pin.Vq = U2q_LV;

      HV_pin.Id = I12d_HV;
      HV_pin.Iq = I12q_HV;

      kt_hm*MV_pin.Id = -I12d_MV;
      kt_hm*MV_pin.Iq = -I12q_MV;

      LV_pin.Id = I12d_LV;
      LV_pin.Iq = I12q_LV;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(extent={{-64,126},{66,98}},
              textColor={0,0,0},
              textString="%name"),
            Text(
              textString=DynamicSelect("P MW",
              if P1_HV>=0 then
                String(P1_HV, significantDigits=3) + " MW →"
              else
                String(abs(P1_HV), significantDigits=3) + " MW ←"),
              visible=displayPowerFlow,
              extent={{-244,54},{-44,14}},
              textColor={0,168,6}),
            Text(
              textString=DynamicSelect("Q MVar",
              if Q1_HV>=0 then
                String(Q1_HV, significantDigits=3) + " MVar →"
              else
                String(abs(Q1_HV), significantDigits=3) + " MVar ←"),
              visible=displayPowerFlow,
              extent={{-248,2},{-50,-36}},
              textColor={102,44,145}),
            Text(
              textString=String(n_step),
              visible=displayPowerFlow,
              extent={{-66,72},{-2,40}},
              textColor={0,0,0}),
            Line(
              points={{0,54},{0,-48}},
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
              points={{16,-80},{16,-30}},
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
            Ellipse(
              extent={{-9.5,9.5},{9.5,-9.5}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None,
              closure=EllipseClosure.None,
              startAngle=0,
              endAngle=180,
              origin={-15.5,52.5},
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
              origin={-15.5,-39.5},
              rotation=90),
            Line(
              points={{66,62},{-16,62}},
              color={0,0,0},
              thickness=1.5),
            Line(
              points={{66,30},{66,62}},
              color={0,0,0},
              thickness=1.5),
            Line(
              points={{100,30},{66,30}},
              color={0,0,0},
              thickness=1.5),
            Text(
              textString=DynamicSelect("P MW",
              if P1_MV>=0 then
                String(P1_MV, significantDigits=3) + " MW →"
              else
                String(abs(P1_MV), significantDigits=3) + " MW ←"),
              visible=displayPowerFlow,
              extent={{36,84},{236,44}},
              textColor={0,168,6}),
            Text(
              textString=DynamicSelect("Q MVar",
              if Q1_MV>=0 then
                String(Q1_MV, significantDigits=3) + " MVar →"
              else
                String(abs(Q1_MV), significantDigits=3) + " MVar ←"),
              visible=displayPowerFlow,
              extent={{40,24},{238,-14}},
              textColor={102,44,145}),
            Text(
              textString=DynamicSelect("P MW",
              if P1_LV>=0 then
                String(P1_LV, significantDigits=3) + " MW ←"
              else
                String(abs(P1_LV), significantDigits=3) + " MW →"),
              visible=displayPowerFlow,
              extent={{36,-32},{236,-72}},
              textColor={0,168,6}),
            Text(
              textString=DynamicSelect("Q MVar",
              if Q1_LV>=0 then
                String(Q1_LV, significantDigits=3) + " MVar ←"
              else
                String(abs(Q1_LV), significantDigits=3) + " MVar →"),
              visible=displayPowerFlow,
              extent={{40,-90},{238,-128}},
              textColor={102,44,145}),
            Text(
              extent={{-48,34},{-16,-2}},
              textColor={0,0,0},
              textString="HV"),
            Text(
              extent={{20,64},{48,34}},
              textColor={0,0,0},
              textString="MV"),
            Text(
              extent={{20,-30},{50,-58}},
              textColor={0,0,0},
              textString="LV"),
            Line(
              points={{98,-80},{16,-80}},
              color={0,0,0},
              thickness=1.5)}),                                      Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>Autotransformer model.</p>
<p>Модель  автотрансформатора. </p>
</html>"));
    end Autotransformer;
  end Transformers_numerical_units;

  package Transformers_per_units
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
  end Transformers_per_units;
end Transformers;
