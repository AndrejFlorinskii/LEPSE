within ;
model ASR_Regulator

  parameter Real Sigma=0.0475 "Slip deviation control coefficient";
  parameter Real Tauc=0.15 "Slip deviation time constant";

  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function SlipDeviation(b={-1/
        Sigma}, a={Tauc,1}) annotation (extent=[-74,57.3333; -27.3333,104],
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
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function SlipI_Dif(b={1}, a={1,
        0}) annotation (Placement(transformation(extent={{10,-28},{66,12}})));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function Slip_Prop(b={1}, a={1})
    annotation (Placement(transformation(extent={{10,-68},{66,-28}})));
  LEPSE.Basic.Excitation_systems.Logic.Transfer_Function Slip_Int(b={1,0}, a={1,
        1}) annotation (Placement(transformation(extent={{10,12},{66,52}})));
  LEPSE.Basic.Excitation_systems.Logic.Summator_3 summator_3_1
    annotation (Placement(transformation(extent={{92,-18},{112,2}})));

equation

  connect(SlipDeviation.inp,ds_pin)  annotation (points=[-69.8,80.6667; -91,70],
      Line(points={{-64,-8},{-101,-8}},                   thickness=0.5));

  connect(SlipDeviation.out, SlipI_Dif.inp)
    annotation (Line(points={{-11.3333,-8},{10,-8}}, color={0,0,0}));
  connect(Slip_Prop.inp, SlipI_Dif.inp) annotation (Line(
      points={{10,-48},{0,-48},{0,-8},{10,-8}},
      color={0,0,0},
      thickness=0.5));
  connect(Slip_Int.inp, SlipI_Dif.inp) annotation (Line(
      points={{10,32},{0,32},{0,-8},{10,-8}},
      color={0,0,0},
      thickness=0.5));
  connect(SlipI_Dif.out, summator_3_1.inp2) annotation (Line(
      points={{66,-8},{68,-8.2},{92,-8.2}},
      color={0,0,0},
      thickness=0.5));
  connect(Slip_Int.out, summator_3_1.inp1) annotation (Line(
      points={{66,32},{86,32},{86,-2},{92,-2}},
      color={0,0,0},
      thickness=0.5));
  connect(Slip_Prop.out, summator_3_1.inp3) annotation (Line(
      points={{66,-48},{86,-48},{86,-14},{92,-14}},
      color={0,0,0},
      thickness=0.5));
  connect(summator_3_1.out, out_pin) annotation (Line(
      points={{112,-8},{128,-8},{128,0},{139,0}},
      color={0,0,0},
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
          textString="s")}),
    Documentation(info="<html>
<p>Automatic Slip Regulator (ASR) model. </p>
<p>Модель автоматического регулятора скольжения. </p>
</html>"));
end ASR_Regulator;
