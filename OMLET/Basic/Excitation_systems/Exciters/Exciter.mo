within ;
model Exciter
   //--- Параметры возбудителя ---
  parameter Real Te = 0.02 "Exciter time constant, с";
  parameter Real Kemax = 2.0 "Multiplicity of forcing on, p.u.";
  parameter Real Kemin = -0.6 "Multiplicity of forcing off, p.u.";
  parameter Boolean selfExcitation = true "Sign of self‑excitation (dependence on Ut)";
  parameter Real Kig_exc = 1.0;
  parameter Real Kif_exc = 1.0;
  parameter Real Ku_exc = 1.0;

  //--- Внутренние переменные ---

  LEPSE.Interfaces.Signal_pin Er0_pin annotation (extent=[-90,-8; -70,12],
      Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  LEPSE.Interfaces.Signal_pin dEr_pin annotation (
    extent=[-60,66; -40,86],
    layer="icon",
    Placement(transformation(extent={{-110,16},{-90,36}}, rotation=0),
        iconTransformation(extent={{-110,16},{-90,36}})));
  LEPSE.Interfaces.Signal_pin Er_pin annotation (extent=[-90,-8; -70,12],
      Placement(transformation(extent={{170,-10},{190,10}}, rotation=0),
        iconTransformation(extent={{170,-10},{190,10}})));
  LEPSE.Interfaces.Signal_pin Ut_pin annotation (extent=[-90,-8; -70,12],
      Placement(transformation(extent={{-110,-34},{-90,-14}}, rotation=0),
        iconTransformation(extent={{-110,-34},{-90,-14}})));

  LEPSE.Interfaces.Signal_pin dIg_pin annotation (
    extent=[-60,66; -40,86],
    layer="icon",
    Placement(transformation(extent={{-110,44},{-90,64}}, rotation=0),
        iconTransformation(extent={{-110,42},{-90,62}})));
  LEPSE.Interfaces.Signal_pin dIf_pin annotation (extent=[-90,-8; -70,12],
      Placement(transformation(extent={{-110,-64},{-90,-44}}, rotation=0),
        iconTransformation(extent={{-110,-64},{-90,-44}})));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function Excitation_delay(b={1}, a=
        {Te,1})
    annotation (Placement(transformation(extent={{52,-22},{100,24}})));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function Rotor_current_deviation(b={
        Kif_exc}, a={1})
    annotation (Placement(transformation(extent={{-76,-80},{-12,-28}})));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function AVR_signal(b={Ku_exc},
      a={1}) annotation (Placement(transformation(extent={{-76,0},{-12,52}})));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function Stator_current_deviation(b={
        Kig_exc}, a={1})
    annotation (Placement(transformation(extent={{-76,28},{-12,80}})));
  LEPSE.Basic.Excitation_systems.Logic.Excitation_limiter excitation_limiter(
    selfExcitation=selfExcitation,
    Kemax=Kemax,
    Kemin=Kemin)
    annotation (Placement(transformation(extent={{112,-20},{154,24}})));
  LEPSE.Basic.Excitation_systems.Logic.Summator_4 summator_4_1
    annotation (Placement(transformation(extent={{8,-16},{42,18}})));
equation

  connect(dIf_pin, dIf_pin) annotation (Line(
      points={{-100,-54},{-100,-54}},
      color={255,255,0},
      thickness=0.5));
  connect(dIg_pin, Stator_current_deviation.inp) annotation (Line(
      points={{-100,54},{-76,54}},
      color={255,255,0},
      thickness=0.5));
  connect(dIf_pin, Rotor_current_deviation.inp) annotation (Line(
      points={{-100,-54},{-76,-54}},
      color={255,255,0},
      thickness=0.5));
  connect(dEr_pin, AVR_signal.inp) annotation (Line(
      points={{-100,26},{-76,26}},
      color={255,255,0},
      thickness=0.5));
  connect(excitation_limiter.inp, Excitation_delay.out) annotation (Line(
      points={{112,2},{112,1},{100,1}},
      color={255,255,0},
      thickness=0.5));
  connect(excitation_limiter.out, Er_pin) annotation (Line(
      points={{154,2},{168,2},{168,0},{180,0}},
      color={255,255,0},
      thickness=0.5));
  connect(Ut_pin, excitation_limiter.Ut_pin) annotation (Line(
      points={{-100,-24},{134,-24},{134,-18},{128.8,-18},{128.8,-11.2}},
      color={255,255,0},
      thickness=0.5));
  connect(summator_4_1.out, Excitation_delay.inp) annotation (Line(
      points={{42,1},{52,1}},
      color={255,255,0},
      thickness=0.5));
  connect(AVR_signal.out, summator_4_1.inp2) annotation (Line(
      points={{-12,26},{2,26},{2,5.42},{8,5.42}},
      color={255,255,0},
      thickness=0.5));
  connect(Stator_current_deviation.out, summator_4_1.inp1) annotation (Line(
      points={{-12,54},{4,54},{4,13.24},{8,13.24}},
      color={255,255,0},
      thickness=0.5));
  connect(Er0_pin, summator_4_1.inp3) annotation (Line(
      points={{-100,0},{-80,0},{-80,-4},{4,-4},{4,-2.4},{8,-2.4}},
      color={255,255,0},
      thickness=0.5));
  connect(Rotor_current_deviation.out, summator_4_1.inp4) annotation (Line(
      points={{-12,-54},{-2,-54},{-2,-10.22},{8,-10.22}},
      color={255,255,0},
      thickness=0.5));
  connect(Er0_pin, excitation_limiter.Er0_pin) annotation (Line(
      points={{-100,0},{-80,0},{-80,-4},{4,-4},{4,-26},{137.2,-26},{137.2,-11.2}},
      color={255,255,0},
      thickness=0.5));

  annotation (Diagram(coordinateSystem(extent={{-100,-100},{180,100}})),
                          Icon(coordinateSystem(extent={{-100,-100},{180,100}}),
                               graphics={
        Ellipse(
          extent={{-52,84},{126,-86}},
          lineColor={0,0,255},
          lineThickness=1),
        Text(extent={{6,38},{82,-36}},
          textString="Exciter",
          textColor={0,0,0}),
        Text(extent={{-42,-90},{118,-132}},
          textColor={0,0,0},
          textString="%name"),
        Line(
          points={{-52,0},{-94,0}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{176,0},{126,0}},
          color={0,0,255},
          thickness=1)}),
    Documentation(info="<html>
<p>Exciter model. </p>
<p>Модель возбудителя. </p>
</html>"));
end Exciter;
