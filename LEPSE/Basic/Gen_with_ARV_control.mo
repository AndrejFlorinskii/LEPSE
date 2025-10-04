within Basic;
model Gen_with_ARV_control

  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[78,-4; 98,16],
    layer="icon",
    Placement(transformation(extent={{90,-10},{110,10}},
                                                       rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  Basic.Excitation_Regulator AVR annotation (extent=[-84,-90; -32,82],
      Placement(transformation(extent={{-84,-90},{-32,82}}, rotation=0)));
  Basic.Synch_Machine G annotation (extent=[-28,-72; 70,80], Placement(
        transformation(extent={{-28,-72},{70,80}}, rotation=0)));
equation
  connect(AVR.out_pin, G.Ef_pin) annotation (points=[-34.34, 6.32; -18.2,
        5.52], Line(points={{-31.7833,-10.88},{-28,4}}));
  connect(AVR.dV1_pin, AVR.dV_pin) annotation (points=[-81.66, 30.4; -
        81.66, 56.2], Line(points={{-84.2167,13.2},{-84.2167,38},{-82,38},{
          -82,44},{-84.2167,44},{-84.2167,39}}));
  connect(G.dUtr_pin, AVR.dV_pin) annotation (points=[-3.5, 61.76; -4, 76;
          -82, 76; -81.66, 56.2], Line(points={{-5.46,80},{-5.46,76},{
          -84.2167,76},{-84.2167,39}}));
  connect(G.dWu_pin, AVR.dfsys_pin) annotation (points=[13.16, 61.76; 14,
        80; -86, 80; -86, 4; -81.66, 4.6], Line(points={{8.26,80},{8.26,80},
          {-86,80},{-86,-12.6},{-84.2167,-12.6}}));
  connect(G.dWf_pin, AVR.dfU_pin) annotation (points=[28.84, 61.76; 28, 84;
          -88, 84; -88, -22; -81.66, -21.2], Line(points={{21,80},{21,84},{
          -88,84},{-88,-38.4},{-84.2167,-38.4}}));
  connect(G.dIf_pin, AVR.dif1_pin) annotation (points=[45.5, 61.76; 44, 90;
          -94, 90; -94, -46; -81.66, -47], Line(points={{34.72,80},{34.72,
          90},{-94,90},{-94,-59.04},{-84.2167,-59.04}}));
  connect(G.Stator_pin, inp) annotation (points=[59.22, 5.52; 88, 6], Line(
        points={{70,4},{100,0}}));

  connect(G.Ut_pin, AVR.Ut_pin) annotation (Line(points={{48.44,80},{48.44,
          92},{-96,92},{-96,-76.24},{-84,-76.24}},    color={0,0,0}));
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0),
      graphics={
        Ellipse(extent={{-74,68},{72,-68}}, lineColor={0,0,255},
          lineThickness=1),
        Text(extent={{-44,44},{46,10}}, textString=
                                            "Gen."),
        Text(extent={{-50,12},{50,-14}},textString=
                                            "with ARV"),
        Text(extent={{-78,96},{74,70}},
          textColor={0,0,0},
          textString="%name"),
        Line(points={{94,0},{72,0}}, color={0,0,255},
          thickness=1),
        Text(extent={{-50,-14},{50,-40}},textString=
                                             "control")},
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
<p>Generator model with automatic excitation control</p>
</html>"));
end Gen_with_ARV_control;
