within Turbines;
model ASR_Regulator_

  parameter Real Sigma=0.0475 "Slip deviation control coefficient";
  parameter Real Tauc=0.15 "Slip deviation time constant";

  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function SlipDeviation(b={-1/
        Sigma}, a={1}) annotation (extent=[-74,57.3333; -27.3333,104],
      Placement(transformation(extent={{-64,-32},{-11.3333,16}}, rotation=0)));
  LEPSE.Interfaces.Signal_pin ds_pin annotation (
    extent=[-96,64; -86,76],
    layer="icon",
    Placement(transformation(extent={{-106,-14},{-96,-2}},
                                                         rotation=0),
        iconTransformation(extent={{-106,-14},{-96,-2}})));
  LEPSE.Interfaces.Signal_pin out_pin annotation (
    extent=[86,2; 96,22],
    layer="icon",
    Placement(transformation(extent={{134,-10},{144,10}},
                                                        rotation=0),
        iconTransformation(extent={{134,-10},{144,10}})));

  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function Time_constant(b={1}, a=
        {Tauc,1})
    annotation (Placement(transformation(extent={{64,-24},{118,22}})));
  LEPSE.Interfaces.Signal_pin Mu0_pin annotation (
    extent=[-96,64; -86,76],
    layer="icon",
    Placement(transformation(extent={{-106,34},{-96,46}}, rotation=0),
        iconTransformation(extent={{-106,32},{-96,44}})));
  LEPSE.Basic.Excitation_systems.Logic.Summator_2 summator_2_1
    annotation (Placement(transformation(extent={{16,-10},{36,10}})));
equation

  connect(SlipDeviation.inp,ds_pin)  annotation (points=[-69.8,80.6667; -91,70],
      Line(points={{-64,-8},{-101,-8}},                   thickness=0.5));

  connect(Time_constant.out, out_pin) annotation (Line(
      points={{118,-1},{118,-2},{130,-2},{130,0},{139,0}},
      color={255,255,0},
      thickness=0.5));
  connect(Mu0_pin, summator_2_1.inp1) annotation (Line(
      points={{-101,40},{10,40},{10,4.2},{16,4.2}},
      color={255,255,0},
      thickness=0.5));
  connect(SlipDeviation.out, summator_2_1.inp2) annotation (Line(
      points={{-11.3333,-8},{10,-8},{10,-4},{16,-4}},
      color={255,255,0},
      thickness=0.5));
  connect(summator_2_1.out, Time_constant.inp) annotation (Line(
      points={{36,0},{56,0},{56,-1},{64,-1}},
      color={255,255,0},
      thickness=0.5));
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.32,
      y=0.06,
      width=0.6,
      height=0.82),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-100},{140,100}},
        grid={2,2},
        initialScale=0),
      graphics={
        Rectangle(
          extent={{-68,72},{104,-94}},
          lineColor={0,0,255},
          lineThickness=1),
        Text(extent={{-6,26},{38,-10}},
          textString="Slip",
          textColor={0,0,0}),
        Text(extent={{-14,20},{56,-46}}, textString=
                                             "regulator"),
        Text(extent={{-64,106},{96,74}},
          textColor={0,0,0},
          textString="%name"),
        Line(
          points={{138,-2},{104,-2}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-68,-8},{-100,-8}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-68,38},{-100,38}},
          color={0,0,255},
          thickness=1)},
      Rectangle(extent=[-68, 80; 66, -60], style(thickness=2)),
      Text(extent=[-42, 60; 40, -18], string="Excitation"),
      Text(extent=[-36, 34; 34, -32], string="regulator"),
      Line(points=[-68, 10; -88, 10], style(thickness=2)),
      Line(points=[-68, -20; -88, -20], style(thickness=2)),
      Line(points=[-68, -50; -88, -50], style(thickness=2)),
      Line(points=[-68, 40; -88, 40], style(thickness=2)),
      Line(points=[-68, 70; -88, 70], style(thickness=2)),
      Text(extent=[-84, -62; 76, -94], string="%name"),
      Line(points=[86, 12; 66, 12], style(thickness=2))),
    Diagram(coordinateSystem(extent={{-100,-100},{140,100}}), graphics={
        Text(
          extent={{-90,10},{-80,0}},
          textColor={0,0,0},
          textString="s"),
        Text(
          extent={{-94,66},{-82,54}},
          textColor={0,0,0},
          textString="Mu0")}),
    Documentation(info="<html>
<p>Automatic Slip Regulator (ASR) model. </p>
<p>Модель автоматического регулятора скольжения. </p>
</html>"));
end ASR_Regulator_;
