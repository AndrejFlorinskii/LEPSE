within ;
model Battery_of_static_capacitors
 outer LEPSE.Basic.SysData sysData;

  parameter Boolean inService = true "Battery topological condition";

  parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
  parameter Real Unom=330 "Nominal battery voltage, kV";
  parameter Real Pc=0.05 "Active losses, MW";
  parameter Real Qc=50 "Reactive power, MVar";
  parameter Real Gc(fixed=false) "Active load, S";
  parameter Real Bc(fixed=false) "Reactive load, S";
  //-------------------------------------------------------------
  parameter Real TloadOff=1000 "Time of battery disconnection, s";
  parameter Real dTloadOff=10 "Duration of battery disconnection, s";

  parameter Boolean displayPowerFlow = true;
  //-------------------------------------------------------------
  Real Udc "D-axis voltage of battery";
  Real Uqc "Q-axis voltage of battery";
  Real Iqc "D-axis current of battery";
  Real Idc "Q-axis current of battery";
  Real Pc_fact "Active power of battery fact";
  Real Qc_fact "Reactive power of battery fact";
  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[-10,76; 10,96],
    layer="icon",
    Placement(transformation(extent={{-10,88},{10,108}},rotation=0),
        iconTransformation(extent={{-10,88},{10,108}})));
initial equation
  // calculating conductivity from power
  Gc = if not inService then 0.00001 else
  Pc/Sbaz;
  Bc = if not inService then -0.00001 else
  Qc/Sbaz;

equation

  // active and reactive load
  Pc_fact = (Uqc*Iqc + Udc*Idc)*Sbaz;
  Qc_fact = (-Uqc*Idc + Udc*Iqc)*Sbaz;

  //the algorithm of triping battery
  Idc = if time >= TloadOff and time < TloadOff + dTloadOff then Udc*
    Gc*1e-8 + Uqc*Bc*1e-8 else Udc*Gc + Uqc*Bc;
  Iqc = if time >= TloadOff and time < TloadOff + dTloadOff then Uqc*
    Gc*1e-8 - Udc*Bc*1e-8 else Uqc*Gc - Udc*Bc;

  //-----connector-----
  inp.Vd = Udc;
  inp.Vq = Uqc;

  inp.Id = -Idc;
  inp.Iq = -Iqc;

  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      Gcid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.31,
      y=0.4,
      width=0.6,
      height=0.6),
    Icon(
      coordinateSystem(
        PceserveAspectRatio=false,
        PceserveOrientation=false,
        extent={{-100,-100},{100,100}},
        Gcid={2,2},
        initialScale=0),
      Gcaphics={
        Line(
          points={{0,30},{0,94}},
          color={28,108,200},
          thickness=1),
        Text(extent={{-98,-62},{102,-98}},
          textColor={0,0,0},
          textString="%name"),
        Line(
          points={{0,30},{-60,-44}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-6,42},{38,34}},
          pattern=LinePattern.None,
          thickness=1,
          color={28,108,200}),
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
        Line(
          points={{-30,-20},{30,-20}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{0,30},{60,-44}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{60,-44},{-60,-44}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-30,-30},{30,-30}},
          color={28,108,200},
          thickness=1)},
      Text(extent=[-100, -64; 100, -100], string="%name"),
      graphics={
        Text(extent={{-100,-42},{100,-78}},
          textColor={0,0,0},
          textString="%name"),
        Line(
          points={{-6,58},{38,50}},
          pattern=LinePattern.None,
          thickness=1),
        Line(
          points={{0,32},{0,92}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-60,-46},{0,32}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{60,-46},{0,32}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{60,-46},{-60,-46}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{28,-22},{-28,-22}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{28,-30},{-28,-30}},
          color={0,0,0},
          thickness=1),
        Text(
          textString=DynamicSelect("Pc MW", String(Pc_fact, siGrificantDigits=3) + " MW"),
          visible=displayPowerFlow,
          extent={{-66,-78},{64,-122}},
          textColor={0,140,72}),
        Text(
          textString=DynamicSelect("Qc MVar", String(Qc_fact, siGrificantDigits=3) + " MVar"),
          visible=displayPowerFlow,
          extent={{-72,-122},{70,-160}},
          textColor={102,44,145})}),
    Documentation(info="<html>
<p>A battery of static capacitors model.</p>
<p>Модель батареи статических конденсаторов. </p>
</html>"));
end Battery_of_static_capacitors;
