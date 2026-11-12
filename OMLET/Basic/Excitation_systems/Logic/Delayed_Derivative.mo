within ;
model Delayed_Derivative
  parameter Real t1 = 0.02 "Time delay (sec)";

  Real u "Входной сигнал";
  Real u_delayed "Задержанный входной сигнал";
  Real y "Выходной сигнал (производная)";

public
  LEPSE.Interfaces.Signal_pin inp annotation (
    Placement(transformation(extent={{-110,-10},{-90,10}})));
  LEPSE.Interfaces.Signal_pin out annotation (
    Placement(transformation(extent={{90,-10},{110,10}})));

equation
  u = inp.Signal;

  // Оператор delay(выражение, время_задержки)
  // Вторым аргументом может быть указано максимальное время задержки (обычно равно t1)
  u_delayed = delay(u, t1);

  // Дифференцирование задержанного сигнала
  y = der(u_delayed);

  out.Signal = y;

  annotation (
    Icon(
      coordinateSystem(extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(
          extent={{-60,30},{58,-28}},
          lineColor={0,0,255},
          lineThickness=1),
        Text(
          extent={{-55,25},{55,-25}},
          lineColor={0,0,255},
          textString="p*exp(-t1*p)"),
        Text(
          extent={{-100,60},{100,40}},
          textColor={0,0,0},
          textString="%name"),
        Line(points={{-60,0},{-94,0}}, color={0,0,255}),
        Line(points={{98,0},{58,0}}, color={0,0,255})}),
    Documentation(info="<html>
<p>Differentiation block with delay.</p>
<p>Блок дифференцирования с чистым запаздыванием: W(p) = p * exp(-t1*p)</p>
</html>"));
end Delayed_Derivative;
