within Examples;
model Simple_model_with_IB_and_AT
  Real delta_G1_G2 "Mutual angle";
  parameter Boolean globalDisplay_U = true;
  parameter Boolean globalDisplay_S = true;

  LEPSE.Basic.Generators.Numerical_units.SM_with_AVR G1(
    AVR(
      K0u=-20,
      K1u=1,
      K0w=0.5,
      K1w=0.5,
      K1if=1,
      Tokp=1,
      ExcitationCurrent(x(start={-2.3522164821624756})),
      FrequencyBlockD(x(start={-1.4936236993889906E-06})),
      FrequencyDerivative(x(start={6.43398379907012E-05})),
      FrequencyDeviation(x(start={7.389810343738645E-05})),
      SimpleExciter(x(start={-9.401464462280273})),
      VoltageDerivative(x(start={0.4700719714164734})),
      VoltageDeviation(x(start={0.4700711667537689}))),
    Pg=500,
    Ut=20,
    Pnom=500,
    Ugnom=20,
    Sbaz=sysData.Sbaz,
    Xd_p=2.56,
    Xq_p=2.559,
    Xs_p=0.259,
    Tj_p=12.122,
    X2q_p=0.242,
    X2d_p=0.235,
    X1d_p=0.355,
    Td0=9.2,
    T2d_p=0.04,
    T2q_p=0.5,
    Sigma=0.0475,
    K0u=-10,
    Uforc=0.85,
    Udeforc=0.95,
    Tforcedelay=0,
    cosfi_nom=0.8,
    displayPowerFlow=globalDisplay_S,
    G(ud(start=-0.033826773074383566), uq(start=1.020381381777528)),
    fbaz=sysData.fbaz,
    pq_table=LEPSE.Data.TVV_500_2) annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=0,
        origin={-122,10})));
  LEPSE.Basic.Generators.Numerical_units.Infinite_bus G2(
    ASC_Regulator_1(SlipDeviation(x(start={-4.708469614200794E-09}))),
    AVR(
      ExcitationCurrent(x(start={-3.2290213108062744})),
      FrequencyBlockD(x(start={-1.4936236993889906E-06})),
      FrequencyDerivative(x(start={6.032549936207943E-05})),
      FrequencyDeviation(x(start={6.928620132384822E-05})),
      SimpleExciter(x(start={-5.408055782318115})),
      VoltageDerivative(x(start={0.5408056974411011})),
      VoltageDeviation(x(start={0.5408057570457458}))),
    Ut=330,
    Xd_p=0.5,
    Xq_p=0.5,
    Xs_p=0.037,
    X1d_p=0.058,
    X2d_p=0.041,
    X2q_p=0.059,
    K0u=-50,
    Sigma=0.0001,
    Tauc=0.0001,
    Pnom=1000,
    inp(Vd(start=-0.036036766431498016), Vq(start=1.017821731299887)),
    displayPowerFlow=globalDisplay_S,
    Sbaz=sysData.Sbaz,
    fbaz=sysData.fbaz)
    annotation (Placement(transformation(extent={{94,-6},{64,26}})));
  LEPSE.Basic.Branches.Branches_numerical_units.HVline HVline_NU1(
    Rline=2.5,
    Xline=29,
    Bline1=170,
    Bline2=170,
    displayPowerFlow=globalDisplay_S)
    annotation (Placement(transformation(extent={{14,-10},{40,26}})));
  LEPSE.Basic.Shunts.Shunts_numerical_units.Constant_Conductivity_Load Constant_Conductivity_Load_NU(
    Pn=1000,
    Qn=100,
    displayPowerFlow=globalDisplay_S)
    annotation (Placement(transformation(extent={{44,-36},{68,-12}})));
  LEPSE.Basic.Buses.Bus node_1(Unom=20, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{-106,-2},{-86,22}})));
  LEPSE.Basic.Buses.Bus node_3(busNumber=3, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{38,-2},{58,22}})));
  LEPSE.Basic.Buses.Bus node_2(busNumber=2, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{-66,-2},{-46,22}})));

  inner LEPSE.Basic.SysData sysData(
    Sbaz=1000,
    Ubaz=330,
    fbaz=50)
    annotation (Placement(transformation(extent={{-140,-64},{-120,-44}})));
  LEPSE.Basic.Shunts.Shunts_numerical_units.ShortCircuitShunt shortCircuitShunt_NU(
    Bn=1000,
    Gn=1000,
    TkzOn=40,
    dTkzOn=0.2)
    annotation (Placement(transformation(extent={{2,-46},{20,-22}})));

  LEPSE.Basic.Transformers.Transformers_numerical_units.Transformer transformer_NU(
    Sbaz=sysData.Sbaz,
    n_step=2,
    Unom=115,
    Rtrans=0.4,
    Xtrans=10,
    Btrans=10) annotation (Placement(transformation(
        extent={{-12,-13},{12,13}},
        rotation=0,
        origin={-76,9})));
  LEPSE.Basic.Transformers.Transformers_numerical_units.Autotransformer autotransformer(
    n_step=0,
    Unom_HV=340,
    Unom_MV=115,
    Rline_HV=1,
    Xline_HV=58,
    Rline_MV=0.32,
    Xline_MV=-2.5,
    Rline_LV=2.8,
    Xline_LV=130) annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=180,
        origin={-26,10})));
  LEPSE.Basic.Shunts.Shunts_numerical_units.Constant_Conductivity_Load Constant_Conductivity_Load_NU1(
    Unom=10,
    Pn=10,
    Qn=1,
    displayPowerFlow=globalDisplay_S)
    annotation (Placement(transformation(extent={{-28,-40},{-4,-16}})));
