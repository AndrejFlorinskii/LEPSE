within ;
model Reactive_power_limiter
  input Real Qgen;
  input Real Qmax;
  input Real Qmin;
  parameter Boolean inService = true "Excitation limiter condition";

equation
  out.Signal = if inService then
  if Qgen > Qmax then
    0 else if Qgen < Qmin
  then 0 else inp.Signal else inp.Signal;

public
  LEPSE.Interfaces.Signal_pin inp annotation (
    extent=[-92,-10; -72,10],
    layer="icon",
    Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  LEPSE.Interfaces.Signal_pin out annotation (
    extent=[70,-10; 90,10],
    layer="icon",
    Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-60,30},{58,-28}},
          lineColor={0,0,255},
          lineThickness=1),
        Text(extent={{-40,16},{40,-10}},
          textString="dEr limiter",
          textColor={0,0,0}),
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
          thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Reactive_power_limiter model - limits AVR signal afer reaching Qmin/Qmax. </p>
<p>Модель блока ограничения сигнала при достижении Qmin/Qmax. </p>
</html>"));
end Reactive_power_limiter;
