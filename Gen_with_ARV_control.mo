within ;
model Gen_with_ARV_control

  LEPSE.Basic.Pin_v2 inp annotation (
    extent=[78,-4; 98,16],
    layer="icon",
    Placement(transformation(extent={{78,-4},{98,16}}, rotation=0)));
  LEPSE.Basic.Excitation_Regulator AVR annotation (extent=[-84,-90; -32,82],
      Placement(transformation(extent={{-84,-90},{-32,82}}, rotation=0)));
  LEPSE.Basic.Synch_Machine G annotation (extent=[-28,-72; 70,80],
      Placement(transformation(extent={{-28,-72},{70,80}}, rotation=0)));
equation
  connect(AVR.out_pin, G.Ef_pin) annotation (points=[-34.34, 6.32; -18.2,
        5.52], Line(points={{-34.3833,6.32},{-18.2,5.52}}));
  connect(AVR.dV1_pin, AVR.dV_pin) annotation (points=[-81.66, 30.4; -
        81.66, 56.2], Line(points={{-82.05,30.4},{-82.05,38},{-82,38},{-82,44},
          {-82.4833,44},{-82.4833,47.6}}));
  connect(G.dUtr_pin, AVR.dV_pin) annotation (points=[-3.5, 61.76; -4, 76;
          -82, 76; -81.66, 56.2], Line(points={{-6.44,61.76},{-6.44,76},{
          -82.4833,76},{-82.4833,47.6}}));
  connect(G.dWu_pin, AVR.dfsys_pin) annotation (points=[13.16, 61.76; 14,
        80; -86, 80; -86, 4; -81.66, 4.6], Line(points={{5.32,61.76},{5.32,80},
          {-86,80},{-86,4.6},{-82.05,4.6}}));
  connect(G.dWf_pin, AVR.dfU_pin) annotation (points=[28.84, 61.76; 28, 84;
          -88, 84; -88, -22; -81.66, -21.2], Line(points={{17.08,61.76},{
          17.08,84},{-88,84},{-88,-21.2},{-82.05,-21.2}}));
  connect(G.dIf_pin, AVR.dif1_pin) annotation (points=[45.5, 61.76; 44, 90;
          -94, 90; -94, -46; -81.66, -47], Line(points={{29.82,61.76},{
          29.82,90},{-94,90},{-94,-41.84},{-82.05,-41.84}}));
  connect(G.Stator_pin, inp) annotation (points=[59.22, 5.52; 88, 6], Line(
        points={{59.22,5.52},{88,6}}));
  //equation
  //connect(G.dUtr, AVR.u_u);
  //connect(G.dUtr, AVR.u_pu);
  //connect(G.dWu, AVR.u_fsys);
  //connect(G.dWf, AVR.u_fu);
  //connect(G.dIf, AVR.u_pIf);
  //connect(AVR.y_er, G.dEr);
  //---connector---
  //-----------------------------------------------------------
  //inp.Vd = G.UdG;
  //inp.Vq = G.UqG;
  //inp.Id = G.IdG;
  //inp.Iq = G.IqG;
  connect(G.Ut_pin, AVR.Ut_pin) annotation (Line(points={{41.58,61.76},{41.58,
          92},{-96,92},{-96,-59.04},{-81.8333,-59.04}},
                                                      color={0,0,0}));
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
        Ellipse(extent={{-74,72},{72,-58}}),
        Text(extent={{-44,54},{46,20}}, textString=
                                            "Gen."),
        Text(extent={{-50,22},{50,-4}}, textString=
                                            "with ARV"),
        Text(extent={{-78,-58},{74,-84}}, textString=
                                              "%name"),
        Line(points={{80,6},{72,6}}),
        Text(extent={{-50,-4},{50,-30}}, textString=
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
