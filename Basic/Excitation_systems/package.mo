within Basic;
package Excitation_systems

  package Logic
    model Summator_4
      LEPSE.Interfaces.Signal_pin inp1 annotation (
        extent=[-94,14; -74,66],
        layer="icon",
        Placement(transformation(extent={{-110,46},{-90,98}},rotation=0),
            iconTransformation(extent={{-110,46},{-90,98}})));
      LEPSE.Interfaces.Signal_pin inp2 annotation (
        extent=[-94,-66; -74,-14],
        layer="icon",
        Placement(transformation(extent={{-110,0},{-90,52}},   rotation=0),
            iconTransformation(extent={{-110,0},{-90,52}})));
      LEPSE.Interfaces.Signal_pin out annotation (
        extent=[74,-26; 94,26],
        layer="icon",
        Placement(transformation(extent={{90,-26},{110,26}},rotation=0),
            iconTransformation(extent={{90,-26},{110,26}})));
      LEPSE.Interfaces.Signal_pin inp3 annotation (
        extent=[-94,-66; -74,-14],
        layer="icon",
        Placement(transformation(extent={{-110,-46},{-90,6}}, rotation=0),
            iconTransformation(extent={{-110,-46},{-90,6}})));
      LEPSE.Interfaces.Signal_pin inp4 annotation (
        extent=[-94,-66; -74,-14],
        layer="icon",
        Placement(transformation(extent={{-110,-92},{-90,-40}}, rotation=0),
            iconTransformation(extent={{-110,-92},{-90,-40}})));
    equation
      // the sum of 2 input signals
      out.Signal = inp1.Signal + inp2.Signal + inp3.Signal + inp4.Signal;
      connect(inp2, inp2) annotation (Line(
          points={{-100,26},{-100,26}},
          color={255,255,0},
          thickness=0.5));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Rectangle(
              extent={{-60,98},{60,-98}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={255,255,255},
              fillPattern=FillPattern.Forward),
            Line(
              points={{-60,70},{-94,70}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-60,-64},{-96,-64}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{96,0},{60,0}},
              color={0,0,255},
              thickness=1),
            Rectangle(
              extent={{-50,72},{-22,68}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-38,86},{-34,54}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Line(
              points={{-60,-20},{-94,-20}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-60,26},{-94,26}},
              color={0,0,255},
              thickness=1),
            Rectangle(
              extent={{-50,28},{-22,24}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-38,42},{-34,10}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-38,-4},{-34,-36}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-50,-18},{-22,-22}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-38,-48},{-34,-80}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-50,-62},{-22,-66}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1)},
          Rectangle(extent=[-60, 80; 60, -80], style(
              color=73,
              thickness=2,
              fillColor=7,
              fillPattern=7)),
          Line(points=[-60, 40; -76, 40], style(thickness=2)),
          Line(points=[-60, -40; -76, -40], style(thickness=2)),
          Line(points=[76, 0; 60, 0], style(thickness=2)),
          Rectangle(extent=[-50, 42; -14, 38], style(fillColor=0)),
          Rectangle(extent=[-34, 60; -30, 20], style(fillColor=0)),
          Rectangle(extent=[-34, -20; -30, -60], style(fillColor=0)),
          Rectangle(extent=[-50, -38; -14, -42], style(fillColor=0))),
        Window(
          x=0.29,
          y=0.02,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>The adder model with 4 inputs. </p>
<p>Модель сумматора с 4 входами. </p>
</html>"));
    end Summator_4;

    model Summator_2
      LEPSE.Interfaces.Signal_pin inp1 annotation (
        extent=[-94,14; -74,66],
        layer="icon",
        Placement(transformation(extent={{-110,16},{-90,68}},rotation=0),
            iconTransformation(extent={{-110,16},{-90,68}})));
      LEPSE.Interfaces.Signal_pin inp2 annotation (
        extent=[-94,-66; -74,-14],
        layer="icon",
        Placement(transformation(extent={{-110,-66},{-90,-14}},rotation=0),
            iconTransformation(extent={{-110,-66},{-90,-14}})));
      LEPSE.Interfaces.Signal_pin out annotation (
        extent=[74,-26; 94,26],
        layer="icon",
        Placement(transformation(extent={{90,-26},{110,26}},rotation=0),
            iconTransformation(extent={{90,-26},{110,26}})));
    equation
      // the sum of 2 input signals
      out.Signal = inp1.Signal + inp2.Signal;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Rectangle(
              extent={{-60,80},{60,-80}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={255,255,255},
              fillPattern=FillPattern.Forward),
            Line(
              points={{-60,40},{-94,40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-60,-40},{-96,-40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{96,0},{60,0}},
              color={0,0,255},
              thickness=1),
            Rectangle(
              extent={{-50,42},{-14,38}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-34,60},{-30,20}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-34,-20},{-30,-60}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-50,-38},{-14,-42}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1)},
          Rectangle(extent=[-60, 80; 60, -80], style(
              color=73,
              thickness=2,
              fillColor=7,
              fillPattern=7)),
          Line(points=[-60, 40; -76, 40], style(thickness=2)),
          Line(points=[-60, -40; -76, -40], style(thickness=2)),
          Line(points=[76, 0; 60, 0], style(thickness=2)),
          Rectangle(extent=[-50, 42; -14, 38], style(fillColor=0)),
          Rectangle(extent=[-34, 60; -30, 20], style(fillColor=0)),
          Rectangle(extent=[-34, -20; -30, -60], style(fillColor=0)),
          Rectangle(extent=[-50, -38; -14, -42], style(fillColor=0))),
        Window(
          x=0.29,
          y=0.02,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>The adder model with 2 inputs</p>
<p>Модель сумматора с 2входами. </p>
</html>"));
    end Summator_2;

    model Summator_3
      LEPSE.Interfaces.Signal_pin inp1 annotation (
        extent=[-94,14; -74,66],
        layer="icon",
        Placement(transformation(extent={{-110,34},{-90,86}},rotation=0),
            iconTransformation(extent={{-110,34},{-90,86}})));
      LEPSE.Interfaces.Signal_pin inp2 annotation (
        extent=[-94,-66; -74,-14],
        layer="icon",
        Placement(transformation(extent={{-110,-28},{-90,24}}, rotation=0),
            iconTransformation(extent={{-110,-28},{-90,24}})));
      LEPSE.Interfaces.Signal_pin out annotation (
        extent=[74,-26; 94,26],
        layer="icon",
        Placement(transformation(extent={{90,-26},{110,26}},rotation=0),
            iconTransformation(extent={{90,-26},{110,26}})));
      LEPSE.Interfaces.Signal_pin inp3 annotation (
        extent=[-94,-66; -74,-14],
        layer="icon",
        Placement(transformation(extent={{-110,-28},{-90,24}}, rotation=0),
            iconTransformation(extent={{-110,-86},{-90,-34}})));
    equation
      // the sum of 2 input signals
      out.Signal = inp1.Signal + inp2.Signal + inp3.Signal;
      connect(inp2, inp2) annotation (Line(
          points={{-100,-2},{-100,-2}},
          color={255,255,0},
          thickness=0.5));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Rectangle(
              extent={{-60,98},{60,-98}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={255,255,255},
              fillPattern=FillPattern.Forward),
            Line(
              points={{-60,60},{-94,60}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-60,-60},{-96,-60}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{96,0},{60,0}},
              color={0,0,255},
              thickness=1),
            Rectangle(
              extent={{-50,62},{-14,58}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-34,80},{-30,40}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-34,-40},{-30,-80}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-50,-58},{-14,-62}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Line(
              points={{-60,0},{-94,0}},
              color={0,0,255},
              thickness=1),
            Rectangle(
              extent={{-34,20},{-30,-20}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-50,2},{-14,-2}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1)},
          Rectangle(extent=[-60, 80; 60, -80], style(
              color=73,
              thickness=2,
              fillColor=7,
              fillPattern=7)),
          Line(points=[-60, 40; -76, 40], style(thickness=2)),
          Line(points=[-60, -40; -76, -40], style(thickness=2)),
          Line(points=[76, 0; 60, 0], style(thickness=2)),
          Rectangle(extent=[-50, 42; -14, 38], style(fillColor=0)),
          Rectangle(extent=[-34, 60; -30, 20], style(fillColor=0)),
          Rectangle(extent=[-34, -20; -30, -60], style(fillColor=0)),
          Rectangle(extent=[-50, -38; -14, -42], style(fillColor=0))),
        Window(
          x=0.29,
          y=0.02,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>The adder model with 3 inputs. </p>
<p>Модель сумматора с 3 входами. </p>
</html>"));
    end Summator_3;

    model Summator_2_negative
      LEPSE.Interfaces.Signal_pin inp1 annotation (
        extent=[-94,14; -74,66],
        layer="icon",
        Placement(transformation(extent={{-110,16},{-90,68}},rotation=0),
            iconTransformation(extent={{-110,16},{-90,68}})));
      LEPSE.Interfaces.Signal_pin inp2 annotation (
        extent=[-94,-66; -74,-14],
        layer="icon",
        Placement(transformation(extent={{-110,-66},{-90,-14}},rotation=0),
            iconTransformation(extent={{-110,-66},{-90,-14}})));
      LEPSE.Interfaces.Signal_pin out annotation (
        extent=[74,-26; 94,26],
        layer="icon",
        Placement(transformation(extent={{90,-26},{110,26}},rotation=0),
            iconTransformation(extent={{90,-26},{110,26}})));
    equation
      // the sum of 2 input signals
      out.Signal = inp1.Signal - inp2.Signal;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Rectangle(
              extent={{-60,80},{60,-80}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={255,255,255},
              fillPattern=FillPattern.Forward),
            Line(
              points={{-60,40},{-94,40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-60,-40},{-96,-40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{96,0},{60,0}},
              color={0,0,255},
              thickness=1),
            Rectangle(
              extent={{-50,42},{-14,38}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-34,60},{-30,20}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-50,-38},{-14,-42}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              lineThickness=1)},
          Rectangle(extent=[-60, 80; 60, -80], style(
              color=73,
              thickness=2,
              fillColor=7,
              fillPattern=7)),
          Line(points=[-60, 40; -76, 40], style(thickness=2)),
          Line(points=[-60, -40; -76, -40], style(thickness=2)),
          Line(points=[76, 0; 60, 0], style(thickness=2)),
          Rectangle(extent=[-50, 42; -14, 38], style(fillColor=0)),
          Rectangle(extent=[-34, 60; -30, 20], style(fillColor=0)),
          Rectangle(extent=[-34, -20; -30, -60], style(fillColor=0)),
          Rectangle(extent=[-50, -38; -14, -42], style(fillColor=0))),
        Window(
          x=0.29,
          y=0.02,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>The adder model with 1 powitive and 1 negative inputs. </p>
<p>Модель сумматора с положительным и отрицательным входами. </p>
</html>"));
    end Summator_2_negative;

    model logical_switch
      parameter Real a1 "Uforc, Voltage of field forcing input";
      parameter Real a2 "Udeforc, Voltage of field forcing removing";
      parameter Real a3 "K0U, Voltage deviation control coefficient";
      parameter Real a4 "Tforcedelay, Delay of field forcing removing";
      Real T_force_on "moment of time, when forcing starts";

      LEPSE.Interfaces.Signal_pin inp1 annotation (
        extent=[-94,14; -74,66],
        layer="icon",
        Placement(transformation(extent={{-110,8},{-90,60}}, rotation=0),
            iconTransformation(extent={{-110,8},{-90,60}})));
      LEPSE.Interfaces.Signal_pin inp2 annotation (
        extent=[-94,-66; -74,-14],
        layer="icon",
        Placement(transformation(extent={{-110,-62},{-90,-10}},
                                                              rotation=0),
            iconTransformation(extent={{-110,-62},{-90,-10}})));
      LEPSE.Interfaces.Signal_pin inp2inf annotation (
        extent=[-94,-66; -74,-14],
        layer="icon",
        Placement(transformation(
            extent={{-10,-26},{10,26}},
            rotation=90,
            origin={2,-118}), iconTransformation(
            extent={{-10,-26},{10,26}},
            rotation=90,
            origin={2,-118})));
      LEPSE.Interfaces.Signal_pin out annotation (
        extent=[74,-26; 94,26],
        layer="icon",
        Placement(transformation(extent={{90,-34},{110,18}},rotation=0),
            iconTransformation(extent={{90,-34},{110,18}})));
      LEPSE.Interfaces.Signal_pin inp1inf annotation (Placement(transformation(
              extent={{-24,110},{26,130}}), iconTransformation(extent={{-24,110},
                {26,130}})));

    initial equation
      pre(T_force_on) = 0;

      // the condition of forcing's start
    equation
      when abs(inp1inf.Signal) < (inp2inf.Signal - a2) then
        T_force_on = time;
      end when;

      // the value of output signal
      out.Signal = if (abs(inp1inf.Signal) > (inp2inf.Signal - a1)) then (inp1.Signal)
         else (if (abs(inp1inf.Signal) > (inp2inf.Signal - a2)) then (inp1.Signal)
         else (if (time < T_force_on + a4) then (inp1.Signal) else (inp2.Signal)));

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-120},{100,120}},
            grid={2,2},
            initialScale=0),
          graphics={
            Rectangle(
              extent={{-58,74},{62,-86}},
              lineColor={0,0,255},
              lineThickness=1,
              fillPattern=FillPattern.Forward,
              fillColor={244,125,35}),
            Line(
              points={{-46,34},{-94,34}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-48,-34},{-94,-34}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{98,-6},{44,-6}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-162,80}},
              color={162,29,33},
              thickness=1,
              smooth=Smooth.Bezier),
            Line(
              points={{-6,-6},{-46,34}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{16,-6},{-6,-6}},
              color={28,108,200},
              thickness=1),
            Line(
              points={{50,-6},{16,-6}},
              color={0,0,255},
              thickness=1),
            Text(extent={{-158,176},{162,136}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{10,6},{-16,6}},
              color={0,0,255},
              thickness=1,
              origin={8,-96},
              rotation=90),
            Line(
              points={{0,118},{0,74}},
              color={0,0,255},
              thickness=1)},
          Rectangle(extent=[-60, 80; 60, -80], style(
              color=73,
              thickness=2,
              fillColor=7,
              fillPattern=7)),
          Line(points=[-60, 40; -76, 40], style(thickness=2)),
          Line(points=[-60, -40; -76, -40], style(thickness=2)),
          Line(points=[76, 0; 60, 0], style(thickness=2)),
          Rectangle(extent=[-50, 42; -14, 38], style(fillColor=0)),
          Rectangle(extent=[-34, 60; -30, 20], style(fillColor=0)),
          Rectangle(extent=[-34, -20; -30, -60], style(fillColor=0)),
          Rectangle(extent=[-50, -38; -14, -42], style(fillColor=0))),
        Window(
          x=0.29,
          y=0.02,
          width=0.6,
          height=0.6),
        Diagram(coordinateSystem(extent={{-100,-120},{100,120}})),
        Documentation(info="<html>
<p>The model of the logic key of the automatic excitation regulator for excitation forcing. </p>
<p>Модель логического ключа АРВ для реализации функции форсировки возбуждения. </p>
</html>"));
    end logical_switch;

    model Transfer_Function
      parameter Real b[:]={1}
      "Numerator coefficients of transfer function.";
      parameter Real a[:]={1,1}
      "Denominator coefficients of transfer function.";
      output Real x[size(a, 1) - 1]
      "State of transfer function from controller canonical form";

    protected
      parameter Integer na=size(a, 1)
        "Size of Denominator of transfer function.";
      parameter Integer nb(max=na) = size(b, 1)
        "Size of Numerator of transfer function.";
      parameter Integer nx=size(a, 1) - 1;
      Real x1dot
      "Derivative of first state of TransferFcn";
      Real xn
      "Highest order state of TransferFcn";
      Real u
      "input variable";
      Real y
      "output variable";

    public
      LEPSE.Interfaces.Signal_pin inp annotation (
        extent=[-92,-10; -72,10],
        layer="icon",
        Placement(transformation(extent={{-110,-10},{-90,10}},rotation=0),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      LEPSE.Interfaces.Signal_pin out annotation (
        extent=[70,-10; 90,10],
        layer="icon",
        Placement(transformation(extent={{90,-10},{110,10}},rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
    equation
      [der(x); xn] = [x1dot; x];
      [u] = transpose([a])*[x1dot; x];
      [y] = transpose([zeros(na - nb, 1); b])*[x1dot; x];

      //-----connector-----
      inp.Signal = u;
      out.Signal = y;

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Rectangle(
              extent={{-60,30},{58,-28}},
              lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-40,28},{40,2}}, textString=
                                               "Transfer"),
            Text(extent={{-38,4},{42,-22}}, textString=
                                                "function"),
            Text(extent={{-100,58},{100,34}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{-60,0},{-94,0}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{98,0},{58,0}},
              color={0,0,255},
              thickness=1)},
          Rectangle(extent=[-60, 30; 58, -28], style(color=0, thickness=2)),
          Text(extent=[-40, 28; 40, 2], string="Transfer"),
          Text(extent=[-38, 4; 42, -22], string="function"),
          Text(extent=[-60, -28; 58, -52], string="%name"),
          Line(points=[-60, 0; -74, 0], style(color=0, thickness=2)),
          Line(points=[74, 0; 58, 0], style(color=0, thickness=2))),
        Window(
          x=0.37,
          y=0.14,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>The model of the transfer function. </p>
<p>Модель передаточной функции. </p>
</html>"));
    end Transfer_Function;

    model Reactive_power_limiter
      input Real Qgen;
      input Real Qmax;
      input Real Qmin;
      parameter Boolean inService = true "Excitation limiter condition";

    equation
      out.Signal = if inService then
      if Qgen > Qmax then
        0 else if Qgen < Qmin
      then 0 else inp.Signal else inp.Signal;

    public
      LEPSE.Interfaces.Signal_pin inp annotation (
        extent=[-92,-10; -72,10],
        layer="icon",
        Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      LEPSE.Interfaces.Signal_pin out annotation (
        extent=[70,-10; 90,10],
        layer="icon",
        Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-60,30},{58,-28}},
              lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-40,16},{40,-10}},
              textString="dEr limiter",
              textColor={0,0,0}),
            Text(extent={{-100,58},{100,34}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{-60,0},{-94,0}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{98,0},{58,0}},
              color={0,0,255},
              thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>Reactive_power_limiter model - limits AVR signal afer reaching Qmin/Qmax. </p>
<p>Модель блока ограничения сигнала при достижении Qmin/Qmax. </p>
</html>"));
    end Reactive_power_limiter;

    model Excitation_limiter
      parameter Boolean selfExcitation = true "Sign of self‑excitation (dependence on Ut)";
      parameter Real Kemax = 2.0 "Multiplicity of forcing on, p.u.";
      parameter Real Kemin = -0.6 "Multiplicity of forcing off, p.u.";

      Real Er_max_dyn "Dynamic upper limit";
      Real Er_min_dyn "Dynamic lower limit";
      Real Er0_val;
      Real Ut_val;

    public
      LEPSE.Interfaces.Signal_pin Ut_pin annotation (
        extent=[-92,-10; -72,10],
        layer="icon",
        Placement(transformation(extent={{-30,-70},{-10,-50}}, rotation=0),
            iconTransformation(extent={{-30,-70},{-10,-50}})));
    public
      LEPSE.Interfaces.Signal_pin Er0_pin annotation (
        extent=[-92,-10; -72,10],
        layer="icon",
        Placement(transformation(extent={{12,-70},{32,-50}}, rotation=0),
            iconTransformation(extent={{10,-70},{30,-50}})));
    equation
       // 1. Учет схемы питания (самовозбуждение от шин генератора)
      if selfExcitation then
        Er_max_dyn = Kemax * Er0_val * Ut_val; // Потолок падает вместе с Ut!
        Er_min_dyn = Kemin * Er0_val * Ut_val;
      else
        Er_max_dyn = Kemax * Er0_val;          // Независимое возбуждение
        Er_min_dyn = Kemin * Er0_val;
      end if;

      out.Signal = smooth(0, if inp.Signal > Er_max_dyn then Er_max_dyn
                         else if inp.Signal < Er_min_dyn then Er_min_dyn
     else
         inp.Signal);

      Ut_val = min(1.0, Ut_pin.Signal);
      Er0_pin.Signal = Er0_val;

    public
      LEPSE.Interfaces.Signal_pin inp annotation (
        extent=[-92,-10; -72,10],
        layer="icon",
        Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      LEPSE.Interfaces.Signal_pin out annotation (
        extent=[70,-10; 90,10],
        layer="icon",
        Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-60,30},{58,-28}},
              lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-40,16},{40,-10}},
              textString="dEr limiter",
              textColor={0,0,0}),
            Text(extent={{-100,58},{100,34}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{-60,0},{-94,0}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{98,0},{58,0}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-20,-58},{-20,-28}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{20,-58},{20,-28}},
              color={0,0,255},
              thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>Limiter of minimum and maximum excitation.</p>
