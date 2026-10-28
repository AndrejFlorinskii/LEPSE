within Basic;
package Shunts

  package Shunts_numerical_units
    model Constant_Conductivity_Load
      outer SysData sysData;

      parameter Boolean inService = true "Load topological condition";

      parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
      parameter Real Unom=330 "Nominal load voltage, kV";
      parameter Real Pn=10 "Active load, MW";
      parameter Real Qn=1 "Reactive load, MVar";
      parameter Real Gn(fixed=false) "Active load, S";
      parameter Real Bn(fixed=false) "Reactive load, S";
      //-------------------------------------------------------------
      parameter Real TloadOff=1000 "Time of load disconnection, s";
      parameter Real dTloadOff=10 "Duration of load disconnection, s";
      parameter Real Koff=0.7 "Degree of load disconnection, p.u.";

      parameter Boolean displayPowerFlow = true;
      //-------------------------------------------------------------
      Real Udn "D-axis voltage of load";
      Real Uqn "Q-axis voltage of load";
      Real Iqn "D-axis current of load";
      Real Idn "Q-axis current of load";
      Real Pn_fact "Active power of load fact";
      Real Qn_fact "Reactive power of load fact";
      LEPSE.Interfaces.Pin_v2 inp annotation (
        extent=[-10,76; 10,96],
        layer="icon",
        Placement(transformation(extent={{-10,88},{10,108}},rotation=0),
            iconTransformation(extent={{-10,88},{10,108}})));
    initial equation
      // calculating conductivity from power
      Gn = if not inService then 0.00001 else
      Pn/Sbaz;
      Bn = if not inService then -0.00001 else
      -Qn/Sbaz;

    equation

      // active and reactive load
      Pn_fact = (Uqn*Iqn + Udn*Idn)*Sbaz;
      Qn_fact = (-Uqn*Idn + Udn*Iqn)*Sbaz;

      //the algorithm of triping load
      Idn = if time >= TloadOff and time < TloadOff + dTloadOff then Koff*(Udn*
        Gn + Uqn*Bn) else Udn*Gn + Uqn*Bn;
      Iqn = if time >= TloadOff and time < TloadOff + dTloadOff then Koff*(Uqn*
        Gn - Udn*Bn) else Uqn*Gn - Udn*Bn;

      //-----connector-----
      inp.Vd = Udn;
      inp.Vq = Uqn;

      inp.Id = -Idn;
      inp.Iq = -Iqn;

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.31,
          y=0.4,
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
            Line(
              points={{80,-60},{-80,-60}},
              color={0,0,0},
              thickness=1),
            Text(extent={{-98,-62},{102,-98}},
              textColor={0,0,0},
              textString="%name"),
              Text(
              textString=DynamicSelect("Pn MW", String(Pn_fact, significantDigits=3) + " MW"),
              visible=displayPowerFlow,
              extent={{-94,-102},{104,-140}},
              textColor={0,168,6}),
            Text(
              textString=DynamicSelect("Qn MVar", String(Qn_fact, significantDigits=3) + " MVar"),
              visible=displayPowerFlow,
              extent={{-94,-140},{104,-178}},
              textColor={102,44,145}),
            Line(
              points={{-80,0},{-80,-60}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{80,20},{80,-60}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-80,0},{-40,20}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-40,0},{0,20}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{0,0},{40,20}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{40,0},{80,20}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-40,20},{-40,0}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{0,20},{0,0}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{40,20},{40,0}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-60,-20},{-20,-20}},
              color={28,108,200},
              thickness=1),
            Line(
              points={{-60,-40},{-20,-40}},
              color={28,108,200},
              thickness=1),
            Line(
              points={{-60,-20},{-60,-40}},
              color={28,108,200},
              thickness=1),
            Line(
              points={{-20,-20},{-20,-40}},
              color={28,108,200},
              thickness=1),
            Line(
              points={{20,-20},{60,-20}},
              color={28,108,200},
              thickness=1),
            Line(
              points={{20,-40},{60,-40}},
              color={28,108,200},
              thickness=1),
            Line(
              points={{20,-20},{20,-40}},
              color={28,108,200},
              thickness=1),
            Line(
              points={{60,-20},{60,-40}},
              color={28,108,200},
              thickness=1),
            Line(
              points={{-74,2},{-70,60}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-50,16},{-54,60}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-54,60},{-70,60}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-60,70},{-58,80},{-56,84},{-62,70},{-66,72},{-54,90}},
              pattern=LinePattern.None,
              thickness=1),
            Line(
              points={{-6,54},{38,46}},
              pattern=LinePattern.None,
              thickness=1),
            Line(
              points={{-58,82},{-60,70}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-48,76},{-60,70}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-58,92},{-58,82}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-52,98},{-58,92}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-40,100},{-52,98}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-26,100},{-40,100}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-26,100},{-20,96}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-42,82},{-48,76}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-36,84},{-42,82}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-24,84},{-36,84}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-20,90},{-24,84}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-20,96},{-20,90}},
              color={0,0,0},
              thickness=1),
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
              extent={{-34,-15},{36,-81}},
              textColor={238,0,0},
              textString="DISC",
              visible=DynamicSelect(not inService, not inService))},
          Rectangle(extent=[-20, 60; 20, -40], style(thickness=2)),
          Line(points=[0, -40; 0, -60], style(thickness=2)),
          Line(points=[-20, -60; 20, -60], style(thickness=2)),
          Line(points=[0, 80; 0, 60], style(thickness=2)),
          Text(extent=[-100, -64; 100, -100], string="%name")),
        Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">A load model defined as a constant conductivity. </span></p>
