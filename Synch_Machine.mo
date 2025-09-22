within ;
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
  LEPSE.Basic.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
      Placement(transformation(extent={{68,-8},{88,12}}, rotation=0)));
  LEPSE.Basic.Single_Pin Ef_pin annotation (extent=[-90,-8; -70,12],
      Placement(transformation(extent={{-90,-8},{-70,12}}, rotation=0)));
  LEPSE.Basic.Single_Pin dUtr_pin annotation (
    extent=[-60,66; -40,86],
    layer="icon",
    Placement(transformation(extent={{-66,66},{-46,86}}, rotation=0)));
  LEPSE.Basic.Single_Pin dWu_pin annotation (
    extent=[-26,66; -6,86],
    layer="icon",
    Placement(transformation(extent={{-42,66},{-22,86}}, rotation=0)));
  LEPSE.Basic.Single_Pin dWf_pin annotation (
    extent=[6,66; 26,86],
    layer="icon",
    Placement(transformation(extent={{-18,66},{2,86}}, rotation=0)));
  LEPSE.Basic.Single_Pin dIf_pin annotation (
    extent=[40,66; 60,86],
    layer="icon",
    Placement(transformation(extent={{8,66},{28,86}}, rotation=0)));
  LEPSE.Basic.Single_Pin Ut_pin
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
