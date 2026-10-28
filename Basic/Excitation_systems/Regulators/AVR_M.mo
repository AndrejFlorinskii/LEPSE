within ;
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

  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function VoltageDeviation(b={-K0u},
      a={1}) annotation (extent=[-74,57.3333; -27.3333,104], Placement(
        transformation(extent={{-102,63.3333},{-55.3333,110}}, rotation=0)));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function VoltageDerivative(b={-K1u},
      a={T1,1}) annotation (extent=[-73.3333,17.3333; -26.6667,64], Placement(
        transformation(extent={{-71.3333,13.3333},{-24.6667,60}}, rotation=0)));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function FrequencyBlockD(b={T2,0},
      a={T2,1}) annotation (extent=[-82.6667,-22.6667; -48,24], Placement(
        transformation(extent={{-128.667,-22.6667},{-94,24}}, rotation=0)));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function ExcitationCurrent(b={K1if},
      a={T5,1}) annotation (extent=[-74,-102; -27.3333,-55.3333], Placement(
        transformation(extent={{-68,-88},{-21.3333,-41.3333}}, rotation=0)));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function SimpleExciter(b={1}, a=
        {Tokp,1}) annotation (extent=[56,-24; 83.3333,22.6667], Placement(
        transformation(extent={{-12,14},{26,58}}, rotation=0)));
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
  LEPSE.Basic.Excitation_systems.Logic.Summator_2 Summator1 annotation (
     extent=[-44,-32; -30,-12], Placement(transformation(extent={{-4,-16},
            {10,4}}, rotation=0)));
  LEPSE.Basic.Excitation_systems.Logic.Summator_2 Summator5 annotation (
     extent=[26,18; 40,38], Placement(transformation(extent={{76,14},{
            90,34}}, rotation=0)));
  LEPSE.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
          extent={{-146,-90},{-134,-78}}),
                                         iconTransformation(extent={{-146,-90},{
            -134,-78}})));
  LEPSE.Basic.Excitation_systems.Logic.logical_switch logical_switch1(
    a1=Uforc,
    a2=Udeforc,
    a3=K0u,
    a4=Tforcedelay)
    annotation (Placement(transformation(extent={{118,-10},{138,10}})));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function FrequencyBlockD1(b={K0w},
      a={T3,1}) annotation (extent=[-82.6667,-22.6667; -48,24], Placement(
        transformation(extent={{-74.6667,-22.6667},{-32,24}}, rotation=0)));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function FrequencyBlockD2(b={-K1w},
      a={T4,1}) annotation (extent=[-82.6667,-22.6667; -48,24], Placement(
        transformation(extent={{-64.6667,-58.6667},{-22,-12}}, rotation=0)));
  LEPSE.Basic.Excitation_systems.Logic.Delayed_Derivative delayed_Derivative(t1=tau1)
    annotation (Placement(transformation(extent={{-124,20},{-82,62}})));
  LEPSE.Basic.Excitation_systems.Logic.Delayed_Derivative delayed_Derivative1(t1=tau2)
    annotation (Placement(transformation(extent={{-126,-60},{-84,-18}})));
  LEPSE.Basic.Excitation_systems.Logic.Delayed_Derivative delayed_Derivative2(t1=tau3)
    annotation (Placement(transformation(extent={{-124,-86},{-82,-44}})));
  LEPSE.Basic.Excitation_systems.Logic.Summator_2_negative negative_summator
    annotation (Placement(transformation(extent={{50,26},{70,46}})));
  LEPSE.Basic.Excitation_systems.Logic.Summator_2_negative negative_summator1
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function SimpleExciter1(b={1}, a=
        {Tokp,1}) annotation (extent=[56,-24; 83.3333,22.6667], Placement(
        transformation(extent={{18,-28},{56,16}}, rotation=0)));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function SimpleExciter2(b={1}, a=
        {Tokp,1}) annotation (extent=[56,-24; 83.3333,22.6667], Placement(
        transformation(extent={{-10,-86},{28,-42}}, rotation=0)));
  LEPSE.Basic.Excitation_systems.Logic.Reactive_power_limiter under_overexcitation_limiter(
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
          -91, 70], Line(points={{-102,86.6667},{-130,86.6667},{-130,80},{-141,
          80}}));
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
        points={{-102,86.6667},{-110,86.6667},{-110,64},{128.1,64},{128.1,10}},
                                                                      color={
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
        points={{-84,-39},{-84,-34},{-64,-34},{-64,-35.3333},{-64.6667,-35.3333}},
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
