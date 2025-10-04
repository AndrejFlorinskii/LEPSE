within ;
connector Node
  Real Vd "Potential Vd";
  Real Vq "Potential Vq";
  flow Real Id "Current Id";
  flow Real Iq "Current Iq";
  annotation (
    Coordsys(
      extent=[-30, -30; 30, 30],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.26,
      y=0.25,
      width=0.6,
      height=0.6),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0),
      graphics={Ellipse(
          extent={{-20,20},{20,-20}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)},
         Rectangle(extent=[-30, 30; 30, -30], style(fillColor=0))),
    Documentation(info="<html>
<p>Node Model</p>
</html>"));
end Node;