<p><span style=\"background-color: #ffffff;\">Модель нагрузки постоянной проводимости. </span></p>
</html>"));
    end Constant_Conductivity_Load;

    model ShortCircuitShunt
      outer SysData sysData;

      parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
      parameter Real Umon=20 "Nominal voltage, kV";
      parameter Real Bn=1000 "Reactive conductivity of short sircuit, S";
      parameter Real Gn=1000 "Active conductivity of short sircuit, S";
      parameter Real Yn(fixed=false) "Total conductivity of short sircuit, S";
      //-----------------------------------
      parameter Real TkzOn=1000 "Time of short sircuit, s";
      parameter Real dTkzOn=0.12 "Duration of short sircuit, s";

      parameter Real Bn_sc(fixed=false) "Reactive conductivity of short sircuit, p.u.";
      parameter Real Gn_sc(fixed=false) "Active conductivity of short sircuit, p.u.";
      //-----------------------------------

      Real id "D-axis current of short-circuit";
      Real iq "Q-axis current of short-circuit";
      Real Ud  "D-axis voltage of short-circuit";
      Real Uq "Q-axis voltage of short-circuit";
      LEPSE.Interfaces.Pin_v2 inp annotation (
        extent=[-10,38; 10,58],
        layer="icon",
        Placement(transformation(extent={{-10,88},{10,108}},rotation=0),
            iconTransformation(extent={{-10,88},{10,108}})));
    initial equation
      // full short-circuit shunt conductivity
      Yn = sqrt( Bn^(2) + Gn^(2));
      // conversion from Siemens to p.u.
      Bn_sc = -Bn/Sbaz*Umon^(2);
      Gn_sc = -Gn/Sbaz*Umon^(2);

    equation

      // short-circuit current
      id = if time >= TkzOn and time < TkzOn + dTkzOn then Bn_sc*Uq + Gn_sc*Ud else 0;
      iq = if time >= TkzOn and time < TkzOn + dTkzOn then -Bn_sc*Ud + Gn_sc*Uq else 0;

      //-----connector-----
      inp.Vd = Ud;
      inp.Vq = Uq;

      inp.Id = -id;
      inp.Iq = -iq;

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.29,
          y=0.11,
          width=0.6,
          height=0.6),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-60,-60},{60,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Line(
              points={{-20,-10},{20,-10}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{0,-10},{0,90}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{34,54},{6,24},{30,24},{0,-10}},
              color={255,0,0},
              thickness=1),
            Text(extent={{-56,-22},{58,-50}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{0,-10},{2,0}},
              color={255,0,0},
              thickness=1),
            Line(
              points={{0,-10},{10,-6}},
              color={255,0,0},
              thickness=1)},
          Line(points=[-20, -60; 20, -60], style(thickness=4)),
          Line(points=[0, -60; 0, 40], style(thickness=4)),
          Line(points=[34, 4; 6, -26; 30, -26; 0, -60], style(
              color=41,
              thickness=4,
              arrow=1)),
          Text(extent=[-54, -64; 60, -92], string="%name")),
        Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">Short-Circuit Shunt Model. </span></p>
