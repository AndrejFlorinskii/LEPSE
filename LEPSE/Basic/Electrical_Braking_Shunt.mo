within Basic;
model Electrical_Braking_Shunt
  parameter Real Rline=0.2 "Active resistance of electrical braking device";
  //---------------------------------------------
  parameter Real TLineOff=1000 "Time of electrical braking";
  parameter Real dTLineOff=10 "Duration of electrical braking";
  //---------------------------------------------

  Real Ud "D-axis voltage of shunt electrical braking";
  Real Uq "Q-axis voltage of shunt electrical braking";
  Real I12d "D-axis current of shunt electrical braking";
  Real I12q "Q-axis current of shunt electrical braking";
  Real I12m "Full current of shunt electrical braking";
  Real Um "Full voltage of shunt electrical braking";
  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[-10,78; 10,98],
    layer="icon",
    Placement(transformation(extent={{-10,88},{10,108}},rotation=0),
        iconTransformation(extent={{-10,88},{10,108}})));
equation
  // the algorithm of shunt electrical braking start
  I12d = if time >= TLineOff and time < TLineOff + dTLineOff then Ud/Rline
     else 0;
  I12q = if time >= TLineOff and time < TLineOff + dTLineOff then Uq/Rline
     else 0;

  //---------measurements-----------------------------------------------------
  I12m = sqrt(I12d^2 + I12q^2);
  Um = sqrt(Ud^2 + Uq^2);

  //-----connector-----
  inp.Vd = Ud;
  inp.Vq = Uq;

  inp.Id = -I12d;
  inp.Iq = -I12q;

  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.25,
      y=0.18,
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
        Rectangle(
          extent={{-20,50},{20,-30}},
          lineColor={0,0,255},
          lineThickness=1.0,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-20,-50},{20,-50}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{0,-50},{0,-30}},
          color={0,0,255},
          thickness=1.0),
        Rectangle(
          extent={{-10,80},{10,60}},
          lineColor={0,0,255},
          lineThickness=1.0,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,50},{0,60}},
          color={0,0,255},
          thickness=1.0),
        Line(
          points={{0,80},{0,90}},
          color={0,0,255},
          thickness=1.0),
        Text(extent={{-98,-50},{102,-88}},
          textColor={0,0,0},
          textString="%name")},
      Rectangle(extent=[-20, 40; 20, -40], style(thickness=2, fillColor=8)),
      Line(points=[-20, -60; 20, -60], style(thickness=2)),
      Line(points=[0, -60; 0, -40], style(thickness=2)),
      Rectangle(extent=[-10, 70; 10, 50], style(thickness=2, fillColor=8)),
      Line(points=[0, 40; 0, 50], style(thickness=2)),
      Line(points=[0, 70; 0, 80], style(thickness=2)),
      Text(extent=[-100, -62; 100, -100], string="%name")),
    Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">Model of parallel electric braking device</span></p>
</html>"));
end Electrical_Braking_Shunt;
