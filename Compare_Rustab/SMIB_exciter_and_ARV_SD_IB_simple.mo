within ;
model SMIB_exciter_and_ARV_SD_IB_simple
  Real delta_G1_G2(start=-7.362938404083252)
                   "Mutual angle";
  parameter Boolean globalDisplay_U = true;
  parameter Boolean globalDisplay_S = true;

  LEPSE.Basic.Generators.Numerical_units.Infinite_bus_simple G2(
    Mtmax=1.1,
    Mtmin=-1.1,
    Ut=330,
    X1d_p=0.05,
    Sigma=0.0001,
    Tauc=0.0001,
    Pnom=1000,
    displayPowerFlow=globalDisplay_S,
    Sbaz=sysData.Sbaz,
    fbaz=sysData.fbaz,
    Qmax=9999,
    Qmin=-9999,
    cosfi_nom=0.9,
    Ugnom=330,
    Tj_p=500,
    ASC_Regulator_1(SlipDeviation(x(start={4.3473974642438407E-08})), SlipI_Dif(
          x(start={-0.492626816034317}))),
    G(Pg(start=-495.3849792480469), Qgen(start=-0.7352029085159302)))
    annotation (Placement(transformation(extent={{98,-6},{68,26}})));
  LEPSE.Basic.Transformers.Transformers_numerical_units.Transformer Transformer(
    Sbaz=Transformer.sysData.Sbaz,
    n_step=0,
    Rtrans=0.8,
    Xtrans=20,
    Btrans=10,
    displayPowerFlow=globalDisplay_S,
    I2d(start=0.04732172191143036),
    I2q(start=0.4915044605731964))
    annotation (Placement(transformation(extent={{-36,-6},{-10,24}})));
  LEPSE.Basic.Branches.Branches_numerical_units.HVline Line_1(
    Rline=2.5,
    Xline=29,
    Bline1=170,
    Bline2=170,
    TLineOff=10.2,
    dTLineOff=10000,
    Koff=1000,
    displayPowerFlow=globalDisplay_S,
    I12d(start=2.8756017854902893E-05),
    I12q(start=0.0004938726779073477),
    Idc2(start=1.8450302377459593E-05),
    Iqc2(start=-4.1219308855033887E-07))
    annotation (Placement(transformation(extent={{14,-10},{40,26}})));
  LEPSE.Basic.Buses.Bus node_1(Unom=20, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{-56,-2},{-36,22}})));
  LEPSE.Basic.Buses.Bus node_3(busNumber=3, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{40,-2},{60,22}})));
  LEPSE.Basic.Buses.Bus node_2(busNumber=2, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{-6,-2},{14,22}})));

  inner LEPSE.Basic.SysData sysData(
    Sbaz=1000,
    Ubaz=330,
    fbaz=50)
    annotation (Placement(transformation(extent={{-100,-64},{-80,-44}})));
  LEPSE.Basic.Shunts.Shunts_numerical_units.ShortCircuitShunt shortCircuitShunt_NU(
    Bn=100000,
    Gn=100000,
    TkzOn=10,
    dTkzOn=0.2)
    annotation (Placement(transformation(extent={{-18,-42},{0,-18}})));

  LEPSE.Basic.Generators.Numerical_units.SM_with_exciter_and_AVR_SD G1(
    TauC_up=0.04,
    TregOff=9,
    Kemax=2.5,
    Kemin=-2,
    Pg=500,
    Ut=20.5,
    Pnom=500,
    Ugnom=20,
    Sbaz=sysData.Sbaz,
    Xd_p=1.741,
    Xq_p=1.74,
    Xs_p=0.126,
    Tj_p=12.122,
    X2q_p=0.16,
    X2d_p=0.165,
    X1d_p=0.241,
    Td0=9.2,
    T2d_p=0.04,
    T2q_p=0.5,
    Sigma=0.0475,
    K0u=20,
    Uforc=0,
    Udeforc=0,
    Tforcedelay=0,
    cosfi_nom=0.8,
    displayPowerFlow=globalDisplay_S,
    fbaz=sysData.fbaz,
    pq_table=LEPSE.Data.TVV_500_2,
    inService=true,
    Te=0.12,
    selfExcitation=true,
    AVR(
      ExcitationCurrent(x(start={0.000955859781242907})),
      FrequencyBlockD(x(start={1.6055728337960318E-06})),
      FrequencyBlockU(x(start={0.24151237308979034})),
      SimpleExciter(x(start={0.00142754300031811})),
      VoltageDerivative(x(start={-7.174623169703409E-05}))),
    G(E11d(start=0.6918363571166992), E11q(start=0.7937282919883728)),
    exciter(Excitation_delay(x(start={1.8285093307495117}))),
    Umax=6,
    Umin=-6,
    inService_1=true,
    Kd=0) annotation (Placement(transformation(extent={{-104,-6},{-58,26}})));
  LEPSE.Basic.Branches.Branches_numerical_units.HVline Line_2(
    Rline=2.5,
    Xline=29,
    Bline1=170,
    Bline2=170,
    displayPowerFlow=globalDisplay_S,
    I12d(start=0.028756018728017807),
    I12q(start=0.49387267231941223),
    Idc2(start=0.0184503011405468),
    Iqc2(start=-0.0004121930687688291))
    annotation (Placement(transformation(extent={{14,-46},{40,-10}})));
