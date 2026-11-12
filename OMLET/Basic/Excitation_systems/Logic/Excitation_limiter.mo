within ;
model Excitation_limiter
  parameter Boolean selfExcitation = true "Sign of self‑excitation (dependence on Ut)";
  parameter Real Kemax = 2.0 "Multiplicity of forcing on, p.u.";
  parameter Real Kemin = -0.6 "Multiplicity of forcing off, p.u.";

  Real Er_max_dyn "Dynamic upper limit";
  Real Er_min_dyn "Dynamic lower limit";
  Real Er0_val;
  Real Ut_val;

public
  LEPSE.Interfaces.Signal_pin Ut_pin annotation (
    extent=[-92,-10; -72,10],
    layer="icon",
    Placement(transformation(extent={{-30,-70},{-10,-50}}, rotation=0),
        iconTransformation(extent={{-30,-70},{-10,-50}})));
public
  LEPSE.Interfaces.Signal_pin Er0_pin annotation (
    extent=[-92,-10; -72,10],
    layer="icon",
    Placement(transformation(extent={{12,-70},{32,-50}}, rotation=0),
        iconTransformation(extent={{10,-70},{30,-50}})));
equation
   // 1. Учет схемы питания (самовозбуждение от шин генератора)
  if selfExcitation then
    Er_max_dyn = Kemax * Er0_val * Ut_val; // Потолок падает вместе с Ut!
    Er_min_dyn = Kemin * Er0_val * Ut_val;
  else
    Er_max_dyn = Kemax * Er0_val;          // Независимое возбуждение
    Er_min_dyn = Kemin * Er0_val;
  end if;

  out.Signal = smooth(0, if inp.Signal > Er_max_dyn then Er_max_dyn
                     else if inp.Signal < Er_min_dyn then Er_min_dyn
 else
     inp.Signal);

  Ut_val = min(1.0, Ut_pin.Signal);
  Er0_pin.Signal = Er0_val;

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
          thickness=1),
        Line(
          points={{-20,-58},{-20,-28}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{20,-58},{20,-28}},
          color={0,0,255},
          thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Limiter of minimum and maximum excitation.</p>
<p>Ограничитель минимального и максимального возбуждения. </p>
</html>"));
end Excitation_limiter;
