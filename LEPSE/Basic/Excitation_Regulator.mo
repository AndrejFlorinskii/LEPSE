within Basic;
model Excitation_Regulator
  parameter Real K0u=-10 "Voltage deviation control coefficient";
  parameter Real K1u=0 "Voltage derivative control coefficient";
  parameter Real K0w=0 "Frequency deviation control coefficient";
  parameter Real K1w=0 "Frequency derivative control coefficient";
  parameter Real K1if=0 "Rotor current derivative control coefficient";
  parameter Real Uforc=0.85 "Voltage of field forcing input";
  parameter Real Udeforc=0.9 "Voltage of field forcing removing";
  parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
  parameter Real DL0=0;

  constant Real Tokp=0.05 "The main channel of regulation time constant";
  constant Real T0u=0.02 "Voltage deviation time constant";
  constant Real T1u=0.039 "Voltage derivative time constant";
  constant Real Tfb=0.07 "Frequency block time constant";
  constant Real T0w=1.0 "Frequency deviation time constant";
  constant Real T1w=0.026 "Frequency derivative time constant";
  constant Real T1if=0.03 "Field current derivative time constant";

  Basic.Transfer_Function VoltageDeviation(b={K0u}, a={T0u,1}) annotation (
      extent=[-74,57.3333; -27.3333,104], Placement(transformation(extent={{-86,
            37.3333},{-39.3333,84}}, rotation=0)));
  Basic.Transfer_Function VoltageDerivative(b={K1u,0}, a={T1u,1}) annotation (
      extent=[-73.3333,17.3333; -26.6667,64], Placement(transformation(extent={
            {-85.3333,15.3333},{-38.6667,62}}, rotation=0)));
  Basic.Transfer_Function FrequencyBlockD(b={1}, a={Tfb,1}) annotation (extent=
        [-82.6667,-22.6667; -48,24], Placement(transformation(extent={{-86.6667,
            -12.6667},{-52,34}}, rotation=0)));
  Basic.Transfer_Function FrequencyBlockU(b={1,0}, a={Tfb,1}) annotation (
      extent=[-82,-63.3333; -48,-16], Placement(transformation(extent={{-86,-43.3333},
            {-52,4}}, rotation=0)));
  Basic.Transfer_Function FrequencyDeviation(b={K0w,0}, a={T0w,1}) annotation (
      extent=[-28,-46; 10,2], Placement(transformation(extent={{-32,-44},{6,4}},
          rotation=0)));
  Basic.Transfer_Function FrequencyDerivative(b={K1w,0}, a={T1w,1}) annotation
    (extent=[-24.6667,-19.3333; 10,28], Placement(transformation(extent={{-30.6667,
            -5.3333},{4,42}}, rotation=0)));
  Basic.Transfer_Function ExcitationCurrent(b={K1if,0}, a={T1if,1}) annotation
    (extent=[-74,-102; -27.3333,-55.3333], Placement(transformation(extent={{-86,
            -68},{-39.3333,-21.3333}}, rotation=0)));
  Basic.Transfer_Function SimpleExciter(b={1}, a={Tokp,1}) annotation (extent=[
        56,-24; 83.3333,22.6667], Placement(transformation(extent={{90,6},{
            117.333,52.6667}}, rotation=0)));
  LEPSE.Interfaces.Single_Pin dV_pin annotation (
    extent=[-96,64; -86,76],
    layer="icon",
    Placement(transformation(extent={{-106,44},{-96,56}},rotation=0),
        iconTransformation(extent={{-106,44},{-96,56}})));
  LEPSE.Interfaces.Single_Pin dV1_pin annotation (
    extent=[-96,34; -86,46],
    layer="icon",
    Placement(transformation(extent={{-106,14},{-96,26}},rotation=0),
        iconTransformation(extent={{-106,14},{-96,26}})));
  LEPSE.Interfaces.Single_Pin dfsys_pin annotation (
    extent=[-96,4; -86,16],
    layer="icon",
    Placement(transformation(extent={{-106,-16},{-96,-4}},
                                                        rotation=0),
        iconTransformation(extent={{-106,-16},{-96,-4}})));
  LEPSE.Interfaces.Single_Pin dfU_pin annotation (
    extent=[-96,-26; -86,-14],
    layer="icon",
    Placement(transformation(extent={{-106,-46},{-96,-34}},rotation=0),
        iconTransformation(extent={{-106,-46},{-96,-34}})));
  LEPSE.Interfaces.Single_Pin dif1_pin annotation (
    extent=[-96,-56; -86,-44],
    layer="icon",
    Placement(transformation(extent={{-106,-70},{-96,-58}},rotation=0),
        iconTransformation(extent={{-106,-70},{-96,-58}})));
  LEPSE.Interfaces.Single_Pin out_pin annotation (
    extent=[86,2; 96,22],
    layer="icon",
    Placement(transformation(extent={{136,-18},{146,2}},rotation=0),
        iconTransformation(extent={{136,-18},{146,2}})));
  Basic.Summator Summator1 annotation (extent=[-44,-32; -30,-12], Placement(
        transformation(extent={{-50,-4},{-36,16}}, rotation=0)));
  Basic.Summator Summator2 annotation (extent=[12,-18; 26,2], Placement(
        transformation(extent={{10,-26},{24,-6}}, rotation=0)));
  Basic.Summator Summator3 annotation (extent=[8,48; 22,68], Placement(
        transformation(extent={{-12,32},{2,52}}, rotation=0)));
  Basic.Summator Summator5 annotation (extent=[26,18; 40,38], Placement(
        transformation(extent={{12,18},{26,38}}, rotation=0)));
  Basic.Summator Summator6 annotation (extent=[40,-10; 54,10], Placement(
        transformation(extent={{30,14},{44,34}}, rotation=0)));
  LEPSE.Interfaces.Single_Pin Ut_pin annotation (Placement(transformation(
          extent={{-106,-90},{-94,-78}}),iconTransformation(extent={{-106,
            -90},{-94,-78}})));
  Basic.logical_switch logical_switch1(
    a1=Uforc,
    a2=Udeforc,
    a3=K0u,
    a4=Tforcedelay)
    annotation (Placement(transformation(extent={{60,18},{80,38}})));
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
        40.6667; -91, 40], Line(points={{-85.3333,38.6666},{-85.3333,20},{
          -101,20}}));
  connect(VoltageDeviation.inp, dV_pin) annotation (points=[-69.8, 80.6667;
          -91, 70], Line(points={{-86,60.6667},{-86,50},{-101,50}}));
  connect(VoltageDeviation.out, Summator3.inp1) annotation (points=[-32,
        80.6667; 9.12, 62], Line(points={{-39.3333,60.6667},{-18,60.6667},{
          -18,46.2},{-12,46.2}}));
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
  connect(SimpleExciter.out, out_pin) annotation (points=[80.6, -0.666667;
          91, 12], Line(points={{117.333,29.3333},{141,29.3333},{141,-8}}));
  connect(Summator6.inp2, ExcitationCurrent.out) annotation (points=[41.12,
          -4; -32, -78.6667], Line(points={{30,20},{30,-44.6667},{-39.3333,
          -44.6667}}));
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
<p>The classical model of the Automatic Voltage Regulator (AVR)</p>
</html>"));
end Excitation_Regulator;
