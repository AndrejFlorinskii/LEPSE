within Basic;
package Branches

  package Branches_numerical_units
    model El_Braking_Series
      outer SysData sysData;

      parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
      parameter Real Unom=20 "Nominal voltage, kV";
      parameter Real Rline=0.2 "Active resistance of electrical braking device, Ω";
      parameter Real Rl(fixed=false) "Active resistance of electrical braking device, p.u.";
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
    initial equation
      // conversion from Ω to p.u.
      Rl = Rline/Unom^(2)*Sbaz;

    equation
      // the algorithm of series electrical braking start
      RL = if time >= TLineOff and time < TLineOff + dTLineOff then Rl else 0;

      //---------series impedance between nodes--------------------
      U1q = U2q + RL*I12q;
      U1d = U2d + RL*I12d;

      //---------measurements--------------------------------------
      I12m = (sqrt(I12d^2 + I12q^2))*Sbaz/Unom/sqrt(3);
      U1m = (sqrt(U1d^2 + U1q^2))*Unom;
      U2m = (sqrt(U2d^2 + U2q^2))*Unom;

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
<p><span style=\"background-color: #ffffff;\">Model of series electric braking device. </span></p>
<p><span style=\"background-color: #ffffff;\">Модель устройства последовательного электрического торможения.</span></p>
</html>"));
    end El_Braking_Series;

    model Breaker
      outer SysData sysData;

      parameter Boolean inService = true "breaker topological condition";
      parameter Real R_off = 1e8 "disconnecrion resistance, p.u.";
      parameter Real G_off = 1e-5 "transverse grounding conductivity, p.u.";

      parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
      parameter Real Unom=330 "Nominal line voltage, kV";
      //---------------------------------------------
      parameter Real TLineOff=1000 "Time of line disconnection, s";
      parameter Real dTLineOff=10 "Duration of line disconnection, s";
      parameter Real Koff=2 "Degree of line disconnection, p.u.";
      parameter Real TLineOff_1=2000 "Time of line second disconnection, s";
      parameter Real dTLineOff_1=20 "Duration of line second disconnection, s";
      parameter Real Koff_1=4 "Degree of line second disconnection, p. u.";

      parameter Boolean displayPowerFlow=true "Display power flow";
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
      (if (time >= TLineOff and time < TLineOff + dTLineOff) then (R_off)
        else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (R_off) else (0.00001)));
      XL = if not inService then R_off else
      (if (time >= TLineOff and time < TLineOff + dTLineOff) then (R_off)
        else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (R_off) else (0.00001)));
      G_gnd1 = if not inService then G_off else 0.00001;
      G_gnd2 = if not inService then G_off else 0.00001;

      // series impedance between nodes
      U1q = U2q + RL*I12q - XL*I12d;
      U1d = U2d + RL*I12d + XL*I12q;

      // line capacitances
      Idc1 = U1d*G_gnd1;
      Iqc1 = U1q*G_gnd1;
      Idc2 = U2d*G_gnd2;
      Iqc2 = U2q*G_gnd2;

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
              points={{-20,0},{-98,0}},
              color={0,0,255},
              thickness=1.0),
            Line(
              points={{30,-2},{30,32}},
              lineColor={0,0,255},
              lineThickness=2.5,
              visible=DynamicSelect(not inService, not inService)),
            Text(
              extent={{-34,30},{36,-76}},
              textColor={255,0,0},
              textString="DISC",
              visible=DynamicSelect(not inService, not inService)),
            Rectangle(
              extent={{-40,46},{40,-48}},
              lineColor={0,0,255},
              lineThickness=1),
            Line(
              points={{100,0},{30,0}},
              color={0,0,255},
              thickness=1.0),
            Line(
              points={{28,30},{-20,0}},
              color={0,0,255},
              thickness=1.0)},
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
<p>Breaker model.</p>
<p>Модель выключателя. </p>
</html>"));
    end Breaker;

    model HVline
      outer SysData sysData;

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

    model El_Braking_Shunt
      outer SysData sysData;

      parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
      parameter Real Unom=20 "Nominal voltage, kV";
      parameter Real Rline=0.2 "Active resistance of electrical braking device, Ω";
      parameter Real Rl(fixed=false) "Active resistance of electrical braking device, p.u.";
      //---------------------------------------------
      parameter Real TLineOff=1000 "Time of electrical braking, s";
      parameter Real dTLineOff=10 "Duration of electrical braking, s";
      //---------------------------------------------

      Real Ud "D-axis voltage of shunt electrical braking";
      Real Uq "Q-axis voltage of shunt electrical braking";
      Real I12d "D-axis current of shunt electrical braking";
      Real I12q "Q-axis current of shunt electrical braking";
      Real I12m "Full current of shunt electrical braking";
      Real Um "Full voltage of shunt electrical braking";
      LEPSE.Interfaces.Pin_v2 inp annotation (
        extent=[-10,78; 10,98],
        layer="icon",
        Placement(transformation(extent={{-10,88},{10,108}},rotation=0),
            iconTransformation(extent={{-10,88},{10,108}})));
    initial equation
      // conversion from Ω to p.u.
      Rl = Rline/Unom^(2)*Sbaz;

    equation
      // the algorithm of shunt electrical braking start
      I12d = if time >= TLineOff and time < TLineOff + dTLineOff then Ud/Rl
         else 0;
      I12q = if time >= TLineOff and time < TLineOff + dTLineOff then Uq/Rl
         else 0;

      //---------measurements-----------------------------------------------------
      I12m = (sqrt(I12d^2 + I12q^2))*Sbaz/Unom/sqrt(3);
      Um = (sqrt(Ud^2 + Uq^2))*Unom;

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
              extent={{-20,50},{20,-30}},
              lineColor={0,0,255},
              lineThickness=1.0,
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-20,-50},{20,-50}},
              color={0,0,255},
              thickness=1.0),
            Line(
              points={{0,-50},{0,-30}},
              color={0,0,255},
              thickness=1.0),
            Rectangle(
              extent={{-10,80},{10,60}},
              lineColor={0,0,255},
              lineThickness=1.0,
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,50},{0,60}},
              color={0,0,255},
              thickness=1.0),
            Line(
              points={{0,80},{0,90}},
              color={0,0,255},
              thickness=1.0),
            Text(extent={{-98,-50},{102,-88}},
              textColor={0,0,0},
              textString="%name")},
          Rectangle(extent=[-20, 40; 20, -40], style(thickness=2, fillColor=8)),
          Line(points=[-20, -60; 20, -60], style(thickness=2)),
          Line(points=[0, -60; 0, -40], style(thickness=2)),
          Rectangle(extent=[-10, 70; 10, 50], style(thickness=2, fillColor=8)),
          Line(points=[0, 40; 0, 50], style(thickness=2)),
          Line(points=[0, 70; 0, 80], style(thickness=2)),
          Text(extent=[-100, -62; 100, -100], string="%name")),
        Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">Model of parallel electric braking device. </span></p>