equation
  // the formula of the derivative of the angle
  der(delta_G1_G2) = G2.G.Wc*(G2.G.s - G1.G.s);

  // the equations of the relation of power and mutual angles
  G2.G.DeltaIJ = 0;
  G1.G.DeltaIJ = delta_G1_G2;

  // equating of basis slip to G2 generator's slip
  G1.G.Ssys = G2.G.s;
  G2.G.Ssys = G2.G.s;

  connect(Constant_Conductivity_Load_NU.inp, G2.inp) annotation (Line(
        points={{56,-12.24},{56,10},{64,10}},color={28,108,200}));
  connect(HVline_NU1.out, node_3.bus_pin) annotation (Line(points={{40,10.7},
          {40,10},{48,10},{48,9.12},{47.875,9.12}},
                                                color={28,108,200}));
  connect(node_3.bus_pin, G2.inp) annotation (Line(points={{47.875,9.12},{
          47.875,10},{64,10}},
                        color={28,108,200}));
  connect(HVline_NU1.inp, shortCircuitShunt_NU.inp) annotation (Line(points={{14.26,
          10.7},{14.26,-5.65},{11,-5.65},{11,-22.3}},         color={28,108,
          200}));
  connect(G1.inp, node_1.bus_pin) annotation (Line(points={{-106,10},{-106,
          9.12},{-96.125,9.12}},  color={28,108,200}));
  connect(node_1.bus_pin, transformer_NU.inp) annotation (Line(points={{
          -96.125,9.12},{-96.125,9.65},{-88,9.65}}, color={28,108,200}));
  connect(transformer_NU.out, node_2.bus_pin) annotation (Line(points={{-64,
          9.65},{-64,9.12},{-56.125,9.12}}, color={28,108,200}));
  connect(node_2.bus_pin, autotransformer.MV_pin) annotation (Line(points={
          {-56.125,9.12},{-48.0625,9.12},{-48.0625,6.4},{-38,6.4}}, color={
          28,108,200}));
  connect(autotransformer.HV_pin, HVline_NU1.inp) annotation (Line(points={
          {-14,9.28},{10,9.28},{10,10.7},{14.26,10.7}}, color={28,108,200}));
  connect(autotransformer.LV_pin, Constant_Conductivity_Load_NU1.inp)
    annotation (Line(points={{-37.76,19.6},{-37.76,26},{-10,26},{-10,-12},{
          -16,-12},{-16,-16.24}},  color={28,108,200}));
  annotation (Documentation(info="<html>
<p>Calssical model of the simpliest power energy system, which is used to study the basics of transient processes. </p>
<p><b>0 s</b>: start;</p>
<p><b>30 s</b>: three-phase short-circuit in node_1;</p>
<p><b>30.1 s</b>: end of short-circuit, disconnection one of the two circuits of the Line_1;</p>
<p><b>35.1 s</b>: automatic reclosing of the Line_1 circuit ;</p>
<p><b>50 s</b>: end. </p>
</html>"),
       experiment(
      StopTime=50,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-05,
      __Dymola_Algorithm="Lsodar"),
    Icon(coordinateSystem(extent={{-140,-60},{100,40}}),
         graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-94,-72},{58,74}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-40,56},{42,0},{-40,-52},{-40,56}})}),
    Diagram(coordinateSystem(extent={{-140,-60},{100,40}})));
end Simple_model_with_IB_and_AT;
