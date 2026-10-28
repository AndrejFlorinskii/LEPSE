within Examples;
model Simple_model_with_IB_simple
  Real delta_G1_G2(start=-0.8181529641151428)
                   "Mutual angle";
  parameter Boolean globalDisplay_U = true;
  parameter Boolean globalDisplay_S = true;

  LEPSE.Basic.Generators.Numerical_units.SM_with_AVR G1(
    TregOff=50,
    AVR(
      K0u=20,
      K1u=1,
      K0w=0.5,
      K1w=0.5,
      K1if=1,
      Tokp=1,
      ExcitationCurrent(x(start={3.61038310359163E-10})),
      FrequencyBlockD(x(start={7.436739483772381E-13})),
      FrequencyDerivative(x(start={7.343578870000478E-12})),
      FrequencyDeviation(x(start={5.822318755593914E-12})),
      SimpleExciter(x(start={2.2703037227955747E-09})),
      VoltageDerivative(x(start={-1.2102227553434375E-10})),
      VoltageDeviation(x(start={-1.2119059922266473E-10}))),
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
    K0u=20,
    Uforc=0.85,
    Udeforc=0.95,
    Tforcedelay=0,
    cosfi_nom=0.8,
    displayPowerFlow=globalDisplay_S,
    G(
      ud(start=-0.033826773074383566),
      uq(start=1.020381381777528),
      Qg(start=78.32073974609375)),
    fbaz=sysData.fbaz,
    pq_table=LEPSE.Data.TVV_500_2)
    annotation (Placement(transformation(extent={{-110,-6},{-78,26}})));
  LEPSE.Basic.Generators.Numerical_units.Infinite_bus G2(
    ASC_Regulator_1(SlipDeviation(x(start={2.3845495771766508E-15})), SlipI_Dif(
          x(start={0.5073677897453308}))),
    Mtmin=-1.1,
    AVR(
      K0u=10,
      ExcitationCurrent(x(start={-2.2143660516338315E-10})),
      FrequencyBlockD(x(start={7.436739483772381E-13})),
      FrequencyDerivative(x(start={3.7059990493082395E-12})),
      FrequencyDeviation(x(start={2.999895470923164E-12})),
      SimpleExciter(x(start={1.0827304608440613E-09})),
      VoltageDerivative(x(start={-1.0848310444400155E-10})),
      VoltageDeviation(x(start={-1.0861222338176546E-10}))),
    Ut=330,
    Xd_p=0.5,
    Xq_p=0.5,
    Xs_p=0.037,
    X1d_p=0.058,
    X2d_p=0.041,
    X2q_p=0.059,
    K0u=50,
    Sigma=0.0001,
    Tauc=0.0001,
    Pnom=1000,
    inp(Vd(start=-0.21416403353214264), Vq(start=0.9767976999282837)),
    displayPowerFlow=globalDisplay_S,
    Sbaz=sysData.Sbaz,
    fbaz=sysData.fbaz,
    G(Pg(start=507.3677978515625), Qg(start=91.8717269897461)),
    Qmax=9999,
    Qmin=-9999)
    annotation (Placement(transformation(extent={{126,-6},{96,26}})));
  LEPSE.Basic.Transformers.Transformers_numerical_units.Transformer Transformer_NU1(
    Sbaz=Transformer_NU1.sysData.Sbaz,
    n_step=2,
    Rtrans=0.8,
    Xtrans=20,
    Btrans=10,
    displayPowerFlow=globalDisplay_S,
    I2d(start=-0.07897039502859116),
    I2q(start=0.5000495910644531))
    annotation (Placement(transformation(extent={{-36,-6},{-10,24}})));
  LEPSE.Basic.Branches.Branches_numerical_units.HVline HVline_NU1(
    Rline=2.5,
    Xline=29,
    Bline1=170,
    Bline2=170,
    displayPowerFlow=globalDisplay_S)
    annotation (Placement(transformation(extent={{14,-10},{40,26}})));
  LEPSE.Basic.Buses.Bus node_1(Unom=20, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{-56,-2},{-36,22}})));
  LEPSE.Basic.Buses.Bus node_3(busNumber=3, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{38,-2},{58,22}})));
  LEPSE.Basic.Buses.Bus bus(busNumber=2, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{-6,-2},{14,22}})));

  inner LEPSE.Basic.SysData sysData(
    Sbaz=1000,
    Ubaz=330,
    fbaz=50)
    annotation (Placement(transformation(extent={{-100,-64},{-80,-44}})));
  LEPSE.Basic.Shunts.Shunts_numerical_units.ShortCircuitShunt shortCircuitShunt_NU(
    Bn=1000,
    Gn=1000,
    TkzOn=40,
    dTkzOn=0.2)
    annotation (Placement(transformation(extent={{-6,-44},{12,-20}})));

  LEPSE.Basic.Branches.Branches_numerical_units.Breaker breaker(
    I12d(start=-0.0789467841386795),
    I12q(start=0.5000675320625305),
    Idc2(start=8.748163082827887E-09),
    Iqc2(start=9.999833309848327E-06))
    annotation (Placement(transformation(extent={{-76,-2},{-54,20}})));