<p><span style=\"background-color: #ffffff;\">Модель шунта короткого замыкания. </span></p>
</html>"),
        Diagram(coordinateSystem(extent={{-60,-60},{60,100}})));
    end ShortCircuitShunt;
  end Shunts_numerical_units;

  package Shunts_per_units
    model Constant_Conductivity_Load
      parameter Real Gn=0.7 "Active load";
      parameter Real Bn=-0.35 "Reactive load";
      //-------------------------------------------------------------
      parameter Real TloadOff=1000 "Time of load disconnection";
      parameter Real dTloadOff=10 "Duration of load disconnection";
      parameter Real Koff=0.7 "Degree of load disconnection";
      //-------------------------------------------------------------
      Real Udn "D-axis voltage of load";
      Real Uqn "Q-axis voltage of load";
      Real Iqn "D-axis current of load";
      Real Idn "Q-axis current of load";
      Real Pn "Active power of load";
      Real Qn "Reactive power of load";
      LEPSE.Interfaces.Pin_v2 inp annotation (
        extent=[-10,76; 10,96],
        layer="icon",
        Placement(transformation(extent={{-10,88},{10,108}},rotation=0),
            iconTransformation(extent={{-10,88},{10,108}})));
    equation
      // active and reactive load
      Pn = Uqn*Iqn + Udn*Idn;
      Qn = -Uqn*Idn + Udn*Iqn;

      //the algorithm of triping load
      Idn = if time >= TloadOff and time < TloadOff + dTloadOff then Koff*(Udn*
        Gn + Uqn*Bn) else Udn*Gn + Uqn*Bn;
      Iqn = if time >= TloadOff and time < TloadOff + dTloadOff then Koff*(Uqn*
        Gn - Udn*Bn) else Uqn*Gn - Udn*Bn;

      //-----connector-----
      inp.Vd = Udn;
      inp.Vq = Uqn;

      inp.Id = -Idn;
      inp.Iq = -Iqn;

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.31,
          y=0.4,
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
              extent={{-20,72},{20,-28}},
              lineColor={0,0,255},
              lineThickness=1.0),
            Line(
              points={{0,-28},{0,-48}},
              color={0,0,255},
              thickness=1.0),
            Line(
              points={{-20,-48},{20,-48}},
              color={0,0,255},
              thickness=1.0),
            Line(
              points={{0,92},{0,72}},
              color={0,0,255},
              thickness=1.0),
            Text(extent={{-98,-60},{102,-96}},
              textColor={0,0,0},
              textString="%name")},
          Rectangle(extent=[-20, 60; 20, -40], style(thickness=2)),
          Line(points=[0, -40; 0, -60], style(thickness=2)),
          Line(points=[-20, -60; 20, -60], style(thickness=2)),
          Line(points=[0, 80; 0, 60], style(thickness=2)),
          Text(extent=[-100, -64; 100, -100], string="%name")),
        Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">A load model defined as a constant conductivity</span></p>
</html>"));
    end Constant_Conductivity_Load;

    model ShortCircuitShunt
      parameter Real Bn=-100000 "Reactive conductivity of short sircuit";
      parameter Real Gn=-100000 "Active conductivity of short sircuit";
      parameter Real Yn = sqrt( Bn^(2) + Gn^(2)) "Total conductivity of short sircuit";
      //-----------------------------------
      parameter Real TkzOn=1000 "Time of short sircuit";
      parameter Real dTkzOn=0.12 "Duration of short sircuit";
      //-----------------------------------

      Real id "D-axis current of short-circuit";
      Real iq "Q-axis current of short-circuit";
      Real Ud  "D-axis voltage of short-circuit";
      Real Uq "Q-axis voltage of short-circuit";
      LEPSE.Interfaces.Pin_v2 inp annotation (
        extent=[-10,38; 10,58],
        layer="icon",
        Placement(transformation(extent={{-10,88},{10,108}},rotation=0),
            iconTransformation(extent={{-10,88},{10,108}})));
    equation
      // short-circuit current
      id = if time >= TkzOn and time < TkzOn + dTkzOn then Bn*Uq + Gn*Ud else 0;
      iq = if time >= TkzOn and time < TkzOn + dTkzOn then -Bn*Ud + Gn*Uq else 0;

      //-----connector-----
      inp.Vd = Ud;
      inp.Vq = Uq;

      inp.Id = -id;
      inp.Iq = -iq;

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.29,
          y=0.11,
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
            Line(
              points={{-20,-10},{20,-10}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{0,-10},{0,90}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{34,54},{6,24},{30,24},{0,-10}},
              color={255,0,0},
              thickness=1,
              arrow={Arrow.None,Arrow.Filled}),
            Text(extent={{-56,-28},{58,-56}},
              textColor={0,0,0},
              textString="%name")},
          Line(points=[-20, -60; 20, -60], style(thickness=4)),
          Line(points=[0, -60; 0, 40], style(thickness=4)),
          Line(points=[34, 4; 6, -26; 30, -26; 0, -60], style(
              color=41,
              thickness=4,
              arrow=1)),
          Text(extent=[-54, -64; 60, -92], string="%name")),
        Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">Short-Circuit Shunt Model</span></p>
</html>"));
    end ShortCircuitShunt;
  end Shunts_per_units;
end Shunts;
