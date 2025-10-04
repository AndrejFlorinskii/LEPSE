within Examples;
model Simple_model
  Real delta_G1_G2(start=0.5534006953239441) "Mutual angle";

  LEPSE.Basic.Gen_with_ARV_control G1(G(
      Pg=0.85,
      Qg=0.5,
      Ut=1.05), AVR(
      K0u=-20,
      ExcitationCurrent(x(start={-0.03201247379183769})),
      FrequencyBlockD(x(start={-0.2747640907764435})),
      FrequencyDerivative(x(start={-0.2747640907764435})),
      FrequencyDeviation(x(start={-0.27476415038108826})),
      SimpleExciter(x(start={-0.05362093076109886})),
      VoltageDerivative(x(start={0.0026810464914888144})),
      VoltageDeviation(x(start={0.0026810464914888144}))))
    annotation (Placement(transformation(extent={{-64,-2},{-28,32}})));
  LEPSE.Basic.HVline Line_1(TLineOff=30.1, dTLineOff=5)
    annotation (Placement(transformation(extent={{-14,2},{6,22}})));
  LEPSE.Basic.Gen_with_ARV_control G2(AVR(
      K0u=-30,
      K1u=-5,
      K0w=0,
      ExcitationCurrent(x(start={-1.6456316709518433})),
      FrequencyBlockD(x(start={-0.2747640907764435})),
      FrequencyDerivative(x(start={-0.2747640907764435})),
      FrequencyDeviation(x(start={-0.27476415038108826})),
      SimpleExciter(x(start={-0.14810684323310852})),
      VoltageDerivative(x(start={0.004936894867569208})),
      VoltageDeviation(x(start={0.004936894867569208}))), G(
      Pg=2,
      Qg=0.5,
      Ut=1,
      R1d_p=0.0037,
      R1q_p=0.0028,
      Rf_p=0.0009,
      Tj_p=50.0,
      X1d_p=0.015,
      X2d_p=0.012,
      X2q_p=0.012,
      Xd_p=0.1,
      Xq_p=0.1,
      Xs_p=0.01)) "infinite bus"        annotation (Placement(transformation(
        extent={{-18,-18},{18,18}},
        rotation=180,
        origin={40,18})));
  LEPSE.Basic.Constant_Conductivity_Load constant_Conductivity_Load(Gn=2.81, Bn
      =0.7) annotation (Placement(transformation(extent={{4,-18},{24,2}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt(
    Bn=-100000,
    Gn=-100000,
    TkzOn=30,
    dTkzOn=0.1)
    annotation (Placement(transformation(extent={{-32,-16},{-12,4}})));
  LEPSE.Interfaces.Node node_1 annotation (Placement(transformation(extent={{-24,
            14},{-18,20}}), iconTransformation(extent={{-138,-48},{-118,-28}})));
  LEPSE.Interfaces.Node node_2 annotation (Placement(transformation(extent={{10,
            14},{16,20}}), iconTransformation(extent={{-136,-48},{-116,-28}})));
equation
  // the formula of the derivative of the angle
  der(delta_G1_G2) = G2.G.Wc*(G2.G.s - G1.G.s);

  G2.G.DeltaIJ = 0;
  G1.G.DeltaIJ = delta_G1_G2;

  G1.G.Ssys = G2.G.s;
  G2.G.Ssys = G2.G.s;

  connect(node_1,Line_1. inp)
    annotation (Line(points={{-21,17},{-11.6,17}}, color={28,108,200}));
  connect(Line_1.out, node_2) annotation (Line(points={{3.8,17.2},{3.8,17},
          {13,17}}, color={28,108,200}));
  connect(node_2,G2. inp) annotation (Line(points={{13,17},{13,16.92},{
          24.16,16.92}},
                   color={28,108,200}));
  connect(node_2, constant_Conductivity_Load.inp) annotation (Line(points={
          {13,17},{14,17},{14,0.6}}, color={28,108,200}));
  connect(node_1, G1.inp) annotation (Line(points={{-21,17},{-24,17},{-24,
          16.02},{-30.16,16.02}},
                           color={28,108,200}));
  connect(node_1, shortCircuitShunt.inp) annotation (Line(points={{-21,17},
          {-22,17},{-22,-1.2}}, color={28,108,200}));
  annotation (Documentation(info="<html>
<p>Calssical model of the simpliest power energy system, which is used to study the basics of transient processes. </p>
<p><b>0 s</b>: start;</p>
<p><b>30 s</b>: three-phase short-circuit in node_1;</p>
<p><b>30.1 s</b>: end of short-circuit, disconnection one of the two circuits of the Line_1;</p>
<p><b>35.1 s</b>: automatic reclosing of the Line_1 circuit ;</p>
<p><b>50 s</b>: end. </p>
</html>"),
       experiment(
      StopTime=30,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-05,
      __Dymola_Algorithm="Dassl"),
    Icon(graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-74,-72},{78,74}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-22,56},{60,0},{-22,-52},{-22,56}})}),
    Diagram(graphics={Text(
          extent={{-30,34},{-16,24}},
          textColor={0,0,255},
          textString="1"), Text(
          extent={{6,34},{20,24}},
          textColor={0,0,255},
          textString="2")}));
end Simple_model;
