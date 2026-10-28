within ;
model Equation_of_motion_mashine
 outer LEPSE.Basic.SysData sysData;

  //--- Параметры базисные и номинальные ---
  parameter Real Sbaz = sysData.Sbaz "Базовая полная мощность системы, МВА";
  parameter Real Ugnom = 20 "Номинальное напряжение статора генератора, кВ";

  //--- Параметры электрические и механические ---
  parameter Real Tj = 6.5 "Постоянная механической инерции ротора, сек";
  parameter Real D = 2.0 "Коэффициент демпфирования (асинхронный момент), о.е.";
  parameter Real Xd_p = 0.25 "Переходное реактивное сопротивление по оси d, о.е.";
  parameter Real Xq_p = 0.25 "Переходное реактивное сопротивление по оси q, о.е.";
  parameter Real Ra = 0.0015 "Активное сопротивление статора, о.е.";

  //--- Уставки доаварийного (установившегося) режима ---
  parameter Real Pg = 500 "Заданная активная мощность генератора (PV), МВт";
  parameter Real Ut = 20 "Заданное напряжение статора генератора (PV), кВ";
  parameter Real Qg(fixed = false) "Рассчитываемая реактивная мощность в t=0, МВар";

  parameter Real Ut_pu(fixed=false) "stator voltage, p.u.";
  parameter Real Pg_pu(fixed=false) "Active power, p.u.";
  parameter Real Qg_pu(fixed=false) "Reactive power, p.u.";

  //--- Внешний соединитель (координаты D-Q сети) ---
  LEPSE.Interfaces.Pin_v2 inp "Выводы статора генератора";

  //--- Переменные состояния (Динамика ротора) ---
  Real DGi(start = 0.1, fixed = false) "Угол ротора относительно базисной оси сети, рад";
  Real s(start = 0.0, fixed = false) "Относительное скольжение ротора, о.е.";

  //--- Алгебраические переменные ---
  Real Dg "Угол ротора (для отображения и связи)";
  Real dWf "Угол вектора напряжения на зажимах генератора, рад";
  Real DeltaIJ "Угол между ротором и напряжением статора (внутренний угол), рад";

  // Напряжения и токи в осях ротора d-q
  Real ud "Напряжение статора по оси d, о.е.";
  Real uq "Напряжение статора по оси q, о.е.";
  Real id "Ток статора по оси d, о.е.";
  Real iq "Ток статора по оси q, о.е.";

  // Напряжения и токи в осях сети D-Q
  Real UdG "Напряжение статора по оси D сети, о.е.";
  Real UqG "Напряжение статора по оси Q сети, о.е.";
  Real IdG "Ток статора по оси D сети, о.е.";
  Real IqG "Ток статора по оси Q сети, о.е.";

  // Мощности и ЭДС
  Real Pgen "Фактическая активная мощность генератора, МВт";
  Real Qgen "Фактическая реактивная мощность генератора, МВар";
  Real Ugen "Действующее напряжение на зажимах статора, кВ";
  Real Pm "Механическая мощность турбины, о.е.";

  // Переходная ЭДС (постоянна в динамике 2-го порядка, либо управляется АРВ)
  Real Eq_p "Переходная ЭДС по оси q, о.е.";

  LEPSE.Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(
          extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,
            10}})));
initial equation
  //===========================================================================
  // ИНИЦИАЛИЗАЦИЯ УСТАНОВИВШЕГОСЯ РЕЖИМА (PV-bus)
  //===========================================================================
  s = 0;              // В доаварийном режиме скольжение нулевое
  Ugen = Ut;          // Поддерживаем заданное напряжение статора
  Pgen = Pg;          // Генерируем заданную активную мощность
  Qg = Qgen;          // Реактивная мощность определяется балансом сети

  // Расчетные переменные для t=0 в о.е.
  Ut_pu = Ut/Ugnom;
  Pg_pu = Pg/Sbaz;
  Qg_pu = Qg/Sbaz;

  // Физический расчет переходной ЭДС Eq_p и угла DeltaIJ по классическим формулам:
  DeltaIJ = atan2((Xq_p * Pg_pu - Ra * Qg_pu), (Ut_pu^2 + Ra * Pg_pu + Xq_p * Qg_pu));
  Eq_p = sqrt((Ut_pu + (Ra * Pg_pu + Xd_p * Qg_pu)/Ut_pu)^2 +
              ((Xd_p * Pg_pu - Ra * Qg_pu)/Ut_pu)^2);

  // Связь углов при t=0
  DGi = DeltaIJ + dWf;

  // Баланс моментов при t=0 (механическая мощность равна электрической + потери)
  Pm = (Pgen / Sbaz) + (id^2 + iq^2) * Ra;