<p>Ограничитель минимального и максимального возбуждения. </p>
</html>"));
    end Excitation_limiter;

    model AVR_signal_limiter
      parameter Real Umax "AVR upper limit";
      parameter Real Umin "AVR lower limit";
      parameter Boolean inService_1 = true "AVR_signal limiter condition";

    equation
      out.Signal = if inService_1 then
      if inp.Signal > Umax then
        Umax else if inp.Signal < Umin
      then Umin else inp.Signal else inp.Signal;

    public
      LEPSE.Interfaces.Signal_pin inp annotation (
        extent=[-92,-10; -72,10],
        layer="icon",
        Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      LEPSE.Interfaces.Signal_pin out annotation (
        extent=[70,-10; 90,10],
        layer="icon",
        Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-60,30},{58,-28}},
              lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-40,16},{40,-10}},
              textColor={0,0,0},
              textString="dU limiter"),
            Text(extent={{-100,58},{100,34}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{-60,0},{-94,0}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{98,0},{58,0}},
              color={0,0,255},
              thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>Reactive_power_limiter model - limits AVR signal afer reaching Qmin/Qmax. </p>
<p>Модель блока ограничения сигнала при достижении Qmin/Qmax. </p>
</html>"));
    end AVR_signal_limiter;

    model Delayed_Derivative
      parameter Real t1 = 0.02 "Time delay (sec)";

      Real u "Входной сигнал";
      Real u_delayed "Задержанный входной сигнал";
      Real y "Выходной сигнал (производная)";

    public
      LEPSE.Interfaces.Signal_pin inp annotation (
        Placement(transformation(extent={{-110,-10},{-90,10}})));
      LEPSE.Interfaces.Signal_pin out annotation (
        Placement(transformation(extent={{90,-10},{110,10}})));

    equation
      u = inp.Signal;

      // Оператор delay(выражение, время_задержки)
      // Вторым аргументом может быть указано максимальное время задержки (обычно равно t1)
      u_delayed = delay(u, t1);

      // Дифференцирование задержанного сигнала
      y = der(u_delayed);

      out.Signal = y;

      annotation (
        Icon(
          coordinateSystem(extent={{-100,-100},{100,100}}),
          graphics={
            Rectangle(
              extent={{-60,30},{58,-28}},
              lineColor={0,0,255},
              lineThickness=1),
            Text(
              extent={{-55,25},{55,-25}},
              lineColor={0,0,255},
              textString="p*exp(-t1*p)"),
            Text(
              extent={{-100,60},{100,40}},
              textColor={0,0,0},
              textString="%name"),
            Line(points={{-60,0},{-94,0}}, color={0,0,255}),
            Line(points={{98,0},{58,0}}, color={0,0,255})}),
        Documentation(info="<html>
<p>Differentiation block with delay.</p>
<p>Блок дифференцирования с чистым запаздыванием: W(p) = p * exp(-t1*p)</p>
</html>"));
    end Delayed_Derivative;
  end Logic;

  package Exciters
    model Exciter
       //--- Параметры возбудителя ---
      parameter Real Te = 0.02 "Exciter time constant, с";
      parameter Real Kemax = 2.0 "Multiplicity of forcing on, p.u.";
      parameter Real Kemin = -0.6 "Multiplicity of forcing off, p.u.";
      parameter Boolean selfExcitation = true "Sign of self‑excitation (dependence on Ut)";
      parameter Real Kig_exc = 1.0;
      parameter Real Kif_exc = 1.0;
      parameter Real Ku_exc = 1.0;

      //--- Внутренние переменные ---

      LEPSE.Interfaces.Signal_pin Er0_pin annotation (extent=[-90,-8; -70,12],
          Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      LEPSE.Interfaces.Signal_pin dEr_pin annotation (
        extent=[-60,66; -40,86],
        layer="icon",
        Placement(transformation(extent={{-110,16},{-90,36}}, rotation=0),
            iconTransformation(extent={{-110,16},{-90,36}})));
      LEPSE.Interfaces.Signal_pin Er_pin annotation (extent=[-90,-8; -70,12],
          Placement(transformation(extent={{170,-10},{190,10}}, rotation=0),
            iconTransformation(extent={{170,-10},{190,10}})));
      LEPSE.Interfaces.Signal_pin Ut_pin annotation (extent=[-90,-8; -70,12],
          Placement(transformation(extent={{-110,-34},{-90,-14}}, rotation=0),
            iconTransformation(extent={{-110,-34},{-90,-14}})));

      LEPSE.Interfaces.Signal_pin dIg_pin annotation (
        extent=[-60,66; -40,86],
        layer="icon",
        Placement(transformation(extent={{-110,44},{-90,64}}, rotation=0),
            iconTransformation(extent={{-110,42},{-90,62}})));
      LEPSE.Interfaces.Signal_pin dIf_pin annotation (extent=[-90,-8; -70,12],
          Placement(transformation(extent={{-110,-64},{-90,-44}}, rotation=0),
            iconTransformation(extent={{-110,-64},{-90,-44}})));
      Logic.Transfer_Function Excitation_delay(b={1}, a={Te,1})
        annotation (Placement(transformation(extent={{52,-22},{100,24}})));
      Logic.Transfer_Function Rotor_current_deviation(b={Kif_exc}, a={1})
        annotation (Placement(transformation(extent={{-76,-80},{-12,-28}})));
      Logic.Transfer_Function AVR_signal(b={Ku_exc}, a={1})
        annotation (Placement(transformation(extent={{-76,0},{-12,52}})));
      Logic.Transfer_Function Stator_current_deviation(b={Kig_exc}, a={1})
        annotation (Placement(transformation(extent={{-76,28},{-12,80}})));
      Logic.Excitation_limiter excitation_limiter(
        selfExcitation=selfExcitation,
        Kemax=Kemax,
        Kemin=Kemin)
        annotation (Placement(transformation(extent={{112,-20},{154,24}})));
      Logic.Summator_4 summator_4_1
        annotation (Placement(transformation(extent={{8,-16},{42,18}})));
    equation

      connect(dIf_pin, dIf_pin) annotation (Line(
          points={{-100,-54},{-100,-54}},
          color={255,255,0},
          thickness=0.5));
      connect(dIg_pin, Stator_current_deviation.inp) annotation (Line(
          points={{-100,54},{-76,54}},
          color={255,255,0},
          thickness=0.5));
      connect(dIf_pin, Rotor_current_deviation.inp) annotation (Line(
          points={{-100,-54},{-76,-54}},
          color={255,255,0},
          thickness=0.5));
      connect(dEr_pin, AVR_signal.inp) annotation (Line(
          points={{-100,26},{-76,26}},
          color={255,255,0},
          thickness=0.5));
      connect(excitation_limiter.inp, Excitation_delay.out) annotation (Line(
          points={{112,2},{112,1},{100,1}},
          color={255,255,0},
          thickness=0.5));
      connect(excitation_limiter.out, Er_pin) annotation (Line(
          points={{154,2},{168,2},{168,0},{180,0}},
          color={255,255,0},
          thickness=0.5));
      connect(Ut_pin, excitation_limiter.Ut_pin) annotation (Line(
          points={{-100,-24},{134,-24},{134,-18},{128.8,-18},{128.8,-11.2}},
          color={255,255,0},
          thickness=0.5));
      connect(summator_4_1.out, Excitation_delay.inp) annotation (Line(
          points={{42,1},{52,1}},
          color={255,255,0},
          thickness=0.5));
      connect(AVR_signal.out, summator_4_1.inp2) annotation (Line(
          points={{-12,26},{2,26},{2,5.42},{8,5.42}},
          color={255,255,0},
          thickness=0.5));
      connect(Stator_current_deviation.out, summator_4_1.inp1) annotation (Line(
          points={{-12,54},{4,54},{4,13.24},{8,13.24}},
          color={255,255,0},
          thickness=0.5));
      connect(Er0_pin, summator_4_1.inp3) annotation (Line(
          points={{-100,0},{-80,0},{-80,-4},{4,-4},{4,-2.4},{8,-2.4}},
          color={255,255,0},
          thickness=0.5));
      connect(Rotor_current_deviation.out, summator_4_1.inp4) annotation (Line(
          points={{-12,-54},{-2,-54},{-2,-10.22},{8,-10.22}},
          color={255,255,0},
          thickness=0.5));
      connect(Er0_pin, excitation_limiter.Er0_pin) annotation (Line(
          points={{-100,0},{-80,0},{-80,-4},{4,-4},{4,-26},{137.2,-26},{137.2,-11.2}},
          color={255,255,0},
          thickness=0.5));

      annotation (Diagram(coordinateSystem(extent={{-100,-100},{180,100}})),
                              Icon(coordinateSystem(extent={{-100,-100},{180,100}}),
                                   graphics={
            Ellipse(
              extent={{-52,84},{126,-86}},
              lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{6,38},{82,-36}},
              textString="Exciter",
              textColor={0,0,0}),
            Text(extent={{-42,-90},{118,-132}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{-52,0},{-94,0}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{176,0},{126,0}},
              color={0,0,255},
              thickness=1)}),
        Documentation(info="<html>
<p>Exciter model. </p>
<p>Модель возбудителя. </p>
</html>"));
    end Exciter;
  end Exciters;

  package Regulators
    model AVR_standart
      parameter Real K0u=-10 "Voltage deviation control coefficient";
      parameter Real K1u=0 "Voltage derivative control coefficient";
      parameter Real K0w=0 "Frequency deviation control coefficient";
      parameter Real K1w=0 "Frequency derivative control coefficient";
      parameter Real K1if=0 "Rotor current derivative control coefficient";
      parameter Real Uforc=0.85 "Voltage of field forcing input";
      parameter Real Udeforc=0.9 "Voltage of field forcing removing";
      parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
      parameter Real DL0=0;

      parameter Real Tokp=0.05 "The main channel of regulation time constant";
      constant Real T0u=0.02 "Voltage deviation time constant";
      constant Real T1u=0.039 "Voltage derivative time constant";
      constant Real Tfb=0.07 "Frequency block time constant";
      constant Real T0w=1.0 "Frequency deviation time constant";
      constant Real T1w=0.026 "Frequency derivative time constant";
      constant Real T1if=0.03 "Field current derivative time constant";

      Logic.Transfer_Function VoltageDeviation(b={K0u}, a={T0u,1})
        annotation (extent=[-74,57.3333; -27.3333,104], Placement(
            transformation(extent={{-86,37.3333},{-39.3333,84}}, rotation=0)));
      Logic.Transfer_Function VoltageDerivative(b={K1u,0}, a={T1u,1})
        annotation (extent=[-73.3333,17.3333; -26.6667,64], Placement(
            transformation(extent={{-85.3333,15.3333},{-38.6667,62}},
              rotation=0)));
      Logic.Transfer_Function FrequencyBlockD(b={1}, a={Tfb,1}) annotation (
         extent=[-82.6667,-22.6667; -48,24], Placement(transformation(
              extent={{-86.6667,-12.6667},{-52,34}}, rotation=0)));
      Logic.Transfer_Function FrequencyBlockU(b={1,0}, a={Tfb,1})
        annotation (extent=[-82,-63.3333; -48,-16], Placement(
            transformation(extent={{-86,-43.3333},{-52,4}}, rotation=0)));
      Logic.Transfer_Function FrequencyDeviation(b={K0w,0}, a={T0w,1})
        annotation (extent=[-28,-46; 10,2], Placement(transformation(extent
              ={{-32,-44},{6,4}}, rotation=0)));
      Logic.Transfer_Function FrequencyDerivative(b={K1w,0}, a={T1w,1})
        annotation (extent=[-24.6667,-19.3333; 10,28], Placement(
            transformation(extent={{-30.6667,-5.3333},{4,42}}, rotation=0)));
      Logic.Transfer_Function ExcitationCurrent(b={K1if,0}, a={T1if,1})
        annotation (extent=[-74,-102; -27.3333,-55.3333], Placement(
            transformation(extent={{-86,-68},{-39.3333,-21.3333}}, rotation
              =0)));
      Logic.Transfer_Function SimpleExciter(b={1}, a={Tokp,1}) annotation (
          extent=[56,-24; 83.3333,22.6667], Placement(transformation(extent
              ={{90,6},{117.333,52.6667}}, rotation=0)));
      LEPSE.Interfaces.Signal_pin dV_pin annotation (
        extent=[-96,64; -86,76],
        layer="icon",
        Placement(transformation(extent={{-106,44},{-96,56}},rotation=0),
            iconTransformation(extent={{-106,44},{-96,56}})));
      LEPSE.Interfaces.Signal_pin dV1_pin annotation (
        extent=[-96,34; -86,46],
        layer="icon",
        Placement(transformation(extent={{-106,14},{-96,26}},rotation=0),
            iconTransformation(extent={{-106,14},{-96,26}})));
      LEPSE.Interfaces.Signal_pin dfsys_pin annotation (
        extent=[-96,4; -86,16],
        layer="icon",
        Placement(transformation(extent={{-106,-16},{-96,-4}},
                                                            rotation=0),
            iconTransformation(extent={{-106,-16},{-96,-4}})));
      LEPSE.Interfaces.Signal_pin dfU_pin annotation (
        extent=[-96,-26; -86,-14],
        layer="icon",
        Placement(transformation(extent={{-106,-46},{-96,-34}},rotation=0),
            iconTransformation(extent={{-106,-46},{-96,-34}})));
      LEPSE.Interfaces.Signal_pin dif1_pin annotation (
        extent=[-96,-56; -86,-44],
        layer="icon",
        Placement(transformation(extent={{-106,-70},{-96,-58}},rotation=0),
            iconTransformation(extent={{-106,-70},{-96,-58}})));
      LEPSE.Interfaces.Signal_pin out_pin annotation (
        extent=[86,2; 96,22],
        layer="icon",
        Placement(transformation(extent={{136,-18},{146,2}},rotation=0),
            iconTransformation(extent={{136,-18},{146,2}})));
      Basic.Excitation_systems.Logic.Summator_2 Summator1 annotation (extent=[-44,
            -32; -30,-12], Placement(transformation(extent={{-50,-4},{-36,16}},
              rotation=0)));
      LEPSE.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
              extent={{-106,-90},{-94,-78}}),iconTransformation(extent={{-106,
                -90},{-94,-78}})));
      Basic.Excitation_systems.Logic.logical_switch logical_switch1(
        a1=Uforc,
        a2=Udeforc,
        a3=K0u,
        a4=Tforcedelay)
        annotation (Placement(transformation(extent={{66,20},{86,40}})));
      Logic.Summator_4 summator_4_1
        annotation (Placement(transformation(extent={{34,10},{50,44}})));
      Logic.Summator_2 summator_2_1
        annotation (Placement(transformation(extent={{-18,36},{2,56}})));
    equation
      connect(dfsys_pin, FrequencyBlockD.inp) annotation (points=[-91, 10; -
            79.5467, 0.666667], Line(points={{-101,-10},{-86.6667,10.6666}}));
      connect(dfU_pin, FrequencyBlockU.inp) annotation (points=[-91, -20; -
            78.94, -39.6667], Line(points={{-101,-40},{-101,-19.6667},{-86,
              -19.6667}}));
      connect(FrequencyBlockD.out, Summator1.inp1) annotation (points=[-
            51.4667, 0.666667; -42.88, -18], Line(points={{-52,10.6666},{
              -52,10.2},{-50,10.2}}));
      connect(FrequencyBlockU.out, Summator1.inp2) annotation (points=[-51.4,
            -39.6667; -42.88, -26], Line(points={{-52,-19.6667},{-50,
              -19.6667},{-50,2}}));
      connect(dif1_pin, ExcitationCurrent.inp) annotation (points=[-91, -50; -
            69.8, -78.6667], Line(points={{-101,-64},{-101,-44.6667},{-86,
              -44.6667}}));
      connect(Summator1.out, FrequencyDeviation.inp) annotation (points=[-
            31.12, -22; -24.58, -22], Line(points={{-36,6},{-32,6},{-32,-20},{
              -32,-20}}));
      connect(FrequencyDerivative.inp, FrequencyDeviation.inp) annotation (
          points=[-21.5467, 4.33333; -24.58, -22], Line(points={{-30.6667,
              18.3333},{-30.6667,18},{-32,18},{-32,-20},{-32,-20}}));
      connect(VoltageDerivative.inp, dV1_pin) annotation (points=[-69.1333,
            40.6667; -91, 40], Line(points={{-85.3333,38.6666},{-85.3333,20},
              {-101,20}}));
      connect(VoltageDeviation.inp, dV_pin) annotation (points=[-69.8, 80.6667;
              -91, 70], Line(points={{-86,60.6667},{-86,50},{-101,50}}));
      when initial() then
        reinit(FrequencyBlockU.x[1], DL0);
        //     reinit(FrequencyDeviation.x[1],DL0);
        //     reinit(FrequencyDerivative.x[1],DL0);
      end when;

      connect(logical_switch1.out, SimpleExciter.inp) annotation (Line(points={{86,
              29.3333},{88,29.3333},{88,30},{88,29.3334},{88,29.3333},{90,
              29.3333}},                                                color={0,
              0,0}));
      connect(Ut_pin, logical_switch1.inp2inf) annotation (Line(points={{-100,
              -84},{56,-84},{56,20.1667},{76.2,20.1667}},
                                                   color={0,0,0}));
      connect(VoltageDeviation.out, logical_switch1.inp1) annotation (Line(points={{
              -39.3333,60.6667},{-6,60.6667},{-6,60},{54,60},{54,32.8333},{
              66,32.8333}},
                         color={0,0,0}));
      connect(VoltageDeviation.inp, logical_switch1.inp1inf) annotation (Line(
            points={{-86,60.6667},{-86,74},{70,74},{70,56},{76.1,56},{76.1,
              40}},                                                       color={
              0,0,0}));
      connect(SimpleExciter.out, out_pin) annotation (Line(points={{117.333,
              29.3333},{130,29.3333},{130,-8},{141,-8}},
                                               color={0,0,0}));
      connect(summator_4_1.out, logical_switch1.inp2)
        annotation (Line(points={{50,27},{66,27}}, color={0,0,0}));
      connect(ExcitationCurrent.out, summator_4_1.inp4) annotation (Line(
            points={{-39.3333,-44.6667},{-39.3333,-38},{-34,-38},{-34,-48},
              {28,-48},{28,-20},{30,-20},{30,15.78},{34,15.78}},color={0,0,0}));
      connect(FrequencyDeviation.out, summator_4_1.inp3) annotation (Line(
            points={{6,-20},{28,-20},{28,16},{30,16},{30,23.6},{34,23.6}},
            color={0,0,0}));
      connect(FrequencyDerivative.out, summator_4_1.inp2) annotation (Line(
            points={{4,18.3333},{28,18.3333},{28,31.42},{34,31.42}}, color={0,
              0,0}));
      connect(summator_2_1.out, summator_4_1.inp1) annotation (Line(points={{
              2,46},{28,46},{28,39.24},{34,39.24}}, color={0,0,0}));
      connect(VoltageDerivative.out, summator_2_1.inp2) annotation (Line(
            points={{-38.6667,38.6666},{-20,38.6666},{-20,38},{-18,38},{-18,
              42}}, color={0,0,0}));
      connect(VoltageDeviation.out, summator_2_1.inp1) annotation (Line(
            points={{-39.3333,60.6667},{-22,60.6667},{-22,50.2},{-18,50.2}},
            color={0,0,0}));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.32,
          y=0.06,
          width=0.6,
          height=0.82),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{140,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Rectangle(
              extent={{-68,72},{104,-94}},
              lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-22,38},{60,-40}}, textString=
                                                 "Excitation"),
            Text(extent={{-14,14},{56,-52}}, textString=
                                                 "regulator"),
            Line(
              points={{-68,-10},{-98,-10}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,-40},{-100,-40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,-84},{-96,-84}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,20},{-98,20}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,50},{-98,50}},
              color={0,0,255},
              thickness=1),
            Text(extent={{-64,106},{96,74}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{138,-8},{104,-8}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,-64},{-98,-64}},
              color={0,0,255},
              thickness=1)},
          Rectangle(extent=[-68, 80; 66, -60], style(thickness=2)),
          Text(extent=[-42, 60; 40, -18], string="Excitation"),
          Text(extent=[-36, 34; 34, -32], string="regulator"),
          Line(points=[-68, 10; -88, 10], style(thickness=2)),
          Line(points=[-68, -20; -88, -20], style(thickness=2)),
          Line(points=[-68, -50; -88, -50], style(thickness=2)),
          Line(points=[-68, 40; -88, 40], style(thickness=2)),
          Line(points=[-68, 70; -88, 70], style(thickness=2)),
          Text(extent=[-84, -62; 76, -94], string="%name"),
          Line(points=[86, 12; 66, 12], style(thickness=2))),
        Diagram(coordinateSystem(extent={{-100,-100},{140,100}}), graphics={
            Text(
              extent={{-36,70},{-26,60}},
              textColor={0,0,0},
              textString="ΔU"),
            Text(
              extent={{-38,50},{-26,38}},
              textColor={0,0,0},
              textString="ΔU'"),
            Text(
              extent={{6,-26},{18,-36}},
              textColor={0,0,0},
              textString="ΔF"),
            Text(
              extent={{-12,8},{0,-2}},
              textColor={0,0,0},
              textString="ΔF'"),
            Text(
              extent={{-42,-32},{-30,-42}},
              textColor={0,0,0},
              textString="ΔIf'")}),
        Documentation(info="<html>
<p>The standart model of Automatic Voltage Regulator (AVR). </p>
<p>Стандартная модель автоматического регулятора возбуждения. </p>
</html>"));
    end AVR_standart;

    model AVR_SD
      parameter Real K0u=10 "Voltage deviation control coefficient";
      parameter Real K1u=0 "Voltage derivative control coefficient";
      parameter Real K0w=0 "Frequency deviation control coefficient";
      parameter Real K1w=0 "Frequency derivative control coefficient";
      parameter Real K1if=0 "Rotor current derivative control coefficient";
      parameter Real Uforc=0.85 "Voltage of field forcing input";
      parameter Real Udeforc=0.9 "Voltage of field forcing removing";
      parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
      parameter Real DL0=0;

      parameter Real Tokp=0.05 "The main channel of regulation time constant";
      constant Real T1u=0.04 "Voltage derivative time constant";
      constant Real Tfb=0.07 "Frequency block time constant";
      constant Real T0w=0.9 "Frequency deviation time constant";
      constant Real T1w=0.04 "Frequency derivative time constant";
      constant Real T1if=0.04 "Field current derivative time constant";

      input Real Qgen;
      input Real Qmax;
      input Real Qmin;

      Logic.Transfer_Function VoltageDeviation(b={-K0u}, a={1}) annotation (
         extent=[-74,57.3333; -27.3333,104], Placement(transformation(
              extent={{-80,39.3333},{-33.3333,86}}, rotation=0)));
      Logic.Transfer_Function VoltageDerivative(b={-K1u,0}, a={T1u,1})
        annotation (extent=[-73.3333,17.3333; -26.6667,64], Placement(
            transformation(extent={{-79.3333,15.3333},{-32.6667,62}},
              rotation=0)));
      Logic.Transfer_Function FrequencyBlockD(b={T0w,0}, a={T0w,1})
        annotation (extent=[-82.6667,-22.6667; -48,24], Placement(
            transformation(extent={{-98.6667,-16.6667},{-64,30}}, rotation=
                0)));
      Logic.Transfer_Function FrequencyBlockU(b={1,0}, a={T1w,1})
        annotation (extent=[-82,-63.3333; -48,-16], Placement(
            transformation(extent={{-96,-45.3333},{-62,2}}, rotation=0)));
      Logic.Transfer_Function FrequencyDeviation(b={1}, a={Tfb,1})
        annotation (extent=[-28,-46; 10,2], Placement(transformation(extent
              ={{-2,-28},{36,20}}, rotation=0)));
      Logic.Transfer_Function ExcitationCurrent(b={-K1if,0}, a={T1if,1})
        annotation (extent=[-74,-102; -27.3333,-55.3333], Placement(
            transformation(extent={{-86,-68},{-39.3333,-21.3333}}, rotation
              =0)));
      Logic.Transfer_Function SimpleExciter(b={1}, a={Tokp,1}) annotation (
          extent=[56,-24; 83.3333,22.6667], Placement(transformation(extent
              ={{90,6},{117.333,52.6667}}, rotation=0)));
      LEPSE.Interfaces.Signal_pin dV_pin annotation (
        extent=[-96,64; -86,76],
        layer="icon",
        Placement(transformation(extent={{-106,44},{-96,56}},rotation=0),
            iconTransformation(extent={{-106,44},{-96,56}})));
      LEPSE.Interfaces.Signal_pin dV1_pin annotation (
        extent=[-96,34; -86,46],
        layer="icon",
        Placement(transformation(extent={{-106,14},{-96,26}},rotation=0),
            iconTransformation(extent={{-106,14},{-96,26}})));
      LEPSE.Interfaces.Signal_pin dfsys_pin annotation (
        extent=[-96,4; -86,16],
        layer="icon",
        Placement(transformation(extent={{-106,-16},{-96,-4}},
                                                            rotation=0),
            iconTransformation(extent={{-106,-16},{-96,-4}})));
      LEPSE.Interfaces.Signal_pin dfU_pin annotation (
        extent=[-96,-26; -86,-14],
        layer="icon",
        Placement(transformation(extent={{-106,-46},{-96,-34}},rotation=0),
            iconTransformation(extent={{-106,-46},{-96,-34}})));
      LEPSE.Interfaces.Signal_pin dif1_pin annotation (
        extent=[-96,-56; -86,-44],
        layer="icon",
        Placement(transformation(extent={{-106,-70},{-96,-58}},rotation=0),
            iconTransformation(extent={{-106,-70},{-96,-58}})));
      LEPSE.Interfaces.Signal_pin out_pin annotation (
        extent=[86,2; 96,22],
        layer="icon",
        Placement(transformation(extent={{136,-18},{146,2}},rotation=0),
            iconTransformation(extent={{136,-18},{146,2}})));
      Basic.Excitation_systems.Logic.Summator_2 Summator1 annotation (extent=[-44,
            -32; -30,-12], Placement(transformation(extent={{-20,-14},{-6,6}},
              rotation=0)));
      LEPSE.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
              extent={{-106,-90},{-94,-78}}),iconTransformation(extent={{-106,
                -90},{-94,-78}})));
      Basic.Excitation_systems.Logic.logical_switch logical_switch1(
        a1=Uforc,
        a2=Udeforc,
        a3=K0u,
        a4=Tforcedelay)
        annotation (Placement(transformation(extent={{66,20},{86,40}})));
      Logic.Transfer_Function FrequencyBlockD1(b={K0w}, a={1}) annotation (
          extent=[-82.6667,-22.6667; -48,24], Placement(transformation(
              extent={{-58.6667,-16.6667},{-24,30}}, rotation=0)));
      Logic.Transfer_Function FrequencyBlockD2(b={-K1w}, a={1}) annotation (
         extent=[-82.6667,-22.6667; -48,24], Placement(transformation(
              extent={{-56.6667,-44.6667},{-22,2}}, rotation=0)));
      Logic.Reactive_power_limiter under_overexcitation_limiter(
        Qgen=Qgen,
        Qmax=Qmax,
        Qmin=Qmin,
        inService=inService)
        annotation (Placement(transformation(extent={{126,18},{146,38}})));
      parameter Boolean inService=true "Excitation limiter condition";
      Logic.Summator_4 summator_4_1
        annotation (Placement(transformation(extent={{40,12},{60,42}})));
      Logic.AVR_signal_limiter aVR_signal_limiter(
        Umax=Umax,
        Umin=Umin,
        inService_1=inService_1)
        annotation (Placement(transformation(extent={{96,-12},{120,10}})));
      parameter Real Umax "AVR upper limit";
      parameter Real Umin "AVR lower limit";
      parameter Boolean inService_1=true "AVR_signal limiter condition";
    equation
      connect(dfsys_pin, FrequencyBlockD.inp) annotation (points=[-91, 10; -
            79.5467, 0.666667], Line(points={{-101,-10},{-110,-10},{-110,6.66665},{-98.6667,
              6.66665}}));
      connect(dfU_pin, FrequencyBlockU.inp) annotation (points=[-91, -20; -
            78.94, -39.6667], Line(points={{-101,-40},{-102,-40},{-102,
              -21.6667},{-96,-21.6667}}));
      connect(dif1_pin, ExcitationCurrent.inp) annotation (points=[-91, -50; -
            69.8, -78.6667], Line(points={{-101,-64},{-101,-44.6667},{-86,
              -44.6667}}));
      connect(Summator1.out, FrequencyDeviation.inp) annotation (points=[-
            31.12, -22; -24.58, -22], Line(points={{-6,-4},{-2,-4}}));
      connect(VoltageDerivative.inp, dV1_pin) annotation (points=[-69.1333,
            40.6667; -91, 40], Line(points={{-79.3333,38.6666},{-79.3333,20},
              {-101,20}}));
      when initial() then
        reinit(FrequencyDeviation.x[1], DL0);
        //     reinit(FrequencyDeviation.x[1],DL0);
        //     reinit(FrequencyDerivative.x[1],DL0);
      end when;

      connect(logical_switch1.out, SimpleExciter.inp) annotation (Line(points={{86,
              29.3333},{88,29.3333},{88,30},{88,29.3334},{88,29.3333},{90,
              29.3333}},                                                color={0,
              0,0}));
      connect(Ut_pin, logical_switch1.inp2inf) annotation (Line(points={{-100,
              -84},{76,-84},{76,20.1667},{76.2,20.1667}},
                                                   color={0,0,0}));
      connect(VoltageDeviation.out, logical_switch1.inp1) annotation (Line(points={{
              -33.3333,62.6667},{34,62.6667},{34,46},{66,46},{66,32.8333}},
                         color={0,0,0}));
      connect(VoltageDeviation.inp, logical_switch1.inp1inf) annotation (Line(
            points={{-80,62.6667},{-80,90},{76.1,90},{76.1,40}},          color={
              0,0,0}));
      connect(FrequencyBlockU.out, FrequencyBlockD2.inp) annotation (Line(
          points={{-62,-21.6667},{-62,-21.3333},{-56.6667,-21.3333}},
          color={0,0,0}));
      connect(Summator1.inp2, FrequencyBlockD2.out) annotation (Line(
          points={{-20,-8},{-20,-21.3333},{-22,-21.3333}},
          color={0,0,0}));
      connect(Summator1.inp1, FrequencyBlockD1.out) annotation (Line(
          points={{-20,0.2},{-20,0},{-24,0},{-24,6.66665}},
          color={0,0,0}));
      connect(FrequencyBlockD.out, FrequencyBlockD1.inp) annotation (Line(points={{-64,
              6.66665},{-58.6667,6.66665}},                             color={0,0,0}));
      connect(SimpleExciter.out, under_overexcitation_limiter.inp)
        annotation (Line(points={{117.333,29.3333},{117.333,28},{126,28}},
            color={0,0,0}));
      connect(VoltageDeviation.out, summator_4_1.inp1) annotation (Line(points={{
              -33.3333,62.6667},{34,62.6667},{34,37.8},{40,37.8}},
                                                         color={0,0,0}));
      connect(VoltageDerivative.out, summator_4_1.inp2) annotation (Line(points={{
              -32.6667,38.6666},{30,38.6666},{30,30.9},{40,30.9}},
                                                          color={0,0,0}));
      connect(FrequencyDeviation.out, summator_4_1.inp3)
        annotation (Line(points={{36,-4},{36,24},{40,24}}, color={0,0,0}));
      connect(ExcitationCurrent.out, summator_4_1.inp4) annotation (Line(points={{
              -39.3333,-44.6667},{0,-44.6667},{0,-44},{40,-44},{40,17.1}},
                                                                  color={0,0,0}));
      connect(summator_4_1.out, logical_switch1.inp2)
        annotation (Line(points={{60,27},{66,27}}, color={0,0,0}));
      connect(dV_pin, VoltageDeviation.inp) annotation (Line(points={{-101,50},
              {-88,50},{-88,90},{-80,90},{-80,62.6667}}, color={0,0,0}));
      connect(aVR_signal_limiter.inp, under_overexcitation_limiter.out)
        annotation (Line(points={{96,-1},{96,-2},{92,-2},{92,-16},{132,-16},{
              132,14},{150,14},{150,28},{146,28}}, color={0,0,0}));
      connect(aVR_signal_limiter.out, out_pin) annotation (Line(points={{120,
              -1},{120,-2},{128,-2},{128,-8},{141,-8}}, color={0,0,0}));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.32,
          y=0.06,
          width=0.6,
          height=0.82),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{140,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Rectangle(
              extent={{-68,72},{104,-94}},
              lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-22,38},{60,-40}}, textString=
                                                 "Excitation"),
            Text(extent={{-14,14},{56,-52}}, textString=
                                                 "regulator"),
            Line(
              points={{-68,-10},{-98,-10}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,-40},{-100,-40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,-84},{-96,-84}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,20},{-98,20}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,50},{-98,50}},
              color={0,0,255},
              thickness=1),
            Text(extent={{-64,106},{96,74}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{138,-8},{104,-8}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,-64},{-98,-64}},
              color={0,0,255},
              thickness=1)},
          Rectangle(extent=[-68, 80; 66, -60], style(thickness=2)),
          Text(extent=[-42, 60; 40, -18], string="Excitation"),
          Text(extent=[-36, 34; 34, -32], string="regulator"),
          Line(points=[-68, 10; -88, 10], style(thickness=2)),
          Line(points=[-68, -20; -88, -20], style(thickness=2)),
          Line(points=[-68, -50; -88, -50], style(thickness=2)),
          Line(points=[-68, 40; -88, 40], style(thickness=2)),
          Line(points=[-68, 70; -88, 70], style(thickness=2)),
          Text(extent=[-84, -62; 76, -94], string="%name"),
          Line(points=[86, 12; 66, 12], style(thickness=2))),
        Diagram(coordinateSystem(extent={{-100,-100},{140,100}}), graphics={
            Text(
              extent={{-36,78},{-26,68}},
              textColor={0,0,0},
              textString="ΔU"),
            Text(
              extent={{-36,52},{-24,40}},
              textColor={0,0,0},
              textString="ΔU'"),
            Text(
              extent={{-66,18},{-54,8}},
              textColor={0,0,0},
              textString="ΔF"),
            Text(
              extent={{-64,-10},{-52,-20}},
              textColor={0,0,0},
              textString="ΔF'"),
            Text(
              extent={{-44,-32},{-32,-42}},
              textColor={0,0,0},
              textString="ΔIf'")}),
        Documentation(info="<html>
<p>The model of Automatic Voltage Regulator (AVR), type &quot;AVR-SD&quot;. </p>
<p>Модель регулятора возбуждения типа &quot;АРВ-СД&quot;. </p>
</html>"));
    end AVR_SD;

    model Excitation_Regulator_Q_limit
      parameter Real K0u=20 "Voltage deviation control coefficient";
      parameter Real K1u=0 "Voltage derivative control coefficient";
      parameter Real K0w=0 "Frequency deviation control coefficient";
      parameter Real K1w=0 "Frequency derivative control coefficient";
      parameter Real K1if=0 "Rotor current derivative control coefficient";
      parameter Real Uforc=0.85 "Voltage of field forcing input";
      parameter Real Udeforc=0.9 "Voltage of field forcing removing";
      parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
      parameter Real DL0=0;

      parameter Real Tokp=0.05 "The main channel of regulation time constant";
      constant Real T0u=0.02 "Voltage deviation time constant";
      constant Real T1u=0.039 "Voltage derivative time constant";
      constant Real Tfb=0.07 "Frequency block time constant";
      constant Real T0w=1.0 "Frequency deviation time constant";
      constant Real T1w=0.026 "Frequency derivative time constant";
      constant Real T1if=0.03 "Field current derivative time constant";

      input Real Qgen;
      input Real Qmax;
      input Real Qmin;

      Logic.Transfer_Function VoltageDeviation(b={-K0u}, a={T0u,1})
        annotation (extent=[-74,57.3333; -27.3333,104], Placement(
            transformation(extent={{-86,37.3333},{-39.3333,84}}, rotation=0)));
      Logic.Transfer_Function VoltageDerivative(b={-K1u,0}, a={T1u,1})
        annotation (extent=[-73.3333,17.3333; -26.6667,64], Placement(
            transformation(extent={{-85.3333,15.3333},{-38.6667,62}},
              rotation=0)));
      Logic.Transfer_Function FrequencyBlockD(b={1}, a={Tfb,1}) annotation (
         extent=[-82.6667,-22.6667; -48,24], Placement(transformation(
              extent={{-86.6667,-12.6667},{-52,34}}, rotation=0)));
      Logic.Transfer_Function FrequencyBlockU(b={1,0}, a={Tfb,1})
        annotation (extent=[-82,-63.3333; -48,-16], Placement(
            transformation(extent={{-86,-43.3333},{-52,4}}, rotation=0)));
      Logic.Transfer_Function FrequencyDeviation(b={K0w,0}, a={T0w,1})
        annotation (extent=[-28,-46; 10,2], Placement(transformation(extent
              ={{-32,-44},{6,4}}, rotation=0)));
      Logic.Transfer_Function FrequencyDerivative(b={-K1w,0}, a={T1w,1})
        annotation (extent=[-24.6667,-19.3333; 10,28], Placement(
            transformation(extent={{-30.6667,-5.3333},{4,42}}, rotation=0)));
      Logic.Transfer_Function ExcitationCurrent(b={K1if,0}, a={T1if,1})
        annotation (extent=[-74,-102; -27.3333,-55.3333], Placement(
            transformation(extent={{-86,-68},{-39.3333,-21.3333}}, rotation
              =0)));
      Logic.Transfer_Function SimpleExciter(b={1}, a={Tokp,1}) annotation (
          extent=[56,-24; 83.3333,22.6667], Placement(transformation(extent
              ={{90,6},{117.333,52.6667}}, rotation=0)));
      LEPSE.Interfaces.Signal_pin dV_pin annotation (
        extent=[-96,64; -86,76],
        layer="icon",
        Placement(transformation(extent={{-106,44},{-96,56}},rotation=0),
            iconTransformation(extent={{-106,44},{-96,56}})));
      LEPSE.Interfaces.Signal_pin dV1_pin annotation (
        extent=[-96,34; -86,46],
        layer="icon",
        Placement(transformation(extent={{-106,14},{-96,26}},rotation=0),
            iconTransformation(extent={{-106,14},{-96,26}})));
      LEPSE.Interfaces.Signal_pin dfsys_pin annotation (
        extent=[-96,4; -86,16],
        layer="icon",
        Placement(transformation(extent={{-106,-16},{-96,-4}},
                                                            rotation=0),
            iconTransformation(extent={{-106,-16},{-96,-4}})));
      LEPSE.Interfaces.Signal_pin dfU_pin annotation (
        extent=[-96,-26; -86,-14],
        layer="icon",
        Placement(transformation(extent={{-106,-46},{-96,-34}},rotation=0),
            iconTransformation(extent={{-106,-46},{-96,-34}})));
      LEPSE.Interfaces.Signal_pin dif1_pin annotation (
        extent=[-96,-56; -86,-44],
        layer="icon",
        Placement(transformation(extent={{-106,-70},{-96,-58}},rotation=0),
            iconTransformation(extent={{-106,-70},{-96,-58}})));
      LEPSE.Interfaces.Signal_pin out_pin annotation (
        extent=[86,2; 96,22],
        layer="icon",
        Placement(transformation(extent={{136,-18},{146,2}},rotation=0),
            iconTransformation(extent={{136,-18},{146,2}})));
      Basic.Excitation_systems.Logic.Summator_2 Summator1 annotation (extent=[-44,
            -32; -30,-12], Placement(transformation(extent={{-50,-4},{-36,16}},
              rotation=0)));
      Basic.Excitation_systems.Logic.Summator_2 Summator2 annotation (extent=[
            12,-18; 26,2], Placement(transformation(extent={{10,-26},{24,-6}},
              rotation=0)));
      Basic.Excitation_systems.Logic.Summator_2 Summator3 annotation (extent=[8,
            48; 22,68], Placement(transformation(extent={{-12,32},{2,52}},
              rotation=0)));
      Basic.Excitation_systems.Logic.Summator_2 Summator5 annotation (extent=[
            26,18; 40,38], Placement(transformation(extent={{12,18},{26,38}},
              rotation=0)));
      Basic.Excitation_systems.Logic.Summator_2 Summator6 annotation (extent=[
            40,-10; 54,10], Placement(transformation(extent={{30,14},{44,34}},
              rotation=0)));
      LEPSE.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
              extent={{-106,-90},{-94,-78}}),iconTransformation(extent={{-106,
                -90},{-94,-78}})));
      Basic.Excitation_systems.Logic.logical_switch logical_switch1(
        a1=Uforc,
        a2=Udeforc,
        a3=K0u,
        a4=Tforcedelay)
        annotation (Placement(transformation(extent={{60,18},{80,38}})));
      Logic.Reactive_power_limiter under_overexcitation_limiter(
        Qgen=Qgen,
        Qmax=Qmax,
        Qmin=Qmin,
        inService=inService)
        annotation (Placement(transformation(extent={{128,20},{148,40}})));
      parameter Boolean inService=true "Excitation limiter condition";
    equation
      connect(dfsys_pin, FrequencyBlockD.inp) annotation (points=[-91, 10; -
            79.5467, 0.666667], Line(points={{-101,-10},{-86.6667,10.6666}}));
      connect(dfU_pin, FrequencyBlockU.inp) annotation (points=[-91, -20; -
            78.94, -39.6667], Line(points={{-101,-40},{-101,-19.6667},{-86,
              -19.6667}}));
      connect(FrequencyBlockD.out, Summator1.inp1) annotation (points=[-
            51.4667, 0.666667; -42.88, -18], Line(points={{-52,10.6666},{-52,
              10.2},{-50,10.2}}));
      connect(FrequencyBlockU.out, Summator1.inp2) annotation (points=[-51.4,
            -39.6667; -42.88, -26], Line(points={{-52,-19.6667},{-50,-19.6667},
              {-50,2}}));
      connect(dif1_pin, ExcitationCurrent.inp) annotation (points=[-91, -50; -
            69.8, -78.6667], Line(points={{-101,-64},{-101,-44.6667},{-86,
              -44.6667}}));
      connect(Summator1.out, FrequencyDeviation.inp) annotation (points=[-
            31.12, -22; -24.58, -22], Line(points={{-36,6},{-32,6},{-32,-20},{
              -32,-20}}));
      connect(FrequencyDerivative.inp, FrequencyDeviation.inp) annotation (
          points=[-21.5467, 4.33333; -24.58, -22], Line(points={{-30.6667,
              18.3333},{-30.6667,18},{-32,18},{-32,-20},{-32,-20}}));
      connect(Summator2.inp2, FrequencyDeviation.out) annotation (points=[
            13.12, -12; 6.2, -22], Line(points={{10,-20},{6,-20}}));
      connect(FrequencyDerivative.out, Summator2.inp1) annotation (points=[
            6.53333, 4.33333; 13.12, -4], Line(points={{4,18.3333},{6,18.3333},
              {6,-11.8},{10,-11.8}}));
      connect(VoltageDerivative.inp, dV1_pin) annotation (points=[-69.1333,
            40.6667; -91, 40], Line(points={{-85.3333,38.6666},{-85.3333,20},
              {-101,20}}));
      connect(VoltageDeviation.inp, dV_pin) annotation (points=[-69.8, 80.6667;
              -91, 70], Line(points={{-86,60.6667},{-86,50},{-101,50}}));
      connect(VoltageDeviation.out, Summator3.inp1) annotation (points=[-32,
            80.6667; 9.12, 62], Line(points={{-39.3333,60.6667},{-18,60.6667},
              {-18,46.2},{-12,46.2}}));
      connect(VoltageDerivative.out, Summator3.inp2) annotation (points=[-
            31.3333, 40.6667; 9.12, 54], Line(points={{-38.6667,38.6666},{
              -38.6667,38},{-12,38}}));
      connect(Summator5.inp1, Summator3.out) annotation (points=[27.12, 32;
            20.88, 58], Line(points={{12,32.2},{6,32.2},{6,42},{2,42}}));
      connect(Summator5.inp2, Summator2.out) annotation (points=[27.12, 24;
            24.88, -8], Line(points={{12,24},{10,24},{10,-4},{26,-4},{26,-16},{
              24,-16}}));
      connect(Summator6.inp1, Summator5.out) annotation (points=[41.12, 4;
            38.88, 28], Line(points={{30,28.2},{29.12,28.2},{29.12,28},{26,28}}));
      connect(Summator6.inp2, ExcitationCurrent.out) annotation (points=[41.12,
              -4; -32, -78.6667], Line(points={{30,20},{30,-44.6667},{
              -39.3333,-44.6667}}));
      when initial() then
        reinit(FrequencyBlockU.x[1], DL0);
        //     reinit(FrequencyDeviation.x[1],DL0);
        //     reinit(FrequencyDerivative.x[1],DL0);
      end when;

      connect(logical_switch1.out, SimpleExciter.inp) annotation (Line(points={{80,
              27.3333},{86,27.3333},{86,29.3333},{90,29.3333}},         color={0,
              0,0}));
      connect(Ut_pin, logical_switch1.inp2inf) annotation (Line(points={{-100,
              -84},{56,-84},{56,18.1667},{70.2,18.1667}},
                                                   color={0,0,0}));
      connect(Summator6.out, logical_switch1.inp2) annotation (Line(points={{44,24},
              {52,24},{52,25},{60,25}},                       color={0,0,0}));
      connect(VoltageDeviation.out, logical_switch1.inp1) annotation (Line(points={{
              -39.3333,60.6667},{-6,60.6667},{-6,60},{54,60},{54,30.8333},{60,
              30.8333}}, color={0,0,0}));
      connect(VoltageDeviation.inp, logical_switch1.inp1inf) annotation (Line(
            points={{-86,60.6667},{-86,74},{70,74},{70,56},{70.1,56},{70.1,38}},
                                                                          color={
              0,0,0}));
      connect(under_overexcitation_limiter.inp, SimpleExciter.out) annotation (Line(
            points={{128,30},{128,29.3333},{117.333,29.3333}}, color={0,0,0}));
      connect(under_overexcitation_limiter.out, out_pin) annotation (Line(points={{148,
              30},{152,30},{152,-8},{141,-8}}, color={0,0,0}));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.32,
          y=0.06,
          width=0.6,
          height=0.82),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{140,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Rectangle(
              extent={{-68,72},{104,-94}},
              lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-22,38},{60,-40}}, textString=
                                                 "Excitation"),
            Text(extent={{-14,14},{56,-52}}, textString=
                                                 "regulator"),
            Line(
              points={{-68,-10},{-98,-10}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,-40},{-100,-40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,-84},{-96,-84}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,20},{-98,20}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,50},{-98,50}},
              color={0,0,255},
              thickness=1),
            Text(extent={{-64,106},{96,74}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{138,-8},{104,-8}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,-64},{-98,-64}},
              color={0,0,255},
              thickness=1)},
          Rectangle(extent=[-68, 80; 66, -60], style(thickness=2)),
          Text(extent=[-42, 60; 40, -18], string="Excitation"),
          Text(extent=[-36, 34; 34, -32], string="regulator"),
          Line(points=[-68, 10; -88, 10], style(thickness=2)),
          Line(points=[-68, -20; -88, -20], style(thickness=2)),
          Line(points=[-68, -50; -88, -50], style(thickness=2)),
          Line(points=[-68, 40; -88, 40], style(thickness=2)),
          Line(points=[-68, 70; -88, 70], style(thickness=2)),
          Text(extent=[-84, -62; 76, -94], string="%name"),
          Line(points=[86, 12; 66, 12], style(thickness=2))),
        Diagram(coordinateSystem(extent={{-100,-100},{140,100}}), graphics={
            Text(
              extent={{-36,70},{-26,60}},
              textColor={0,0,0},
              textString="ΔU"),
            Text(
              extent={{-38,50},{-26,38}},
              textColor={0,0,0},
              textString="ΔU'"),
            Text(
              extent={{6,-26},{18,-36}},
              textColor={0,0,0},
              textString="ΔF"),
            Text(
              extent={{-12,8},{0,-2}},
              textColor={0,0,0},
              textString="ΔF'"),
            Text(
              extent={{-42,-32},{-30,-42}},
              textColor={0,0,0},
              textString="ΔIf'")}),
        Documentation(info="<html>
<p>The standart model of Automatic Voltage Regulator (AVR) with Q-limiter. </p>
<p>Стандартная модель автоматического регулятора возбуждения с ограничителем сигнала по реактивной мощности. </p>
</html>"));
    end Excitation_Regulator_Q_limit;

    model AVR_M
      parameter Real K0u=10 "Voltage deviation control coefficient";
      parameter Real K1u=0 "Voltage derivative control coefficient";
      parameter Real K0w=0 "Frequency deviation control coefficient";
      parameter Real K1w=0 "Frequency derivative control coefficient";
      parameter Real K1if=0 "Rotor current derivative control coefficient";
      parameter Real Uforc=0.85 "Voltage of field forcing input";
      parameter Real Udeforc=0.9 "Voltage of field forcing removing";
      parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
      parameter Real DL0=0;

      constant Real T1=0.06;
      constant Real T2=2;
      constant Real T3=0.02;
      constant Real T4=0.08;
      constant Real T5=0.135;
      constant Real Tokp=2 "The main channel of regulation time constant";
      constant Real tau1=0.02;
      constant Real tau2=0.05;
      constant Real tau3=0.02;

      input Real Qgen;
      input Real Qmax;
      input Real Qmin;

      Logic.Transfer_Function VoltageDeviation(b={-K0u}, a={1}) annotation (
         extent=[-74,57.3333; -27.3333,104], Placement(transformation(
              extent={{-102,63.3333},{-55.3333,110}}, rotation=0)));
      Logic.Transfer_Function VoltageDerivative(b={-K1u}, a={T1,1})
        annotation (extent=[-73.3333,17.3333; -26.6667,64], Placement(
            transformation(extent={{-71.3333,13.3333},{-24.6667,60}},
              rotation=0)));
      Logic.Transfer_Function FrequencyBlockD(b={T2,0}, a={T2,1})
        annotation (extent=[-82.6667,-22.6667; -48,24], Placement(
            transformation(extent={{-128.667,-22.6667},{-94,24}}, rotation=
                0)));
      Logic.Transfer_Function ExcitationCurrent(b={K1if}, a={T5,1})
        annotation (extent=[-74,-102; -27.3333,-55.3333], Placement(
            transformation(extent={{-68,-88},{-21.3333,-41.3333}}, rotation
              =0)));
      Logic.Transfer_Function SimpleExciter(b={1}, a={Tokp,1}) annotation (
          extent=[56,-24; 83.3333,22.6667], Placement(transformation(extent
              ={{-12,14},{26,58}}, rotation=0)));
      LEPSE.Interfaces.Signal_pin dV_pin annotation (
        extent=[-96,64; -86,76],
        layer="icon",
        Placement(transformation(extent={{-146,74},{-136,86}},
                                                             rotation=0),
            iconTransformation(extent={{-146,74},{-136,86}})));
      LEPSE.Interfaces.Signal_pin dV1_pin annotation (
        extent=[-96,34; -86,46],
        layer="icon",
        Placement(transformation(extent={{-146,36},{-136,48}},
                                                             rotation=0),
            iconTransformation(extent={{-146,36},{-136,48}})));
      LEPSE.Interfaces.Signal_pin dfsys_pin annotation (
        extent=[-96,4; -86,16],
        layer="icon",
        Placement(transformation(extent={{-146,-6},{-136,6}},
                                                            rotation=0),
            iconTransformation(extent={{-146,-6},{-136,6}})));
      LEPSE.Interfaces.Signal_pin dfU_pin annotation (
        extent=[-96,-26; -86,-14],
        layer="icon",
        Placement(transformation(extent={{-146,-46},{-136,-34}},
                                                               rotation=0),
            iconTransformation(extent={{-146,-46},{-136,-34}})));
      LEPSE.Interfaces.Signal_pin dif1_pin annotation (
        extent=[-96,-56; -86,-44],
        layer="icon",
        Placement(transformation(extent={{-146,-70},{-136,-58}},
                                                               rotation=0),
            iconTransformation(extent={{-146,-70},{-136,-58}})));
      LEPSE.Interfaces.Signal_pin out_pin annotation (
        extent=[86,2; 96,22],
        layer="icon",
        Placement(transformation(extent={{194,-10},{204,10}},
                                                            rotation=0),
            iconTransformation(extent={{194,-10},{204,10}})));
      Basic.Excitation_systems.Logic.Summator_2 Summator1 annotation (extent=[-44,
            -32; -30,-12], Placement(transformation(extent={{-4,-16},{10,4}},
              rotation=0)));
      Basic.Excitation_systems.Logic.Summator_2 Summator5 annotation (extent=[
            26,18; 40,38], Placement(transformation(extent={{76,14},{90,34}},
              rotation=0)));
      LEPSE.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
              extent={{-146,-90},{-134,-78}}),
                                             iconTransformation(extent={{-146,-90},{
                -134,-78}})));
      Basic.Excitation_systems.Logic.logical_switch logical_switch1(
        a1=Uforc,
        a2=Udeforc,
        a3=K0u,
        a4=Tforcedelay)
        annotation (Placement(transformation(extent={{118,-10},{138,10}})));
      Logic.Transfer_Function FrequencyBlockD1(b={K0w}, a={T3,1})
        annotation (extent=[-82.6667,-22.6667; -48,24], Placement(
            transformation(extent={{-74.6667,-22.6667},{-32,24}}, rotation=
                0)));
      Logic.Transfer_Function FrequencyBlockD2(b={-K1w}, a={T4,1})
        annotation (extent=[-82.6667,-22.6667; -48,24], Placement(
            transformation(extent={{-64.6667,-58.6667},{-22,-12}}, rotation
              =0)));
      Logic.Delayed_Derivative delayed_Derivative(t1=tau1)
        annotation (Placement(transformation(extent={{-124,20},{-82,62}})));
      Logic.Delayed_Derivative delayed_Derivative1(t1=tau2) annotation (
          Placement(transformation(extent={{-126,-60},{-84,-18}})));
      Logic.Delayed_Derivative delayed_Derivative2(t1=tau3) annotation (
          Placement(transformation(extent={{-124,-86},{-82,-44}})));
      Logic.Summator_2_negative negative_summator
        annotation (Placement(transformation(extent={{50,26},{70,46}})));
      Logic.Summator_2_negative negative_summator1
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Logic.Transfer_Function SimpleExciter1(b={1}, a={Tokp,1}) annotation (
         extent=[56,-24; 83.3333,22.6667], Placement(transformation(extent=
                {{18,-28},{56,16}}, rotation=0)));
      Logic.Transfer_Function SimpleExciter2(b={1}, a={Tokp,1}) annotation (
         extent=[56,-24; 83.3333,22.6667], Placement(transformation(extent=
                {{-10,-86},{28,-42}}, rotation=0)));
      Logic.Reactive_power_limiter under_overexcitation_limiter(
        Qgen=Qgen,
        Qmax=Qmax,
        Qmin=Qmin,
        inService=inService)
        annotation (Placement(transformation(extent={{152,-10},{172,10}})));
      parameter Boolean inService=true "Excitation limiter condition";
    equation
      connect(dfsys_pin, FrequencyBlockD.inp) annotation (points=[-91, 10; -
            79.5467, 0.666667], Line(points={{-141,0},{-141,0.66665},{-128.667,0.66665}}));
      connect(VoltageDeviation.inp, dV_pin) annotation (points=[-69.8, 80.6667;
              -91, 70], Line(points={{-102,86.6667},{-130,86.6667},{-130,80},
              {-141,80}}));
      when initial() then
        //     reinit(FrequencyBlockD2.x[1], DL0);
        //     reinit(FrequencyDeviation.x[1],DL0);
        //     reinit(FrequencyDerivative.x[1],DL0);
      end when;

      connect(Ut_pin, logical_switch1.inp2inf) annotation (Line(points={{-140,-84},{
              128.2,-84},{128.2,-9.83333}},        color={0,0,0}));
      connect(VoltageDeviation.out, logical_switch1.inp1) annotation (Line(points={{
              -55.3333,86.6667},{54,86.6667},{54,56},{118,56},{118,2.83333}},
                         color={0,0,0}));
      connect(VoltageDeviation.inp, logical_switch1.inp1inf) annotation (Line(
            points={{-102,86.6667},{-110,86.6667},{-110,64},{128.1,64},{128.1,
              10}},                                                       color={
              0,0,0}));
      connect(FrequencyBlockD.out, FrequencyBlockD1.inp) annotation (Line(
          points={{-94,0.66665},{-74.6667,0.66665}},
          color={0,0,0}));
      connect(delayed_Derivative.inp, dV1_pin) annotation (Line(
          points={{-124,41},{-124,42},{-141,42}},
          color={255,255,0},
          thickness=0.5));
      connect(delayed_Derivative.out, VoltageDerivative.inp) annotation (Line(
          points={{-82,41},{-82,36.6666},{-71.3333,36.6666}},
          color={0,0,0}));
      connect(dfU_pin, delayed_Derivative1.inp) annotation (Line(points={{-141,-40},
              {-140,-39},{-126,-39}}, color={0,0,0}));
      connect(delayed_Derivative1.out, FrequencyBlockD2.inp) annotation (Line(
            points={{-84,-39},{-84,-34},{-64,-34},{-64,-35.3333},{-64.6667,
              -35.3333}},
            color={0,0,0}));
      connect(dif1_pin, delayed_Derivative2.inp) annotation (Line(points={{-141,-64},
              {-140,-65},{-124,-65}}, color={0,0,0}));
      connect(delayed_Derivative2.out, ExcitationCurrent.inp) annotation (Line(
            points={{-82,-65},{-82,-64.6667},{-68,-64.6667}}, color={0,0,0}));
      connect(negative_summator.inp1, VoltageDeviation.out) annotation (Line(points={{50,40.2},
              {42,40.2},{42,56},{54,56},{54,86.6667},{-55.3333,86.6667}},
            color={0,0,0}));
      connect(negative_summator.out, Summator5.inp1) annotation (Line(
          points={{70,36},{72,36},{72,28.2},{76,28.2}},
          color={255,255,0},
          thickness=0.5));
      connect(Summator5.out, negative_summator1.inp1) annotation (Line(points={{90,24},
              {88,24},{88,6},{78,6},{78,4.2},{90,4.2}}, color={0,0,0}));
      connect(negative_summator1.out, logical_switch1.inp2) annotation (Line(points
            ={{110,0},{114,0},{114,-3},{118,-3}}, color={0,0,0}));
      connect(ExcitationCurrent.out, SimpleExciter2.inp) annotation (Line(
            points={{-21.3333,-64.6667},{-22,-64},{-10,-64}}, color={0,0,0}));
      connect(FrequencyBlockD1.out, Summator1.inp1) annotation (Line(points={{
              -32,0.66665},{-10,0.66665},{-10,-1.8},{-4,-1.8}}, color={0,0,0}));
      connect(FrequencyBlockD2.out, Summator1.inp2) annotation (Line(points={{-22,
              -35.3333},{-10,-35.3333},{-10,-10},{-4,-10}},     color={0,0,0}));
      connect(Summator1.out, SimpleExciter1.inp) annotation (Line(
          points={{10,-6},{18,-6}},
          color={255,255,0},
          thickness=0.5));
      connect(SimpleExciter1.out, Summator5.inp2) annotation (Line(points={{56,
              -6},{70,-6},{70,20},{76,20}}, color={0,0,0}));
      connect(VoltageDerivative.out, SimpleExciter.inp) annotation (Line(points={{
              -24.6667,36.6666},{-24,36},{-12,36}},  color={0,0,0}));
      connect(SimpleExciter.out, negative_summator.inp2) annotation (Line(
            points={{26,36},{44,36},{44,32},{50,32}}, color={0,0,0}));
      connect(SimpleExciter2.out, negative_summator1.inp2) annotation (Line(
            points={{28,-64},{84,-64},{84,-4},{90,-4}}, color={0,0,0}));
      connect(logical_switch1.out, under_overexcitation_limiter.inp)
        annotation (Line(points={{138,-0.666667},{138,0},{152,0}}, color={0,0,
              0}));
      connect(under_overexcitation_limiter.out, out_pin)
        annotation (Line(points={{172,0},{199,0}}, color={0,0,0}));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.32,
          y=0.06,
          width=0.6,
          height=0.82),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-140,-100},{200,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Rectangle(
              extent={{-108,92},{164,-94}},
              lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-6,32},{76,-46}},  textString=
                                                 "Excitation"),
            Text(extent={{4,10},{74,-56}},   textString=
                                                 "regulator"),
            Line(
              points={{-106,0},{-136,0}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-106,-40},{-138,-40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-108,-84},{-136,-84}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-108,42},{-138,42}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-108,80},{-138,80}},
              color={0,0,255},
              thickness=1),
            Text(extent={{-46,64},{114,32}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{198,0},{164,0}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-108,-64},{-138,-64}},
              color={0,0,255},
              thickness=1)},
          Rectangle(extent=[-68, 80; 66, -60], style(thickness=2)),
          Text(extent=[-42, 60; 40, -18], string="Excitation"),
          Text(extent=[-36, 34; 34, -32], string="regulator"),
          Line(points=[-68, 10; -88, 10], style(thickness=2)),
          Line(points=[-68, -20; -88, -20], style(thickness=2)),
          Line(points=[-68, -50; -88, -50], style(thickness=2)),
          Line(points=[-68, 40; -88, 40], style(thickness=2)),
          Line(points=[-68, 70; -88, 70], style(thickness=2)),
          Text(extent=[-84, -62; 76, -94], string="%name"),
          Line(points=[86, 12; 66, 12], style(thickness=2))),
        Diagram(coordinateSystem(extent={{-140,-100},{200,100}}), graphics={
            Text(
              extent={{-98,78},{-88,68}},
              textColor={0,0,0},
              textString="ΔU"),
            Text(
              extent={{-92,32},{-80,20}},
              textColor={0,0,0},
              textString="ΔU'"),
            Text(
              extent={{-94,16},{-82,6}},
              textColor={0,0,0},
              textString="ΔF"),
            Text(
              extent={{-82,-20},{-70,-30}},
              textColor={0,0,0},
              textString="ΔF'"),
            Text(
              extent={{-74,-68},{-62,-78}},
              textColor={0,0,0},
              textString="ΔIf'")}),
        Documentation(info="<html>
<p>The  model of Automatic Voltage Regulator, type &quot;AVR-M&quot;. </p>
<p>Модель регулятора возбуждения типа &quot;АРВ-М&quot;. </p>
</html>"));
    end AVR_M;
  end Regulators;
end Excitation_systems;