<p><span style=\"background-color: #ffffff;\">Модель устройства параллельного электрического торможения.</span></p>
</html>"));
    end El_Braking_Shunt;
  end Branches_numerical_units;

  package Branches_per_units
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

    model El_Braking_Shunt
      parameter Real Rline=0.2 "Active resistance of electrical braking device";
      //---------------------------------------------
      parameter Real TLineOff=1000 "Time of electrical braking";
      parameter Real dTLineOff=10 "Duration of electrical braking";
      //---------------------------------------------

      Real Ud "D-axis voltage of shunt electrical braking";
      Real Uq "Q-axis voltage of shunt electrical braking";
      Real I12d "D-axis current of shunt electrical braking";
      Real I12q "Q-axis current of shunt electrical braking";
      Real I12m "Full current of shunt electrical braking";
      Real Um "Full voltage of shunt electrical braking";
      LEPSE.Interfaces.Pin_v2 inp annotation (
        extent=[-10,78; 10,98],
        layer="icon",
        Placement(transformation(extent={{-10,88},{10,108}},rotation=0),
            iconTransformation(extent={{-10,88},{10,108}})));
    equation
      // the algorithm of shunt electrical braking start
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
              extent={{-20,50},{20,-30}},
              lineColor={0,0,255},
              lineThickness=1.0,
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-20,-50},{20,-50}},
              color={0,0,255},
              thickness=1.0),
            Line(
              points={{0,-50},{0,-30}},
              color={0,0,255},
              thickness=1.0),
            Rectangle(
              extent={{-10,80},{10,60}},
              lineColor={0,0,255},
              lineThickness=1.0,
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,50},{0,60}},
              color={0,0,255},
              thickness=1.0),
            Line(
              points={{0,80},{0,90}},
              color={0,0,255},
              thickness=1.0),
            Text(extent={{-98,-50},{102,-88}},
              textColor={0,0,0},
              textString="%name")},
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
    end El_Braking_Shunt;

    model El_Braking_Series
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
    end El_Braking_Series;
  end Branches_per_units;
end Branches;
