within ;
package Basic
  model HVline
    parameter Real Rline=0.01 "Active resistance of Pi-model";
    parameter Real Xline=0.1 "Reactance of Pi-model";
    parameter Real Bline1=0 "Reactive conductivity of Pi-model beginning";
    parameter Real Bline2=0 "Reactive conductivity of Pi-model end";
    //---------------------------------------------
    parameter Real TLineOff=1000 "Time of line disconnection";
    parameter Real dTLineOff=10 "Duration of line disconnection";
    parameter Real Koff=2 "Degree of line disconnection";
    parameter Real TLineOff_1=2000 "Time of line second disconnection";
    parameter Real dTLineOff_1=20 "Duration of line second disconnection";
    parameter Real Koff_1=4 "Degree of line second disconnection";
    //---------------------------------------------
    Real U1d;
    Real U1q;
    Real U2d;
    Real U2q;
    Real I12d;
    Real I12q;
    Real I12m;
    Real U1m;
    Real U2m;
    flow Real I1d;
    flow Real I1q;
    flow Real I2d;
    flow Real I2q;
    Real Idc1;
    Real Iqc1;
    Real Idc2;
    Real Iqc2;
    Real DU1;
    Real DU2;
    Real P1;
    Real Q1;
    Real P2;
    Real Q2;
    Real RL;
    Real XL;
    Real BL1;
    Real BL2;
    Basic.Pin_v2 inp annotation (extent=[-86,40; -66,60], Placement(
          transformation(extent={{-86,40},{-66,60}}, rotation=0)));
    Basic.Pin_v2 out annotation (extent=[68,42; 88,62], Placement(
          transformation(extent={{68,42},{88,62}}, rotation=0)));
  equation
    // the algorithm of triping transmission line
    RL = if (time >= TLineOff and time < TLineOff + dTLineOff) then (Koff*Rline)
      else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Koff_1*Rline) else (Rline));
    XL = if (time >= TLineOff and time < TLineOff + dTLineOff) then (Koff*Xline)
      else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Koff_1*Xline) else (Xline));
    BL1 = if (time >= TLineOff and time < TLineOff + dTLineOff) then (Bline1/Koff)
      else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Bline1/Koff_1) else (Bline1));
    BL2 = if (time >= TLineOff and time < TLineOff + dTLineOff) then (Bline2/Koff)
      else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Bline2/Koff_1) else (Bline2));
    // series impedance between nodes
    U1q = U2q + RL*I12q - XL*I12d;
    U1d = U2d + RL*I12d + XL*I12q;
    // line capacitances
    Idc1 = U1q*BL1;
    Iqc1 = -U1d*BL1;
    Idc2 = U2q*BL2;
    Iqc2 = -U2d*BL2;
    // balance of current
    I1d = Idc1 + I12d;
    I1q = Iqc1 + I12q;
    I12d = Idc2 + I2d;
    I12q = Iqc2 + I2q;
    // measurements
    I12m = sqrt(I12d^2 + I12q^2);
    U1m = sqrt(U1d^2 + U1q^2);
    U2m = sqrt(U2d^2 + U2q^2);
    DU1 = atan2(U1d, U1q);
    DU2 = atan2(U2d, U2q);
    // powers
    P1 = U1q*I1q + U1d*I1d;
    Q1 = -U1q*I1d + U1d*I1q;
    P2 = U2q*I2q + U2d*I2d;
    Q2 = -U2q*I2d + U2d*I2q;
    //---connector1---
    inp.Vd = U1d;
    inp.Vq = U1q;
    inp.Id = -I1d;
    inp.Iq = -I1q;
    //connect(inp.Vd, U1d);
    //connect(inp.Vq, U1q);
    //connect(inp.Id, I1d);
    //connect(inp.Iq, I1q);
    ////---connector2---
    out.Vd = U2d;
    out.Vq = U2q;
    out.Id = I2d;
    out.Iq = I2q;
    //connect(out.Vd, U2d);
    //connect(out.Vq, U2q);
    //connect(out.Id, I2d);
    //connect(out.Iq, I2q);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.13,
        y=0.17,
        width=0.6,
        height=0.6),
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
          Rectangle(
            extent={{-30,60},{30,40}},
            lineColor={28,108,200},
            lineThickness=1.0),
          Rectangle(
            extent={{-60,20},{-40,-20}},
            lineColor={28,108,200},
            lineThickness=1.0),
          Rectangle(
            extent={{40,20},{60,-20}},
            lineColor={28,108,200},
            lineThickness=1.0),
          Line(
            points={{-50,-20},{-50,-40}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{-60,-40},{-40,-40}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{50,-20},{50,-40}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{40,-40},{60,-40}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{-50,20},{-50,50}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{-30,50},{-70,50}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{50,20},{50,52}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{70,52},{30,52}},
            color={28,108,200},
            thickness=1.0),
          Text(extent={{-64,-48},{64,-80}}, textString=
                                                "%name")},
        Rectangle(extent=[-30, 60; 30, 40], style(thickness=2)),
        Rectangle(extent=[-60, 20; -40, -20], style(thickness=2)),
        Rectangle(extent=[40, 20; 60, -20], style(thickness=2)),
        Line(points=[-50, -20; -50, -40], style(thickness=2)),
        Line(points=[-60, -40; -40, -40], style(thickness=2)),
        Line(points=[50, -20; 50, -40], style(thickness=2)),
        Line(points=[40, -40; 60, -40], style(thickness=2)),
        Line(points=[-50, 20; -50, 50], style(thickness=2)),
        Line(points=[-30, 50; -70, 50], style(thickness=2)),
        Line(points=[50, 20; 50, 52], style(thickness=2)),
        Line(points=[70, 52; 30, 52], style(thickness=2)),
        Text(extent=[-64, -48; 64, -80], string="%name")),
      Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">The simplest model of a high voltage power transmission line</span></p>