equation
  //===========================================================================
  // 1. УРАВНЕНИЯ ДВИЖЕНИЯ РОТОРА (Swing Equation)
  //===========================================================================
  der(DGi) = 314.159265358979 * s; // 2 * pi * f_nom (50 Гц)
  Tj * der(s) = Pm - (Pgen / Sbaz) - D * s;

  Dg = DGi;

  //===========================================================================
  // 2. УРАВНЕНИЯ ЭЛЕКТРИЧЕСКОЙ ЧАСТИ (ЭДС за переходным сопротивлением)
  //===========================================================================
  // Связь переходной ЭДС, токов и напряжений статора в осях d-q
  ud = -Ra * id + Xq_p * iq;
  uq = Eq_p - Ra * iq - Xd_p * id;

  //===========================================================================
  // 3. ПРЕОБРАЗОВАНИЯ КООРДИНАТ (Ротор d-q <-> Сеть D-Q)
  //===========================================================================
  // Напряжение сети из пина переводим в о.е.
  UdG = Stator_pin.Vd;
  UqG = Stator_pin.Vq;

  // Определение углов
  dWf = if UqG <> 0 then atan2(UdG, UqG) else atan2(UdG, 0.001);
  DeltaIJ = DGi - dWf;

  // Преобразование напряжений сети в d-q оси ротора
  ud = UqG * sin(DeltaIJ) + UdG * cos(DeltaIJ);
  uq = UqG * cos(DeltaIJ) - UdG * sin(DeltaIJ);

  // Преобразование токов из d-q осей ротора в D-Q оси сети
  IqG = iq * cos(DeltaIJ) + id * sin(DeltaIJ);
  IdG = id * cos(DeltaIJ) - iq * sin(DeltaIJ);

  //===========================================================================
  // 4. СВЯЗЬ С ВНЕШНИМИ ВЫВОДАМИ И ИЗМЕРЕНИЯ
  //===========================================================================
  // Ток, выходящий из генератора в сеть (знак минус согласно правилу flow)
  Stator_pin.Id = -IdG;
  Stator_pin.Iq = -IqG;

  // Расчет мощностей и модуля напряжения
  Pgen = (uq * iq + ud * id) * Sbaz;
  Qgen = (ud * iq - uq * id) * Sbaz;
  Ugen = sqrt(ud^2 + uq^2) * Ugnom;
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.06,
      y=0.07,
      width=0.6,
      height=0.77),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0), graphics),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0),
      graphics={
        Ellipse(
          extent={{-66,66},{70,-64}},
          lineColor={0,0,255},
          lineThickness=1),
        Text(extent={{-36,36},{40,-38}},  textString=
                                               "SM"),
        Text(extent={{-74,-56},{86,-98}},
          textColor={0,0,0},
          textString="%name"),
        Line(
          points={{-58,0},{-94,0}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{96,0},{62,0}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-46,48},{-54,60},{-54,94}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-26,60},{-26,96}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{0,66},{0,98}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{48,48},{56,60},{56,94}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{28,60},{28,94}},
          color={0,0,255},
          thickness=1)},
      Ellipse(extent=[-60, 62; 60, -58], style(thickness=2)),
      Text(extent=[-38, 38; 38, -36], string="SM"),
      Text(extent=[-80, -58; 80, -100], string="%name"),
      Line(points=[-60, 2; -72, 2], style(thickness=2)),
      Line(points=[70, 2; 60, 2], style(thickness=2))),
              __Dymola_Commands(editCall=plot(
            {"L0709_1.P1","L0709_1.U1m"},
            legends={"Calibration L0709_1.P1","Calibration L0709_1.U1m"},
            colors={{255,0,0},{255,0,0}}) "Calibration_U"), Documentation(
        info="<html>
<p>Equation_of_motion_mashine model. </p>
<p>Модель генератора типа &quot;уравнение движения&quot;.</p>
</html>"));
end Equation_of_motion_mashine;
