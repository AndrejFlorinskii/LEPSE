within OMLET.Compare_Rustab;
model SMIB_exciter_and_ARV_SD_IB_simple_SM_Kundur
  Real delta_G1_G2(start=-7.297346115112305)
                   "Mutual angle";
  parameter Boolean globalDisplay_U = true;
  parameter Boolean globalDisplay_S = true;

  OMLET.Basic.Generators.Numerical_units.Infinite_bus_simple IB(
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
    G(Pg(start=-495.3849792480469), Qgen(start=-70.46939086914062)),
    TregOff=9) annotation (Placement(transformation(extent={{98,-6},{68,26}})));
  OMLET.Basic.Transformers.Transformers_numerical_units.Transformer Transformer(
    Sbaz=Transformer.sysData.Sbaz,
    n_step=0,
    Rtrans=0.8,
    Xtrans=20,
    Btrans=10,
    displayPowerFlow=globalDisplay_S,
    I2d(start=0.01497831754386425),
    I2q(start=0.49274519085884094))
    annotation (Placement(transformation(extent={{-36,-6},{-10,24}})));
  OMLET.Basic.Branches.Branches_numerical_units.HVline Line_1(
    Rline=2.5,
    Xline=29,
    Bline1=170,
    Bline2=170,
    TLineOff=10.2,
    dTLineOff=10000,
    Koff=1000,
    displayPowerFlow=globalDisplay_S,
    I12d(start=-0.011179720982909203),
    I12q(start=0.24800440669059753),
    Idc2(start=0.018508361652493477),
    Iqc2(start=-0.00041390713886357844))
    annotation (Placement(transformation(extent={{14,-10},{40,26}})));
  OMLET.Basic.Buses.Bus node_1(Unom=20, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{-54,-2},{-34,22}})));
  OMLET.Basic.Buses.Bus node_3(busNumber=3, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{40,-2},{60,22}})));
  OMLET.Basic.Buses.Bus node_2(busNumber=2, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{-6,-2},{14,22}})));

  inner OMLET.Basic.SysData sysData(
    Sbaz=1000,
    Ubaz=330,
    fbaz=50)
    annotation (Placement(transformation(extent={{-78,-44},{-58,-24}})));
  OMLET.Basic.Shunts.Shunts_numerical_units.ShortCircuitShunt SCS(
    Bn=100000,
    Gn=100000,
    TkzOn=10,
    dTkzOn=0.2)
    annotation (Placement(transformation(extent={{-18,-42},{0,-18}})));

  OMLET.Basic.Generators.Numerical_units.SM_with_exciter_and_AVR_SD G(
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
    T2q_p=0.05,
    Sigma=0.0475,
    K0u=20,
    K1u=0,
    Uforc=0,
    Udeforc=0,
    Tforcedelay=0,
    cosfi_nom=0.8,
    displayPowerFlow=globalDisplay_S,
    fbaz=sysData.fbaz,
    pq_table=OMLET.Data.TVV_500_2,
    inService=true,
    Te=0.12,
    selfExcitation=true,
    AVR(
      ExcitationCurrent(x(start={0.0})),
      FrequencyBlockD(x(start={9.508497811339112E-08})),
      FrequencyBlockU(x(start={0.17528675496578217})),
      SimpleExciter(x(start={9.593826689524576E-05})),
      VoltageDerivative(x(start={-4.756775069836294E-06}))),
    exciter(Excitation_delay(x(start={1.8263931274414062}))),
    Umax=6,
    Umin=-6,
    inService_1=true,
    Kd=0,
    Kig_exc=1,
    Kif_exc=1,
    Ku_exc=1,
    ASR(Time_constant(x(start={0.5}))),
    Tauc=0.08,
    G(id(start=-0.40969958901405334), iq(start=0.2738809287548065)))
    annotation (Placement(transformation(extent={{-98,-6},{-52,26}})));
  OMLET.Basic.Branches.Branches_numerical_units.HVline Line_2(
    Rline=2.5,
    Xline=29,
    Bline1=170,
    Bline2=170,
    displayPowerFlow=globalDisplay_S,
    I12d(start=-0.011179720982909203),
    I12q(start=0.24800440669059753),
    Idc2(start=0.018508361652493477),
    Iqc2(start=-0.00041390713886357844))
    annotation (Placement(transformation(extent={{14,-46},{40,-10}})));
equation
  // the formula of the derivative of the angle
  der(delta_G1_G2) =IB.G.Wc*(IB.G.s - G.G.s);

  // the equations of the relation of power and mutual angles
  IB.G.DeltaIJ = 0;
  G.G.DeltaIJ = delta_G1_G2;

  // equating of basis slip to G2 generator's slip
  G.G.Ssys = IB.G.s;
  IB.G.Ssys =IB.G.s;

  connect(node_1.bus_pin, Transformer.inp) annotation (Line(points={{-44.125,
          9.12},{-44.125,9.75},{-36,9.75}}, color={28,108,200}));
  connect(Line_1.out, node_3.bus_pin) annotation (Line(points={{40,10.7},{40,
          10},{48,10},{48,9.12},{49.875,9.12}}, color={28,108,200}));
  connect(node_3.bus_pin,IB. inp) annotation (Line(points={{49.875,9.12},{
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
  connect(SCS.inp, Transformer.out) annotation (Line(points={{-9,-18.3},{-10,-18.3},
          {-10,9.75}}, color={28,108,200}));
  connect(G.inp, node_1.bus_pin) annotation (Line(points={{-52,8.54545},{-52,
          9.12},{-44.125,9.12}}, color={28,108,200}));
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
    Icon(coordinateSystem(extent={{-80,-60},{100,40}}),
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
    Diagram(coordinateSystem(extent={{-80,-60},{100,40}})));
end SMIB_exciter_and_ARV_SD_IB_simple_SM_Kundur;