</html>"));
  end HVline;

  model Transformer
    parameter Real Rline=0.001 "Active resistance of T-model";
    parameter Real Xline=0.01 "Reactance of T-model";
    //---------------------------------------------
    parameter Real TtOff=1000 "Time of transformer disconnection";
    parameter Real dTtOff=10 "Duration of transformer disconnection";
    parameter Real Koff=100000 "Degree of transformer disconnection";
    //---------------------------------------------
    Real U1d;
    Real U1q;
    Real U2d;
    Real U2q;
    Real I12d;
    Real I12q;
    Real I12m;
    Real U1m;
    Real U2m;
    Real P1;
    Real Q1;
    Real P2;
    Real Q2;
    Real RL;
    Real XL;
    Basic.Pin_v2 inp annotation (
      extent=[-88,0; -68,20],
      layer="icon",
      Placement(transformation(extent={{-88,0},{-68,20}}, rotation=0)));
    Basic.Pin_v2 out annotation (
      extent=[70,0; 90,20],
      layer="icon",
      Placement(transformation(extent={{70,0},{90,20}}, rotation=0)));
  equation
    // the algorithm of triping transmission line
    RL = if time >= TtOff and time < TtOff + dTtOff then Koff*Rline else Rline;
    XL = if time >= TtOff and time < TtOff + dTtOff then Koff*Xline else Xline;
    // series impedance between nodes
    U1q = U2q + RL*I12q - XL*I12d;
    U1d = U2d + RL*I12d + XL*I12q;
    // measurements
    I12m = sqrt(I12d^2 + I12q^2);
    U1m = sqrt(U1d^2 + U1q^2);
    U2m = sqrt(U2d^2 + U2q^2);
    // powers
    P1 = U1q*I12q + U1d*I12d;
    Q1 = -U1q*I12d + U1d*I12q;
    P2 = U2q*I12q + U2d*I12d;
    Q2 = -U2q*I12d + U2d*I12q;
    //------connectors-----
    inp.Vd = U1d;
    inp.Vq = U1q;

    out.Vd = U2d;
    out.Vq = U2q;

    inp.Id = -I12d;
    inp.Iq = -I12q;

    out.Id = I12d;
    out.Iq = I12q;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.31,
        y=0.28,
        width=0.5,
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
            points={{0,60},{0,-40}},
            color={0,0,0},
            thickness=1.5),
          Rectangle(
            extent={{-50,70},{50,-50}},
            lineColor={0,0,255},
            lineThickness=1.0),
          Line(
            points={{-20,10},{-70,10}},
            color={0,0,0},
            thickness=1.5),
          Line(
            points={{72,10},{22,10}},
            color={0,0,0},
            thickness=1.0),
          Text(extent={{-64,-54},{66,-82}}, textString=
                                                "%name"),
          Line(
            points={{-20,34},{-8,38},{-4,46},{-8,54},{-20,58}},
            color={0,0,0},
            thickness=1.0),
          Line(
            points={{22,10},{10,14},{6,22},{10,30},{20,32}},
            color={0,0,0},
            thickness=1.0),
          Line(
            points={{22,32},{10,36},{6,44},{10,52},{22,56}},
            color={0,0,0},
            thickness=1.0),
          Line(
            points={{-20,10},{-8,14},{-4,22},{-8,30},{-20,34}},
            color={0,0,0},
            thickness=1.0),
          Line(
            points={{-20,-14},{-8,-10},{-4,-2},{-8,6},{-20,10}},
            color={0,0,0},
            thickness=1.0),
          Line(
            points={{-20,-38},{-8,-34},{-4,-26},{-8,-18},{-20,-14}},
            color={0,0,0},
            thickness=1.0),
          Line(
            points={{22,-12},{10,-8},{6,0},{10,8},{20,10}},
            color={0,0,0},
            thickness=1.0),
          Line(
            points={{22,-34},{10,-30},{6,-22},{10,-14},{20,-12}},
            color={0,0,0},
            thickness=1.0)},
        Line(points=[0, 60; 0, -40], style(color=0, thickness=4)),
        Rectangle(extent=[-50, 70; 50, -50], style(color=73, thickness=2)),
        Line(points=[-20, 10; -70, 10], style(color=0, thickness=2)),
        Line(points=[72, 10; 22, 10], style(color=0, thickness=2)),
        Text(extent=[-64, -54; 66, -82], string="%name"),
        Line(points=[-20, 34; -8, 38; -4, 46; -8, 54; -20, 58], style(color=0,
                thickness=2)),
        Line(points=[22, 10; 10, 14; 6, 22; 10, 30; 20, 32], style(color=0,
              thickness=2)),
        Line(points=[22, 32; 10, 36; 6, 44; 10, 52; 22, 56], style(color=0,
              thickness=2)),
        Line(points=[-20, 10; -8, 14; -4, 22; -8, 30; -20, 34], style(color=0,
                thickness=2)),
        Line(points=[-20, -14; -8, -10; -4, -2; -8, 6; -20, 10], style(color=0,
                thickness=2)),
        Line(points=[-20, -38; -8, -34; -4, -26; -8, -18; -20, -14], style(
              color=0, thickness=2)),
        Line(points=[22, -12; 10, -8; 6, 0; 10, 8; 20, 10], style(color=0,
              thickness=2)),
        Line(points=[22, -34; 10, -30; 6, -22; 10, -14; 20, -12], style(color=
                0, thickness=2))),
      Documentation(info="<html>
<p>The model of a two-winding transformer</p>
</html>"));
  end Transformer;

  model Constant_Conductivity_Load
    parameter Real Gn=0.7 "Active load";
    parameter Real Bn=-0.35 "Reactive load";
    //-------------------------------------------------------------
    parameter Real TloadOff=1000 "Time of load disconnection";
    parameter Real dTloadOff=10 "Duration of load disconnection";
    parameter Real Koff=0.7 "Degree of load disconnection";
    //-------------------------------------------------------------
    Real Udn;
    Real Uqn;
    Real Iqn;
    Real Idn;
    Real Pn;
    Real Qn;
    Basic.Pin_v2 inp annotation (
      extent=[-10,76; 10,96],
      layer="icon",
      Placement(transformation(extent={{-10,76},{10,96}}, rotation=0)));
  equation
    Pn = Uqn*Iqn + Udn*Idn;
    Qn = -Uqn*Idn + Udn*Iqn;
    Idn = if time >= TloadOff and time < TloadOff + dTloadOff then Koff*(Udn*
      Gn + Uqn*Bn) else Udn*Gn + Uqn*Bn;
    Iqn = if time >= TloadOff and time < TloadOff + dTloadOff then Koff*(Uqn*
      Gn - Udn*Bn) else Uqn*Gn - Udn*Bn;
    //-----connector-----
    inp.Vd = Udn;
    inp.Vq = Uqn;

    inp.Id = -Idn;
    inp.Iq = -Iqn;
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
          Rectangle(
            extent={{-20,60},{20,-40}},
            lineColor={28,108,200},
            lineThickness=1.0),
          Line(
            points={{0,-40},{0,-60}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{-20,-60},{20,-60}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{0,80},{0,60}},
            color={28,108,200},
            thickness=1.0),
          Text(extent={{-100,-64},{100,-100}}, textString=
                                                   "%name")},
        Rectangle(extent=[-20, 60; 20, -40], style(thickness=2)),
        Line(points=[0, -40; 0, -60], style(thickness=2)),
        Line(points=[-20, -60; 20, -60], style(thickness=2)),
        Line(points=[0, 80; 0, 60], style(thickness=2)),
        Text(extent=[-100, -64; 100, -100], string="%name")),
      Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">A load model defined as a constant conductivity</span></p>
</html>"));
  end Constant_Conductivity_Load;

  model ShortCircuitShunt
    parameter Real Bn=-100000 "Reactive conductivity of short sircuit";
    parameter Real Gn=-100000 "Active conductivity of short sircuit";
    parameter Real Yn = sqrt( Bn^(2) + Gn^(2)) "Total conductivity of short sircuit";
    //-----------------------------------
    parameter Real TkzOn=1000 "Time of short sircuit";
    parameter Real dTkzOn=0.12 "Duration of short sircuit";
    //-----------------------------------
    Real id;
    Real iq;
    Real Ud;
    Real Uq;
    Basic.Pin_v2 inp annotation (
      extent=[-10,38; 10,58],
      layer="icon",
      Placement(transformation(extent={{-10,38},{10,58}}, rotation=0)));
  equation
    id = if time >= TkzOn and time < TkzOn + dTkzOn then Bn*Uq + Gn*Ud else 0;
    iq = if time >= TkzOn and time < TkzOn + dTkzOn then -Bn*Ud + Gn*Uq else 0;
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
          extent={{-100,-100},{100,100}},
          grid={2,2},
          initialScale=0),
        graphics={
          Line(
            points={{-20,-60},{20,-60}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{0,-60},{0,40}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{34,4},{6,-26},{30,-26},{0,-60}},
            color={255,0,0},
            thickness=1,
            arrow={Arrow.None,Arrow.Filled}),
          Text(extent={{-54,-64},{60,-92}}, textString=
                                                "%name")},
        Line(points=[-20, -60; 20, -60], style(thickness=4)),
        Line(points=[0, -60; 0, 40], style(thickness=4)),
        Line(points=[34, 4; 6, -26; 30, -26; 0, -60], style(
            color=41,
            thickness=4,
            arrow=1)),
        Text(extent=[-54, -64; 60, -92], string="%name")),
      Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">Short Circuit Shunt Model</span></p>
