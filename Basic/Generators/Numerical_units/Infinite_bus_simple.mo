within ;
model Infinite_bus_simple

  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[78,-4; 98,16],
    layer="icon",
    Placement(transformation(extent={{90,-10},{110,10}},
                                                       rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  LEPSE.Basic.Turbines.ASR_Regulator ASC_Regulator_1(Sigma=Sigma, Tauc=Tauc)
    annotation (Placement(transformation(extent={{-86,-20},{-20,28}})));

  parameter Real Ut=1 "ARV voltage reference value";

  parameter Real X1d_p=0.3016 "D-axis transient reactance";

  parameter Real Mtmax=1.1 "Turbine overloading coefficient";
  parameter Real Mtmin=0 "Turbine minimum-loading coefficient";

  parameter Real Sigma=0.0001 "Slip deviation control coefficient";
  parameter Real Tauc=0.0001 "Slip deviation time constant";

  parameter Boolean displayPowerFlow=true "Display power flow";

  parameter Real Sbaz=1000 "Bazis power, MWA";
  parameter Real fbaz=G.sysData.fbaz "Bazic frequency, Hz";
  parameter Real Qmax=9999
    "Текущий предел перевозбуждения, МВар";
  parameter Real Qmin=-9999
    "Текущий предел недовозбуждения, МВар";
  parameter Real cosfi_nom=0.9
    "Nominal maschine power coefficient, p.u.";
  parameter Real Pnom=10000 "Set PV-generator power";
  LEPSE.Basic.Generators.Numerical_units.Infinite_bus_Mashine_simple G(
    Sbaz=Sbaz,
    fbaz=fbaz,
    Ut=Ut,
    Pnom=Pnom,
    Ugnom=Ugnom,
    cosfi_nom=cosfi_nom,
    Qmax=Qmax,
    Qmin=Qmin,
    X1d_p=X1d_p,
    Tj_p=Tj_p,
    Mtmax=Mtmax,
    Mtmin=Mtmin)
    annotation (Placement(transformation(extent={{-2,-32},{70,40}})));
  parameter Real Ugnom=330 "Nominal voltage";
  parameter Real Tj_p=7 "Inertia coefficient";

initial equation
    ASC_Regulator_1.out_pin.Signal = G.Me;

equation

  connect(G.Stator_pin, inp) annotation (Line(points={{70,4},{86,4},{86,0},{100,
          0}}, color={28,108,200}));
  connect(G.slip_pin, ASC_Regulator_1.ds_pin) annotation (Line(
      points={{34,40.72},{34,48},{-92,48},{-92,2.08},{-86.275,2.08}},
      color={255,255,0},
      thickness=0.5));
  connect(ASC_Regulator_1.out_pin, G.Mt_pin) annotation (Line(
      points={{-20.275,4},{-2.72,4}},
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
end Infinite_bus_simple;
