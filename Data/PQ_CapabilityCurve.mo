within Data;
record PQ_CapabilityCurve "Паспортные ограничения P-Q диаграммы генератора"
  parameter Real Snom = 588 "Номинальная полная мощность, МВА";
  parameter Real Pnom = 500 "Номинальная активная мощность, МВт";

  // Точки ограничения по нагреву ротора (возбуждения) - Верхний предел Q_max
  parameter Real Qmax_P0 = 320 "Максимальная Q при P=0, МВар";
  parameter Real Qmax_Pnom = 310 "Максимальная Q при P=Pnom, МВар";

  // Точки ограничения по недовозбуждению / устойчивости - Нижний предел Q_min
  parameter Real Qmin_P0 = -200 "Предел потребления Q при P=0, МВар";
  parameter Real Qmin_Pnom = -100 "Предел потребления Q при P=Pnom, МВар";
end PQ_CapabilityCurve;
