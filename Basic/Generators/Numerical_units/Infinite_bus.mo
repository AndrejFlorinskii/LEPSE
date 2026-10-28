within ;
model Infinite_bus

  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[78,-4; 98,16],
    layer="icon",
    Placement(transformation(extent={{90,-10},{110,10}},
                                                       rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  LEPSE.Basic.Turbines.ASR_Regulator ASC_Regulator_1(Sigma=Sigma, Tauc=Tauc)
    annotation (Placement(transformation(extent={{-86,-80},{-20,-32}})));
  LEPSE.Basic.Generators.Numerical_units.Infinite_bus_Mashine G(
    TgenOff=TgenOff,
    dTgenOff=dTgenOff,
    Sbaz=Sbaz,
    fbaz=fbaz,
    Pnom=Pnom,
    Ut=Ut,
    cosfi_nom=cosfi_nom,
    Qmax=Qmax,
    Qmin=Qmin,
    Xd_p=Xd_p,
    Xq_p=Xq_p,
    Xs_p=Xs_p,
    X1d_p=X1d_p,
    X2d_p=X2d_p,
    X2q_p=X2q_p,
    Tj_p=500,
    Td0=Td0,
    T2d_p=T2d_p,
    T2q_p=T2q_p,
    Mtmax=Mtmax,
    Mtmin=Mtmin,
    Kemax=Kemax,
    Kemin=Kemin)
    annotation (Placement(transformation(extent={{-6,-38},{82,58}})));

  parameter Real TgenOff=1000 "Time of generator's disconnection";
  parameter Real dTgenOff=10 "Duration of generator's disconnection";
  parameter Real Ut=1 "ARV voltage reference value";
  parameter Real Xd_p=1.869 "D-axis synchronous reactance";
  parameter Real Xq_p=1.869 "Q-axis synchronous reactance";
  parameter Real Xs_p=0.194 "Leakage reactance of stator winding";
  parameter Real X1d_p=0.3016 "D-axis transient reactance";
  parameter Real X2d_p=0.2337 "D-axis subtransient reactance";
  parameter Real X2q_p=0.2337 "Q-axis subtransient reactance";
  parameter Real Rf_p=904e-6 "Active resistance of field winding";
  parameter Real R1d_p=3.688e-3
    "Active resistance of d-axis damper winding";
  parameter Real R1q_p=2.77e-3 "Active resistance of q-axis damper winding";
  parameter Real Mtmax=1.1 "Turbine overloading coefficient";
  parameter Real Mtmin=0 "Turbine minimum-loading coefficient";
  parameter Real Kemax=2.0 "Multiplicity of forcing on";
  parameter Real Kemin=-0.6 "Multiplicity of forcing off";
  parameter Real K0u=-10 "Voltage deviation control coefficient";
  parameter Real K1u=0 "Voltage derivative control coefficient";
  parameter Real K0w=0 "Frequency deviation control coefficient";
  parameter Real K1w=0 "Frequency derivative control coefficient";
  parameter Real K1if=0 "Rotor current derivative control coefficient";
  parameter Real Uforc=0.85 "Voltage of field forcing input";
  parameter Real Udeforc=0.9 "Voltage of field forcing removing";
  parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
  parameter Real Sigma=0.0001 "Slip deviation control coefficient";
  parameter Real Tauc=0.0001 "Slip deviation time constant";

  parameter Real Td0=10 "D-axis transient time constant, s";
  parameter Real T2d_p=0.02 "D-axis subtransient time constant, s";
  parameter Real T2q_p=0.05 "Q-axis subtransient time constant, s";

  parameter Boolean displayPowerFlow=true "Display power flow";

  parameter Real Sbaz=1000 "Bazis power, MWA";
  parameter Real fbaz=G.sysData.fbaz "Bazic frequency, Hz";
  parameter Real Qmax=9999
    "Текущий предел перевозбуждения, МВар";
  parameter Real Qmin=-9999
    "Текущий предел недовозбуждения, МВар";
  LEPSE.Basic.Excitation_systems.Regulators.Excitation_Regulator_Q_limit AVR(
    K0u=K0u,
    K1u=K1u,
    K0w=K0w,
    K1w=K1w,
    K1if=K1if,
    Uforc=Uforc,
    Udeforc=Udeforc,
    Tforcedelay=Tforcedelay,
    Tokp=Tokp,
    Qgen=G.Qgen,
    Qmax=G.Qmax,
    Qmin=G.Qmin,
    inService=inService)
    annotation (Placement(transformation(extent={{-108,-24},{-24,58}})));
  parameter Boolean inService=true "Excitation limiter condition";
  parameter Real cosfi_nom=0.9
    "Nominal maschine power coefficient, p.u.";
  parameter Real Pnom=10000 "Set PV-generator power";
  parameter Real Tokp=0.05
    "The main channel of regulation time constant";
initial equation
    ASC_Regulator_1.out_pin.Signal = G.Me;

equation

  connect(G.Mt_pin, ASC_Regulator_1.out_pin) annotation (Line(
      points={{-6,-3.44},{-16,-3.44},{-16,-56},{-20.275,-56}},
      color={255,255,0},
      thickness=0.5));

  connect(inp, G.Stator_pin) annotation (Line(points={{100,0},{100,10},{82,
          10}}, color={28,108,200}));
  connect(G.Ef_pin, AVR.out_pin) annotation (Line(
      points={{-6,10},{-20,10},{-20,13.72},{-23.65,13.72}},
      color={255,255,0},
      thickness=0.5));
  connect(G.dUtr_pin, AVR.dV_pin) annotation (Line(
      points={{14.24,58},{14.24,66},{-114,66},{-114,37.5},{-108.35,37.5}},
      color={255,255,0},
      thickness=0.5));
  connect(AVR.dV_pin, AVR.dV1_pin) annotation (Line(
      points={{-108.35,37.5},{-108.35,25.2}},
      color={255,255,0},
      thickness=0.5));
  connect(G.slip_pin, ASC_Regulator_1.ds_pin) annotation (Line(
      points={{75.84,58},{75.84,66},{116,66},{116,-86},{-90,-86},{-90,-57.92},{-86.275,
          -57.92}},
      color={255,255,0},
      thickness=0.5));
  connect(G.Ut_pin, AVR.Ut_pin) annotation (Line(
      points={{62.64,58},{62.64,82},{-122,82},{-122,-17.44},{-108,-17.44}},
      color={255,255,0},
      thickness=0.5));
  connect(G.dIf_pin, AVR.dif1_pin) annotation (Line(
      points={{50.32,58},{50.32,78},{-120,78},{-120,-9.24},{-108.35,-9.24}},
      color={255,255,0},
      thickness=0.5));
  connect(G.dWf_pin, AVR.dfU_pin) annotation (Line(
      points={{38,58},{38,74},{-118,74},{-118,0.6},{-108.35,0.6}},
      color={255,255,0},
      thickness=0.5));
  connect(G.dWu_pin, AVR.dfsys_pin) annotation (Line(
      points={{26.56,58},{26.56,70},{-116,70},{-116,12.9},{-108.35,12.9}},
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
        extent={{-120,-100},{100,100}},
        grid={2,2},
        initialScale=0),
      graphics={
        Ellipse(extent={{-74,68},{72,-68}}, lineColor={0,0,255},
          lineThickness=1),
        Text(extent={{-78,96},{74,70}},
          textColor={0,0,0},
          textString="%name"),
        Line(points={{94,0},{72,0}}, color={0,0,255},
          thickness=1),
          Text(
          textString=DynamicSelect("P MW", String(G.Pgen, significantDigits=3) + " MW"),
          visible=displayPowerFlow,
          extent={{-96,-70},{102,-108}},
          textColor={0,168,6}),
        Text(
          textString=DynamicSelect("Q MVar", String(G.Qgen, significantDigits=3) + " MVar"),
          visible=displayPowerFlow,
          extent={{-94,-100},{104,-138}},
          textColor={102,44,145}),
        Ellipse(
          extent={{-25,26},{25,-26}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={-25,-3.55271e-15},
          rotation=180),
        Ellipse(
          extent={{-25,26},{25,-26}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          closure=EllipseClosure.None,
          startAngle=0,
          endAngle=180,
          origin={25,0},
          rotation=360)},
      Ellipse(extent=[-74, 72; 72, -58]),
      Text(extent=[-44, 54; 46, 20], string="Gen."),
      Text(extent=[-50, 22; 50, -4], string="with ARV"),
      Text(extent=[-78, -58; 74, -84], string="%name"),
      Line(points=[80, 6; 72, 6]),
      Text(extent=[-50, -4; 50, -30], string="control")),
    Window(
      x=0.28,
      y=0.01,
      width=0.6,
      height=0.88),
    Documentation(info="<html>
<p>Infinite bus model. </p>
<p>Модель шин бесконечной мощности. </p>
</html>"),
    Diagram(coordinateSystem(extent={{-120,-100},{100,100}})));
end Infinite_bus;
