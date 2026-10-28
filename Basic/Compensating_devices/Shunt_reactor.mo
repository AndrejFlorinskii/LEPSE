within ;
model Shunt_reactor
 outer LEPSE.Basic.SysData sysData;

  parameter Boolean inService = true "Reactor topological condition";

  parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
  parameter Real Unom=330 "Nominal load voltage, kV";
  parameter Real Pr=0.05 "Active losses, MW";
  parameter Real Qr=50 "Reactive power, MVar";
  parameter Real Gr(fixed=false) "Active load, S";
  parameter Real Br(fixed=false) "Reactive load, S";
  //-------------------------------------------------------------
  parameter Real TloadOff=1000 "Time of reactor disconnection, s";
  parameter Real dTloadOff=10 "Duration of reactor disconnection, s";

  parameter Boolean displayPowerFlow = true;
  //-------------------------------------------------------------
  Real Udr "D-axis voltage of reactor";
  Real Uqr "Q-axis voltage of reactor";
  Real Iqr "D-axis current of reactor";
  Real Idr "Q-axis current of reactor";
  Real Pr_fact "Active power of reactor fact";
  Real Qr_fact "Reactive power of reactor fact";
  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[-10,76; 10,96],
    layer="icon",
    Placement(transformation(extent={{-10,88},{10,108}},rotation=0),
        iconTransformation(extent={{-10,88},{10,108}})));
initial equation
  // calculating conductivity from power
  Gr = if not inService then 0.00001 else
  Pr/Sbaz;
  Br = if not inService then -0.00001 else
  -Qr/Sbaz;

equation

  // active and reactive load
  Pr_fact = (Uqr*Iqr + Udr*Idr)*Sbaz;
  Qr_fact = (-Uqr*Idr + Udr*Iqr)*Sbaz;

  //the algorithm of triping reactor
  Idr = if time >= TloadOff and time < TloadOff + dTloadOff then Udr*
    Gr*1e-8 + Uqr*Br*1e-8 else Udr*Gr + Uqr*Br;
  Iqr = if time >= TloadOff and time < TloadOff + dTloadOff then Uqr*
    Gr*1e-8 - Udr*Br*1e-8 else Uqr*Gr - Udr*Br;

  //-----connector-----
  inp.Vd = Udr;
  inp.Vq = Uqr;

  inp.Id = -Idr;
  inp.Iq = -Iqr;

  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.31,
      y=0.4,
      width=0.6,
      height=0.6),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0),
      graphics={
        Line(
          points={{0,42},{0,92}},
          color={0,0,0},
          thickness=1),
        Text(extent={{-98,-62},{102,-98}},
          textColor={0,0,0},
          textString="%name"),
          Text(
          textString=DynamicSelect("Pr MW", String(Pr_fact, siGrificantDigits=3) + " MW"),
          visible=displayPowerFlow,
          extent={{-94,-102},{104,-140}},
          textColor={0,168,6}),
        Text(
          textString=DynamicSelect("Qr MVar", String(Qr_fact, siGrificantDigits=3) + " MVar"),
          visible=displayPowerFlow,
          extent={{-94,-140},{104,-178}},
          textColor={102,44,145}),
        Line(
          points={{-40,2},{0,2}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{0,2},{0,-54}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-6,54},{38,46}},
          pattern=LinePattern.None,
          thickness=1),
        Line(
          points={{-40,60},{40,-20}},
          lineColor={255,0,0},
          lineThickness=3.5,
          visible=DynamicSelect(not inService, not inService)),
        Line(
          points={{-40,-20},{40,60}},
          lineColor={255,0,0},
          lineThickness=3.5,
          visible=DynamicSelect(not inService, not inService)),
        Text(
          extent={{-34,-15},{36,-81}},
          textColor={238,0,0},
          textString="DISC",
          visible=DynamicSelect(not inService, not inService)),
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          startAngle=0,
          endAngle=270,
          closure=EllipseClosure.None,
          rotation=90,
          lineThickness=1,
          origin={0,2}),
        Line(
          points={{-20,-54},{20,-54}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-12,-60},{12,-60}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-6,-66},{6,-66}},
          color={0,0,0},
          thickness=1)},
      Rectangle(extent=[-20, 60; 20, -40], style(thickness=2)),
      Line(points=[0, -40; 0, -60], style(thickness=2)),
      Line(points=[-20, -60; 20, -60], style(thickness=2)),
      Line(points=[0, 80; 0, 60], style(thickness=2)),
      Text(extent=[-100, -64; 100, -100], string="%name")),
    Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">A shunt_reactor model.</span></p>
<p><span style=\"background-color: #ffffff;\">Модель шунтирующего реактора.</span></p>
</html>"));
end Shunt_reactor;