</html>"));
  end ShortCircuitShunt;

  model Electrical_Braking_Parallel
    parameter Real Rline=0.2 "Active resistance of electrical breaking device";
    //---------------------------------------------
    parameter Real TLineOff=1000 "Time of electrical breaking";
    parameter Real dTLineOff=10 "Duration of electrical breaking";
    //---------------------------------------------
    Real Ud;
    Real Uq;
    Real I12d;
    Real I12q;
    Real I12m;
    Real Um;
    Basic.Pin_v2 inp annotation (
      extent=[-10,78; 10,98],
      layer="icon",
      Placement(transformation(extent={{-10,78},{10,98}}, rotation=0)));
  equation
    //--------------------------------------------------------------------------
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
            extent={{-20,40},{20,-40}},
            lineColor={28,108,200},
            lineThickness=1.0,
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-20,-60},{20,-60}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{0,-60},{0,-40}},
            color={28,108,200},
            thickness=1.0),
          Rectangle(
            extent={{-10,70},{10,50}},
            lineColor={28,108,200},
            lineThickness=1.0,
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(
            points={{0,40},{0,50}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{0,70},{0,80}},
            color={28,108,200},
            thickness=1.0),
          Text(extent={{-100,-62},{100,-100}}, textString=
                                                   "%name")},
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
  end Electrical_Braking_Parallel;

  model Electrical_Braking
    parameter Real Rline=0.2 "Active resistance of electrical breaking device";
    //---------------------------------------------
    parameter Real TLineOff=1000 "Time of electrical breaking";
    parameter Real dTLineOff=10 "Duration of electrical breaking";
    //---------------------------------------------
    Real U1d;
    Real U1q;
    Real U2d;
    Real U2q;
    Real I12d;
    Real I12q;
    Real I12m;
    Real U1m;
    Real U2m;
    Real RL;
    Basic.Pin_v2 inp annotation (extent=[-98,0; -78,20], Placement(
          transformation(extent={{-98,0},{-78,20}}, rotation=0)));
    Basic.Pin_v2 out annotation (extent=[78,0; 98,20], Placement(transformation(
            extent={{78,0},{98,20}}, rotation=0)));
  equation
    //---------the algorithm of triping transmission line--------
    RL = if time >= TLineOff and time < TLineOff + dTLineOff then Rline else 0;
    //---------series impedance between nodes--------------------
    U1q = U2q + RL*I12q;
    U1d = U2d + RL*I12d;
    //---------measurements--------------------------------------
    I12m = sqrt(I12d^2 + I12q^2);
    U1m = sqrt(U1d^2 + U1q^2);
    U2m = sqrt(U2d^2 + U2q^2);
    //-----connectors------
    inp.Vd = U1d;
    inp.Vq = U1q;

    out.Vd = U2d;
    out.Vq = U2q;

    inp.Id = -I12d;
    inp.Iq = -I12q;

    out.Id = I12d;
    out.Iq = I12q;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.28,
        y=0.09,
        width=0.6,
        height=0.6),
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
          Rectangle(
            extent={{-40,20},{40,0}},
            lineColor={28,108,200},
            lineThickness=1.0,
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-40,10},{-80,10}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{80,10},{40,10}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{-60,10},{-60,40},{-20,40}},
            color={28,108,200},
            thickness=1.0),
          Line(
            points={{20,40},{60,40},{60,10}},
            color={28,108,200},
            thickness=1.0),
          Rectangle(
            extent={{-20,48},{20,46}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{22,38},{18,42}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-18,38},{-22,42}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Text(extent={{-100,-8},{100,-48}}, textString=
                                                 "%name")},
        Rectangle(extent=[-40, 20; 40, 0], style(thickness=2, fillColor=8)),
        Line(points=[-40, 10; -80, 10], style(thickness=2)),
        Line(points=[80, 10; 40, 10], style(thickness=2)),
        Line(points=[-60, 10; -60, 40; -20, 40], style(thickness=2)),
        Line(points=[20, 40; 60, 40; 60, 10], style(thickness=2)),
        Rectangle(extent=[-20, 48; 20, 46], style(fillColor=0)),
        Ellipse(extent=[22, 38; 18, 42], style(fillColor=0)),
        Ellipse(extent=[-18, 38; -22, 42], style(fillColor=0)),
        Text(extent=[-100, -8; 100, -48], string="%name")),
      Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">Model of series electric braking device</span></p>
