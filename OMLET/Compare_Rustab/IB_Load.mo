within OMLET.Compare_Rustab;
model IB_Load
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
    G(
      Pg(start=-495.3849792480469),
      Ut=340,
      Qgen(start=-0.7352029085159302)))
    annotation (Placement(transformation(extent={{98,-6},{68,26}})));
  OMLET.Basic.Branches.Branches_numerical_units.HVline Line_1(
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
  OMLET.Basic.Buses.Bus node_3(busNumber=2, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{40,-2},{60,22}})));
  OMLET.Basic.Buses.Bus node_2(busNumber=1, displayVoltage=globalDisplay_U)
    annotation (Placement(transformation(extent={{-6,-2},{14,22}})));

  inner OMLET.Basic.SysData sysData(
    Sbaz=1000,
    Ubaz=330,
    fbaz=50)
    annotation (Placement(transformation(origin={40,20},   extent = {{-100, -64}, {-80, -44}})));
  OMLET.Basic.Shunts.Shunts_numerical_units.ShortCircuitShunt SCS(
    Bn=100000,
    Gn=100000,
    TkzOn=10,
    dTkzOn=0.2)
    annotation (Placement(transformation(extent={{-24,-38},{-6,-14}})));

  OMLET.Basic.Branches.Branches_numerical_units.HVline Line_2(
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
  OMLET.Basic.Shunts.Shunts_numerical_units.Constant_Conductivity_Load Load(Pn=1100,
      Qn=110) annotation (Placement(transformation(extent={{-48,-12},{-28,8}})));
equation

  IB.G.DeltaIJ = 0;
  IB.G.Ssys = IB.G.s;

  connect(Line_1.out, node_3.bus_pin) annotation (Line(points={{40,10.7},{40,
          10},{48,10},{48,9.12},{49.875,9.12}}, color={28,108,200}));
  connect(node_3.bus_pin, IB.inp) annotation (Line(points={{49.875,9.12},{
          49.875,10},{68,10}}, color={28,108,200}));
  connect(node_2.bus_pin, Line_1.inp) annotation (Line(points={{3.875,9.12},{
          3.875,10},{14.26,10},{14.26,10.7}}, color={28,108,200}));
  connect(Line_2.inp, Line_1.inp) annotation (Line(points={{14.26,-25.3},{
          14.26,10.7}}, color={28,108,200}));
  connect(Line_2.out, Line_1.out)
    annotation (Line(points={{40,-25.3},{40,10.7}}, color={28,108,200}));
  connect(Load.inp, node_2.bus_pin) annotation (Line(points={{-38,7.8},{-38,10},
          {-16,10},{-16,9.12},{3.875,9.12}}, color={28,108,200}));
  connect(SCS.inp, node_2.bus_pin) annotation (Line(points={{-15,-14.3},{-16,-14.3},
          {-16,9.12},{3.875,9.12}}, color={28,108,200}));
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
end IB_Load;
