within Basic;
package Generators

  package Numerical_units
    model SM
      outer SysData sysData;

      // PQ-diagram parameter
      parameter LEPSE.Data.PQ_CapabilityTable
      pq_table = LEPSE.Data.TVV_500_2;

      parameter Real TgenOff=1000 "Time of generator's disconnection, s";
      parameter Real dTgenOff=10 "Duration of generator's disconnection, s";

      //------------------------------------------------------------------------------------
      parameter Real Sbaz=sysData.Sbaz "Bazic power, MWA";
      parameter Real fbaz=sysData.fbaz "Bazic frequency, Hz";
      parameter Real Pg=500 "Active power, MW";
      parameter Real Qg(fixed=false) "Reactive power, MVAR";
      parameter Real Ut=20 "ARV voltage reference value, kV";
      parameter Real Pnom=500 "Nominal maschine active power, MW";
      parameter Real Ugnom=20 "Nominal stator voltage, kV";
      parameter Real cosfi_nom=0.85 "Nominal maschine power coefficient, p.u.";

       // Limitation variables
      Real Qmax "Текущий предел перевозбуждения, МВар";
      Real Qmin "Текущий предел недовозбуждения, МВар";

      // Вспомогательные переменные для интерполятора (требование синтаксиса Modelica)
        Real P_clipped_max "Срезанная P для интерполяции Qmax";
        Real P_clipped_min "Срезанная P для интерполяции Qmin";
        Integer i_max_dummy;
        Integer i_min_dummy;

      //------------------------------------------------------------------------------------
      parameter Real Xd_p=1.869 "D-axis synchronous reactance, p.u.";
      parameter Real Xq_p=1.869 "Q-axis synchronous reactance, p.u.";
      parameter Real Xs_p=0.194 "Leakage reactance of stator winding, p.u.";
      parameter Real X1d_p=0.3016 "D-axis transient reactance, p.u.";
      parameter Real X2d_p=0.2337 "D-axis subtransient reactance, p.u.";
      parameter Real X2q_p=0.2337 "Q-axis subtransient reactance, p.u.";
      Real Rf_p "Active resistance of field winding, p.u.";
      Real R1d_p "Active resistance of d-axis damper winding, p.u.";
      Real R1q_p "Active resistance of q-axis damper winding, p.u.";
      parameter Real Tj_p=7 "Inertia coefficient, s";
      parameter Real Td0=10 "D-axis transient time constant, s";
      parameter Real T2d_p=0.02 "D-axis subtransient time constant, s";
      parameter Real T2q_p=0.05 "Q-axis subtransient time constant, s";

      parameter Real Sigma=0.0475 "Turbine statism coefficient, p.u.";
      parameter Real TauC_up=0.8 "Time constant of servo motor while valving control, s";
      parameter Real TregOff=50 "Turbine speed regulator off-time, s";

      parameter Real TregOn=1000 "Turbine speed regulator on-time, s";
      parameter Real Mtmax=1.1 "Turbine overloading coefficient, p.u.";
      parameter Real Mtmin=0 "Turbine minimum-loading coefficient, p.u.";

      parameter Real Aimp=1 "Fast turbine valving control amplitude, p.u.";
      parameter Real Timp=1000 "Fast turbine valving control on-time, s";
      parameter Real dTimp=0.2 "Fast turbine valving control duration, s";
      parameter Real TauC_down=5 "Time constant of servo motor after valving control end, s";

      parameter Real TkzOn=1000 "HPP generators dropping on-time, s";
      parameter Real Pg_new=0.85 "New power of HPP, p.u.";
      parameter Real Kemax=2.0 "Multiplicity of forcing on, p.u.";
      parameter Real Kemin=-0.6 "Multiplicity of forcing off, p.u.";

      //------------------------------------------------------------------------------------
      Real dUtr "voltage deviation";
      Real dWu "frequency deviation";
      Real dIf "current deviation";
      Real dEr "Electromotive force (EMF) deviation";
      Real dWf "frequency deviation";
      constant Real PI=4*atan(1) "PI-constant";
      parameter Real Wc=2*PI*fbaz "frequency of electric current fluctuations";
      parameter Real Xt=0.0 "resistance of step-up transformer and line to IB";

      // Parameters of power system elements
      constant Real Ra=0 "active resistance of generator stator winding";
      constant Real Rt=0 "active resistance of transformer";
      parameter Real EQ(fixed=false) "Auxiliaire EMF of salient-pole generator";
      parameter Real Dg(fixed=false) "Generator power angle";
      parameter Real Uq(fixed=false) "D-axis ARV voltage reference value";
      parameter Real Ud(fixed=false) "Q-axis ARV voltage reference value";
      parameter Real Id(fixed=false) "D-axis stator current value";
      parameter Real Iq(fixed=false) "Q-axis stator current value";
      parameter Real Eiq(fixed=false) "synchronous stator EMF";
      parameter Real Ir(fixed=false) "field winding current";
      parameter Real Uf(fixed=false) "field winding voltage";
      parameter Real Eq(fixed=false) "EMF of generator";
      parameter Real Er0(fixed=false) "EMF of generator initial value";
      parameter Real PsiR(fixed=false) "field winding flow coupling initial value";
      parameter Real PsiRD(fixed=false) "D-axis damper winding flow coupling initial value";
      parameter Real PsiRQ(fixed=false) "Q-axis damper winding flow coupling initial value";
      parameter Real Er_max(fixed=false) "upper bound of EMF of generator";
      parameter Real Er_min(fixed=false) "lower bound of EMF of generator";
      Real Uf_full "field winding voltage actual value";

      Real Xad "D-axis resistance to mutual induction";
      Real Xaq "Q-axis resistance to mutual induction";
      Real X2dt "D-axis subtransient reactance of generator and transformer";
      Real X2qt "Q-axis subtransient reactance of generator and transformer";
      Real Rs "Sum resistance of stator winding and step-up transformer";
      Real Xsf "Leakage reactance of field winding";
      Real Xs1d "D-axis leakage reactance of damping winding";
      Real Xs1q "Q-axis leakage reactance of damping winding";
      Real X1 "interim reactance в„–1";
      Real X2 "interim reactance в„–2";
      Real X3 "interim reactance в„–3";
      Real Ugen "generator full voltage actual value";
      parameter Real Mu0(fixed=false) "Turbine rotation moment initial value";
      Real Ro;
      Real Mu "Turbine valve position / moment";
      Real Mt_pp "Turbine rotation moment actual value";
      Real Pgen "Generator active power actual value";
      Real Qgen "Generator reactive power actual value";
      Real UdG;
      Real UqG;
      Real IdG;
      Real IqG;
      input Real DeltaIJ;
      input Real Ssys "system slip";

      //------------------------------------------------------------------
      // Integrated Variables
      Real Yr "field winding flow coupling actual value";
      Real Yrd "D-axis damper winding flow coupling actual value";
      Real Yrq "Q-axis damper winding flow coupling actual value";
      Real s "generator slip";
      Real DGi "Generator power angle initial value";
      Real Me "electrical moment";
      Real Yad "D-axis flow coupling of mutual inductance";
      Real Yaq "Q-axis flow coupling of mutual inductance";
      Real iq "Q-axis generator stator winding current actual value";
      Real id "D-axis generator stator winding current actual value";
      Real ir "D-axis generator field winding current actual value";
      Real ird "D-axis generator damper winding current actual value";
      Real irq "Q-axis generator damper winding current actual value";
      Real ud "D-axis generator voltage actual value";
      Real uq "Q-axis generator voltage actual value";
      Real E11d "EMF, connected with d-axis damper winding";
      Real E11q "EMF, connected with q-axis damper winding";
      Real TauC "Time constant of servo motor actual value";
      Real MT_MAX "Turbine overloading coefficient actual value";
      Real MT_MIN "Turbine minimum-loading coefficient actual value";
      Real Xd "D-axis synchronous reactance actual value";
      Real Xq "Q-axis synchronous reactance actual value";
      Real Xs "Leakage reactance actual value";
      Real X1d "D-axis transient reactance actual value";
      Real X2d "D-axis subtransient reactance actual value";
      Real X2q "Q-axis subtransient reactance actual value";
      Real Rf "Active resistance of field winding actual value";
      Real R1d "Active resistance of d-axis damper winding actual value";
      Real R1q "Active resistance of q-axis damper winding actual value";
      Real Tj "Inertia coefficient actual value";
      Real f "frequency";
      parameter Real Ut_pu(fixed=false) "stator voltage, p.u.";
      parameter Real Pg_pu(fixed=false) "Active power, p.u.";
      parameter Real Qg_pu(fixed=false) "Reactive power, p.u.";

      LEPSE.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
          Placement(transformation(extent={{90,-10},{110,10}},
                                                             rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      LEPSE.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
          Placement(transformation(extent={{-110,-10},{-90,10}},
                                                               rotation=0),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      LEPSE.Interfaces.Signal_pin dUtr_pin annotation (
        extent=[-60,66; -40,86],
        layer="icon",
        Placement(transformation(extent={{-64,90},{-44,110}},rotation=0),
            iconTransformation(extent={{-64,90},{-44,110}})));
      LEPSE.Interfaces.Signal_pin dWu_pin annotation (
        extent=[-26,66; -6,86],
        layer="icon",
        Placement(transformation(extent={{-36,90},{-16,110}},rotation=0),
            iconTransformation(extent={{-36,90},{-16,110}})));
      LEPSE.Interfaces.Signal_pin dWf_pin annotation (
        extent=[6,66; 26,86],
        layer="icon",
        Placement(transformation(extent={{-10,90},{10,110}},
                                                           rotation=0),
            iconTransformation(extent={{-10,90},{10,110}})));
      LEPSE.Interfaces.Signal_pin dIf_pin annotation (
        extent=[40,66; 60,86],
        layer="icon",
        Placement(transformation(extent={{18,90},{38,110}},
                                                          rotation=0),
            iconTransformation(extent={{18,90},{38,110}})));
      LEPSE.Interfaces.Signal_pin Ut_pin
        annotation (Placement(transformation(extent={{46,90},{66,110}}),
            iconTransformation(extent={{46,90},{66,110}})));
    initial equation
      // additional variables in p.u.
      Ut_pu = Ut/Ugnom;
      Pg_pu = Pg/Sbaz;
      Qg_pu = Qg/Sbaz;

      Pg=Pgen;
      Qg=min(Qmax, max(Qmin, Qgen));

      // equations of currents, voltages, and flux densities
      s = 0;

      EQ = sqrt((Ut_pu + ((Ra + Rt)*Pg_pu + (Xq + Xt)*Qg_pu)/Ut_pu)^2 + (((Xq + Xt)*Pg_pu - (Ra + Rt)*Qg_pu)/Ut_pu)^2);
      Dg = atan((((Xq + Xt)*Pg_pu - (Ra + Rt)*Qg_pu)/Ut_pu)/(Ut_pu + ((Ra + Rt)*Pg_pu + (Xq + Xt)*Qg_pu)/Ut_pu));

      Uq = Ut_pu*cos(Dg);
      Ud = -Ut_pu*sin(Dg);

      Id = ((Uq - EQ)*(Xq + Xt) - (Ra + Rt)*Ud)/((Ra + Rt)^2 + (Xq + Xt)^2);
      Iq = (-Ud - (Ra + Rt)*Id)/(Xq + Xt);
      Mu0 = EQ*Iq;
      Mu = Mu0;

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

      DGi = Dg;
      Yr = PsiR;
      Yrd = PsiRD;
      Yrq = PsiRQ;

    equation

      // 1. ЗАЩИТА ОТ ЭКСТРАПОЛЯЦИИ (Ограничиваем Pgen границами таблиц, чтобы математика не улетала)
      P_clipped_max = max(pq_table.P_max[1], min(Pgen, pq_table.P_max[end]));
      P_clipped_min = max(pq_table.P_min[1], min(Pgen, pq_table.P_min[end]));

       // 2. АВТОМАТИЧЕСКАЯ ИНТЕРПОЛЯЦИЯ НА КАЖДОМ ШАГЕ РАСЧЕТА
      // Функция interpolate возвращает кортеж (значение_Y, индекс_интервала)
      (Qmax, i_max_dummy) = Modelica.Math.Vectors.interpolate(
        pq_table.P_max,
        pq_table.Qmax,
        P_clipped_max);

      (Qmin, i_min_dummy) = Modelica.Math.Vectors.interpolate(
        pq_table.P_min,
        pq_table.Qmin,
        P_clipped_min);

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
      Tj = if time < TkzOn then Tj_p else Tj_p*Pg_new/Pg;

      Xd = if time < TkzOn then Xd_p else Xd_p*Pg/Pg_new;
      Xq = if time < TkzOn then Xq_p else Xq_p*Pg/Pg_new;
      Xs = if time < TkzOn then Xs_p else Xs_p*Pg/Pg_new;
      X1d = if time < TkzOn then X1d_p else X1d_p*Pg/Pg_new;
      X2d = if time < TkzOn then X2d_p else X2d_p*Pg/Pg_new;
      X2q = if time < TkzOn then X2q_p else X2q_p*Pg/Pg_new;

      Rf_p = (Xad+Xsf)/Wc/Td0;
      R1d_p = (Xs1d+(1/((1/Xad)+(1/Xsf)+(1/Xs))))/Wc/T2d_p;
      R1q_p = (Xs1q+(1/((1/Xaq)+(1/Xsf))))/Wc/T2q_p;
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

      der(Mu) = if time >= TregOff and time < TregOn then Ro/10e6 else Ro/TauC;
      //--------------------------------------------------------------------------------
      MT_MIN = if time < TkzOn then Mtmin*Pg_pu else Pg_new/Sbaz - 0.01;
      MT_MAX = if time < TkzOn then Mtmax*Pg_pu else Pg_new/Sbaz + 0.01;

      Mt_pp = if Mu >= MT_MIN and Mu <= MT_MAX then Mu else if Mu > MT_MAX then
        MT_MAX else MT_MIN;
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
      Ugen = (sqrt(ud^2 + uq^2))*Ugnom;
      dUtr = sqrt(ud^2 + uq^2) - Ut_pu;
      dWu = Wc*Ssys;
      dWf = if UqG <> 0.0 then atan2(UdG, UqG) else atan2(UdG, 0.001);
      dIf = ir - Ir;
      //----------------------------------------
      Pgen = (uq*iq + ud*id)*Sbaz;
      Qgen = (-uq*id + ud*iq)*Sbaz;
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
      dEr = Ef_pin.Signal;

      //----to--excitation--system---
      dUtr_pin.Signal = dUtr;
      dWu_pin.Signal = dWu;
      dWf_pin.Signal = dWf;
      dIf_pin.Signal = dIf;
      Ut_pin.Signal = Ut_pu;
      connect(dUtr_pin, dUtr_pin) annotation (Line(
          points={{-54,100},{-54,100}},
          color={255,255,0},
          thickness=0.5));

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
<p>Synchronous generator model. </p>
<p>Модель синхронного генератора</p>
</html>"));
    end SM;

    model SM_with_AVR

      LEPSE.Interfaces.Pin_v2 inp annotation (
        extent=[78,-4; 98,16],
        layer="icon",
        Placement(transformation(extent={{90,-10},{110,10}},
                                                           rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      parameter Real TgenOff=1000 "Time of generator's disconnection, s";
      parameter Real dTgenOff=10 "Duration of generator's disconnection, s";
      parameter Real Pg=100 "Active power, MW";
      parameter Real Ut=20 "ARV voltage reference value, kV";
      parameter Real Pnom=100 "Nominal maschine active power";
      parameter Real Ugnom=20 "Nominal stator voltage, kV";
      parameter Real Sbaz=1000 "Bazis power, MWA";
      parameter Real Xd_p=1.869 "D-axis synchronous reactance, p.u.";
      parameter Real Xq_p=1.869 "Q-axis synchronous reactance, p.u.";
      parameter Real Xs_p=0.194 "Leakage reactance of stator winding, p.u.";
      parameter Real Tj_p=7 "Inertia coefficient, s";
      parameter Real X2q_p=0.2337 "Q-axis subtransient reactance, p.u.";
      parameter Real X2d_p=0.2337 "D-axis subtransient reactance, p.u.";
      parameter Real X1d_p=0.3016 "D-axis transient reactance, p.u.";
      parameter Real Td0=10 "D-axis transient time constant, s";
      parameter Real T2d_p=0.02 "D-axis subtransient time constant, s";
      parameter Real T2q_p=0.05 "Q-axis subtransient time constant, s";
      parameter Real Sigma=0.0475 "Turbine statism coefficient, p.u.";
      parameter Real TauC_up=0.8 "Time constant of servo motor while valving control, s";
      parameter Real TregOff=50 "Turbine speed regulator off-time, s";
      parameter Real TregOn=1000 "Turbine speed regulator on-time, s";
      parameter Real Mtmax=1.1 "Turbine overloading coefficient, p.u.";
      parameter Real Aimp=1 "Fast turbine valving control amplitude, p.u.";
      parameter Real Mtmin=0 "Turbine minimum-loading coefficient, p.u.";
      parameter Real Timp=1000 "Fast turbine valving control on-time, s";
      parameter Real dTimp=0.2 "Fast turbine valving control duration, s";
      parameter Real TauC_down=5 "Time constant of servo motor after valving control end, s";
      parameter Real TkzOn=1000 "HPP generators dropping on-time, s";
      parameter Real Pg_new=100 "New power of HPP, MW";
      parameter Real Kemax=2.0 "Multiplicity of forcing on, p.u.";
      parameter Real Kemin=-0.6 "Multiplicity of forcing off, p.u.";
      parameter Real K0u=-10 "Voltage deviation control coefficient";
      parameter Real K1u=0 "Voltage derivative control coefficient";
      parameter Real K0w=0 "Frequency deviation control coefficient";
      parameter Real K1if=0 "Rotor current derivative control coefficient";
      parameter Real K1w=0 "Frequency derivative control coefficient";
      parameter Real Uforc=0.85 "Voltage of field forcing input";
      parameter Real Udeforc=0.9 "Voltage of field forcing removing";
      parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
      parameter Real DL0=0;
      parameter Real Tokp=0.05 "The main channel of regulation time constant";
      parameter Real cosfi_nom=0.85 "Nominal maschine power coefficient, p.u.";
      parameter Real n_gen=1 "Number of generators";

      parameter Boolean displayPowerFlow=true "Display power flow";
      SM G(
        pq_table=pq_table,
        TgenOff=TgenOff,
        dTgenOff=dTgenOff,
        Sbaz=Sbaz,
        fbaz=fbaz,
        Pg=Pg,
        Ut=Ut,
        Pnom=Pnom,
        Ugnom=Ugnom,
        cosfi_nom=cosfi_nom,
        Xd_p=Xd_p,
        Xq_p=Xq_p,
        Xs_p=Xs_p,
        X1d_p=X1d_p,
        X2d_p=X2d_p,
        X2q_p=X2q_p,
        Tj_p=Tj_p,
        Td0=Td0,
        T2d_p=T2d_p,
        T2q_p=T2q_p,
        Sigma=Sigma,
        TauC_up=TauC_up,
        TregOff=TregOff,
        TregOn=TregOn,
        Mtmax=Mtmax,
        Mtmin=Mtmin,
        Aimp=Aimp,
        Timp=Timp,
        dTimp=dTimp,
        TauC_down=TauC_down,
        TkzOn=TkzOn,
        Pg_new=Pg_new,
        Kemax=Kemax,
        Kemin=Kemin)
        annotation (Placement(transformation(extent={{-16,-58},{76,40}})));

      parameter Real fbaz=G.sysData.fbaz "Bazic frequency, Hz";
      parameter LEPSE.Data.PQ_CapabilityTable pq_table=LEPSE.Data.TVV_500_2;
      replaceable
        Excitation_systems.Regulators.Excitation_Regulator_Q_limit AVR(
        K0u=K0u,
        K1u=K1u,
        K0w=K0w,
        K1w=K1w,
        K1if=K1if,
        Uforc=Uforc,
        Udeforc=Udeforc,
        Tforcedelay=Tforcedelay,
        DL0=DL0,
        Tokp=Tokp,
        Qgen=G.Qgen,
        Qmax=G.Qmax,
        Qmin=G.Qmin,
        inService=inService) annotation (Placement(transformation(extent={{
                -124,-44},{-36,50}})));
      parameter Boolean inService=true "Excitation limiter condition";
    equation

      connect(G.Stator_pin, inp) annotation (Line(points={{76,-9},{76,-10},{86,
              -10},{86,0},{100,0}}, color={28,108,200}));

      connect(G.Ef_pin, AVR.out_pin) annotation (Line(
          points={{-16,-9},{-16,-10},{-28,-10},{-28,-0.76},{-35.6333,-0.76}},
          color={255,255,0},
          thickness=0.5));
      connect(G.Ut_pin, AVR.Ut_pin) annotation (Line(
          points={{55.76,40},{55.76,72},{-138,72},{-138,-36.48},{-124,-36.48}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dIf_pin, AVR.dif1_pin) annotation (Line(
          points={{42.88,40},{42.88,68},{-136,68},{-136,-27.08},{-124.367,
              -27.08}},
          color={255,255,0},
          thickness=0.5));

      connect(G.dWf_pin, AVR.dfU_pin) annotation (Line(
          points={{30,40},{30,64},{-134,64},{-134,-15.8},{-124.367,-15.8}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dWu_pin, AVR.dfsys_pin) annotation (Line(
          points={{18.04,40},{18.04,60},{-132,60},{-132,-1.7},{-124.367,
              -1.7}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dUtr_pin, AVR.dV_pin) annotation (Line(
          points={{5.16,40},{5.16,56},{-130,56},{-130,26.5},{-124.367,26.5}},
          color={255,255,0},
          thickness=0.5));
      connect(AVR.dV_pin, AVR.dV1_pin) annotation (Line(
          points={{-124.367,26.5},{-124.367,24},{-124,24},{-124,20},{
              -124.367,20},{-124.367,12.4}},
          color={255,255,0},
          thickness=0.5));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-140,-100},{100,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Text(extent={{-78,96},{74,70}},
              textColor={0,0,0},
              textString="%name"),
            Line(points={{94,0},{60,0}}, color={0,0,0},
              thickness=1),
            Text(
              textString=DynamicSelect("P MW", String(G.Pgen, significantDigits=3) + " MW"),
              visible=displayPowerFlow,
              extent={{-96,-70},{102,-108}},
              textColor={0,168,6}),
            Text(
              textString=DynamicSelect("Q MVar", String(G.Qgen, significantDigits=3) + " MVar"),
              visible=displayPowerFlow,
              extent={{-94,-100},{104,-138}},
              textColor={102,44,145}),
            Line(
              points={{-52,20},{-52,-20},{-20,-40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-52,20},{-20,40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-20,40},{-20,-40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-20,0},{20,0}},
              color={0,0,0},
              thickness=1),
            Ellipse(
              extent={{20,20},{60,-20}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None),
            Ellipse(
              extent={{-5,6},{5,-6}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None,
              closure=EllipseClosure.None,
              startAngle=0,
              endAngle=180,
              origin={35,-8.88178e-16},
              rotation=180),
            Ellipse(
              extent={{-5,6},{5,-6}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None,
              closure=EllipseClosure.None,
              startAngle=0,
              endAngle=180,
              origin={45,0},
              rotation=360),
            Line(
              points={{-52,0},{-78,0}},
              color={0,0,0},
              thickness=1),
            Rectangle(
              extent={{-80,60},{80,-60}},
              lineColor={28,108,200},
              lineThickness=1,
              pattern=LinePattern.Dash)},
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
<p>Generator model with automatic excitation control. </p>
<p>Модель синхронного генератора с подключенным АРВ. </p>
</html>"),
        Diagram(coordinateSystem(extent={{-140,-100},{100,100}})));
    end SM_with_AVR;

    model Infinite_bus

      LEPSE.Interfaces.Pin_v2 inp annotation (
        extent=[78,-4; 98,16],
        layer="icon",
        Placement(transformation(extent={{90,-10},{110,10}},
                                                           rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      Turbines.ASR_Regulator ASC_Regulator_1(Sigma=Sigma, Tauc=Tauc)
        annotation (Placement(transformation(extent={{-86,-80},{-20,-32}})));
      Infinite_bus_Mashine G(
        TgenOff=TgenOff,
        dTgenOff=dTgenOff,
        Sbaz=Sbaz,
        fbaz=fbaz,
        Pnom=Pnom,
        Ut=Ut,
        cosfi_nom=cosfi_nom,
        Qmax=Qmax,
        Qmin=Qmin,
        Xd_p=Xd_p,
        Xq_p=Xq_p,
        Xs_p=Xs_p,
        X1d_p=X1d_p,
        X2d_p=X2d_p,
        X2q_p=X2q_p,
        Tj_p=500,
        Td0=Td0,
        T2d_p=T2d_p,
        T2q_p=T2q_p,
        Mtmax=Mtmax,
        Mtmin=Mtmin,
        Kemax=Kemax,
        Kemin=Kemin)
        annotation (Placement(transformation(extent={{-6,-38},{82,58}})));

      parameter Real TgenOff=1000 "Time of generator's disconnection";
      parameter Real dTgenOff=10 "Duration of generator's disconnection";
      parameter Real Ut=1 "ARV voltage reference value";
      parameter Real Xd_p=1.869 "D-axis synchronous reactance";
      parameter Real Xq_p=1.869 "Q-axis synchronous reactance";
      parameter Real Xs_p=0.194 "Leakage reactance of stator winding";
      parameter Real X1d_p=0.3016 "D-axis transient reactance";
      parameter Real X2d_p=0.2337 "D-axis subtransient reactance";
      parameter Real X2q_p=0.2337 "Q-axis subtransient reactance";
      parameter Real Rf_p=904e-6 "Active resistance of field winding";
      parameter Real R1d_p=3.688e-3
        "Active resistance of d-axis damper winding";
      parameter Real R1q_p=2.77e-3 "Active resistance of q-axis damper winding";
      parameter Real Mtmax=1.1 "Turbine overloading coefficient";
      parameter Real Mtmin=0 "Turbine minimum-loading coefficient";
      parameter Real Kemax=2.0 "Multiplicity of forcing on";
      parameter Real Kemin=-0.6 "Multiplicity of forcing off";
      parameter Real K0u=-10 "Voltage deviation control coefficient";
      parameter Real K1u=0 "Voltage derivative control coefficient";
      parameter Real K0w=0 "Frequency deviation control coefficient";
      parameter Real K1w=0 "Frequency derivative control coefficient";
      parameter Real K1if=0 "Rotor current derivative control coefficient";
      parameter Real Uforc=0.85 "Voltage of field forcing input";
      parameter Real Udeforc=0.9 "Voltage of field forcing removing";
      parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
      parameter Real Sigma=0.0001 "Slip deviation control coefficient";
      parameter Real Tauc=0.0001 "Slip deviation time constant";

      parameter Real Td0=10 "D-axis transient time constant, s";
      parameter Real T2d_p=0.02 "D-axis subtransient time constant, s";
      parameter Real T2q_p=0.05 "Q-axis subtransient time constant, s";

      parameter Boolean displayPowerFlow=true "Display power flow";

      parameter Real Sbaz=1000 "Bazis power, MWA";
      parameter Real fbaz=G.sysData.fbaz "Bazic frequency, Hz";
      parameter Real Qmax=9999
        "Текущий предел перевозбуждения, МВар";
      parameter Real Qmin=-9999
        "Текущий предел недовозбуждения, МВар";
      Excitation_systems.Regulators.Excitation_Regulator_Q_limit AVR(
        K0u=K0u,
        K1u=K1u,
        K0w=K0w,
        K1w=K1w,
        K1if=K1if,
        Uforc=Uforc,
        Udeforc=Udeforc,
        Tforcedelay=Tforcedelay,
        Tokp=Tokp,
        Qgen=G.Qgen,
        Qmax=G.Qmax,
        Qmin=G.Qmin,
        inService=inService) annotation (Placement(transformation(extent={{
                -108,-24},{-24,58}})));
      parameter Boolean inService=true "Excitation limiter condition";
      parameter Real cosfi_nom=0.9
        "Nominal maschine power coefficient, p.u.";
      parameter Real Pnom=10000 "Set PV-generator power";
      parameter Real Tokp=0.05
        "The main channel of regulation time constant";
    initial equation
        ASC_Regulator_1.out_pin.Signal = G.Me;

    equation

      connect(G.Mt_pin, ASC_Regulator_1.out_pin) annotation (Line(
          points={{-6,-3.44},{-16,-3.44},{-16,-56},{-20.275,-56}},
          color={255,255,0},
          thickness=0.5));

      connect(inp, G.Stator_pin) annotation (Line(points={{100,0},{100,10},{82,
              10}}, color={28,108,200}));
      connect(G.Ef_pin, AVR.out_pin) annotation (Line(
          points={{-6,10},{-20,10},{-20,13.72},{-23.65,13.72}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dUtr_pin, AVR.dV_pin) annotation (Line(
          points={{14.24,58},{14.24,66},{-114,66},{-114,37.5},{-108.35,37.5}},
          color={255,255,0},
          thickness=0.5));
      connect(AVR.dV_pin, AVR.dV1_pin) annotation (Line(
          points={{-108.35,37.5},{-108.35,25.2}},
          color={255,255,0},
          thickness=0.5));
      connect(G.slip_pin, ASC_Regulator_1.ds_pin) annotation (Line(
          points={{75.84,58},{75.84,66},{116,66},{116,-86},{-90,-86},{-90,-57.92},{-86.275,
              -57.92}},
          color={255,255,0},
          thickness=0.5));
      connect(G.Ut_pin, AVR.Ut_pin) annotation (Line(
          points={{62.64,58},{62.64,82},{-122,82},{-122,-17.44},{-108,-17.44}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dIf_pin, AVR.dif1_pin) annotation (Line(
          points={{50.32,58},{50.32,78},{-120,78},{-120,-9.24},{-108.35,-9.24}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dWf_pin, AVR.dfU_pin) annotation (Line(
          points={{38,58},{38,74},{-118,74},{-118,0.6},{-108.35,0.6}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dWu_pin, AVR.dfsys_pin) annotation (Line(
          points={{26.56,58},{26.56,70},{-116,70},{-116,12.9},{-108.35,12.9}},
          color={255,255,0},
          thickness=0.5));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-120,-100},{100,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Ellipse(extent={{-74,68},{72,-68}}, lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-78,96},{74,70}},
              textColor={0,0,0},
              textString="%name"),
            Line(points={{94,0},{72,0}}, color={0,0,255},
              thickness=1),
              Text(
              textString=DynamicSelect("P MW", String(G.Pgen, significantDigits=3) + " MW"),
              visible=displayPowerFlow,
              extent={{-96,-70},{102,-108}},
              textColor={0,168,6}),
            Text(
              textString=DynamicSelect("Q MVar", String(G.Qgen, significantDigits=3) + " MVar"),
              visible=displayPowerFlow,
              extent={{-94,-100},{104,-138}},
              textColor={102,44,145}),
            Ellipse(
              extent={{-25,26},{25,-26}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None,
              closure=EllipseClosure.None,
              startAngle=0,
              endAngle=180,
              origin={-25,-3.55271e-15},
              rotation=180),
            Ellipse(
              extent={{-25,26},{25,-26}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None,
              closure=EllipseClosure.None,
              startAngle=0,
              endAngle=180,
              origin={25,0},
              rotation=360)},
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
<p>Infinite bus model. </p>
<p>Модель шин бесконечной мощности. </p>
</html>"),
        Diagram(coordinateSystem(extent={{-120,-100},{100,100}})));
    end Infinite_bus;

    model Infinite_bus_Mashine
      outer SysData sysData;

      parameter Real TgenOff=1000 "Time of generator's disconnection";
      parameter Real dTgenOff=10 "Duration of generator's disconnection";

      //------------------------------------------------------------------------------------
      parameter Real Sbaz=sysData.Sbaz "Bazis power, MWA";
      parameter Real fbaz=sysData.fbaz "Bazic frequency, Hz";
      parameter Real Pg(fixed=false) "Active power";
      parameter Real Qg(fixed=false) "Reactive power";
      parameter Real Ut=330 "ARV voltage reference value";
      parameter Real Pnom=10000 "Set PV-generator power";
      parameter Real Ugnom=330 "Nominal voltage";
      parameter Real cosfi_nom=0.9 "Nominal maschine power coefficient, p.u.";

      parameter Real Qmax=9999 "Текущий предел перевозбуждения, МВар";
      parameter Real Qmin=-9999 "Текущий предел недовозбуждения, МВар";

      //------------------------------------------------------------------------------------
      parameter Real Xd_p=1.869 "D-axis synchronous reactance"
      annotation(Dialog(tab="Reactances"));
      parameter Real Xq_p=1.869 "Q-axis synchronous reactance";
      parameter Real Xs_p=0.194 "Leakage reactance of stator winding";
      parameter Real X1d_p=0.3016 "D-axis transient reactance";
      parameter Real X2d_p=0.2337 "D-axis subtransient reactance";
      parameter Real X2q_p=0.2337 "Q-axis subtransient reactance";
      Real Rf_p "Active resistance of field winding";
      Real R1d_p "Active resistance of d-axis damper winding";
      Real R1q_p "Active resistance of q-axis damper winding";
      parameter Real Tj_p=7 "Inertia coefficient";
      parameter Real Td0=10 "D-axis transient time constant, s";
      parameter Real T2d_p=0.02 "D-axis subtransient time constant, s";
      parameter Real T2q_p=0.05 "Q-axis subtransient time constant, s";

      parameter Real Mtmax=1.1 "Turbine overloading coefficient";
      parameter Real Mtmin=0 "Turbine minimum-loading coefficient";

      parameter Real Kemax=2.0 "Multiplicity of forcing on";
      parameter Real Kemin=-0.6 "Multiplicity of forcing off";

      //------------------------------------------------------------------------------------
      Real dUtr "voltage deviation";
      Real dWu "frequency deviation";
      Real dIf "current deviation";
      Real dEr "Electromotive force (EMF) deviation";
      Real dWf "frequency deviation";
      constant Real PI=4*atan(1) "PI-constant";
      parameter Real Wc=2*PI*fbaz "frequency of electric current fluctuations";
      constant Real Xt=0 "resistance of step-up transformer";

      // Parameters of power system elements
      constant Real Ra=0 "active resistance of generator stator winding";
      constant Real Rt=0 "active resistance of transformer";
      parameter Real EQ(fixed=false) "Auxiliaire EMF of salient-pole generator";
      parameter Real Dg(fixed=false) "Generator power angle";
      parameter Real Uq(fixed=false) "D-axis ARV voltage reference value";
      parameter Real Ud(fixed=false) "Q-axis ARV voltage reference value";
      parameter Real Id(fixed=false) "D-axis stator current value";
      parameter Real Iq(fixed=false) "Q-axis stator current value";
      parameter Real Eiq(fixed=false);
      parameter Real Ir(fixed=false) "field winding current";
      parameter Real Uf(fixed=false) "field winding voltage";
      parameter Real Eq(fixed=false) "EMF of generator";
      parameter Real Er0(fixed=false) "EMF of generator initial value";
      parameter Real PsiR(fixed=false) "field winding flow coupling initial value";
      parameter Real PsiRD(fixed=false) "D-axis damper winding flow coupling initial value";
      parameter Real PsiRQ(fixed=false) "Q-axis damper winding flow coupling initial value";
      parameter Real Er_max(fixed=false) "upper bound of EMF of generator";
      parameter Real Er_min(fixed=false) "lower bound of EMF of generator";

      Real Uf_full "field winding voltage actual value";
      Real Xad "D-axis resistance to mutual induction";
      Real Xaq "Q-axis resistance to mutual induction";
      Real X2dt "D-axis subtransient reactance of generator and transformer";
      Real X2qt "Q-axis subtransient reactance of generator and transformer";
      Real Rs "Sum resistance of stator winding and step-up transformer";
      Real Xsf "Leakage reactance of field winding";
      Real Xs1d "D-axis leakage reactance of damping winding";
      Real Xs1q "Q-axis leakage reactance of damping winding";
      Real X1 "interim reactance №1";
      Real X2 "interim reactance №2";
      Real X3 "interim reactance №3";
      Real Ugen "generator full voltage actual value";
      Real Mt_pp "Turbine rotation moment actual value";
      Real Pgen "Generator active power actual value";
      Real Qgen "Generator reactive power actual value";
      Real UdG;
      Real UqG;
      Real IdG;
      Real IqG;
      input Real DeltaIJ;
      input Real Ssys "system slip";
      //------------------------------------------------------------------
      // Integrated Variables
      Real Yr "field winding flow coupling actual value";
      Real Yrd "D-axis damper winding flow coupling actual value";
      Real Yrq "Q-axis damper winding flow coupling actual value";
      Real s "generator slip";
      Real DGi "Generator power angle initial value";
      Real Me "electrical moment";
      Real Yad "D-axis flow coupling of mutual inductance";
      Real Yaq "Q-axis flow coupling of mutual inductance";
      Real iq "Q-axis generator stator winding current actual value";
      Real id "D-axis generator stator winding current actual value";
      Real ir "D-axis generator field winding current actual value";
      Real ird "D-axis generator damper winding current actual value";
      Real irq "Q-axis generator damper winding current actual value";
      Real ud "D-axis generator voltage actual value";
      Real uq "Q-axis generator voltage actual value";
      Real E11d;
      Real E11q;
      Real Xd "D-axis synchronous reactance actual value";
      Real Xq "Q-axis synchronous reactance actual value";
      Real Xs "Leakage reactance actual value";
      Real X1d "D-axis transient reactance actual value";
      Real X2d "D-axis subtransient reactance actual value";
      Real X2q "Q-axis subtransient reactance actual value";
      Real Rf "Active resistance of field winding actual value";
      Real R1d "Active resistance of d-axis damper winding actual value";
      Real R1q "Active resistance of q-axis damper winding actual value";
      Real Tj "Inertia coefficient actual value";
      Real f "frequency";
      parameter Real Ut_pu(fixed=false) "stator voltage, p.u.";
      parameter Real Pg_pu(fixed=false) "Active power, p.u.";
      parameter Real Qg_pu(fixed=false) "Reactive power, p.u.";
      LEPSE.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
          Placement(transformation(extent={{90,-10},{110,10}},
                                                             rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      LEPSE.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
          Placement(transformation(extent={{-110,-10},{-90,10}},
                                                               rotation=0),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      LEPSE.Interfaces.Signal_pin dUtr_pin annotation (
        extent=[-60,66; -40,86],
        layer="icon",
        Placement(transformation(extent={{-64,90},{-44,110}},rotation=0),
            iconTransformation(extent={{-64,90},{-44,110}})));
      LEPSE.Interfaces.Signal_pin dWu_pin annotation (
        extent=[-26,66; -6,86],
        layer="icon",
        Placement(transformation(extent={{-36,90},{-16,110}},rotation=0),
            iconTransformation(extent={{-36,90},{-16,110}})));
      LEPSE.Interfaces.Signal_pin dWf_pin annotation (
        extent=[6,66; 26,86],
        layer="icon",
        Placement(transformation(extent={{-10,90},{10,110}},
                                                           rotation=0),
            iconTransformation(extent={{-10,90},{10,110}})));
      LEPSE.Interfaces.Signal_pin dIf_pin annotation (
        extent=[40,66; 60,86],
        layer="icon",
        Placement(transformation(extent={{18,90},{38,110}},
                                                          rotation=0),
            iconTransformation(extent={{18,90},{38,110}})));
      LEPSE.Interfaces.Signal_pin Ut_pin
        annotation (Placement(transformation(extent={{46,90},{66,110}}),
            iconTransformation(extent={{46,90},{66,110}})));
      LEPSE.Interfaces.Signal_pin Mt_pin annotation (Placement(transformation(
              extent={{-110,-38},{-90,-18}}), iconTransformation(extent={{-110,
                -38},{-90,-18}})));
      LEPSE.Interfaces.Signal_pin slip_pin annotation (Placement(transformation(
              extent={{76,90},{96,110}}), iconTransformation(extent={{76,90},{
                96,110}})));

    initial equation
      // additional variables in p.u.
      Ut_pu = Ut/Ugnom;
      Pg_pu = Pg/Sbaz;
      Qg_pu = Qg/Sbaz;

      // equations of currents, voltages, and flux densities
      s = 0;
      DGi = Dg;
      Yr = PsiR;
      Yrd = PsiRD;
      Yrq = PsiRQ;

      Pg = Pgen;
      Qg=min(Qmax, max(Qmin, Qgen));

      EQ = sqrt((Ut_pu + ((Ra + Rt)*Pg_pu + (Xq + Xt)*Qg_pu)/Ut_pu)^2 + (((Xq + Xt)*Pg_pu - (
          Ra + Rt)*Qg_pu)/Ut_pu)^2);
      Dg = atan((((Xq + Xt)*Pg_pu - (Ra + Rt)*Qg_pu)/Ut_pu)/(Ut_pu + ((Ra + Rt)*Pg_pu + (Xq
           + Xt)*Qg_pu)/Ut_pu));
        //----------------------
      Uq = Ut/Ugnom*cos(Dg);
      Ud = -Ut/Ugnom*sin(Dg);
        //----------------------
      Id = ((Uq - EQ)*(Xq + Xt) - (Ra + Rt)*Ud)/((Ra + Rt)^2 + (Xq + Xt)^2);
      Iq = (-Ud - (Ra + Rt)*Id)/(Xq + Xt);
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

    equation

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
      Tj = Tj_p*Pnom/Sbaz;

      Xd = Xd_p*Sbaz/Pnom*cosfi_nom;
      Xq = Xq_p*Sbaz/Pnom*cosfi_nom;
      Xs = Xs_p*Sbaz/Pnom*cosfi_nom;
      X1d = X1d_p*Sbaz/Pnom*cosfi_nom;
      X2d = X2d_p*Sbaz/Pnom*cosfi_nom;
      X2q = X2q_p*Sbaz/Pnom*cosfi_nom;

      Rf_p = (Xad+Xsf)/Wc/Td0;
      R1d_p = (Xs1d+(1/((1/Xad)+(1/Xsf)+(1/Xs))))/Wc/T2d_p;
      R1q_p = (Xs1q+(1/((1/Xaq)+(1/Xsf))))/Wc/T2q_p;
      Rf = Rf_p;
      R1d = R1d_p;
      R1q = R1q_p;
      //--------------------------------------------------------------------------------
      der(DGi) = Wc*s;

      Uf_full = if (Uf*Xad/Rf + dEr) > Er_max then Er_max*Rf/Xad else if (Uf*Xad
        /Rf + dEr) < Er_min then Er_min*Rf/Xad else Uf + Rf*dEr/Xad;

      der(Yr) = Wc*(Uf_full - Rf*ir);
      der(Yrd) = -Wc*R1d*ird;
      der(Yrq) = -Wc*R1q*irq;
      der(s) = (Mt_pp - Me - 50*s)/Tj;

      //--------------------------------------------------------------------------------

      //--------------------------------------------------------------------------------

      Me = Yad*iq - Yaq*id;
      ir = (Yr - Yad)/Xsf;
      ird = (Yrd - Yad)/Xs1d;
      irq = (Yrq - Yaq)/Xs1q;
      id = ((uq - E11q)*X2qt - Rs*(ud + E11d))/(X2dt*X2qt + Rs^2);
      iq = (-ud - E11d - Rs*id)/X2qt;
      E11d = X3*Yrq;
      E11q = X1*Yr + X2*Yrd;
      Yad = E11q + id*(X2d - Xs);
      Yaq = E11d + iq*(X2q - Xs);
      Ugen = (sqrt(ud^2 + uq^2))*Ugnom;
      dUtr = sqrt(ud^2 + uq^2) - Ut_pu;
      dWu = Wc*Ssys;
      dWf = if UqG <> 0 then atan2(UdG, UqG) else atan2(UdG, 0.001);
      dIf = ir - Ir;
      //----------------------------------------
      Pgen = (uq*iq + ud*id)*Sbaz;
      Qgen = (-uq*id + ud*iq)*Sbaz;
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
      Mt_pp = max(Mtmin, min(Mtmax,Mt_pin.Signal))  "таким хитрым образом выбирается сигнал с регулятора, если он не ограничен Mtmax, Mtmin";
      Ef_pin.Signal = dEr;

      //----to--excitation--system---
      dUtr_pin.Signal = dUtr;
      dWu_pin.Signal = dWu;
      dWf_pin.Signal = dWf;
      dIf_pin.Signal = dIf;
      Ut_pin.Signal = Ut;
      slip_pin.Signal = s;
      connect(dUtr_pin, dUtr_pin) annotation (Line(
          points={{-54,100},{-54,100}},
          color={255,255,0},
          thickness=0.5));

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
              thickness=1),
            Line(
              points={{-58,-28},{-94,-28}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{62,34},{86,58},{86,92}},
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
<p>Infinite bus mashine model. </p>
<p>Модель генератора шин бесконечной мощности. </p>
</html>"));
    end Infinite_bus_Mashine;

    model Equation_of_motion_mashine
     outer SysData sysData;

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
              extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},
                {110,10}})));
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

    model SM_with_AVR_SD

      LEPSE.Interfaces.Pin_v2 inp annotation (
        extent=[78,-4; 98,16],
        layer="icon",
        Placement(transformation(extent={{90,-10},{110,10}},
                                                           rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      parameter Real TgenOff=1000 "Time of generator's disconnection, s";
      parameter Real dTgenOff=10 "Duration of generator's disconnection, s";
      parameter Real Pg=100 "Active power, MW";
      parameter Real Ut=20 "ARV voltage reference value, kV";
      parameter Real Pnom=100 "Nominal maschine active power";
      parameter Real Ugnom=20 "Nominal stator voltage, kV";
      parameter Real Sbaz=1000 "Bazis power, MWA";
      parameter Real Xd_p=1.869 "D-axis synchronous reactance, p.u.";
      parameter Real Xq_p=1.869 "Q-axis synchronous reactance, p.u.";
      parameter Real Xs_p=0.194 "Leakage reactance of stator winding, p.u.";
      parameter Real Tj_p=7 "Inertia coefficient, s";
      parameter Real X2q_p=0.2337 "Q-axis subtransient reactance, p.u.";
      parameter Real X2d_p=0.2337 "D-axis subtransient reactance, p.u.";
      parameter Real X1d_p=0.3016 "D-axis transient reactance, p.u.";
      parameter Real Td0=10 "D-axis transient time constant, s";
      parameter Real T2d_p=0.02 "D-axis subtransient time constant, s";
      parameter Real T2q_p=0.05 "Q-axis subtransient time constant, s";
      parameter Real Sigma=0.0475 "Turbine statism coefficient, p.u.";
      parameter Real TauC_up=0.8 "Time constant of servo motor while valving control, s";
      parameter Real TregOff=50 "Turbine speed regulator off-time, s";
      parameter Real TregOn=1000 "Turbine speed regulator on-time, s";
      parameter Real Mtmax=1.1 "Turbine overloading coefficient, p.u.";
      parameter Real Aimp=1 "Fast turbine valving control amplitude, p.u.";
      parameter Real Mtmin=0 "Turbine minimum-loading coefficient, p.u.";
      parameter Real Timp=1000 "Fast turbine valving control on-time, s";
      parameter Real dTimp=0.2 "Fast turbine valving control duration, s";
      parameter Real TauC_down=5 "Time constant of servo motor after valving control end, s";
      parameter Real TkzOn=1000 "HPP generators dropping on-time, s";
      parameter Real Pg_new=100 "New power of HPP, MW";
      parameter Real Kemax=2.0 "Multiplicity of forcing on, p.u.";
      parameter Real Kemin=-0.6 "Multiplicity of forcing off, p.u.";
      parameter Real K0u=-10 "Voltage deviation control coefficient";
      parameter Real K1u=0 "Voltage derivative control coefficient";
      parameter Real K0w=0 "Frequency deviation control coefficient";
      parameter Real K1if=0 "Rotor current derivative control coefficient";
      parameter Real K1w=0 "Frequency derivative control coefficient";
      parameter Real Uforc=0.85 "Voltage of field forcing input";
      parameter Real Udeforc=0.9 "Voltage of field forcing removing";
      parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
      parameter Real DL0=0;
      parameter Real Tokp=0.05 "The main channel of regulation time constant";
      parameter Real cosfi_nom=0.85 "Nominal maschine power coefficient, p.u.";
      parameter Real n_gen=1 "Number of generators";

      parameter Boolean displayPowerFlow=true "Display power flow";
      SM G(
        pq_table=pq_table,
        TgenOff=TgenOff,
        dTgenOff=dTgenOff,
        Sbaz=Sbaz,
        fbaz=fbaz,
        Pg=Pg,
        Ut=Ut,
        Pnom=Pnom,
        Ugnom=Ugnom,
        cosfi_nom=cosfi_nom,
        Xd_p=Xd_p,
        Xq_p=Xq_p,
        Xs_p=Xs_p,
        X1d_p=X1d_p,
        X2d_p=X2d_p,
        X2q_p=X2q_p,
        Tj_p=Tj_p,
        Td0=Td0,
        T2d_p=T2d_p,
        T2q_p=T2q_p,
        Sigma=Sigma,
        TauC_up=TauC_up,
        TregOff=TregOff,
        TregOn=TregOn,
        Mtmax=Mtmax,
        Mtmin=Mtmin,
        Aimp=Aimp,
        Timp=Timp,
        dTimp=dTimp,
        TauC_down=TauC_down,
        TkzOn=TkzOn,
        Pg_new=Pg_new,
        Kemax=Kemax,
        Kemin=Kemin)
        annotation (Placement(transformation(extent={{-16,-58},{76,40}})));

      parameter Real fbaz=G.sysData.fbaz "Bazic frequency, Hz";
      parameter LEPSE.Data.PQ_CapabilityTable pq_table=LEPSE.Data.TVV_500_2;
      Excitation_systems.Regulators.AVR_SD AVR(
        K0u=K0u,
        K1u=K1u,
        K0w=K0w,
        K1w=K1w,
        K1if=K1if,
        Uforc=Uforc,
        Udeforc=Udeforc,
        Tforcedelay=Tforcedelay,
        DL0=DL0,
        Qgen=G.Qgen,
        Qmax=G.Qmax,
        Qmin=G.Qmin,
        inService=inService) annotation (Placement(transformation(extent={{
                -128,-30},{-50,46}})));
      parameter Boolean inService=true "Excitation limiter condition";
    equation

      connect(G.Stator_pin, inp) annotation (Line(points={{76,-9},{76,-10},{86,
              -10},{86,0},{100,0}}, color={28,108,200}));

      connect(G.Ef_pin, AVR.out_pin) annotation (Line(
          points={{-16,-9},{-16,-10},{-44,-10},{-44,4.96},{-49.675,4.96}},
          color={255,255,0},
          thickness=0.5));
      connect(G.Ut_pin, AVR.Ut_pin) annotation (Line(
          points={{55.76,40},{55.76,68},{-142,68},{-142,-23.92},{-128,-23.92}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dIf_pin, AVR.dif1_pin) annotation (Line(
          points={{42.88,40},{42.88,64},{-140,64},{-140,-16.32},{-128.325,-16.32}},
          color={255,255,0},
          thickness=0.5));

      connect(G.dWf_pin, AVR.dfU_pin) annotation (Line(
          points={{30,40},{30,60},{-138,60},{-138,-7.2},{-128.325,-7.2}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dWu_pin, AVR.dfsys_pin) annotation (Line(
          points={{18.04,40},{18.04,56},{-136,56},{-136,4.2},{-128.325,4.2}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dUtr_pin, AVR.dV_pin) annotation (Line(
          points={{5.16,40},{5.16,52},{-134,52},{-134,27},{-128.325,27}},
          color={255,255,0},
          thickness=0.5));
      connect(AVR.dV1_pin, AVR.dV_pin) annotation (Line(
          points={{-128.325,15.6},{-128.325,27}},
          color={255,255,0},
          thickness=0.5));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-140,-100},{100,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Text(extent={{-78,96},{74,70}},
              textColor={0,0,0},
              textString="%name"),
            Line(points={{94,0},{60,0}}, color={0,0,0},
              thickness=1),
            Text(
              textString=DynamicSelect("P MW", String(G.Pgen, significantDigits=3) + " MW"),
              visible=displayPowerFlow,
              extent={{-96,-70},{102,-108}},
              textColor={0,168,6}),
            Text(
              textString=DynamicSelect("Q MVar", String(G.Qgen, significantDigits=3) + " MVar"),
              visible=displayPowerFlow,
              extent={{-94,-100},{104,-138}},
              textColor={102,44,145}),
            Line(
              points={{-52,20},{-52,-20},{-20,-40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-52,20},{-20,40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-20,40},{-20,-40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-20,0},{20,0}},
              color={0,0,0},
              thickness=1),
            Ellipse(
              extent={{20,20},{60,-20}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None),
            Ellipse(
              extent={{-5,6},{5,-6}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None,
              closure=EllipseClosure.None,
              startAngle=0,
              endAngle=180,
              origin={35,-8.88178e-16},
              rotation=180),
            Ellipse(
              extent={{-5,6},{5,-6}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None,
              closure=EllipseClosure.None,
              startAngle=0,
              endAngle=180,
              origin={45,0},
              rotation=360),
            Line(
              points={{-52,0},{-78,0}},
              color={0,0,0},
              thickness=1),
            Rectangle(
              extent={{-80,60},{80,-60}},
              lineColor={28,108,200},
              lineThickness=1,
              pattern=LinePattern.Dash)},
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
<p>Generator model with automatic excitation control SD. </p>
<p>Модель синхронного генератора с подключенным АРВ сильного действия. </p>
</html>"),
        Diagram(coordinateSystem(extent={{-140,-100},{100,100}})));
    end SM_with_AVR_SD;

    model SM_without_exciter
      outer SysData sysData;

      // PQ-diagram parameter
      parameter LEPSE.Data.PQ_CapabilityTable
      pq_table = LEPSE.Data.TVV_500_2;

      parameter Real TgenOff=1000 "Time of generator's disconnection, s"
       annotation(Dialog(tab="General"));
      parameter Real dTgenOff=10 "Duration of generator's disconnection, s"
       annotation(Dialog(tab="General"));
      parameter Real Kd=0 "damping coefficient"
      annotation(Dialog(tab="Synchronous machine"));

      //------------------------------------------------------------------------------------
      parameter Real Sbaz=sysData.Sbaz "Bazic power, MWA"
      annotation(Dialog(tab="General"));
      parameter Real fbaz=sysData.fbaz "Bazic frequency, Hz"
      annotation(Dialog(tab="General"));
      parameter Real Pg=500 "Active power, MW"
      annotation(Dialog(tab="General"));
      parameter Real Qg(fixed=false) "Reactive power, MVAR";
      parameter Real Ut=20 "ARV voltage reference value, kV"
      annotation(Dialog(tab="General"));
      parameter Real Pnom=500 "Nominal maschine active power, MW"
      annotation(Dialog(tab="General"));
      parameter Real Ugnom=20 "Nominal stator voltage, kV"
      annotation(Dialog(tab="General"));
      parameter Real cosfi_nom=0.85 "Nominal maschine power coefficient, p.u."
      annotation(Dialog(tab="General"));
      parameter Real Ignom(fixed=false) "stator nomunal current, kA";

       // Limitation variables
      Real Qmax "Текущий предел перевозбуждения, МВар";
      Real Qmin "Текущий предел недовозбуждения, МВар";

      // Вспомогательные переменные для интерполятора (требование синтаксиса Modelica)
      Real P_clipped_max "Срезанная P для интерполяции Qmax";
      Real P_clipped_min "Срезанная P для интерполяции Qmin";
      Integer i_max_dummy;
      Integer i_min_dummy;

      //------------------------------------------------------------------------------------
      parameter Real Xd_p=1.869 "D-axis synchronous reactance, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Xq_p=1.869 "Q-axis synchronous reactance, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Xs_p=0.194 "Leakage reactance of stator winding, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real X1d_p=0.3016 "D-axis transient reactance, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real X2d_p=0.2337 "D-axis subtransient reactance, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real X2q_p=0.2337 "Q-axis subtransient reactance, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      Real Rf_p "Active resistance of field winding, p.u.";
      Real R1d_p "Active resistance of d-axis damper winding, p.u.";
      Real R1q_p "Active resistance of q-axis damper winding, p.u.";
      parameter Real Tj_p=7 "Inertia coefficient, s"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Td0=10 "D-axis transient time constant, s"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real T2d_p=0.02 "D-axis subtransient time constant, s"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real T2q_p=0.05 "Q-axis subtransient time constant, s"
      annotation(Dialog(tab="Synchronous machine"));

      parameter Real Sigma=0.0475 "Turbine statism coefficient, p.u."
      annotation(Dialog(tab="Turbine"));
      parameter Real TauC_up=0.8 "Time constant of servo motor while valving control, s"
      annotation(Dialog(tab="Turbine"));
      parameter Real TregOff=50 "Turbine speed regulator off-time, s"
      annotation(Dialog(tab="Turbine"));

      parameter Real TregOn=1000 "Turbine speed regulator on-time, s"
      annotation(Dialog(tab="Turbine"));
      parameter Real Mtmax=1.1 "Turbine overloading coefficient, p.u."
      annotation(Dialog(tab="Turbine"));
      parameter Real Mtmin=0 "Turbine minimum-loading coefficient, p.u."
      annotation(Dialog(tab="Turbine"));

      parameter Real Aimp=1 "Fast turbine valving control amplitude, p.u."
      annotation(Dialog(tab="Turbine"));
      parameter Real Timp=1000 "Fast turbine valving control on-time, s"
      annotation(Dialog(tab="Turbine"));
      parameter Real dTimp=0.2 "Fast turbine valving control duration, s"
      annotation(Dialog(tab="Turbine"));
      parameter Real TauC_down=5 "Time constant of servo motor after valving control end, s"
      annotation(Dialog(tab="Turbine"));

      parameter Real TkzOn=1000 "Generators dropping on-time, s"
      annotation(Dialog(tab="General"));
      parameter Real Pg_new=100 "New power of power plant, MW"
      annotation(Dialog(tab="General"));

      //------------------------------------------------------------------------------------
      Real dUtr "voltage deviation";
      Real dWu "frequency deviation";
      Real dIf "current deviation";
      Real dWf "frequency deviation";
      Real Er "exciter electromotive force";
      constant Real PI=4*atan(1) "PI-constant";
      parameter Real Wc=2*PI*fbaz "frequency of electric current fluctuations";
      parameter Real Xt=0.0 "resistance of step-up transformer and line to IB";

      // Parameters of power system elements
      constant Real Ra=0 "active resistance of generator stator winding";
      constant Real Rt=0 "active resistance of transformer";
      parameter Real EQ(fixed=false) "Auxiliaire EMF of salient-pole generator";
      parameter Real Dg(fixed=false) "Generator power angle";
      parameter Real Uq(fixed=false) "D-axis ARV voltage reference value";
      parameter Real Ud(fixed=false) "Q-axis ARV voltage reference value";
      parameter Real Id(fixed=false) "D-axis stator current value";
      parameter Real Iq(fixed=false) "Q-axis stator current value";
      parameter Real Eiq(fixed=false) "synchronous stator EMF";
      parameter Real Ir(fixed=false) "field winding current";
      parameter Real Uf(fixed=false) "field winding voltage";
      parameter Real Eq(fixed=false) "EMF of generator";
      parameter Real Er0(fixed=false) "EMF of generator initial value";
      parameter Real PsiR(fixed=false) "field winding flow coupling initial value";
      parameter Real PsiRD(fixed=false) "D-axis damper winding flow coupling initial value";
      parameter Real PsiRQ(fixed=false) "Q-axis damper winding flow coupling initial value";

      Real Uf_full "field winding voltage actual value";
      Real Xad "D-axis resistance to mutual induction";
      Real Xaq "Q-axis resistance to mutual induction";
      Real X2dt "D-axis subtransient reactance of generator and transformer";
      Real X2qt "Q-axis subtransient reactance of generator and transformer";
      Real Rs "Sum resistance of stator winding and step-up transformer";
      Real Xsf "Leakage reactance of field winding";
      Real Xs1d "D-axis leakage reactance of damping winding";
      Real Xs1q "Q-axis leakage reactance of damping winding";
      Real X1 "interim reactance в„–1";
      Real X2 "interim reactance в„–2";
      Real X3 "interim reactance в„–3";
      Real Ugen "generator full voltage actual value, kV";
      Real Igen "generator stator current value, kA";
      parameter Real Mu0(fixed=false) "Turbine rotation moment initial value";
      Real Ro;
      Real Mu "Turbine valve position / moment";
      Real Mt_pp "Turbine rotation moment actual value";
      Real Pgen "Generator active power actual value";
      Real Qgen "Generator reactive power actual value";
      Real UdG;
      Real UqG;
      Real IdG;
      Real IqG;
      input Real DeltaIJ;
      input Real Ssys "system slip";

      //------------------------------------------------------------------
      // Integrated Variables
      Real Yr "field winding flow coupling actual value";
      Real Yrd "D-axis damper winding flow coupling actual value";
      Real Yrq "Q-axis damper winding flow coupling actual value";
      Real s "generator slip";
      Real DGi "Generator power angle initial value";
      Real Me "electrical moment";
      Real Yad "D-axis flow coupling of mutual inductance";
      Real Yaq "Q-axis flow coupling of mutual inductance";
      Real iq "Q-axis generator stator winding current actual value";
      Real id "D-axis generator stator winding current actual value";
      Real ir "D-axis generator field winding current actual value";
      Real ird "D-axis generator damper winding current actual value";
      Real irq "Q-axis generator damper winding current actual value";
      Real ud "D-axis generator voltage actual value";
      Real uq "Q-axis generator voltage actual value";
      Real E11d "EMF, connected with d-axis damper winding";
      Real E11q "EMF, connected with q-axis damper winding";
      Real TauC "Time constant of servo motor actual value";
      Real MT_MAX "Turbine overloading coefficient actual value";
      Real MT_MIN "Turbine minimum-loading coefficient actual value";
      Real Xd "D-axis synchronous reactance actual value";
      Real Xq "Q-axis synchronous reactance actual value";
      Real Xs "Leakage reactance actual value";
      Real X1d "D-axis transient reactance actual value";
      Real X2d "D-axis subtransient reactance actual value";
      Real X2q "Q-axis subtransient reactance actual value";
      Real Rf "Active resistance of field winding actual value";
      Real R1d "Active resistance of d-axis damper winding actual value";
      Real R1q "Active resistance of q-axis damper winding actual value";
      Real Tj "Inertia coefficient actual value";
      Real f "frequency";
      parameter Real Ut_pu(fixed=false) "stator voltage, p.u.";
      parameter Real Pg_pu(fixed=false) "Active power, p.u.";
      parameter Real Qg_pu(fixed=false) "Reactive power, p.u.";

      LEPSE.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
          Placement(transformation(extent={{90,-10},{110,10}},
                                                             rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      LEPSE.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
          Placement(transformation(extent={{-110,-10},{-90,10}},
                                                               rotation=0),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      LEPSE.Interfaces.Signal_pin dUtr_pin annotation (
        extent=[-60,66; -40,86],
        layer="icon",
        Placement(transformation(extent={{-64,90},{-44,110}},rotation=0),
            iconTransformation(extent={{-64,90},{-44,110}})));
      LEPSE.Interfaces.Signal_pin dWu_pin annotation (
        extent=[-26,66; -6,86],
        layer="icon",
        Placement(transformation(extent={{-36,90},{-16,110}},rotation=0),
            iconTransformation(extent={{-36,90},{-16,110}})));
      LEPSE.Interfaces.Signal_pin dWf_pin annotation (
        extent=[6,66; 26,86],
        layer="icon",
        Placement(transformation(extent={{-10,90},{10,110}},
                                                           rotation=0),
            iconTransformation(extent={{-10,90},{10,110}})));
      LEPSE.Interfaces.Signal_pin dIf_pin annotation (
        extent=[40,66; 60,86],
        layer="icon",
        Placement(transformation(extent={{18,90},{38,110}},
                                                          rotation=0),
            iconTransformation(extent={{18,90},{38,110}})));
      LEPSE.Interfaces.Signal_pin Ut_pin
        annotation (Placement(transformation(extent={{46,90},{66,110}}),
            iconTransformation(extent={{46,90},{66,110}})));
      LEPSE.Interfaces.Signal_pin Er0_pin annotation (Placement(transformation(
              extent={{70,90},{90,110}}), iconTransformation(extent={{70,90},{
                90,110}})));
      LEPSE.Interfaces.Signal_pin Ugen_pin annotation (Placement(transformation(
              extent={{-90,90},{-70,110}}), iconTransformation(extent={{-90,90},
                {-70,110}})));
      LEPSE.Interfaces.Signal_pin dIg_pin annotation (Placement(transformation(
              extent={{94,90},{114,110}}), iconTransformation(extent={{94,90},{
                114,110}})));
    initial equation
      // additional variables in p.u.
      Ut_pu = Ut/Ugnom;
      Pg_pu = Pg/Sbaz;
      Qg_pu = Qg/Sbaz;
      Ignom = Pnom/cosfi_nom/sqrt(3)/Ugnom;

      Pg=Pgen;
      Qg=min(Qmax, max(Qmin, Qgen));

      // equations of currents, voltages, and flux densities
      s = 0;

      EQ = sqrt((Ut_pu + ((Ra + Rt)*Pg_pu + (Xq + Xt)*Qg_pu)/Ut_pu)^2 + (((Xq + Xt)*Pg_pu - (Ra + Rt)*Qg_pu)/Ut_pu)^2);
      Dg = atan((((Xq + Xt)*Pg_pu - (Ra + Rt)*Qg_pu)/Ut_pu)/(Ut_pu + ((Ra + Rt)*Pg_pu + (Xq + Xt)*Qg_pu)/Ut_pu));

      Uq = Ut_pu*cos(Dg);
      Ud = -Ut_pu*sin(Dg);

      Id = ((Uq - EQ)*(Xq + Xt) - (Ra + Rt)*Ud)/((Ra + Rt)^2 + (Xq + Xt)^2);
      Iq = (-Ud - (Ra + Rt)*Id)/(Xq + Xt);
      Mu0 = EQ*Iq;
      Mu = Mu0;

      Eiq = Uq - Id*(Xs + Xt) + (Ra + Rt)*Iq;
      Ir = -Id + Eiq/Xad;
      Uf = Ir*Rf;
      Eq = Ir*Xad;
      Er0 = Eq;
      PsiR = Eiq + Xsf*Ir;
      PsiRQ = -Ud - Iq*(Xs + Xt) - Id*(Ra + Rt);
      PsiRD = Eiq;

      DGi = Dg;
      Yr = PsiR;
      Yrd = PsiRD;
      Yrq = PsiRQ;

    equation

      // 1. ЗАЩИТА ОТ ЭКСТРАПОЛЯЦИИ (Ограничиваем Pgen границами таблиц, чтобы математика не улетала)
      P_clipped_max = max(pq_table.P_max[1], min(Pgen, pq_table.P_max[end]));
      P_clipped_min = max(pq_table.P_min[1], min(Pgen, pq_table.P_min[end]));

       // 2. АВТОМАТИЧЕСКАЯ ИНТЕРПОЛЯЦИЯ НА КАЖДОМ ШАГЕ РАСЧЕТА
      // Функция interpolate возвращает кортеж (значение_Y, индекс_интервала)
      (Qmax, i_max_dummy) = Modelica.Math.Vectors.interpolate(
        pq_table.P_max,
        pq_table.Qmax,
        P_clipped_max);

      (Qmin, i_min_dummy) = Modelica.Math.Vectors.interpolate(
        pq_table.P_min,
        pq_table.Qmin,
        P_clipped_min);

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
      Tj = if time < TkzOn then Tj_p*Pnom/Sbaz else Tj_p*Pnom/Sbaz*Pg_new/Pg;

      Xd = if time < TkzOn then Xd_p*Sbaz/Pnom*cosfi_nom else Xd_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
      Xq = if time < TkzOn then Xq_p*Sbaz/Pnom*cosfi_nom else Xq_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
      Xs = if time < TkzOn then Xs_p*Sbaz/Pnom*cosfi_nom else Xs_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
      X1d = if time < TkzOn then X1d_p*Sbaz/Pnom*cosfi_nom else X1d_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
      X2d = if time < TkzOn then X2d_p*Sbaz/Pnom*cosfi_nom else X2d_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
      X2q = if time < TkzOn then X2q_p*Sbaz/Pnom*cosfi_nom else X2q_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;

      Rf_p = (Xad+Xsf)/Wc/Td0;
      R1d_p = (Xs1d+(1/((1/Xad)+(1/Xsf)+(1/Xs))))/Wc/T2d_p;
      R1q_p = (Xs1q+(1/((1/Xaq)+(1/Xsf))))/Wc/T2q_p;
      Rf = if time < TkzOn then Rf_p else Rf_p*Pg/Pg_new;
      R1d = if time < TkzOn then R1d_p else R1d_p*Pg/Pg_new;
      R1q = if time < TkzOn then R1q_p else R1q_p*Pg/Pg_new;
      //--------------------------------------------------------------------------------
      der(DGi) = Wc*s;

      Uf_full = Rf*Er/Xad;

      der(Yr) = Wc*(Uf_full - Rf*ir);
      der(Yrd) = -Wc*R1d*ird;
      der(Yrq) = -Wc*R1q*irq;
      der(s) = (Mt_pp - Me - Kd*s)/Tj;

      Ro = if time >= Timp and time < Timp + dTimp then -Aimp else -Mu + Mu0 - s
        /Sigma;

      TauC = if time < Timp + dTimp then TauC_up else TauC_down;

      der(Mu) = if time >= TregOff and time < TregOn then Ro/10e6 else Ro/TauC;
      //--------------------------------------------------------------------------------
      MT_MIN = if time < TkzOn then Mtmin*Pg_pu else Pg_new/Sbaz - 0.01;
      MT_MAX = if time < TkzOn then Mtmax*Pg_pu else Pg_new/Sbaz + 0.01;

      Mt_pp = if Mu >= MT_MIN and Mu <= MT_MAX then Mu else if Mu > MT_MAX then
        MT_MAX else MT_MIN;
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
      Ugen = (sqrt(ud^2 + uq^2))*Ugnom;
      Igen = (sqrt(IqG^2 + IdG^2))*Sbaz/sqrt(3)/Ugnom;
      dUtr = sqrt(ud^2 + uq^2) - Ut_pu;
      dWu = Wc*Ssys;
      dWf = if UqG <> 0.0 then atan2(UdG, UqG) else atan2(UdG, 0.001);
      dIf = ir - Ir;
      //----------------------------------------
      Pgen = (uq*iq + ud*id)*Sbaz;
      Qgen = (-uq*id + ud*iq)*Sbaz;
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
      Er = Ef_pin.Signal;

      //----to--excitation--system---
      dUtr_pin.Signal = dUtr;
      dWu_pin.Signal = dWu;
      dWf_pin.Signal = dWf;
      dIf_pin.Signal = dIf;
      Ut_pin.Signal = Ut_pu;
      Er0_pin.Signal = Er0;
      Ugen_pin.Signal = sqrt(ud^2 + uq^2);
      dIg_pin.Signal = sqrt(IqG^2 + IdG^2) - sqrt(Id^2 + Iq^2);
      connect(dUtr_pin, dUtr_pin) annotation (Line(
          points={{-54,100},{-54,100}},
          color={255,255,0},
          thickness=0.5));

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
              points={{-66,0},{-94,0}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{96,0},{70,0}},
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
              points={{28,62},{28,94}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{62,32},{80,58},{80,92}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-60,30},{-80,58},{-80,92}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{70,12},{104,58},{104,92}},
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
<p>Synchronous generator without exciter model. </p>
<p>Модель синхронного генератора с исключенным возбудителем. </p>
</html>"));
    end SM_without_exciter;

    model SM_with_exciter_and_AVR_SD

      LEPSE.Interfaces.Pin_v2 inp annotation (
        extent=[78,-4; 98,16],
        layer="icon",
        Placement(transformation(extent={{90,-10},{110,10}},
                                                           rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      parameter Real TgenOff=1000 "Time of generator's disconnection, s"
      annotation(Dialog(tab="General"));
      parameter Real dTgenOff=10 "Duration of generator's disconnection, s"
      annotation(Dialog(tab="General"));
      parameter Real Pg=100 "Active power, MW"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Ut=20 "ARV voltage reference value, kV"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Pnom=100 "Nominal maschine active power"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Ugnom=20 "Nominal stator voltage, kV"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Sbaz=1000 "Bazis power, MWA"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Xd_p=1.869 "D-axis synchronous reactance, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Xq_p=1.869 "Q-axis synchronous reactance, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Xs_p=0.194 "Leakage reactance of stator winding, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real X1d_p=0.3016 "D-axis transient reactance, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real X2q_p=0.2337 "Q-axis subtransient reactance, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real X2d_p=0.2337 "D-axis subtransient reactance, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Tj_p=7 "Inertia coefficient, s"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Td0=10 "D-axis transient time constant, s"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real T2d_p=0.02 "D-axis subtransient time constant, s"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real T2q_p=0.05 "Q-axis subtransient time constant, s"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Sigma=0.0475 "Turbine statism coefficient, p.u."
      annotation(Dialog(tab="Turbine"));
      parameter Real TauC_up=0.8 "Time constant of servo motor while valving control, s"
      annotation(Dialog(tab="Turbine"));
      parameter Real TregOff=50 "Turbine speed regulator off-time, s"
      annotation(Dialog(tab="Turbine"));
      parameter Real TregOn=1000 "Turbine speed regulator on-time, s"
      annotation(Dialog(tab="Turbine"));
      parameter Real Mtmax=1.1 "Turbine overloading coefficient, p.u."
      annotation(Dialog(tab="Turbine"));
      parameter Real Aimp=1 "Fast turbine valving control amplitude, p.u."
      annotation(Dialog(tab="Turbine"));
      parameter Real Mtmin=0 "Turbine minimum-loading coefficient, p.u."
      annotation(Dialog(tab="Turbine"));
      parameter Real Timp=1000 "Fast turbine valving control on-time, s"
      annotation(Dialog(tab="Turbine"));
      parameter Real dTimp=0.2 "Fast turbine valving control duration, s"
      annotation(Dialog(tab="Turbine"));
      parameter Real TauC_down=5 "Time constant of servo motor after valving control end, s"
      annotation(Dialog(tab="Turbine"));
      parameter Real TkzOn=1000 "Generators dropping on-time, s"
      annotation(Dialog(tab="General"));
      parameter Real Pg_new=100 "New power of HPP, MW"
      annotation(Dialog(tab="General"));
      parameter Real Kemax=2.0 "Multiplicity of forcing on, p.u."
      annotation(Dialog(tab="Exciter"));
      parameter Real Kemin=-0.6 "Multiplicity of forcing off, p.u."
      annotation(Dialog(tab="Exciter"));
      parameter Real K0u=-10 "Voltage deviation control coefficient"
      annotation(Dialog(tab="AVR"));
      parameter Real K1u=0 "Voltage derivative control coefficient"
      annotation(Dialog(tab="AVR"));
      parameter Real K0w=0 "Frequency deviation control coefficient"
      annotation(Dialog(tab="AVR"));
      parameter Real K1if=0 "Rotor current derivative control coefficient"
      annotation(Dialog(tab="AVR"));
      parameter Real K1w=0 "Frequency derivative control coefficient"
      annotation(Dialog(tab="AVR"));
      parameter Real Uforc=0.85 "Voltage of field forcing input"
      annotation(Dialog(tab="Forcing"));
      parameter Real Udeforc=0.9 "Voltage of field forcing removing"
      annotation(Dialog(tab="Forcing"));
      parameter Real Tforcedelay=0.1 "Delay of field forcing removing"
      annotation(Dialog(tab="Forcing"));
      parameter Real DL0=0
      annotation(Dialog(tab="AVR"));
      parameter Real Tokp=0.05 "The main channel of regulation time constant"
      annotation(Dialog(tab="AVR"));
      parameter Real cosfi_nom=0.85 "Nominal maschine power coefficient, p.u."
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real n_gen=1 "Number of generators"
      annotation(Dialog(tab="General"));

      parameter Boolean displayPowerFlow=true "Display power flow"
      annotation(Dialog(tab="General"));

      parameter Real fbaz=G.sysData.fbaz "Bazic frequency, Hz"
       annotation(Dialog(tab="General"));
      parameter LEPSE.Data.PQ_CapabilityTable pq_table=LEPSE.Data.TVV_500_2
        annotation (Dialog(tab="Synchronous machine"));
      Excitation_systems.Regulators.AVR_SD AVR(
        K0u=K0u,
        K1u=K1u,
        K0w=K0w,
        K1w=K1w,
        K1if=K1if,
        Uforc=Uforc,
        Udeforc=Udeforc,
        Tforcedelay=Tforcedelay,
        DL0=DL0,
        Umax=Umax,
        Umin=Umin,
        Tokp=Tokp,
        Qgen=G.Qgen,
        Qmax=G.Qmax,
        Qmin=G.Qmin,
        inService=inService,
        inService_1=inService_1)
        annotation (Placement(transformation(extent={{-174,-32},{-96,44}})));
      parameter Boolean inService=true "Reactive power limiter condition"
      annotation(Dialog(tab="AVR"));
      Excitation_systems.Exciters.Exciter exciter(
        Te=Te,
        Kemax=Kemax,
        Kemin=Kemin,
        selfExcitation=selfExcitation,
        Kig_exc=Kig_exc,
        Kif_exc=Kif_exc,
        Ku_exc=Ku_exc)
        annotation (Placement(transformation(extent={{-78,-20},{-24,18}})));
      SM_without_exciter G(
        TgenOff=TgenOff,
        dTgenOff=dTgenOff,
        Kd=Kd,
        Sbaz=Sbaz,
        fbaz=fbaz,
        Pg=Pg,
        Ut=Ut,
        Pnom=Pnom,
        Ugnom=Ugnom,
        cosfi_nom=cosfi_nom,
        Xd_p=Xd_p,
        Xq_p=Xq_p,
        Xs_p=Xs_p,
        X1d_p=X1d_p,
        X2d_p=X2d_p,
        X2q_p=X2q_p,
        Tj_p=Tj_p,
        Td0=Td0,
        T2d_p=T2d_p,
        T2q_p=T2q_p,
        Sigma=Sigma,
        TauC_up=TauC_up,
        TregOff=TregOff,
        TregOn=TregOn,
        Mtmax=Mtmax,
        Mtmin=Mtmin,
        Aimp=Aimp,
        Timp=Timp,
        dTimp=dTimp,
        TauC_down=TauC_down,
        TkzOn=TkzOn,
        Pg_new=Pg_new)
        annotation (Placement(transformation(extent={{-18,-46},{74,46}})));
      parameter Real Te=0.02 "Exciter time constant, s"
      annotation(Dialog(tab="Exciter"));
      parameter Boolean selfExcitation=true "Sign of self‑excitation (dependence on Ut)"
      annotation(Dialog(tab="Exciter"));
      parameter Real Umax=6 "AVR upper limit"
      annotation(Dialog(tab="AVR"));
      parameter Real Umin=-6 "AVR lower limit"
      annotation(Dialog(tab="AVR"));
      parameter Boolean inService_1=true "AVR_signal limiter condition"
      annotation(Dialog(tab="AVR"));
      parameter Real Kd=0 "damping coefficient"
      annotation(Dialog(tab="Synchronous machine"));
      parameter Real Kig_exc=1.0
      annotation(Dialog(tab="Exciter"));
      parameter Real Kif_exc=1.0
      annotation(Dialog(tab="Exciter"));
      parameter Real Ku_exc=1.0
      annotation(Dialog(tab="Exciter"));
    equation

      connect(AVR.dV1_pin, AVR.dV_pin) annotation (Line(
          points={{-174.325,13.6},{-174.325,25}},
          color={255,255,0},
          thickness=0.5));
      connect(exciter.dEr_pin, AVR.out_pin) annotation (Line(
          points={{-78,3.94},{-92,3.94},{-92,2.96},{-95.675,2.96}},
          color={255,255,0},
          thickness=0.5));
      connect(exciter.Er_pin, G.Ef_pin) annotation (Line(
          points={{-24,-1},{-24,0},{-18,0}},
          color={255,255,0},
          thickness=0.5));
      connect(G.Stator_pin, inp) annotation (Line(points={{74,0},{100,0}},
                           color={28,108,200}));

      connect(G.dIg_pin, exciter.dIg_pin) annotation (Line(
          points={{75.84,46},{76,46},{76,54},{-84,54},{-84,8.88},{-78,8.88}},
          color={255,255,0},
          thickness=0.5));
      connect(G.Er0_pin, exciter.Er0_pin) annotation (Line(
          points={{64.8,46},{64.8,56},{-86,56},{-86,-1},{-78,-1}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dIf_pin, exciter.dIf_pin) annotation (Line(
          points={{40.88,46},{40.88,58},{-88,58},{-88,-11.26},{-78,-11.26}},
          color={255,255,0},
          thickness=0.5));
      connect(G.Ugen_pin, exciter.Ut_pin) annotation (Line(
          points={{-8.8,46},{-80,46},{-80,22},{-82,22},{-82,-5.56},{-78,-5.56}},
          color={255,255,0},
          thickness=0.5));
      connect(G.Ut_pin, AVR.Ut_pin) annotation (Line(
          points={{53.76,46},{53.76,62},{-180,62},{-180,-25.92},{-174,-25.92}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dUtr_pin, AVR.dV_pin) annotation (Line(
          points={{3.16,46},{3.16,60},{-176,60},{-176,48},{-178,48},{-178,25},{-174.325,
              25}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dWf_pin, AVR.dfU_pin) annotation (Line(
          points={{28,46},{28,64},{-182,64},{-182,-9.2},{-174.325,-9.2}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dIf_pin, AVR.dif1_pin) annotation (Line(
          points={{40.88,46},{40.88,58},{-88,58},{-88,-38},{-178,-38},{-178,-18.32},
              {-174.325,-18.32}},
          color={255,255,0},
          thickness=0.5));
      connect(G.dWu_pin, AVR.dfsys_pin) annotation (Line(
          points={{16.04,46},{16.04,66},{-184,66},{-184,-12},{-178,-12},{-178,2.2},{
              -174.325,2.2}},
          color={255,255,0},
          thickness=0.5));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-180,-100},{100,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Text(extent={{-78,96},{74,70}},
              textColor={0,0,0},
              textString="%name"),
            Line(points={{94,0},{60,0}}, color={0,0,0},
              thickness=1),
            Text(
              textString=DynamicSelect("P MW", String(G.Pgen, significantDigits=3) + " MW"),
              visible=displayPowerFlow,
              extent={{-96,-70},{102,-108}},
              textColor={0,168,6}),
            Text(
              textString=DynamicSelect("Q MVar", String(G.Qgen, significantDigits=3) + " MVar"),
              visible=displayPowerFlow,
              extent={{-94,-100},{104,-138}},
              textColor={102,44,145}),
            Line(
              points={{-52,20},{-52,-20},{-20,-40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-52,20},{-20,40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-20,40},{-20,-40}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-20,0},{20,0}},
              color={0,0,0},
              thickness=1),
            Ellipse(
              extent={{20,20},{60,-20}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None),
            Ellipse(
              extent={{-5,6},{5,-6}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None,
              closure=EllipseClosure.None,
              startAngle=0,
              endAngle=180,
              origin={35,-8.88178e-16},
              rotation=180),
            Ellipse(
              extent={{-5,6},{5,-6}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None,
              closure=EllipseClosure.None,
              startAngle=0,
              endAngle=180,
              origin={45,0},
              rotation=360),
            Line(
              points={{-52,0},{-78,0}},
              color={0,0,0},
              thickness=1),
            Rectangle(
              extent={{-80,60},{80,-60}},
              lineColor={28,108,200},
              lineThickness=1,
              pattern=LinePattern.Dash)},
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
<p>Generator model with automatic excitation (SD) control. </p>
<p>Модель синхронного генератора с подключенным АРВ сильного действия. </p>
</html>"),
        Diagram(coordinateSystem(extent={{-180,-100},{100,100}})));
    end SM_with_exciter_and_AVR_SD;

    model Infinite_bus_Mashine_simple
      outer SysData sysData;

      //------------------------------------------------------------------------------------
      parameter Real Sbaz=sysData.Sbaz "Bazis power, MWA";
      parameter Real fbaz=sysData.fbaz "Bazic frequency, Hz";
      parameter Real Pg(fixed=false) "Active power";
      parameter Real Qg(fixed=false) "Reactive power";
      parameter Real Ut=330 "ARV voltage reference value";
      parameter Real Pnom=10000 "Set PV-generator power";
      parameter Real Ugnom=330 "Nominal voltage";
      parameter Real cosfi_nom=0.9 "Nominal maschine power coefficient, p.u.";

      parameter Real Qmax=9999 "Текущий предел перевозбуждения, МВар";
      parameter Real Qmin=-9999 "Текущий предел недовозбуждения, МВар";

      //------------------------------------------------------------------------------------

      parameter Real X1d_p=0.05 "D-axis transient reactance";

      parameter Real Tj_p=7 "Inertia coefficient";

      parameter Real Mtmax=1.1 "Turbine overloading coefficient";
      parameter Real Mtmin=0 "Turbine minimum-loading coefficient";

      //------------------------------------------------------------------------------------
      constant Real PI=4*atan(1) "PI-constant";
      parameter Real Wc=2*PI*fbaz "frequency of electric current fluctuations";

      // Parameters of power system elements
      parameter Real EQ(fixed=false) "Auxiliaire EMF of salient-pole generator";
      parameter Real Dg(fixed=false) "Generator power angle";
      parameter Real Uq(fixed=false) "D-axis ARV voltage reference value";
      parameter Real Ud(fixed=false) "Q-axis ARV voltage reference value";
      parameter Real Id(fixed=false) "D-axis stator current value";
      parameter Real Iq(fixed=false) "Q-axis stator current value";

      Real Ugen "generator full voltage actual value";
      Real Igen "generator stator current value, kA";
      Real Mt_pp "Turbine rotation moment actual value";
      Real Pgen "Generator active power actual value";
      Real Qgen "Generator reactive power actual value";
      Real UdG;
      Real UqG;
      Real IdG;
      Real IqG;
      input Real DeltaIJ;
      input Real Ssys "system slip";
      //------------------------------------------------------------------
      // Integrated Variables

      Real s "generator slip";
      Real DGi "Generator power angle initial value";
      Real Me "electrical moment";
      Real iq "Q-axis generator stator winding current actual value";
      Real id "D-axis generator stator winding current actual value";
      Real ud "D-axis generator voltage actual value";
      Real uq "Q-axis generator voltage actual value";
      Real X1d "D-axis transient reactance actual value";

      Real Tj "Inertia coefficient actual value";
      Real f "frequency";
      parameter Real Ut_pu(fixed=false) "stator voltage, p.u.";
      parameter Real Pg_pu(fixed=false) "Active power, p.u.";
      parameter Real Qg_pu(fixed=false) "Reactive power, p.u.";
      LEPSE.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
          Placement(transformation(extent={{90,-10},{110,10}},
                                                             rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      LEPSE.Interfaces.Signal_pin Mt_pin annotation (Placement(transformation(
              extent={{-112,-10},{-92,10}}), iconTransformation(extent={{-112,-10},
                {-92,10}})));
      LEPSE.Interfaces.Signal_pin slip_pin annotation (Placement(transformation(
              extent={{-10,92},{10,112}}), iconTransformation(extent={{-10,92},
                {10,112}})));

    initial equation
      // additional variables in p.u.
      Ut_pu = Ut/Ugnom;
      Pg_pu = Pg/Sbaz;
      Qg_pu = Qg/Sbaz;

      // equations of currents, voltages, and flux densities
      s = 0;
      DGi = Dg;

      Pg = Pgen;
      Qg=min(Qmax, max(Qmin, Qgen));

      EQ = sqrt(((Ut_pu + X1d*Qg_pu)/Ut_pu)^2 + (X1d*Pg_pu/Ut_pu)^2);
      Dg = atan(X1d*Pg_pu/(Ut_pu^2 + X1d*Qg_pu));
        //----------------------
      Uq = Ut_pu*cos(Dg);
      Ud = -Ut_pu*sin(Dg);
        //----------------------
      Id = (Uq - EQ)/X1d;
      Iq = (-Ud)/X1d;

    equation

      Tj = Tj_p*Pnom/Sbaz;

      X1d = X1d_p*Sbaz/Pnom*cosfi_nom;
      //--------------------------------------------------------------------------------
      der(DGi) = Wc*s;
      der(s) = (Mt_pp - Me)/Tj;

      //--------------------------------------------------------------------------------

      Me = (uq*iq + ud*id)/(1 - s);

      id = (uq-EQ)/X1d;
      iq = -ud/X1d;

      //----------------------------------------
      Pgen = (uq*iq + ud*id)*Sbaz;
      Qgen = (-uq*id + ud*iq)*Sbaz;

      Ugen = (sqrt(ud^2 + uq^2))*Ugnom;
      Igen = (sqrt(IqG^2 + IdG^2))*Sbaz/sqrt(3)/Ugnom;
      //-----------------------------------------------------------
      uq = UqG*cos(DeltaIJ) - UdG*sin(DeltaIJ);
      ud = UqG*sin(DeltaIJ) + UdG*cos(DeltaIJ);
      //-----------------------------------------------------------
      IqG = iq*cos(DeltaIJ) + id*sin(DeltaIJ);
      IdG = id*cos(DeltaIJ) - iq*sin(DeltaIJ);
      //-----------------------------------------------------------
      f = Wc*(1-s)/2/PI;

      //--Stator--
      Stator_pin.Vd = UdG;
      Stator_pin.Vq = UqG;

      Stator_pin.Id = IdG;
      Stator_pin.Iq = IqG;

      //---input-rotor--field--voltage---
      Mt_pp = max(Mtmin, min(Mtmax,Mt_pin.Signal))  "таким хитрым образом выбирается сигнал с регулятора, если он не ограничен Mtmax, Mtmin";

      slip_pin.Signal = s;

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
              points={{96,0},{70,0}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{0,66},{0,100}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-66,0},{-102,0}},
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
<p>Infinite bus mashine model. </p>
<p>Модель генератора шин бесконечной мощности. </p>
</html>"));
    end Infinite_bus_Mashine_simple;

    model Infinite_bus_simple

      LEPSE.Interfaces.Pin_v2 inp annotation (
        extent=[78,-4; 98,16],
        layer="icon",
        Placement(transformation(extent={{90,-10},{110,10}},
                                                           rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      Turbines.ASR_Regulator ASC_Regulator_1(Sigma=Sigma, Tauc=Tauc)
        annotation (Placement(transformation(extent={{-86,-20},{-20,28}})));

      parameter Real Ut=1 "ARV voltage reference value";

      parameter Real X1d_p=0.3016 "D-axis transient reactance";

      parameter Real Mtmax=1.1 "Turbine overloading coefficient";
      parameter Real Mtmin=0 "Turbine minimum-loading coefficient";

      parameter Real Sigma=0.0001 "Slip deviation control coefficient";
      parameter Real Tauc=0.0001 "Slip deviation time constant";

      parameter Boolean displayPowerFlow=true "Display power flow";

      parameter Real Sbaz=1000 "Bazis power, MWA";
      parameter Real fbaz=G.sysData.fbaz "Bazic frequency, Hz";
      parameter Real Qmax=9999
        "Текущий предел перевозбуждения, МВар";
      parameter Real Qmin=-9999
        "Текущий предел недовозбуждения, МВар";
      parameter Real cosfi_nom=0.9
        "Nominal maschine power coefficient, p.u.";
      parameter Real Pnom=10000 "Set PV-generator power";
      Infinite_bus_Mashine_simple G(
        Sbaz=Sbaz,
        fbaz=fbaz,
        Ut=Ut,
        Pnom=Pnom,
        Ugnom=Ugnom,
        cosfi_nom=cosfi_nom,
        Qmax=Qmax,
        Qmin=Qmin,
        X1d_p=X1d_p,
        Tj_p=Tj_p,
        Mtmax=Mtmax,
        Mtmin=Mtmin)
        annotation (Placement(transformation(extent={{-2,-32},{70,40}})));
      parameter Real Ugnom=330 "Nominal voltage";
      parameter Real Tj_p=7 "Inertia coefficient";

    initial equation
        ASC_Regulator_1.out_pin.Signal = G.Me;

    equation

      connect(G.Stator_pin, inp) annotation (Line(points={{70,4},{86,4},{86,0},{100,
              0}}, color={28,108,200}));
      connect(G.slip_pin, ASC_Regulator_1.ds_pin) annotation (Line(
          points={{34,40.72},{34,48},{-92,48},{-92,2.08},{-86.275,2.08}},
          color={255,255,0},
          thickness=0.5));
      connect(ASC_Regulator_1.out_pin, G.Mt_pin) annotation (Line(
          points={{-20.275,4},{-2.72,4}},
          color={255,255,0},
          thickness=0.5));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-120,-100},{100,100}},
            grid={2,2},
            initialScale=0),
          graphics={
            Ellipse(extent={{-74,68},{72,-68}}, lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-78,96},{74,70}},
              textColor={0,0,0},
              textString="%name"),
            Line(points={{94,0},{72,0}}, color={0,0,255},
              thickness=1),
              Text(
              textString=DynamicSelect("P MW", String(G.Pgen, significantDigits=3) + " MW"),
              visible=displayPowerFlow,
              extent={{-96,-70},{102,-108}},
              textColor={0,168,6}),
            Text(
              textString=DynamicSelect("Q MVar", String(G.Qgen, significantDigits=3) + " MVar"),
              visible=displayPowerFlow,
              extent={{-94,-100},{104,-138}},
              textColor={102,44,145}),
            Ellipse(
              extent={{-25,26},{25,-26}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None,
              closure=EllipseClosure.None,
              startAngle=0,
              endAngle=180,
              origin={-25,-3.55271e-15},
              rotation=180),
            Ellipse(
              extent={{-25,26},{25,-26}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.None,
              closure=EllipseClosure.None,
              startAngle=0,
              endAngle=180,
              origin={25,0},
              rotation=360)},
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
<p>Infinite bus model. </p>
<p>Модель шин бесконечной мощности. </p>
</html>"),
        Diagram(coordinateSystem(extent={{-120,-100},{100,100}})));
    end Infinite_bus_simple;

    model Equation_motion_prototype
      outer SysData sysData;

      //------------------------------------------------------------------------------------
      parameter Real Sbaz=sysData.Sbaz "Bazis power, MWA";
      parameter Real fbaz=sysData.fbaz "Bazic frequency, Hz";
      parameter Real Pg(fixed=false) "Active power";
      parameter Real Qg(fixed=false) "Reactive power";
      parameter Real Ut=330 "ARV voltage reference value";
      parameter Real Pnom=10000 "Set PV-generator power";
      parameter Real Ugnom=330 "Nominal voltage";
      parameter Real cosfi_nom=0.9 "Nominal maschine power coefficient, p.u.";
      parameter Real Kd=50 "Damping coefficient";

      parameter Real Qmax=9999 "Текущий предел перевозбуждения, МВар";
      parameter Real Qmin=-9999 "Текущий предел недовозбуждения, МВар";

      //------------------------------------------------------------------------------------

      parameter Real X1d_p=0.05 "D-axis transient reactance";
      parameter Real Xq_p=0.05 "Q-axis synchronous reactance, p.u.";

      parameter Real Tj_p=7 "Inertia coefficient";

      parameter Real Mtmax=1.1 "Turbine overloading coefficient";
      parameter Real Mtmin=0 "Turbine minimum-loading coefficient";

      //------------------------------------------------------------------------------------
      constant Real PI=4*atan(1) "PI-constant";
      parameter Real Wc=2*PI*fbaz "frequency of electric current fluctuations";

      // Parameters of power system elements
      parameter Real EQ(fixed=false) "Auxiliaire EMF of salient-pole generator";
      parameter Real Dg(fixed=false) "Generator power angle";
      parameter Real Uq(fixed=false) "D-axis ARV voltage reference value";
      parameter Real Ud(fixed=false) "Q-axis ARV voltage reference value";
      parameter Real Id(fixed=false) "D-axis stator current value";
      parameter Real Iq(fixed=false) "Q-axis stator current value";

      Real Ugen "generator full voltage actual value";
      Real Igen "generator stator current value, kA";
      Real Mt_pp "Turbine rotation moment actual value";
      Real Pgen "Generator active power actual value";
      Real Qgen "Generator reactive power actual value";
      Real UdG;
      Real UqG;
      Real IdG;
      Real IqG;
      input Real DeltaIJ;
      input Real Ssys "system slip";
      //------------------------------------------------------------------
      // Integrated Variables

      Real s "generator slip";
      Real DGi "Generator power angle initial value";
      Real Me "electrical moment";
      Real iq "Q-axis generator stator winding current actual value";
      Real id "D-axis generator stator winding current actual value";
      Real ud "D-axis generator voltage actual value";
      Real uq "Q-axis generator voltage actual value";
      Real Xq "Q-axis synchronous reactance actual value";
      Real X1d "D-axis transient reactance actual value";

      Real Tj "Inertia coefficient actual value";
      Real f "frequency";
      parameter Real Ut_pu(fixed=false) "stator voltage, p.u.";
      parameter Real Pg_pu(fixed=false) "Active power, p.u.";
      parameter Real Qg_pu(fixed=false) "Reactive power, p.u.";
      LEPSE.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
          Placement(transformation(extent={{90,-10},{110,10}},
                                                             rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      LEPSE.Interfaces.Signal_pin Mt_pin annotation (Placement(transformation(
              extent={{-112,-10},{-92,10}}), iconTransformation(extent={{-112,-10},
                {-92,10}})));
      LEPSE.Interfaces.Signal_pin slip_pin annotation (Placement(transformation(
              extent={{-10,92},{10,112}}), iconTransformation(extent={{-10,92},
                {10,112}})));

    initial equation
      // additional variables in p.u.
      Ut_pu = Ut/Ugnom;
      Pg_pu = Pg/Sbaz;
      Qg_pu = Qg/Sbaz;

      // equations of currents, voltages, and flux densities
      s = 0;
      DGi = Dg;

      Pg = Pgen;
      Qg=min(Qmax, max(Qmin, Qgen));

      EQ = sqrt(((Ut_pu + Xq*Qg_pu)/Ut_pu)^2 + (Xq*Pg_pu/Ut_pu)^2);
      Dg = atan(Xq*Pg_pu/(Ut_pu^2 + Xq*Qg_pu));
        //----------------------
      Uq = Ut_pu*cos(Dg);
      Ud = -Ut_pu*sin(Dg);
        //----------------------
      Id = (Uq - EQ)/Xq;
      Iq = (-Ud)/Xq;

    equation

      Tj = Tj_p*Pnom/Sbaz;

      X1d = X1d_p*Sbaz/Pnom*cosfi_nom;
      Xq = Xq_p*Sbaz/Pnom*cosfi_nom;
      //--------------------------------------------------------------------------------
      der(DGi) = Wc*s;
      der(s) = (Mt_pp - Me - Kd*s)/Tj;

      //--------------------------------------------------------------------------------

      Me = (uq*iq + ud*id)/(1 - s);

      id = (uq-EQ)/X1d;
      iq = -ud/Xq;

      //----------------------------------------
      Pgen = (uq*iq + ud*id)*Sbaz;
      Qgen = (-uq*id + ud*iq)*Sbaz;

      Ugen = (sqrt(ud^2 + uq^2))*Ugnom;
      Igen = (sqrt(IqG^2 + IdG^2))*Sbaz/sqrt(3)/Ugnom;
      //-----------------------------------------------------------
      uq = UqG*cos(DeltaIJ) - UdG*sin(DeltaIJ);
      ud = UqG*sin(DeltaIJ) + UdG*cos(DeltaIJ);
      //-----------------------------------------------------------
      IqG = iq*cos(DeltaIJ) + id*sin(DeltaIJ);
      IdG = id*cos(DeltaIJ) - iq*sin(DeltaIJ);
      //-----------------------------------------------------------
      f = Wc*(1-s)/2/PI;

      //--Stator--
      Stator_pin.Vd = UdG;
      Stator_pin.Vq = UqG;

      Stator_pin.Id = IdG;
      Stator_pin.Iq = IqG;

      //---input-rotor--field--voltage---
      Mt_pp = max(Mtmin, min(Mtmax,Mt_pin.Signal))  "таким хитрым образом выбирается сигнал с регулятора, если он не ограничен Mtmax, Mtmin";

      slip_pin.Signal = s;

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
              points={{96,0},{70,0}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{0,66},{0,100}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-66,0},{-102,0}},
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
<p>Infinite bus mashine model. </p>
<p>Модель генератора шин бесконечной мощности. </p>
</html>"));
    end Equation_motion_prototype;
  end Numerical_units;

  package Per_units
    model Infinite_bus_Mashine
      parameter Real TgenOff=1000 "Time of generator's disconnection";
      parameter Real dTgenOff=10 "Duration of generator's disconnection";

      //------------------------------------------------------------------------------------
      parameter Real Pg=10;
      parameter Real Qg=0.527 "Reactive power";
      parameter Real Ut=1 "ARV voltage reference value";

      //------------------------------------------------------------------------------------
      parameter Real Xd_p=1.869 "D-axis synchronous reactance";
      parameter Real Xq_p=1.869 "Q-axis synchronous reactance";
      parameter Real Xs_p=0.194 "Leakage reactance of stator winding";
      parameter Real X1d_p=0.3016 "D-axis transient reactance";
      parameter Real X2d_p=0.2337 "D-axis subtransient reactance";
      parameter Real X2q_p=0.2337 "Q-axis subtransient reactance";
      parameter Real Rf_p=904e-6 "Active resistance of field winding";
      parameter Real R1d_p=3.688e-3 "Active resistance of d-axis damper winding";
      parameter Real R1q_p=2.77e-3 "Active resistance of q-axis damper winding";
      parameter Real Tj_p=7 "Inertia coefficient";

      parameter Real Sigma=0.0475 "Turbine statism coefficient";
      parameter Real TauC=0.8 "Time constant of servo motor while valving control";
      parameter Real TregOff=50 "Turbine speed regulator off-time";

      parameter Real TregOn=1000 "Turbine speed regulator on-time";
      parameter Real Mtmax=1.1 "Turbine overloading coefficient";
      parameter Real Mtmin=0 "Turbine minimum-loading coefficient";

      parameter Real Kemax=2.0 "Multiplicity of forcing on";
      parameter Real Kemin=-0.6 "Multiplicity of forcing off";

      //------------------------------------------------------------------------------------
      Real dUtr "voltage deviation";
      Real dWu "frequency deviation";
      Real dIf "current deviation";
      Real dEr "Electromotive force (EMF) deviation";
      Real dWf "frequency deviation";
      constant Real PI=4*atan(1) "PI-constant";
      constant Real Wc=100*PI "frequency of electric current fluctuations";
      constant Real Xt=0 "resistance of step-up transformer";

      // Parameters of power system elements
      constant Real Ra=0 "active resistance of generator stator winding";
      constant Real Rt=0 "active resistance of transformer";
      Real EQ "Auxiliaire EMF of salient-pole generator";
      Real Dg "Generator power angle";
      Real Uq "D-axis ARV voltage reference value";
      Real Ud "Q-axis ARV voltage reference value";
      Real Id "D-axis stator current value";
      Real Iq "Q-axis stator current value";
      Real Mt "Turbine rotation moment";
      Real Eiq;
      Real Ir "field winding current";
      Real Uf "field winding voltage";
      Real Eq "EMF of generator";
      Real Er0 "EMF of generator initial value";
      Real PsiR "field winding flow coupling initial value";
      Real PsiRD "D-axis damper winding flow coupling initial value";
      Real PsiRQ "Q-axis damper winding flow coupling initial value";
      Real Er_max "upper bound of EMF of generator";
      Real Er_min "lower bound of EMF of generator";
      Real Uf_full "field winding voltage actual value";
      Real Xad "D-axis resistance to mutual induction";
      Real Xaq "Q-axis resistance to mutual induction";
      Real X2dt "D-axis subtransient reactance of generator and transformer";
      Real X2qt "Q-axis subtransient reactance of generator and transformer";
      Real Rs "Sum resistance of stator winding and step-up transformer";
      Real Xsf "Leakage reactance of field winding";
      Real Xs1d "D-axis leakage reactance of damping winding";
      Real Xs1q "Q-axis leakage reactance of damping winding";
      Real X1 "interim reactance №1";
      Real X2 "interim reactance №2";
      Real X3 "interim reactance №3";
      Real Ugen "generator full voltage actual value";
      Real Mu0 "Turbine rotation moment initial value";
      Real Ro;
      Real Mu;
      Real Mt_pp "Turbine rotation moment actual value";
      Real Pgen "Generator active power actual value";
      Real Qgen "Generator reactive power actual value";
      Real UdG;
      Real UqG;
      Real IdG;
      Real IqG;
      Real DeltaIJ;
      Real Ssys "system slip";
      //------------------------------------------------------------------
      // Integrated Variables
      Real Yr "field winding flow coupling actual value";
      Real Yrd "D-axis damper winding flow coupling actual value";
      Real Yrq "Q-axis damper winding flow coupling actual value";
      Real s "generator slip";
      Real DGi "Generator power angle initial value";
      Real Me "electrical moment";
      Real Yad "D-axis flow coupling of mutual inductance";
      Real Yaq "Q-axis flow coupling of mutual inductance";
      Real iq "Q-axis generator stator winding current actual value";
      Real id "D-axis generator stator winding current actual value";
      Real ir "D-axis generator field winding current actual value";
      Real ird "D-axis generator damper winding current actual value";
      Real irq "Q-axis generator damper winding current actual value";
      Real ud "D-axis generator voltage actual value";
      Real uq "Q-axis generator voltage actual value";
      Real E11d;
      Real E11q;
      Real Xd "D-axis synchronous reactance actual value";
      Real Xq "Q-axis synchronous reactance actual value";
      Real Xs "Leakage reactance actual value";
      Real X1d "D-axis transient reactance actual value";
      Real X2d "D-axis subtransient reactance actual value";
      Real X2q "Q-axis subtransient reactance actual value";
      Real Rf "Active resistance of field winding actual value";
      Real R1d "Active resistance of d-axis damper winding actual value";
      Real R1q "Active resistance of q-axis damper winding actual value";
      Real Tj "Inertia coefficient actual value";
      Real f "frequency";
      LEPSE.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
          Placement(transformation(extent={{90,-10},{110,10}},
                                                             rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      LEPSE.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
          Placement(transformation(extent={{-110,-10},{-90,10}},
                                                               rotation=0),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      LEPSE.Interfaces.Signal_pin dUtr_pin annotation (
        extent=[-60,66; -40,86],
        layer="icon",
        Placement(transformation(extent={{-64,90},{-44,110}},rotation=0),
            iconTransformation(extent={{-64,90},{-44,110}})));
      LEPSE.Interfaces.Signal_pin dWu_pin annotation (
        extent=[-26,66; -6,86],
        layer="icon",
        Placement(transformation(extent={{-36,90},{-16,110}},rotation=0),
            iconTransformation(extent={{-36,90},{-16,110}})));
      LEPSE.Interfaces.Signal_pin dWf_pin annotation (
        extent=[6,66; 26,86],
        layer="icon",
        Placement(transformation(extent={{-10,90},{10,110}},
                                                           rotation=0),
            iconTransformation(extent={{-10,90},{10,110}})));
      LEPSE.Interfaces.Signal_pin dIf_pin annotation (
        extent=[40,66; 60,86],
        layer="icon",
        Placement(transformation(extent={{18,90},{38,110}},
                                                          rotation=0),
            iconTransformation(extent={{18,90},{38,110}})));
      LEPSE.Interfaces.Signal_pin Ut_pin
        annotation (Placement(transformation(extent={{46,90},{66,110}}),
            iconTransformation(extent={{46,90},{66,110}})));
      LEPSE.Interfaces.Signal_pin Pg_pin annotation (Placement(transformation(
              extent={{-110,-38},{-90,-18}}), iconTransformation(extent={{-110,
                -38},{-90,-18}})));
      LEPSE.Interfaces.Signal_pin slip_pin annotation (Placement(transformation(
              extent={{76,90},{96,110}}), iconTransformation(extent={{76,90},{
                96,110}})));

    equation
      // equations of currents, voltages, and flux densities
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
      Tj = Tj_p;

      Xd = Xd_p;
      Xq = Xq_p;
      Xs = Xs_p;
      X1d = X1d_p;
      X2d = X2d_p;
      X2q = X2q_p;

      Rf = Rf_p;
      R1d = R1d_p;
      R1q = R1q_p;
      //--------------------------------------------------------------------------------
      der(DGi) = Wc*s;

      Uf_full = if (Uf*Xad/Rf + dEr) > Er_max then Er_max*Rf/Xad else if (Uf*Xad
        /Rf + dEr) < Er_min then Er_min*Rf/Xad else Uf + Rf*dEr/Xad;

      der(Yr) = Wc*(Uf_full - Rf*ir);
      der(Yrd) = -Wc*R1d*ird;
      der(Yrq) = -Wc*R1q*irq;
      der(s) = (Mt_pp - Me)/Tj;

      Ro = -Mu + Mu0 - s/Sigma;

      der(Mu) = if time >= TregOff and time < TregOn then Ro/10e6 else Ro/TauC;
      //--------------------------------------------------------------------------------

      //--------------------------------------------------------------------------------

      Me = Yad*iq - Yaq*id;
      ir = (Yr - Yad)/Xsf;
      ird = (Yrd - Yad)/Xs1d;
      irq = (Yrq - Yaq)/Xs1q;
      id = ((uq - E11q)*X2qt - Rs*(ud + E11d))/(X2dt*X2qt + Rs^2);
      iq = (-ud - E11d - Rs*id)/X2qt;
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
      Mt_pp = if Pg_pin.Signal >= Mtmin*Pg and Pg_pin.Signal <= Mtmax*Pg then Pg_pin.Signal else if Pg_pin.Signal > Mtmax*Pg then
        Mtmax*Pg else Mtmin*Pg;

      //----to--excitation--system---
      dUtr_pin.Signal = dUtr;
      dWu_pin.Signal = dWu;
      dWf_pin.Signal = dWf;
      dIf_pin.Signal = dIf;
      Ut_pin.Signal = Ut;
      slip_pin.Signal = s;
      connect(dUtr_pin, dUtr_pin) annotation (Line(
          points={{-54,100},{-54,100}},
          color={255,255,0},
          thickness=0.5));

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
              thickness=1),
            Line(
              points={{-58,-28},{-94,-28}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{62,34},{86,58},{86,92}},
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
<p>Synchronous generator model</p>
</html>"));
    end Infinite_bus_Mashine;

    model SM
      parameter Real TgenOff=1000 "Time of generator's disconnection";
      parameter Real dTgenOff=10 "Duration of generator's disconnection";

      //------------------------------------------------------------------------------------
      parameter Real Pg=0.85 "Active power";
      parameter Real Qg=0.527 "Reactive power";
      parameter Real Ut=1 "ARV voltage reference value";

      //------------------------------------------------------------------------------------
      parameter Real Xd_p=1.869 "D-axis synchronous reactance";
      parameter Real Xq_p=1.869 "Q-axis synchronous reactance";
      parameter Real Xs_p=0.194 "Leakage reactance of stator winding";
      parameter Real X1d_p=0.3016 "D-axis transient reactance";
      parameter Real X2d_p=0.2337 "D-axis subtransient reactance";
      parameter Real X2q_p=0.2337 "Q-axis subtransient reactance";
      parameter Real Rf_p=904e-6 "Active resistance of field winding";
      parameter Real R1d_p=3.688e-3 "Active resistance of d-axis damper winding";
      parameter Real R1q_p=2.77e-3 "Active resistance of q-axis damper winding";
      parameter Real Tj_p=7 "Inertia coefficient";

      parameter Real Sigma=0.0475 "Turbine statism coefficient";
      parameter Real TauC_up=0.8 "Time constant of servo motor while valving control";
      parameter Real TregOff=50 "Turbine speed regulator off-time";

      parameter Real TregOn=1000 "Turbine speed regulator on-time";
      parameter Real Mtmax=1.1 "Turbine overloading coefficient";
      parameter Real Mtmin=0 "Turbine minimum-loading coefficient";

      parameter Real Aimp=1 "Fast turbine valving control amplitude";
      parameter Real Timp=1000 "Fast turbine valving control on-time";
      parameter Real dTimp=0.2 "Fast turbine valving control duration";
      parameter Real TauC_down=5 "Time constant of servo motor after valving control end";

      parameter Real TkzOn=1000 "HPP generators dropping on-time";
      parameter Real Pg_new=0.85 "New power of HPP";
      parameter Real Kemax=2.0 "Multiplicity of forcing on";
      parameter Real Kemin=-0.6 "Multiplicity of forcing off";

      //------------------------------------------------------------------------------------
      Real dUtr "voltage deviation";
      Real dWu "frequency deviation";
      Real dIf "current deviation";
      Real dEr "Electromotive force (EMF) deviation";
      Real dWf "frequency deviation";
      constant Real PI=4*atan(1) "PI-constant";
      constant Real Wc=100*PI "frequency of electric current fluctuations";
      constant Real Xt=0 "resistance of step-up transformer";

      // Parameters of power system elements
      constant Real Ra=0 "active resistance of generator stator winding";
      constant Real Rt=0 "active resistance of transformer";
      Real EQ "Auxiliaire EMF of salient-pole generator";
      Real Dg "Generator power angle";
      Real Uq "D-axis ARV voltage reference value";
      Real Ud "Q-axis ARV voltage reference value";
      Real Id "D-axis stator current value";
      Real Iq "Q-axis stator current value";
      Real Mt "Turbine rotation moment";
      Real Eiq;
      Real Ir "field winding current";
      Real Uf "field winding voltage";
      Real Eq "EMF of generator";
      Real Er0 "EMF of generator initial value";
      Real PsiR "field winding flow coupling initial value";
      Real PsiRD "D-axis damper winding flow coupling initial value";
      Real PsiRQ "Q-axis damper winding flow coupling initial value";
      Real Er_max "upper bound of EMF of generator";
      Real Er_min "lower bound of EMF of generator";
      Real Uf_full "field winding voltage actual value";
      Real Xad "D-axis resistance to mutual induction";
      Real Xaq "Q-axis resistance to mutual induction";
      Real X2dt "D-axis subtransient reactance of generator and transformer";
      Real X2qt "Q-axis subtransient reactance of generator and transformer";
      Real Rs "Sum resistance of stator winding and step-up transformer";
      Real Xsf "Leakage reactance of field winding";
      Real Xs1d "D-axis leakage reactance of damping winding";
      Real Xs1q "Q-axis leakage reactance of damping winding";
      Real X1 "interim reactance №1";
      Real X2 "interim reactance №2";
      Real X3 "interim reactance №3";
      Real Ugen "generator full voltage actual value";
      Real Mu0 "Turbine rotation moment initial value";
      Real Ro;
      Real Mu;
      Real Mt_pp "Turbine rotation moment actual value";
      Real Pgen "Generator active power actual value";
      Real Qgen "Generator reactive power actual value";
      Real UdG;
      Real UqG;
      Real IdG;
      Real IqG;
      Real DeltaIJ;
      Real Ssys "system slip";
      //------------------------------------------------------------------
      // Integrated Variables
      Real Yr "field winding flow coupling actual value";
      Real Yrd "D-axis damper winding flow coupling actual value";
      Real Yrq "Q-axis damper winding flow coupling actual value";
      Real s "generator slip";
      Real DGi "Generator power angle initial value";
      Real Me "electrical moment";
      Real Yad "D-axis flow coupling of mutual inductance";
      Real Yaq "Q-axis flow coupling of mutual inductance";
      Real iq "Q-axis generator stator winding current actual value";
      Real id "D-axis generator stator winding current actual value";
      Real ir "D-axis generator field winding current actual value";
      Real ird "D-axis generator damper winding current actual value";
      Real irq "Q-axis generator damper winding current actual value";
      Real ud "D-axis generator voltage actual value";
      Real uq "Q-axis generator voltage actual value";
      Real E11d;
      Real E11q;
      Real TauC "Time constant of servo motor actual value";
      Real MT_MAX "Turbine overloading coefficient actual value";
      Real MT_MIN "Turbine minimum-loading coefficient actual value";
      Real Xd "D-axis synchronous reactance actual value";
      Real Xq "Q-axis synchronous reactance actual value";
      Real Xs "Leakage reactance actual value";
      Real X1d "D-axis transient reactance actual value";
      Real X2d "D-axis subtransient reactance actual value";
      Real X2q "Q-axis subtransient reactance actual value";
      Real Rf "Active resistance of field winding actual value";
      Real R1d "Active resistance of d-axis damper winding actual value";
      Real R1q "Active resistance of q-axis damper winding actual value";
      Real Tj "Inertia coefficient actual value";
      Real f "frequency";
      LEPSE.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
          Placement(transformation(extent={{90,-10},{110,10}},
                                                             rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      LEPSE.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
          Placement(transformation(extent={{-110,-10},{-90,10}},
                                                               rotation=0),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      LEPSE.Interfaces.Signal_pin dUtr_pin annotation (
        extent=[-60,66; -40,86],
        layer="icon",
        Placement(transformation(extent={{-64,90},{-44,110}},rotation=0),
            iconTransformation(extent={{-64,90},{-44,110}})));
      LEPSE.Interfaces.Signal_pin dWu_pin annotation (
        extent=[-26,66; -6,86],
        layer="icon",
        Placement(transformation(extent={{-36,90},{-16,110}},rotation=0),
            iconTransformation(extent={{-36,90},{-16,110}})));
      LEPSE.Interfaces.Signal_pin dWf_pin annotation (
        extent=[6,66; 26,86],
        layer="icon",
        Placement(transformation(extent={{-10,90},{10,110}},
                                                           rotation=0),
            iconTransformation(extent={{-10,90},{10,110}})));
      LEPSE.Interfaces.Signal_pin dIf_pin annotation (
        extent=[40,66; 60,86],
        layer="icon",
        Placement(transformation(extent={{18,90},{38,110}},
                                                          rotation=0),
            iconTransformation(extent={{18,90},{38,110}})));
      LEPSE.Interfaces.Signal_pin Ut_pin
        annotation (Placement(transformation(extent={{46,90},{66,110}}),
            iconTransformation(extent={{46,90},{66,110}})));
    equation
      // equations of currents, voltages, and flux densities
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

      der(Mu) = if time >= TregOff and time < TregOn then Ro/10e6 else Ro/TauC;
      //--------------------------------------------------------------------------------
      MT_MIN = if time < TkzOn then Mtmin*Pg else Pg_new - 0.01;
      MT_MAX = if time < TkzOn then Mtmax*Pg else Pg_new + 0.01;

      Mt_pp = if Mu >= MT_MIN and Mu <= MT_MAX then Mu else if Mu > MT_MAX then
        MT_MAX else MT_MIN;
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
      Ut_pin.Signal = Ut;
      connect(dUtr_pin, dUtr_pin) annotation (Line(
          points={{-54,100},{-54,100}},
          color={255,255,0},
          thickness=0.5));

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
<p>Synchronous generator model</p>
</html>"));
    end SM;

    model SM_with_AVR

      LEPSE.Interfaces.Pin_v2 inp annotation (
        extent=[78,-4; 98,16],
        layer="icon",
        Placement(transformation(extent={{90,-10},{110,10}},
                                                           rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      Basic.Excitation_systems.Regulators.AVR_standart AVR annotation (extent=[
            -84,-90; -32,82], Placement(transformation(extent={{-84,-90},{-32,
                82}}, rotation=0)));
      Basic.Generators.Per_units.SM G annotation (extent=[-28,-72; 70,80],
          Placement(transformation(extent={{-28,-72},{70,80}}, rotation=0)));
    equation
      connect(AVR.out_pin, G.Ef_pin) annotation (points=[-34.34, 6.32; -18.2,
            5.52], Line(points={{-31.7833,-10.88},{-28,4}}));
      connect(AVR.dV1_pin, AVR.dV_pin) annotation (points=[-81.66, 30.4; -
            81.66, 56.2], Line(points={{-84.2167,13.2},{-84.2167,38},{-82,
              38},{-82,44},{-84.2167,44},{-84.2167,39}}));
      connect(G.dUtr_pin, AVR.dV_pin) annotation (points=[-3.5, 61.76; -4, 76;
              -82, 76; -81.66, 56.2], Line(points={{-5.46,80},{-5.46,76},{
              -84.2167,76},{-84.2167,39}}));
      connect(G.dWu_pin, AVR.dfsys_pin) annotation (points=[13.16, 61.76; 14,
            80; -86, 80; -86, 4; -81.66, 4.6], Line(points={{8.26,80},{8.26,
              80},{-86,80},{-86,-12.6},{-84.2167,-12.6}}));
      connect(G.dWf_pin, AVR.dfU_pin) annotation (points=[28.84, 61.76; 28, 84;
              -88, 84; -88, -22; -81.66, -21.2], Line(points={{21,80},{21,
              84},{-88,84},{-88,-38.4},{-84.2167,-38.4}}));
      connect(G.dIf_pin, AVR.dif1_pin) annotation (points=[45.5, 61.76; 44, 90;
              -94, 90; -94, -46; -81.66, -47], Line(points={{34.72,80},{
              34.72,90},{-94,90},{-94,-59.04},{-84.2167,-59.04}}));
      connect(G.Stator_pin, inp) annotation (points=[59.22, 5.52; 88, 6], Line(
            points={{70,4},{100,0}}));

      connect(G.Ut_pin, AVR.Ut_pin) annotation (Line(points={{48.44,80},{48.44,
              92},{-96,92},{-96,-76.24},{-84,-76.24}},    color={0,0,0}));
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
            Ellipse(extent={{-74,68},{72,-68}}, lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-44,44},{46,10}}, textString=
                                                "Gen."),
            Text(extent={{-50,12},{50,-14}},textString=
                                                "with ARV"),
            Text(extent={{-78,96},{74,70}},
              textColor={0,0,0},
              textString="%name"),
            Line(points={{94,0},{72,0}}, color={0,0,255},
              thickness=1),
            Text(extent={{-50,-14},{50,-40}},textString=
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
    end SM_with_AVR;
  end Per_units;
end Generators;