</html>"));
  end Electrical_Braking;

  connector Pin_v2
    Real Vd "Potential Vd";
    Real Vq "Potential Vq";
    flow Real Id "Current Id";
    flow Real Iq "Current Iq";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.26,
        y=0.25,
        width=0.6,
        height=0.6),
      Icon(
        coordinateSystem(
          preserveAspectRatio=false,
          preserveOrientation=false,
          extent={{-100,-100},{100,100}},
          grid={2,2},
          initialScale=0),
        graphics={Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)},
           Rectangle(extent=[-80, 80; 80, -80], style(fillColor=0))),
      Documentation(info="<html>
<p>The model of the basic connector for power signals</p>
</html>"));
  end Pin_v2;

  model Transfer_Function
    parameter Real b[:]={1} "Numerator coefficients of transfer function.";
    parameter Real a[:]={1,1} "Denominator coefficients of transfer function.";
    output Real x[size(a, 1) - 1]
      "State of transfer function from controller canonical form";
  protected
    parameter Integer na=size(a, 1)
      "Size of Denominator of transfer function.";
    parameter Integer nb(max=na) = size(b, 1)
      "Size of Numerator of transfer function.";
    parameter Integer nx=size(a, 1) - 1;
    Real x1dot "Derivative of first state of TransferFcn";
    Real xn "Highest order state of TransferFcn";
    Real u;
    Real y;
  public
    Basic.Single_Pin inp annotation (
      extent=[-92,-10; -72,10],
      layer="icon",
      Placement(transformation(extent={{-92,-10},{-72,10}}, rotation=0)));
    Basic.Single_Pin out annotation (
      extent=[70,-10; 90,10],
      layer="icon",
      Placement(transformation(extent={{70,-10},{90,10}}, rotation=0)));
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
            lineColor={0,0,0},
            lineThickness=0.5),
          Text(extent={{-40,28},{40,2}}, textString=
                                             "Transfer"),
          Text(extent={{-38,4},{42,-22}}, textString=
                                              "function"),
          Text(extent={{-100,-28},{100,-52}},
                                            textString=
                                                "%name"),
          Line(
            points={{-60,0},{-74,0}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{74,0},{58,0}},
            color={0,0,0},
            thickness=0.5)},
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

  model Gen_with_ARV_control

    Basic.Pin_v2 inp annotation (
      extent=[78,-4; 98,16],
      layer="icon",
      Placement(transformation(extent={{78,-4},{98,16}}, rotation=0)));
    Basic.Excitation_Regulator AVR annotation (extent=[-84,-90; -32,82],
        Placement(transformation(extent={{-84,-90},{-32,82}}, rotation=0)));
    Basic.Synch_Machine G annotation (extent=[-28,-72; 70,80], Placement(
          transformation(extent={{-28,-72},{70,80}}, rotation=0)));
  equation
    connect(AVR.out_pin, G.Ef_pin) annotation (points=[-34.34, 6.32; -18.2,
          5.52], Line(points={{-34.3833,6.32},{-18.2,5.52}}));
    connect(AVR.dV1_pin, AVR.dV_pin) annotation (points=[-81.66, 30.4; -
          81.66, 56.2], Line(points={{-82.05,30.4},{-82.05,38},{-82,38},{-82,44},
            {-82.4833,44},{-82.4833,47.6}}));
    connect(G.dUtr_pin, AVR.dV_pin) annotation (points=[-3.5, 61.76; -4, 76;
            -82, 76; -81.66, 56.2], Line(points={{-6.44,61.76},{-6.44,76},{
            -82.4833,76},{-82.4833,47.6}}));
    connect(G.dWu_pin, AVR.dfsys_pin) annotation (points=[13.16, 61.76; 14,
          80; -86, 80; -86, 4; -81.66, 4.6], Line(points={{5.32,61.76},{5.32,80},
            {-86,80},{-86,4.6},{-82.05,4.6}}));
    connect(G.dWf_pin, AVR.dfU_pin) annotation (points=[28.84, 61.76; 28, 84;
            -88, 84; -88, -22; -81.66, -21.2], Line(points={{17.08,61.76},{
            17.08,84},{-88,84},{-88,-21.2},{-82.05,-21.2}}));
    connect(G.dIf_pin, AVR.dif1_pin) annotation (points=[45.5, 61.76; 44, 90;
            -94, 90; -94, -46; -81.66, -47], Line(points={{29.82,61.76},{
            29.82,90},{-94,90},{-94,-41.84},{-82.05,-41.84}}));
    connect(G.Stator_pin, inp) annotation (points=[59.22, 5.52; 88, 6], Line(
          points={{59.22,5.52},{88,6}}));
    //equation
    //connect(G.dUtr, AVR.u_u);
    //connect(G.dUtr, AVR.u_pu);
    //connect(G.dWu, AVR.u_fsys);
    //connect(G.dWf, AVR.u_fu);
    //connect(G.dIf, AVR.u_pIf);
    //connect(AVR.y_er, G.dEr);
    //---connector---
    //-----------------------------------------------------------
    //inp.Vd = G.UdG;
    //inp.Vq = G.UqG;
    //inp.Id = G.IdG;
    //inp.Iq = G.IqG;
    connect(G.Ut_pin, AVR.Ut_pin) annotation (Line(points={{41.58,61.76},{41.58,
            92},{-96,92},{-96,-59.04},{-81.8333,-59.04}},
                                                        color={0,0,0}));
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
          Ellipse(extent={{-74,72},{72,-58}}),
          Text(extent={{-44,54},{46,20}}, textString=
                                              "Gen."),
          Text(extent={{-50,22},{50,-4}}, textString=
                                              "with ARV"),
          Text(extent={{-78,-58},{74,-84}}, textString=
                                                "%name"),
          Line(points={{80,6},{72,6}}),
          Text(extent={{-50,-4},{50,-30}}, textString=
                                               "control")},
        Ellipse(extent=[-74, 72; 72, -58]),
        Text(extent=[-44, 54; 46, 20], string="Gen."),
        Text(extent=[-50, 22; 50, -4], string="with ARV"),
        Text(extent=[-78, -58; 74, -84], string="%name"),
        Line(points=[80, 6; 72, 6]),
        Text(extent=[-50, -4; 50, -30], string="control")),
      Window(
        x=0.28,
        y=0.01,
        width=0.6,
        height=0.88),
      Documentation(info="<html>
<p>Generator model with automatic excitation control</p>
</html>"));
  end Gen_with_ARV_control;

  model Excitation_Regulator
    parameter Real K0u=-10 "Voltage deviation control coefficient";
    parameter Real K1u=0 "Voltage derivative control coefficient";
    parameter Real K0w=0 "Frequency deviation control coefficient";
    parameter Real K1w=0 "Frequency derivative control coefficient";
    parameter Real K1if=0 "Rotor current derivative control coefficient";
    parameter Real Uforc=0.85 "voltage of field forcing input";
    parameter Real Udeforc=0.9 "voltage of field forcing removing";
    parameter Real Tforcedelay=0.1 "delay of field forcing removing";
    parameter Real DL0=0;
    constant Real Tokp=0.05 "the main channel of regulation time constant";
    constant Real T0u=0.02 "voltage deviation time constant";
    constant Real T1u=0.039 "voltage derivative time constant";
    constant Real Tfb=0.07 "frequency block time constant";
    constant Real T0w=1.0 "frequency deviation time constant";
    constant Real T1w=0.026 "frequency derivative time constant";
    constant Real T1if=0.03 "field current derivative time constant";
    //Real u_u;
    //Real u_pu;
    //Real u_fsys;
    //Real u_fu;
    //Real u_pIf;
    //Real y_er;
    //Real f_sum;
    Basic.Transfer_Function VoltageDeviation(b={K0u}, a={T0u,1}) annotation (
        extent=[-74,57.3333; -27.3333,104], Placement(transformation(extent={{-86,
              37.3333},{-39.3333,84}}, rotation=0)));
    Basic.Transfer_Function VoltageDerivative(b={K1u,0}, a={T1u,1}) annotation
      (extent=[-73.3333,17.3333; -26.6667,64], Placement(transformation(extent=
              {{-85.3333,15.3333},{-38.6667,62}}, rotation=0)));
    Basic.Transfer_Function FrequencyBlockD(b={1}, a={Tfb,1}) annotation (
        extent=[-82.6667,-22.6667; -48,24], Placement(transformation(extent={{-86.6667,
              -12.6667},{-52,34}}, rotation=0)));
    Basic.Transfer_Function FrequencyBlockU(b={1,0}, a={Tfb,1}) annotation (
        extent=[-82,-63.3333; -48,-16], Placement(transformation(extent={{-86,-43.3333},
              {-52,4}}, rotation=0)));
    Basic.Transfer_Function FrequencyDeviation(b={K0w,0}, a={T0w,1})
      annotation (extent=[-28,-46; 10,2], Placement(transformation(extent={{-32,
              -44},{6,4}}, rotation=0)));
    Basic.Transfer_Function FrequencyDerivative(b={K1w,0}, a={T1w,1})
      annotation (extent=[-24.6667,-19.3333; 10,28], Placement(transformation(
            extent={{-30.6667,-5.3333},{4,42}}, rotation=0)));
    Basic.Transfer_Function ExcitationCurrent(b={K1if,0}, a={T1if,1})
      annotation (extent=[-74,-102; -27.3333,-55.3333], Placement(
          transformation(extent={{-86,-68},{-39.3333,-21.3333}}, rotation=0)));
    Basic.Transfer_Function SimpleExciter(b={1}, a={Tokp,1}) annotation (extent
        =[56,-24; 83.3333,22.6667], Placement(transformation(extent={{90,6},{
              117.333,52.6667}}, rotation=0)));
    Basic.Single_Pin dV_pin annotation (
      extent=[-96,64; -86,76],
      layer="icon",
      Placement(transformation(extent={{-98,54},{-88,66}}, rotation=0)));
    Basic.Single_Pin dV1_pin annotation (
      extent=[-96,34; -86,46],
      layer="icon",
      Placement(transformation(extent={{-96,34},{-86,46}}, rotation=0)));
    Basic.Single_Pin dfsys_pin annotation (
      extent=[-96,4; -86,16],
      layer="icon",
      Placement(transformation(extent={{-96,4},{-86,16}}, rotation=0)));
    Basic.Single_Pin dfU_pin annotation (
      extent=[-96,-26; -86,-14],
      layer="icon",
      Placement(transformation(extent={{-96,-26},{-86,-14}}, rotation=0)));
    Basic.Single_Pin dif1_pin annotation (
      extent=[-96,-56; -86,-44],
      layer="icon",
      Placement(transformation(extent={{-96,-50},{-86,-38}}, rotation=0)));
    Basic.Single_Pin out_pin annotation (
      extent=[86,2; 96,22],
      layer="icon",
      Placement(transformation(extent={{124,2},{134,22}}, rotation=0)));
    Basic.Summator Summator1 annotation (extent=[-44,-32; -30,-12], Placement(
          transformation(extent={{-50,-4},{-36,16}}, rotation=0)));
    Basic.Summator Summator2 annotation (extent=[12,-18; 26,2], Placement(
          transformation(extent={{10,-26},{24,-6}}, rotation=0)));
    Basic.Summator Summator3 annotation (extent=[8,48; 22,68], Placement(
          transformation(extent={{-12,32},{2,52}}, rotation=0)));
    Basic.Summator Summator5 annotation (extent=[26,18; 40,38], Placement(
          transformation(extent={{12,18},{26,38}}, rotation=0)));
    Basic.Summator Summator6 annotation (extent=[40,-10; 54,10], Placement(
          transformation(extent={{30,14},{44,34}}, rotation=0)));
    Basic.Single_Pin Ut_pin annotation (Placement(transformation(extent={{-96,-70},
              {-84,-58}}), iconTransformation(extent={{-96,-70},{-84,-58}})));
    Basic.logical_switch logical_switch1(
      a1=Uforc,
      a2=Udeforc,
      a3=K0u,
      a4=Tforcedelay)
      annotation (Placement(transformation(extent={{60,18},{80,38}})));
  equation
    connect(dfsys_pin, FrequencyBlockD.inp) annotation (points=[-91, 10; -
          79.5467, 0.666667], Line(points={{-91,10},{-83.5467,10.6666}}));
    connect(dfU_pin, FrequencyBlockU.inp) annotation (points=[-91, -20; -
          78.94, -39.6667], Line(points={{-91,-20},{-90,-19.6667},{-82.94,
            -19.6667}}));
    connect(FrequencyBlockD.out, Summator1.inp1) annotation (points=[-
          51.4667, 0.666667; -42.88, -18], Line(points={{-55.4667,10.6666},{
            -55.4667,10},{-48.88,10}}));
    connect(FrequencyBlockU.out, Summator1.inp2) annotation (points=[-51.4,
          -39.6667; -42.88, -26], Line(points={{-55.4,-19.6667},{-48.88,
            -19.6667},{-48.88,2}}));
    connect(dif1_pin, ExcitationCurrent.inp) annotation (points=[-91, -50; -
          69.8, -78.6667], Line(points={{-91,-44},{-91,-44.6667},{-81.8,
            -44.6667}}));
    connect(Summator1.out, FrequencyDeviation.inp) annotation (points=[-
          31.12, -22; -24.58, -22], Line(points={{-37.12,6},{-32,6},{-32,-20},{
            -28.58,-20}}));
    connect(FrequencyDerivative.inp, FrequencyDeviation.inp) annotation (
        points=[-21.5467, 4.33333; -24.58, -22], Line(points={{-27.5467,18.3333},
            {-27.5467,18},{-32,18},{-32,-20},{-28.58,-20}}));
    connect(Summator2.inp2, FrequencyDeviation.out) annotation (points=[
          13.12, -12; 6.2, -22], Line(points={{11.12,-20},{2.2,-20}}));
    connect(FrequencyDerivative.out, Summator2.inp1) annotation (points=[
          6.53333, 4.33333; 13.12, -4], Line(points={{0.53333,18.3333},{6,
            18.3333},{6,-12},{11.12,-12}}));
    connect(VoltageDerivative.inp, dV1_pin) annotation (points=[-69.1333,
          40.6667; -91, 40], Line(points={{-81.1333,38.6666},{-81.1333,40},{-91,
            40}}));
    connect(VoltageDeviation.inp, dV_pin) annotation (points=[-69.8, 80.6667;
            -91, 70], Line(points={{-81.8,60.6667},{-81.8,60},{-93,60}}));
    connect(VoltageDeviation.out, Summator3.inp1) annotation (points=[-32,
          80.6667; 9.12, 62], Line(points={{-44,60.6667},{-18,60.6667},{-18,46},
            {-10.88,46}}));
    connect(VoltageDerivative.out, Summator3.inp2) annotation (points=[-
          31.3333, 40.6667; 9.12, 54], Line(points={{-43.3334,38.6666},{
            -43.3334,38},{-10.88,38}}));
    connect(Summator5.inp1, Summator3.out) annotation (points=[27.12, 32;
          20.88, 58], Line(points={{13.12,32},{6,32},{6,42},{0.88,42}}));
    connect(Summator5.inp2, Summator2.out) annotation (points=[27.12, 24;
          24.88, -8], Line(points={{13.12,24},{10,24},{10,-4},{26,-4},{26,-16},
            {22.88,-16}}));
    connect(Summator6.inp1, Summator5.out) annotation (points=[41.12, 4;
          38.88, 28], Line(points={{31.12,28},{24.88,28}}));
    connect(SimpleExciter.out, out_pin) annotation (points=[80.6, -0.666667;
            91, 12], Line(points={{114.6,29.3333},{129,29.3333},{129,12}}));
    connect(Summator6.inp2, ExcitationCurrent.out) annotation (points=[41.12,
            -4; -32, -78.6667], Line(points={{31.12,20},{31.12,-44.6667},{-44,
            -44.6667}}));
    when initial() then
      reinit(FrequencyBlockU.x[1], DL0);
      //     reinit(FrequencyDeviation.x[1],DL0);
      //     reinit(FrequencyDerivative.x[1],DL0);
    end when;
    //u_u = VoltageDeviation.u;
    //u_pu = VoltageDerivative.u;
    //u_fsys = FrequencyBlockD.u;
    //u_fu = FrequencyBlockU.u;
    //u_pIf = ExcitationCurrent.u;
    //f_sum = FrequencyBlockD.y + FrequencyBlockU.y;
    //-------  connect(FrequencyBlock.y, FrequencyDeviation.u);
    //-------  connect(FrequencyBlock.y, FrequencyDerivative.u);
    //FrequencyDeviation.u = f_sum;
    //FrequencyDerivative.u = f_sum;
    //VoltageDeviation.y + VoltageDerivative.y + ExcitationCurrent.y +
    //FrequencyDeviation.y + FrequencyDerivative.y = SimpleExciter.u;
    //y_er = SimpleExciter.y;
    connect(logical_switch1.out, SimpleExciter.inp) annotation (Line(points={{78.4,28},
            {86,28},{86,29.3333},{92.46,29.3333}},                    color={0,
            0,0}));
    connect(Ut_pin, logical_switch1.inp2inf) annotation (Line(points={{-90,-64},
            {56,-64},{56,19.1667},{70,19.1667}}, color={0,0,0}));
    connect(Summator6.out, logical_switch1.inp2) annotation (Line(points={{42.88,
            24},{52,24},{52,25.6667},{61.4,25.6667}},       color={0,0,0}));
    connect(VoltageDeviation.out, logical_switch1.inp1) annotation (Line(points={{-44,
            60.6667},{-6,60.6667},{-6,60},{54,60},{54,31.3333},{61.4,31.3333}},
                       color={0,0,0}));
    connect(VoltageDeviation.inp, logical_switch1.inp1inf) annotation (Line(
          points={{-81.8,60.6667},{-81.8,74},{70,74},{70,56},{69.9,56},{69.9,
            36.1667}},                                                  color={
            0,0,0}));
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.32,
        y=0.06,
        width=0.6,
        height=0.82),
      Icon(
        coordinateSystem(
          preserveAspectRatio=false,
          preserveOrientation=false,
          extent={{-100,-100},{140,100}},
          grid={2,2},
          initialScale=0),
        graphics={
          Rectangle(
            extent={{-68,92},{104,-74}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Text(extent={{-22,58},{60,-20}}, textString=
                                               "Excitation"),
          Text(extent={{-14,34},{56,-32}}, textString=
                                               "regulator"),
          Line(
            points={{-68,10},{-88,10}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-68,-20},{-88,-20}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-68,-50},{-88,-50}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-68,40},{-88,40}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-68,70},{-88,70}},
            color={28,108,200},
            thickness=0.5),
          Text(extent={{-58,-70},{102,-102}},
                                            textString=
                                                "%name"),
          Line(
            points={{128,12},{104,12}},
            color={28,108,200},
            thickness=0.5)},
        Rectangle(extent=[-68, 80; 66, -60], style(thickness=2)),
        Text(extent=[-42, 60; 40, -18], string="Excitation"),
        Text(extent=[-36, 34; 34, -32], string="regulator"),
        Line(points=[-68, 10; -88, 10], style(thickness=2)),
        Line(points=[-68, -20; -88, -20], style(thickness=2)),
        Line(points=[-68, -50; -88, -50], style(thickness=2)),
        Line(points=[-68, 40; -88, 40], style(thickness=2)),
        Line(points=[-68, 70; -88, 70], style(thickness=2)),
        Text(extent=[-84, -62; 76, -94], string="%name"),
        Line(points=[86, 12; 66, 12], style(thickness=2))),
      Diagram(coordinateSystem(extent={{-100,-100},{140,100}}), graphics={
          Text(
            extent={{-36,70},{-26,60}},
            textColor={0,0,0},
            textString="ΔU"),
          Text(
            extent={{-38,50},{-26,38}},
            textColor={0,0,0},
            textString="ΔU'"),
          Text(
            extent={{6,-26},{18,-36}},
            textColor={0,0,0},
            textString="ΔF"),
          Text(
            extent={{-12,8},{0,-2}},
            textColor={0,0,0},
            textString="ΔF'"),
          Text(
            extent={{-42,-32},{-30,-42}},
            textColor={0,0,0},
            textString="ΔIf'")}),
      Documentation(info="<html>
<p>The classical model of the Automatic Voltage Regulator (AVR)</p>
</html>"));
  end Excitation_Regulator;

  model Synch_Machine
    parameter Real TgenOff=1000 "Time of generator's disconnection";
    parameter Real dTgenOff=10 "Duration of generator's disconnection";

    //------------------------------------------------------------------------------------
    parameter Real Pg=0.85 "Active power";
    parameter Real Qg=0.527 "Reactive power";
    parameter Real Ut=1 "ARV voltage reference value";

    //------------------------------------------------------------------------------------
    parameter Real Xd_p=1.869 "d-axis synchronous reactance";
    parameter Real Xq_p=1.869 "q-axis synchronous reactance";
    parameter Real Xs_p=0.194 "leakage reactance";
    parameter Real X1d_p=0.3016 "d-axis transient reactance";
    parameter Real X2d_p=0.2337 "d-axis subtransient reactance";
    parameter Real X2q_p=0.2337 "q-axis subtransient reactance";
    parameter Real Rf_p=904e-6 "active resistance of field winding";
    parameter Real R1d_p=3.688e-3 "active resistance of d-axis damper winding";
    parameter Real R1q_p=2.77e-3 "active resistance of q-axis damper winding";
    parameter Real Tj_p=7 "inertia coefficient Tj";

    parameter Real Sigma=0.0475 "turbine statism coefficient";
    parameter Real TauC_up=0.8 "time constant of servo motor";
    parameter Real TregOff=50 "turbine speed regulator off-time";

    parameter Real TregOn=1000 "turbine speed regulator on-time";
    parameter Real Mtmax=1.1 "turbine overloading coefficient";
    parameter Real Mtmin=0 "turbine minimum-loading coefficient";

    parameter Real Aimp=1 "fast turbine valving control amplitude";
    parameter Real Timp=1000 "fast turbine valving control on-time";
    parameter Real dTimp=0.2 "fast turbine valving control duration";
    parameter Real TauC_down=5 "time constant of servo";

    parameter Real TkzOn=1000 "HPP generators dropping on-time";
    parameter Real Pg_new=0.85 "new power of HPP";
    parameter Real Kemax=2.0 "multiplicity of forcing on";
    parameter Real Kemin=-0.6 "multiplicity of forcing off";

    //------------------------------------------------------------------------------------
    Real dUtr;
    Real dWu;
    Real dIf;
    Real dEr;
    Real dWf;
    constant Real PI=4*atan(1);
    constant Real Wc=100*PI;
    constant Real Xt=0;
    // Parameters of power system elements
    constant Real Ra=0;
    constant Real Rt=0;
    Real EQ;
    Real Dg;
    Real Uq;
    Real Ud;
    Real Id;
    Real Iq;
    Real Mt;
    Real Eiq;
    Real Ir;
    Real Uf;
    Real Eq;
    Real Er0;
    Real PsiR;
    Real PsiRD;
    Real PsiRQ;
    Real Er_max;
    Real Er_min;
    Real Uf_full;
    // Uc, Dl, Ug, Dt, Pt, Qt, , X2ds, X2qs, Udgen, Uqgen, Ugen0,
    Real Xad;
    Real Xaq;
    Real X2dt;
    Real X2qt;
    Real Rs;
    Real Xsf;
    Real Xs1d;
    Real Xs1q;
    Real X1;
    Real X2;
    Real X3;
    Real Ugen;
    // Ut, Pg, Qg,
    Real Mu0;
    Real Ro;
    Real Mu;
    Real Mt_pp;
    Real Pgen;
    Real Qgen;
    Real UdG;
    Real UqG;
    Real IdG;
    Real IqG;
    Real DeltaIJ;
    Real Ssys;
    //------------------------------------------------------------------
    // Integrated Variables
    Real Yr;
    Real Yrd;
    Real Yrq;
    Real s;
    Real DGi;
    Real Me;
    Real Yad;
    Real Yaq;
    Real iq;
    Real id;
    Real ir;
    Real ird;
    Real irq;
    Real ud;
    Real uq;
    Real E11d;
    Real E11q;
    Real TauC;
    Real MT_MAX;
    Real MT_MIN;
    Real Xd;
    Real Xq;
    Real Xs;
    Real X1d;
    Real X2d;
    Real X2q;
    Real Rf;
    Real R1d;
    Real R1q;
    Real Tj;
    Real f;
    Basic.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12], Placement(
          transformation(extent={{68,-8},{88,12}}, rotation=0)));
    Basic.Single_Pin Ef_pin annotation (extent=[-90,-8; -70,12], Placement(
          transformation(extent={{-90,-8},{-70,12}}, rotation=0)));
    Basic.Single_Pin dUtr_pin annotation (
      extent=[-60,66; -40,86],
      layer="icon",
      Placement(transformation(extent={{-66,66},{-46,86}}, rotation=0)));
    Basic.Single_Pin dWu_pin annotation (
      extent=[-26,66; -6,86],
      layer="icon",
      Placement(transformation(extent={{-42,66},{-22,86}}, rotation=0)));
    Basic.Single_Pin dWf_pin annotation (
      extent=[6,66; 26,86],
      layer="icon",
      Placement(transformation(extent={{-18,66},{2,86}}, rotation=0)));
    Basic.Single_Pin dIf_pin annotation (
      extent=[40,66; 60,86],
      layer="icon",
      Placement(transformation(extent={{8,66},{28,86}}, rotation=0)));
    Basic.Single_Pin Ut_pin
      annotation (Placement(transformation(extent={{32,66},{52,86}})));
  equation

    //------------------------------------------------------------------------------------
    // Parameters of power system elements
    // Uc, Dl, Ug, Dt, Pt, Qt, , X2ds, X2qs, Udgen, Uqgen, Ugen0,
    // Ut, Pg, Qg,
    //------------------------------------------------------------------
    // Integrated Variables
    //------------------------------------------------------------------------------------
    // Parameters of power system elements
    // Uc, Dl, Ug, Dt, Pt, Qt, , X2ds, X2qs, Udgen, Uqgen, Ugen0,
    // Ut, Pg, Qg,
    //------------------------------------------------------------------
    // Integrated Variables
    //------------------------------------------------------------------------------------
    // Parameters of power system elements
    // Uc, Dl, Ug, Dt, Pt, Qt, , X2ds, X2qs, Udgen, Uqgen, Ugen0,
    // Ut, Pg, Qg,
    //------------------------------------------------------------------
    // Integrated Variables
    //------------------------------------------------------------------------------------
    // Parameters of power system elements
    // Uc, Dl, Ug, Dt, Pt, Qt, , X2ds, X2qs, Udgen, Uqgen, Ugen0,
    // Ut, Pg, Qg,
    //------------------------------------------------------------------
    // Integrated Variables
    //------------------------------------------------------------------------------------
    //------------------------------------------------------------------------------------
    // Parameters of power system elements
    // Uc, Dl, Ug, Dt, Pt, Qt, , X2ds, X2qs, Udgen, Uqgen, Ugen0,
    // Ut, Pg, Qg,
    //------------------------------------------------------------------
    // Integrated Variables
    //------------------------------------------------------------------------------------
    //------------------------------------------------------------------------------------
    // Parameters of power system elements
    // Uc, Dl, Ug, Dt, Pt, Qt, , X2ds, X2qs, Udgen, Uqgen, Ugen0,
    // Ut, Pg, Qg,
    //------------------------------------------------------------------
    // Integrated Variables
    //------------------------------------------------------------------------------------
    //------------------------------------------------------------------------------------
    // Parameters of power system elements
    // Uc, Dl, Ug, Dt, Pt, Qt, , X2ds, X2qs, Udgen, Uqgen, Ugen0,
    // Ut, Pg, Qg,
    //------------------------------------------------------------------
    // Integrated Variables
    when initial() then

      EQ = sqrt((Ut + ((Ra + Rt)*Pg + (Xq + Xt)*Qg)/Ut)^2 + (((Xq + Xt)*Pg - (
        Ra + Rt)*Qg)/Ut)^2);
      Dg = atan((((Xq + Xt)*Pg - (Ra + Rt)*Qg)/Ut)/(Ut + ((Ra + Rt)*Pg + (Xq
         + Xt)*Qg)/Ut));
      //----------------------
      Uq = Ut*cos(Dg);
      Ud = -Ut*sin(Dg);
      //----------------------
      Id = ((Uq - EQ)*(Xq + Xt) - (Ra + Rt)*Ud)/((Ra + Rt)^2 + (Xq + Xt)^2);
      Iq = (-Ud - (Ra + Rt)*Id)/(Xq + Xt);
      Mt = EQ*Iq;
      Mu0 = Mt;
      Eiq = Uq - Id*(Xs + Xt) + (Ra + Rt)*Iq;
      Ir = -Id + Eiq/Xad;
      Uf = Ir*Rf;
      Eq = Ir*Xad;
      Er0 = Eq;
      PsiR = Eiq + Xsf*Ir;
      PsiRQ = -Ud - Iq*(Xs + Xt) - Id*(Ra + Rt);
      PsiRD = Eiq;
      Er_max = Kemax*Er0;
      Er_min = Kemin*Er0;
      //-------Initialization State Variables------------------
      reinit(DGi, Dg);
      reinit(s, 0);
      reinit(Yr, PsiR);
      reinit(Yrd, PsiRD);
      reinit(Yrq, PsiRQ);
      reinit(Mu, Mu0);
    end when;
    //-------------Calculated parameters of system----------------
    Xad = Xd - Xs;
    Xaq = Xq - Xs;
    X2dt = X2d + Xt;
    X2qt = X2q + Xt;
    Rs = Ra + Rt;
    Xsf = 1/(1/(X1d - Xs) - 1/Xad);
    Xs1d = 1/(1/(X2d - Xs) - 1/Xad - 1/Xsf);
    Xs1q = 1/(1/(X2q - Xs) - 1/Xaq);
    X1 = (X2d - Xs)/Xsf;
    X2 = (X2d - Xs)/Xs1d;
    X3 = (X2q - Xs)/Xs1q;
    //--------------------------------------------------------------------------------
    //  Kzag1 = abs((Mt_min1+Mt_max1)/2);
    //  Kzag2 = abs((Mt_min2+Mt_max2)/2);
    Tj = if time < TkzOn then Tj_p else Tj_p*Pg_new/Pg;

    Xd = if time < TkzOn then Xd_p else Xd_p*Pg/Pg_new;
    Xq = if time < TkzOn then Xq_p else Xq_p*Pg/Pg_new;
    Xs = if time < TkzOn then Xs_p else Xs_p*Pg/Pg_new;
    X1d = if time < TkzOn then X1d_p else X1d_p*Pg/Pg_new;
    X2d = if time < TkzOn then X2d_p else X2d_p*Pg/Pg_new;
    X2q = if time < TkzOn then X2q_p else X2q_p*Pg/Pg_new;

    Rf = if time < TkzOn then Rf_p else Rf_p*Pg/Pg_new;
    R1d = if time < TkzOn then R1d_p else R1d_p*Pg/Pg_new;
    R1q = if time < TkzOn then R1q_p else R1q_p*Pg/Pg_new;
    //--------------------------------------------------------------------------------
    der(DGi) = Wc*s;

    Uf_full = if (Uf*Xad/Rf + dEr) > Er_max then Er_max*Rf/Xad else if (Uf*Xad
      /Rf + dEr) < Er_min then Er_min*Rf/Xad else Uf + Rf*dEr/Xad;

    der(Yr) = Wc*(Uf_full - Rf*ir);
    der(Yrd) = -Wc*R1d*ird;
    der(Yrq) = -Wc*R1q*irq;
    der(s) = (Mt_pp - Me)/Tj;

    Ro = if time >= Timp and time < Timp + dTimp then -Aimp else -Mu + Mu0 - s
      /Sigma;

    TauC = if time < Timp + dTimp then TauC_up else TauC_down;
    //  Ro = -Mu + Mu0 - s/Sigma;
    der(Mu) = if time >= TregOff and time < TregOn then Ro/10e6 else Ro/TauC;
    //--------------------------------------------------------------------------------
    MT_MIN = if time < TkzOn then Mtmin*Pg else Pg_new - 0.01;
    MT_MAX = if time < TkzOn then Mtmax*Pg else Pg_new + 0.01;

    Mt_pp = if Mu >= MT_MIN and Mu <= MT_MAX then Mu else if Mu > MT_MAX then
      MT_MAX else MT_MIN;
    //--------------------------------------------------------------------------------
    //  Mt_pp = if Mu>=Mtmin*Pg and Mu  < Mtmax*Pg then Mu
    //                      else if Mu >= Mtmax*Pg then Mtmax*Pg
    //                                             else Mtmin;
    //--------------------------------------------------------------------------------
    Me = Yad*iq - Yaq*id;
    ir = (Yr - Yad)/Xsf;
    ird = (Yrd - Yad)/Xs1d;
    irq = (Yrq - Yaq)/Xs1q;
    id = if time >= TgenOff and time < TgenOff + dTgenOff then 0 else ((uq -
      E11q)*X2qt - Rs*(ud + E11d))/(X2dt*X2qt + Rs^2);
    iq = if time >= TgenOff and time < TgenOff + dTgenOff then 0 else (-ud -
      E11d - Rs*id)/X2qt;
    E11d = X3*Yrq;
    E11q = X1*Yr + X2*Yrd;
    Yad = E11q + id*(X2d - Xs);
    Yaq = E11d + iq*(X2q - Xs);
    Ugen = sqrt(ud^2 + uq^2);
    dUtr = sqrt(ud^2 + uq^2) - Ut;
    dWu = Wc*Ssys;
    dWf = if UqG <> 0 then atan2(UdG, UqG) else atan2(UdG, 0.001);
    dIf = ir - Ir;
    //----------------------------------------
    Pgen = uq*iq + ud*id;
    Qgen = -uq*id + ud*iq;
    //-----------------------------------------------------------
    uq = UqG*cos(DeltaIJ) - UdG*sin(DeltaIJ);
    ud = UqG*sin(DeltaIJ) + UdG*cos(DeltaIJ);
    //-----------------------------------------------------------
    IqG = iq*cos(DeltaIJ) + id*sin(DeltaIJ);
    IdG = id*cos(DeltaIJ) - iq*sin(DeltaIJ);
    //-----------------------------------------------------------
    f = Wc*(1-s)/2/PI;
    //------connectors------
    //--Stator--
    Stator_pin.Vd = UdG;
    Stator_pin.Vq = UqG;

    Stator_pin.Id = IdG;
    Stator_pin.Iq = IqG;
    //---input-rotor--field--voltage---
    Ef_pin.Signal = dEr;
    //----to--excitation--system---
    dUtr_pin.Signal = dUtr;
    dWu_pin.Signal = dWu;
    dWf_pin.Signal = dWf;
    dIf_pin.Signal = dIf;
    Ut_pin.Signal = Ut
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
            extent={{-60,62},{60,-58}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Text(extent={{-38,38}, {38,-36}}, textString=
                                                 "SM"),
          Text(extent={{-80,-58},{80,-100}}, textString=
                                                 "%name"),
          Line(
            points={{-60,2},{-72,2}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{70,2},{60,2}},
            color={28,108,200},
            thickness=0.5)},
        Ellipse(extent=[-60, 62; 60, -58], style(thickness=2)),
        Text(extent=[-38, 38; 38, -36], string="SM"),
        Text(extent=[-80, -58; 80, -100], string="%name"),
        Line(points=[-60, 2; -72, 2], style(thickness=2)),
        Line(points=[70, 2; 60, 2], style(thickness=2))));
    connect(dUtr_pin, dUtr_pin) annotation (Line(
        points={{-56,76},{-56,76}},
        color={255,255,0},
        thickness=0.5));
    annotation (__Dymola_Commands(editCall=plot(
              {"L0709_1.P1","L0709_1.U1m"},
              legends={"Calibration L0709_1.P1","Calibration L0709_1.U1m"},
              colors={{255,0,0},{255,0,0}}) "Calibration_U"), Documentation(
          info="<html>
<p>Synchronous generator model</p>
</html>"));
  end Synch_Machine;

  connector Single_Pin
    Real Signal "Connector's signal";
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
        graphics={Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={255,255,0},
            lineThickness=0.5,
            fillColor={255,127,0},
            fillPattern=FillPattern.CrossDiag)},
           Rectangle(extent=[-80, 80; 80, -80], style(
            color=49,
            thickness=2,
            fillColor=45,
            fillPattern=10))),
      Window(
        x=0.3,
        y=0.2,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p>The model of the basic connector for measuring signals</p>
</html>"));
  end Single_Pin;

  model Summator
    Basic.Single_Pin inp1 annotation (
      extent=[-94,14; -74,66],
      layer="icon",
      Placement(transformation(extent={{-94,14},{-74,66}}, rotation=0)));
    Basic.Single_Pin inp2 annotation (
      extent=[-94,-66; -74,-14],
      layer="icon",
      Placement(transformation(extent={{-94,-66},{-74,-14}}, rotation=0)));
    Basic.Single_Pin out annotation (
      extent=[74,-26; 94,26],
      layer="icon",
      Placement(transformation(extent={{74,-26},{94,26}}, rotation=0)));
  equation
    out.Signal = inp1.Signal + inp2.Signal;
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
            extent={{-60,80},{60,-80}},
            lineColor={0,0,255},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Forward),
          Line(
            points={{-60,40},{-76,40}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-60,-40},{-76,-40}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{76,0},{60,0}},
            color={28,108,200},
            thickness=0.5),
          Rectangle(
            extent={{-50,42},{-14,38}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-34,60},{-30,20}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-34,-20},{-30,-60}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-50,-38},{-14,-42}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)},
        Rectangle(extent=[-60, 80; 60, -80], style(
            color=73,
            thickness=2,
            fillColor=7,
            fillPattern=7)),
        Line(points=[-60, 40; -76, 40], style(thickness=2)),
        Line(points=[-60, -40; -76, -40], style(thickness=2)),
        Line(points=[76, 0; 60, 0], style(thickness=2)),
        Rectangle(extent=[-50, 42; -14, 38], style(fillColor=0)),
        Rectangle(extent=[-34, 60; -30, 20], style(fillColor=0)),
        Rectangle(extent=[-34, -20; -30, -60], style(fillColor=0)),
        Rectangle(extent=[-50, -38; -14, -42], style(fillColor=0))),
      Window(
        x=0.29,
        y=0.02,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p>The adder model</p>
</html>"));
  end Summator;

  connector Node
    Real Vd "Potential Vd";
    Real Vq "Potential Vq";
    flow Real Id "Current Id";
    flow Real Iq "Current Iq";
    annotation (
      Coordsys(
        extent=[-30, -30; 30, 30],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.26,
        y=0.25,
        width=0.6,
        height=0.6),
      Icon(
        coordinateSystem(
          preserveAspectRatio=false,
          preserveOrientation=false,
          extent={{-100,-100},{100,100}},
          grid={2,2},
          initialScale=0),
        graphics={Ellipse(
            extent={{-20,20},{20,-20}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)},
           Rectangle(extent=[-30, 30; 30, -30], style(fillColor=0))),
      Documentation(info="<html>
<p>Node Model</p>
</html>"));
  end Node;

  model logical_switch
    parameter Real a1;
    parameter Real a2;
    parameter Real a3;
    parameter Real a4;
    Real T_force_off;

    Basic.Single_Pin inp1 annotation (
      extent=[-94,14; -74,66],
      layer="icon",
      Placement(transformation(extent={{-96,14},{-76,66}}, rotation=0),
          iconTransformation(extent={{-96,14},{-76,66}})));
    Basic.Single_Pin inp2 annotation (
      extent=[-94,-66; -74,-14],
      layer="icon",
      Placement(transformation(extent={{-96,-54},{-76,-2}}, rotation=0),
          iconTransformation(extent={{-96,-54},{-76,-2}})));
    Basic.Single_Pin inp2inf annotation (
      extent=[-94,-66; -74,-14],
      layer="icon",
      Placement(transformation(
          extent={{-10,-26},{10,26}},
          rotation=90,
          origin={0,-106}), iconTransformation(
          extent={{-10,-26},{10,26}},
          rotation=90,
          origin={0,-106})));
    Basic.Single_Pin out annotation (
      extent=[74,-26; 94,26],
      layer="icon",
      Placement(transformation(extent={{74,-26},{94,26}}, rotation=0)));
    Basic.Single_Pin inp1inf annotation (Placement(transformation(extent={{-26,
              88},{24,108}}), iconTransformation(extent={{-26,88},{24,108}})));
  initial equation
    pre(T_force_off) = 0;
  equation
    when abs(inp1inf.Signal) < (inp2inf.Signal - a2) then
      T_force_off = time;
    end when;
    out.Signal =if (abs(inp1inf.Signal) > (inp2inf.Signal - a1)) then (inp1.Signal)
       else (if (abs(inp1inf.Signal) > (inp2inf.Signal - a2)) then (inp1.Signal)
       else (if (time < T_force_off + a4) then (inp1.Signal) else (inp2.Signal)));
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        coordinateSystem(
          preserveAspectRatio=false,
          preserveOrientation=false,
          extent={{-100,-120},{100,120}},
          grid={2,2},
          initialScale=0),
        graphics={
          Rectangle(
            extent={{-60,80},{60,-80}},
            lineColor={0,0,255},
            lineThickness=0.5,
            fillPattern=FillPattern.Solid,
            fillColor={244,125,35}),
          Line(
            points={{-52,40},{-80,40}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-50,-28},{-78,-28}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{76,0},{42,0}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-162,80}},
            color={162,29,33},
            thickness=1,
            smooth=Smooth.Bezier),
          Line(
            points={{-8,0},{-48,40}},
            color={0,0,255},
            thickness=0.5),
          Line(
            points={{14,0},{-8,0}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{48,0},{14,0}},
            color={28,108,200},
            thickness=0.5),
          Text(extent={{-158,-112},{162,-152}},
                                            textString=
                                                "%name"),
          Line(
            points={{10,6},{-8,6}},
            color={28,108,200},
            thickness=0.5,
            origin={6,-90},
            rotation=90),
          Line(
            points={{0,90},{0,80}},
            color={28,108,200},
            thickness=0.5)},
        Rectangle(extent=[-60, 80; 60, -80], style(
            color=73,
            thickness=2,
            fillColor=7,
            fillPattern=7)),
        Line(points=[-60, 40; -76, 40], style(thickness=2)),
        Line(points=[-60, -40; -76, -40], style(thickness=2)),
        Line(points=[76, 0; 60, 0], style(thickness=2)),
        Rectangle(extent=[-50, 42; -14, 38], style(fillColor=0)),
        Rectangle(extent=[-34, 60; -30, 20], style(fillColor=0)),
        Rectangle(extent=[-34, -20; -30, -60], style(fillColor=0)),
        Rectangle(extent=[-50, -38; -14, -42], style(fillColor=0))),
      Window(
        x=0.29,
        y=0.02,
        width=0.6,
        height=0.6),
      Diagram(coordinateSystem(extent={{-100,-120},{100,120}})),
      Documentation(info="<html>
<p>The model of the logic key of the automatic excitation regulator</p>
</html>"));
  end logical_switch;
  annotation (__Dymola_UserMetaData(MetaData(category="User Meta Data 1",
          value={ERROR})), Icon(graphics={Bitmap(extent={{-108,-96},{108,96}},
            fileName=
              "F:/Политех/Аспирандура/Modelica assotiation/LEPSE/PTL.png")}));
end Basic;
