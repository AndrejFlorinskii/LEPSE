within ;
model ShortCircuitShunt
  outer LEPSE.Basic.SysData sysData;

  parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
  parameter Real Umon=20 "Nominal voltage, kV";
  parameter Real Bn=1000 "Reactive conductivity of short sircuit, S";
  parameter Real Gn=1000 "Active conductivity of short sircuit, S";
  parameter Real Yn(fixed=false) "Total conductivity of short sircuit, S";
  //-----------------------------------
  parameter Real TkzOn=1000 "Time of short sircuit, s";
  parameter Real dTkzOn=0.12 "Duration of short sircuit, s";

  parameter Real Bn_sc(fixed=false) "Reactive conductivity of short sircuit, p.u.";
  parameter Real Gn_sc(fixed=false) "Active conductivity of short sircuit, p.u.";
  //-----------------------------------

  Real id "D-axis current of short-circuit";
  Real iq "Q-axis current of short-circuit";
  Real Ud  "D-axis voltage of short-circuit";
  Real Uq "Q-axis voltage of short-circuit";
  LEPSE.Interfaces.Pin_v2 inp annotation (
    extent=[-10,38; 10,58],
    layer="icon",
    Placement(transformation(extent={{-10,88},{10,108}},rotation=0),
        iconTransformation(extent={{-10,88},{10,108}})));
initial equation
  // full short-circuit shunt conductivity
  Yn = sqrt( Bn^(2) + Gn^(2));
  // conversion from Siemens to p.u.
  Bn_sc = -Bn/Sbaz*Umon^(2);
  Gn_sc = -Gn/Sbaz*Umon^(2);

equation

  // short-circuit current
  id = if time >= TkzOn and time < TkzOn + dTkzOn then Bn_sc*Uq + Gn_sc*Ud else 0;
  iq = if time >= TkzOn and time < TkzOn + dTkzOn then -Bn_sc*Ud + Gn_sc*Uq else 0;

  //-----connector-----
  inp.Vd = Ud;
  inp.Vq = Uq;

  inp.Id = -id;
  inp.Iq = -iq;

  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.29,
      y=0.11,
      width=0.6,
      height=0.6),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        preserveOrientation=false,
        extent={{-60,-60},{60,100}},
        grid={2,2},
        initialScale=0),
      graphics={
        Line(
          points={{-20,-10},{20,-10}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{0,-10},{0,90}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{34,54},{6,24},{30,24},{0,-10}},
          color={255,0,0},
          thickness=1),
        Text(extent={{-56,-22},{58,-50}},
          textColor={0,0,0},
          textString="%name"),
        Line(
          points={{0,-10},{2,0}},
          color={255,0,0},
          thickness=1),
        Line(
          points={{0,-10},{10,-6}},
          color={255,0,0},
          thickness=1)},
      Line(points=[-20, -60; 20, -60], style(thickness=4)),
      Line(points=[0, -60; 0, 40], style(thickness=4)),
      Line(points=[34, 4; 6, -26; 30, -26; 0, -60], style(
          color=41,
          thickness=4,
          arrow=1)),
      Text(extent=[-54, -64; 60, -92], string="%name")),
    Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">Short-Circuit Shunt Model. </span></p>
<p><span style=\"background-color: #ffffff;\">Модель шунта короткого замыкания. </span></p>
</html>"),
    Diagram(coordinateSystem(extent={{-60,-60},{60,100}})));
end ShortCircuitShunt;
