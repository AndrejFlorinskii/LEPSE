within Basic;
model Transfer_Function
  parameter Real b[:]={1}
  "Numerator coefficients of transfer function.";
  parameter Real a[:]={1,1}
  "Denominator coefficients of transfer function.";
  output Real x[size(a, 1) - 1]
  "State of transfer function from controller canonical form";

protected
  parameter Integer na=size(a, 1)
    "Size of Denominator of transfer function.";
  parameter Integer nb(max=na) = size(b, 1)
    "Size of Numerator of transfer function.";
  parameter Integer nx=size(a, 1) - 1;
  Real x1dot
  "Derivative of first state of TransferFcn";
  Real xn
  "Highest order state of TransferFcn";
  Real u
  "input variable";
  Real y
  "output variable";

public
  LEPSE.Interfaces.Single_Pin inp annotation (
    extent=[-92,-10; -72,10],
    layer="icon",
    Placement(transformation(extent={{-110,-10},{-90,10}},rotation=0),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  LEPSE.Interfaces.Single_Pin out annotation (
    extent=[70,-10; 90,10],
    layer="icon",
    Placement(transformation(extent={{90,-10},{110,10}},rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
equation
  [der(x); xn] = [x1dot; x];
  [u] = transpose([a])*[x1dot; x];
  [y] = transpose([zeros(na - nb, 1); b])*[x1dot; x];

  //-----connector-----
  inp.Signal = u;
  out.Signal = y;

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
        Rectangle(
          extent={{-60,30},{58,-28}},
          lineColor={0,0,255},
          lineThickness=1),
        Text(extent={{-40,28},{40,2}}, textString=
                                           "Transfer"),
        Text(extent={{-38,4},{42,-22}}, textString=
                                            "function"),
        Text(extent={{-100,58},{100,34}},
          textColor={0,0,0},
          textString="%name"),
        Line(
          points={{-60,0},{-94,0}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{98,0},{58,0}},
          color={0,0,255},
          thickness=1)},
      Rectangle(extent=[-60, 30; 58, -28], style(color=0, thickness=2)),
      Text(extent=[-40, 28; 40, 2], string="Transfer"),
      Text(extent=[-38, 4; 42, -22], string="function"),
      Text(extent=[-60, -28; 58, -52], string="%name"),
      Line(points=[-60, 0; -74, 0], style(color=0, thickness=2)),
      Line(points=[74, 0; 58, 0], style(color=0, thickness=2))),
    Window(
      x=0.37,
      y=0.14,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p>The model of the transfer function</p>
</html>"));
end Transfer_Function;
