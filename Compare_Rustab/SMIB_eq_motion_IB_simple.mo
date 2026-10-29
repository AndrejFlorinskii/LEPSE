within LEPSE.Compare_Rustab;
model SMIB_eq_motion_IB_simple
  Real delta_G1_G2 "Mutual angle";
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
    TregOff=9)
    annotation (Placement(transformation(extent={{98,-6},{68,26}})));
  LEPSE.Basic.Transformers.Transformers_numerical_units.Transformer Transformer(
    Sbaz=Transformer.sysData.Sbaz,
    n_step=0,
    Rtrans=0.8,
    Xtrans=20,
    Btrans=10,
    displayPowerFlow=globalDisplay_S)
    annotation (Placement(transformation(extent={{-36,-6},{-10,24}})));
  LEPSE.Basic.Branches.Branches_numerical_units.HVline Line_1(
    Rline=2.5,
    Xline=29,
    Bline1=170,
    Bline2=170,
    TLineOff=10.2,
    dTLineOff=10000,
    Koff=1000,
    displayPowerFlow=globalDisplay_S)
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

  LEPSE.Basic.Branches.Branches_numerical_units.HVline Line_2(
    Rline=2.5,
    Xline=29,
    Bline1=170,
    Bline2=170,
    displayPowerFlow=globalDisplay_S)
    annotation (Placement(transformation(extent={{14,-46},{40,-10}})));
  Basic.Generators.Numerical_units.Equation_motion_grid G1(
    Ut=20.5,
    X1d_p=0.241,
    Mtmax=1.1,
    Mtmin=0,
    Sigma=0.0475,
    Tauc=0.08,
    displayPowerFlow=true,
    Sbaz=G1.G.sysData.Sbaz,
    fbaz=G1.G.sysData.fbaz,
    cosfi_nom=0.8,
    Pnom=500,
    Ugnom=20,
    Tj_p=12.122,
    Pg=500,
    Kd=30,
    TregOff=9)
    annotation (Placement(transformation(extent={{-88,-4},{-62,22}})));
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
  connect(G1.inp, node_1.bus_pin) annotation (Line(points={{-62,9},{-56,9},{-56,
          9.12},{-46.125,9.12}}, color={28,108,200}));
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
      __Dymola_NumberOfIntervals=2000,
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
end SMIB_eq_motion_IB_simple;
