within Interfaces;
connector Single_Pin
  Real Signal "Connector's signal";

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
      graphics={Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={255,255,0},
          lineThickness=0.5,
          fillColor={255,127,0},
          fillPattern=FillPattern.CrossDiag)},
         Rectangle(extent=[-80, 80; 80, -80], style(
          color=49,
          thickness=2,
          fillColor=45,
          fillPattern=10))),
    Window(
      x=0.3,
      y=0.2,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p>The model of the basic connector for measuring signals</p>
</html>"));
end Single_Pin;