equation
  // the formula of the derivative of the angle
  der(delta_G1_G2) = G2.G.Wc*(G2.G.s - G1.G.s);

  // the equations of the relation of power and mutual angles
  G2.G.DeltaIJ = 0;
  G1.G.DeltaIJ = delta_G1_G2;

  // equating of basis slip to G2 generator's slip
  G1.G.Ssys = G2.G.s;
  G2.G.Ssys = G2.G.s;

  connect(node_1.bus_pin, Transformer_NU1.inp) annotation (Line(points={{-46.125,
          9.12},{-46.125,9.75},{-36,9.75}},
                                         color={28,108,200}));
  connect(HVline_NU1.out, node_3.bus_pin) annotation (Line(points={{40,10.7},
          {40,10},{48,10},{48,9.12},{47.875,9.12}},
                                                color={28,108,200}));
  connect(node_3.bus_pin, G2.inp) annotation (Line(points={{47.875,9.12},{
          47.875,10},{96,10}},
                        color={28,108,200}));
  connect(Transformer_NU1.out, bus.bus_pin) annotation (Line(points={{-10,
          9.75},{-10,9.12},{3.875,9.12}},
                                      color={28,108,200}));
  connect(bus.bus_pin, HVline_NU1.inp) annotation (Line(points={{3.875,9.12},
          {3.875,10},{14.26,10},{14.26,10.7}},
                                 color={28,108,200}));
  connect(HVline_NU1.inp, shortCircuitShunt_NU.inp) annotation (Line(points={{14.26,
          10.7},{14.26,-5.65},{3,-5.65},{3,-20.3}},           color={28,108,
          200}));
  connect(G1.inp, breaker.inp) annotation (Line(points={{-78,10},{-78,10.65},
          {-75.78,10.65}},
                        color={28,108,200}));
  connect(breaker.out, node_1.bus_pin) annotation (Line(points={{-54,10.65},
          {-54,9.12},{-46.125,9.12}},color={28,108,200}));
  annotation (Documentation(info="<html>
<p>Calssical model of the simpliest power energy system, which is used to study the basics of transient processes. </p>
<p><b>0 s</b>: start;</p>
<p><b>30 s</b>: three-phase short-circuit in node_1;</p>
<p><b>30.1 s</b>: end of short-circuit, disconnection one of the two circuits of the Line_1;</p>
<p><b>35.1 s</b>: automatic reclosing of the Line_1 circuit ;</p>
<p><b>50 s</b>: end. </p>
</html>"),
       experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-05,
      __Dymola_Algorithm="Lsodar"),
    Icon(coordinateSystem(extent={{-100,-60},{100,40}}),
         graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-74,-72},{78,74}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-22,56},{60,0},{-22,-52},{-22,56}})}),
    Diagram(coordinateSystem(extent={{-100,-60},{100,40}})));
end Simple_model_with_IB_simple;