equation
  // the formula of the derivative of the angle
  der(delta_G1_G2) = G2.G.Wc*(G2.G.s - G1.G.s);

  // the equations of the relation of power and mutual angles
  G2.G.DeltaIJ = 0;
  G1.G.DeltaIJ = delta_G1_G2;

  // equating of basis slip to G2 generator's slip
  G1.G.Ssys = G2.G.s;
  G2.G.Ssys = G2.G.s;

  connect(node_1.bus_pin, Transformer.inp) annotation (Line(points={{-46.125,
          9.12},{-46.125,9.75},{-36,9.75}}, color={28,108,200}));
  connect(Line_1.out, node_3.bus_pin) annotation (Line(points={{40,10.7},{40,
          10},{48,10},{48,9.12},{49.875,9.12}}, color={28,108,200}));
  connect(node_3.bus_pin, G2.inp) annotation (Line(points={{49.875,9.12},{
          49.875,10},{68,10}},
                        color={28,108,200}));
  connect(Transformer.out, node_2.bus_pin) annotation (Line(points={{-10,9.75},
          {-10,9.12},{3.875,9.12}}, color={28,108,200}));
  connect(node_2.bus_pin, Line_1.inp) annotation (Line(points={{3.875,9.12},{
          3.875,10},{14.26,10},{14.26,10.7}}, color={28,108,200}));
  connect(Line_2.inp, Line_1.inp) annotation (Line(points={{14.26,-25.3},{
          14.26,10.7}}, color={28,108,200}));
  connect(Line_2.out, Line_1.out)
    annotation (Line(points={{40,-25.3},{40,10.7}}, color={28,108,200}));
  connect(shortCircuitShunt_NU.inp, Transformer.out) annotation (Line(points=
          {{-9,-18.3},{-10,-18.3},{-10,9.75}}, color={28,108,200}));
  connect(G1.inp, node_1.bus_pin) annotation (Line(points={{-58,10},{-58,9.12},
          {-46.125,9.12}}, color={28,108,200}));
  annotation (Documentation(info="<html>
<p>Calssical model of the simpliest power energy system, which is used to study the basics of transient processes. </p>
<p><b>0 s</b>: start;</p>
<p><b>10 s</b>: three-phase short-circuit in node_2;</p>
<p><b>10.2 s</b>: end of short-circuit, disconnection of the Line_2;</p>
<p><b>30 s</b>: end. </p>
<p>Модель типа &quot;генератор - трансформатор - линия - шины бесконечной мощности&quot;. </p>
<p><b>0 с: </b>старт;</p>
<p><b>10 с:</b> начало 3-фазного КЗ в узле 2;</p>
<p><b>10.2 с: </b>окончание КЗ, отключение линии №1;</p>
<p><b>30 с: </b>финиш расчета;</p>
</html>"),
       experiment(
      StopTime=30,
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
end SMIB_exciter_and_ARV_SD_IB_simple;
