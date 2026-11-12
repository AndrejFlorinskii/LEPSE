within OMLET;
package Basic

  model SysData
    parameter Real Sbaz = 1000 "Bazic power, MWA";
    parameter Real Ubaz = 20 "Basic voltage, kV";
    parameter Real Ubaz_HV = 330 "Basic voltage HV, kV";
    parameter Real fbaz = 50 "Basic frequency, Hz";

    annotation (
      Icon(
        coordinateSystem(extent={{-100,-100},{100,100}}),
        graphics={
          Rectangle(extent={{-100,62},{100,-60}}, lineColor={0,0,255}, fillColor={220,220,255}, fillPattern=FillPattern.Solid),
                  Text(
            textString= String(Sbaz, significantDigits=5) + " MW",
            extent={{-98,38},{100,0}},
            textColor={0,0,0}),
            Text(
            textString= String(fbaz, significantDigits=2) + " Hz",
            extent={{-96,-2},{102,-40}},
            textColor={0,0,0})}), Documentation(info="<html>
<p>Block for setting basic parameters.</p>
<p>Блок задания базисных параметров. </p>
</html>"));
  end SysData;

  package Generators

    package Numerical_units
      model SM
        outer SysData sysData;

        // PQ-diagram parameter
        parameter OMLET.Data.PQ_CapabilityTable pq_table=OMLET.Data.TVV_500_2;

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

        OMLET.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
            Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        OMLET.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
            Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        OMLET.Interfaces.Signal_pin dUtr_pin annotation (
          extent=[-60,66; -40,86],
          layer="icon",
          Placement(transformation(extent={{-64,90},{-44,110}}, rotation=0),
              iconTransformation(extent={{-64,90},{-44,110}})));
        OMLET.Interfaces.Signal_pin dWu_pin annotation (
          extent=[-26,66; -6,86],
          layer="icon",
          Placement(transformation(extent={{-36,90},{-16,110}}, rotation=0),
              iconTransformation(extent={{-36,90},{-16,110}})));
        OMLET.Interfaces.Signal_pin dWf_pin annotation (
          extent=[6,66; 26,86],
          layer="icon",
          Placement(transformation(extent={{-10,90},{10,110}}, rotation=0),
              iconTransformation(extent={{-10,90},{10,110}})));
        OMLET.Interfaces.Signal_pin dIf_pin annotation (
          extent=[40,66; 60,86],
          layer="icon",
          Placement(transformation(extent={{18,90},{38,110}}, rotation=0),
              iconTransformation(extent={{18,90},{38,110}})));
        OMLET.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
                extent={{46,90},{66,110}}), iconTransformation(extent={{46,90},
                  {66,110}})));
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

        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[78,-4; 98,16],
          layer="icon",
          Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
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
        parameter Data.PQ_CapabilityTable pq_table=OMLET.Data.TVV_500_2;
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
            points={{18.04,40},{18.04,60},{-132,60},{-132,-1.7},{-124.367,-1.7}},
            color={255,255,0},
            thickness=0.5));
        connect(G.dUtr_pin, AVR.dV_pin) annotation (Line(
            points={{5.16,40},{5.16,56},{-130,56},{-130,26.5},{-124.367,26.5}},
            color={255,255,0},
            thickness=0.5));
        connect(AVR.dV_pin, AVR.dV1_pin) annotation (Line(
            points={{-124.367,26.5},{-124.367,24},{-124,24},{-124,20},{-124.367,
                20},{-124.367,12.4}},
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
</html>"),Diagram(coordinateSystem(extent={{-140,-100},{100,100}})));
      end SM_with_AVR;

      model Infinite_bus

        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[78,-4; 98,16],
          layer="icon",
          Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        Turbines.ASR_Regulator_IB ASC_Regulator_1(Sigma=Sigma, Tauc=Tauc)
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
</html>"),Diagram(coordinateSystem(extent={{-120,-100},{100,100}})));
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
        OMLET.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
            Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        OMLET.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
            Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        OMLET.Interfaces.Signal_pin dUtr_pin annotation (
          extent=[-60,66; -40,86],
          layer="icon",
          Placement(transformation(extent={{-64,90},{-44,110}}, rotation=0),
              iconTransformation(extent={{-64,90},{-44,110}})));
        OMLET.Interfaces.Signal_pin dWu_pin annotation (
          extent=[-26,66; -6,86],
          layer="icon",
          Placement(transformation(extent={{-36,90},{-16,110}}, rotation=0),
              iconTransformation(extent={{-36,90},{-16,110}})));
        OMLET.Interfaces.Signal_pin dWf_pin annotation (
          extent=[6,66; 26,86],
          layer="icon",
          Placement(transformation(extent={{-10,90},{10,110}}, rotation=0),
              iconTransformation(extent={{-10,90},{10,110}})));
        OMLET.Interfaces.Signal_pin dIf_pin annotation (
          extent=[40,66; 60,86],
          layer="icon",
          Placement(transformation(extent={{18,90},{38,110}}, rotation=0),
              iconTransformation(extent={{18,90},{38,110}})));
        OMLET.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
                extent={{46,90},{66,110}}), iconTransformation(extent={{46,90},
                  {66,110}})));
        Interfaces.Signal_pin Mt_pin annotation (Placement(transformation(extent={{-110,
                  -38},{-90,-18}}), iconTransformation(extent={{-110,-38},{-90,-18}})));
        Interfaces.Signal_pin slip_pin annotation (Placement(transformation(extent={{76,
                  90},{96,110}}), iconTransformation(extent={{76,90},{96,110}})));

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
        OMLET.Interfaces.Pin_v2 inp
          "Выводы статора генератора";

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

        Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(extent={{90,
                  -10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
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

        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[78,-4; 98,16],
          layer="icon",
          Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
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
        parameter Data.PQ_CapabilityTable pq_table=OMLET.Data.TVV_500_2;
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
</html>"),Diagram(coordinateSystem(extent={{-140,-100},{100,100}})));
      end SM_with_AVR_SD;

      model SM_without_exciter
        outer SysData sysData;

        // PQ-diagram parameter
        parameter OMLET.Data.PQ_CapabilityTable pq_table=OMLET.Data.TVV_500_2;

        parameter Boolean inService_G = true "Generator topological condition"
        annotation(Dialog(tab="General"));
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
        Real Qmax "Current limit of overexcitation, MVar";
        Real Qmin "Current limit of underexcitation, MVar";

        // Auxiliary variables for the interpolator (Modelica syntax requirement)
        Real P_clipped_max "Sliced P for Qmax interpolation";
        Real P_clipped_min "Sliced P for Qmin interpolation";
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
        parameter Real TregOff=50 "Turbine speed regulator off-time, s"
        annotation(Dialog(tab="Turbine"));
        parameter Real Mtmax=1.1 "Turbine overloading coefficient, p.u."
        annotation(Dialog(tab="Turbine"));
        parameter Real Mtmin=0 "Turbine minimum-loading coefficient, p.u."
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

        OMLET.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
            Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        OMLET.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
            Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        OMLET.Interfaces.Signal_pin dUtr_pin annotation (
          extent=[-60,66; -40,86],
          layer="icon",
          Placement(transformation(extent={{68,90},{88,110}},   rotation=0),
              iconTransformation(extent={{68,90},{88,110}})));
        OMLET.Interfaces.Signal_pin dWu_pin annotation (
          extent=[-26,66; -6,86],
          layer="icon",
          Placement(transformation(extent={{-26,90},{-6,110}},  rotation=0),
              iconTransformation(extent={{-26,90},{-6,110}})));
        OMLET.Interfaces.Signal_pin dWf_pin annotation (
          extent=[6,66; 26,86],
          layer="icon",
          Placement(transformation(extent={{6,90},{26,110}},   rotation=0),
              iconTransformation(extent={{6,90},{26,110}})));
        OMLET.Interfaces.Signal_pin dIf_pin annotation (
          extent=[40,66; 60,86],
          layer="icon",
          Placement(transformation(extent={{-58,90},{-38,110}},
                                                              rotation=0),
              iconTransformation(extent={{-58,90},{-38,110}})));
        OMLET.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
                extent={{-90,90},{-70,110}}),
                                            iconTransformation(extent={{-90,90},
                  {-70,110}})));
        Interfaces.Signal_pin       Er0_pin
          annotation (Placement(transformation(extent={{-112,66},{-92,86}}),
              iconTransformation(extent={{-112,66},{-92,86}})));
        Interfaces.Signal_pin       Ugen_pin
          annotation (Placement(transformation(extent={{38,90},{58,110}}),
              iconTransformation(extent={{38,90},{58,110}})));
        Interfaces.Signal_pin dIg_pin annotation (Placement(transformation(extent={{-112,28},
                  {-92,48}}),      iconTransformation(extent={{-112,28},{-92,48}})));
        Interfaces.Signal_pin slip_pin annotation (Placement(transformation(extent={{-110,
                  -80},{-90,-60}}),
                                  iconTransformation(extent={{-110,-80},{-90,
                  -60}})));
        Interfaces.Signal_pin Mu0_pin annotation (Placement(transformation(extent={{-110,
                  -108},{-90,-88}}),iconTransformation(extent={{-110,-108},{-90,
                  -88}})));
        Interfaces.Signal_pin Mt_pin annotation (Placement(transformation(extent={{-110,
                  66},{-90,86}}), iconTransformation(extent={{-110,-48},{-90,-28}})));
      initial equation
        // additional variables in p.u.
        Ut_pu = Ut/Ugnom;
        Pg_pu = Pg/Sbaz;
        Qg_pu = Qg/Sbaz;
        Ignom = Pnom/cosfi_nom/sqrt(3)/Ugnom;


        // equations of currents, voltages, and flux densities
        s = 0;

        EQ = sqrt((Ut_pu + ((Ra + Rt)*Pg_pu + (Xq + Xt)*Qg_pu)/Ut_pu)^2 + (((Xq + Xt)*Pg_pu - (Ra + Rt)*Qg_pu)/Ut_pu)^2);
        Dg = atan((((Xq + Xt)*Pg_pu - (Ra + Rt)*Qg_pu)/Ut_pu)/(Ut_pu + ((Ra + Rt)*Pg_pu + (Xq + Xt)*Qg_pu)/Ut_pu));

        Uq = Ut_pu*cos(Dg);
        Ud = -Ut_pu*sin(Dg);

        PsiR = Eiq + Xsf*Ir;
        PsiRQ = -Ud - Iq*(Xs + Xt) - Id*(Ra + Rt);
        PsiRD = Eiq;

        Ir = -Id + Eiq/Xad;
        Er0 = Eq;
        Eiq = Uq - Id*(Xs + Xt) + (Ra + Rt)*Iq;
        Uf = Ir*Rf;
        Eq = Ir*Xad;

        if inService_G then
          Qg=min(Qmax, max(Qmin, Qgen));
          Pg=Pgen;
          Id = ((Uq - EQ)*(Xq + Xt) - (Ra + Rt)*Ud)/((Ra + Rt)^2 + (Xq + Xt)^2);
          Iq = (-Ud - (Ra + Rt)*Id)/(Xq + Xt);
          Mu0 = EQ*Iq;
          DGi = Dg;
          Yr = PsiR;
          Yrd = PsiRD;
          Yrq = PsiRQ;
        else
          Qg=0;
          Id = 0;
          Iq = 0;
          Mu0 = 0;
          DGi = 0;
          Yr = 0;
          Yrd = 0;
          Yrq = 0;
        end if;

      equation

        // 1. EXTRAPOLATION PROTECTION (We limit Pgen to table boundaries so that math doesn't fly away)
        P_clipped_max = max(pq_table.P_max[1], min(Pgen, pq_table.P_max[end]));
        P_clipped_min = max(pq_table.P_min[1], min(Pgen, pq_table.P_min[end]));

         // 2. AUTOMATIC INTERPOLATION AT EACH CALCULATION STEP
        // The interpolate function returns a tuple (value of I, index_interval)
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
        R1d_p = (Xs1d+(1/((1/Xad)+(1/Xsf))))/Wc/T2d_p;
        R1q_p = (Xs1q+(1/((1/Xaq))))/Wc/T2q_p;
        Rf = if time < TkzOn then Rf_p else Rf_p*Pg/Pg_new;
        R1d = if time < TkzOn then R1d_p else R1d_p*Pg/Pg_new;
        R1q = if time < TkzOn then R1q_p else R1q_p*Pg/Pg_new;
        //--------------------------------------------------------------------------------

        der(DGi) = Wc*s;

        der(Yr) = Wc*(Uf_full - Rf*ir);
        der(Yrd) = -Wc*R1d*ird;
        der(Yrq) = -Wc*R1q*irq;
        der(s) = (Mt_pp/(1+s) - Me/(1+s) - Kd/2*s)/Tj;

        Uf_full = Rf*Er/Xad;

        //----------------------------------------

        Me = Yad*iq - Yaq*id;
        ir = (Yr - Yad)/Xsf;
        ird = (Yrd - Yad)/Xs1d;
        irq = (Yrq - Yaq)/Xs1q;
        id = if not inService_G then 0 else if time >= TgenOff and time < TgenOff + dTgenOff then 0 else ((uq -
          E11q)*X2qt - Rs*(ud + E11d))/(X2dt*X2qt + Rs^2);
        iq = if not inService_G then 0 else if time >= TgenOff and time < TgenOff + dTgenOff then 0 else (-ud -
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
        dIf = (ir - Ir)*Xad;

        //--------------------------------------------------------------------------------
        MT_MIN = if time < TkzOn then Mtmin*Pg_pu else Pg_new/Sbaz - 0.01;
        MT_MAX = if time < TkzOn then Mtmax*Pg_pu else Pg_new/Sbaz + 0.01;

        //--------------------------------------------------------------------------------

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

        Mt_pp = max(MT_MIN, min(MT_MAX,Mt_pin.Signal))  "таким хитрым образом выбирается сигнал с регулятора, если он не ограничен Mtmax, Mtmin";
        slip_pin.Signal = if time >= TregOff then 0 else s;
        Mu0 = Mu0_pin.Signal;

        connect(dUtr_pin, dUtr_pin) annotation (Line(
            points={{78,100},{78,100}},
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
                points={{-40,54},{-48,66},{-48,100}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-16,64},{-16,100}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{16,64},{16,98}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{54,44},{80,66},{80,98}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-60,30},{-80,58},{-80,92}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-64,14},{-98,40}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-64,-14},{-100,-42}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-80,58},{-98,76}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-94,-68},{-54,-34}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-44,-64},{-44,-46}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-96,-102},{-44,-64}},
                color={0,0,255},
                thickness=1),
              Text(
                extent={{-62,132},{-38,114}},
                textColor={0,0,0},
                textString="dIf"),
              Text(
                extent={{-142,-90},{-118,-108}},
                textColor={0,0,0},
                textString="Mu0"),
              Text(
                extent={{-140,-60},{-116,-78}},
                textColor={0,0,0},
                textString="s"),
              Text(
                extent={{-140,-28},{-116,-46}},
                textColor={0,0,0},
                textString="Mt"),
              Text(
                extent={{-140,10},{-116,-8}},
                textColor={0,0,0},
                textString="Ef"),
              Text(
                extent={{-142,50},{-118,32}},
                textColor={0,0,0},
                textString="dIg"),
              Text(
                extent={{-140,84},{-116,66}},
                textColor={0,0,0},
                textString="Er0"),
              Text(
                extent={{-94,132},{-70,114}},
                textColor={0,0,0},
                textString="Ut"),
              Text(
                extent={{-32,136},{-2,110}},
                textColor={0,0,0},
                textString="dWu"),
              Text(
                extent={{2,134},{26,112}},
                textColor={0,0,0},
                textString="dWf"),
              Line(
                points={{34,58},{48,74},{48,98}},
                color={0,0,255},
                thickness=1),
              Text(
                extent={{32,138},{62,110}},
                textColor={0,0,0},
                textString="Ugen"),
              Text(
                extent={{66,134},{90,112}},
                textColor={0,0,0},
                textString="dUtr"),
              Text(
                extent={{92,30},{162,-28}},
                textColor={0,0,0},
                textString="id
iq
ud
uq")},      Ellipse(extent=[-60, 62; 60, -58], style(thickness=2)),
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

        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[78,-4; 98,16],
          layer="icon",
          Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
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
        parameter Real TregOff=50 "Turbine speed regulator off-time, s"
        annotation(Dialog(tab="Turbine"));
        parameter Real Mtmax=1.1 "Turbine overloading coefficient, p.u."
        annotation(Dialog(tab="Turbine"));
        parameter Real Mtmin=0 "Turbine minimum-loading coefficient, p.u."
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
        parameter Data.PQ_CapabilityTable pq_table=OMLET.Data.TVV_500_2
         annotation(Dialog(tab="Synchronous machine"));
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
          annotation (Placement(transformation(extent={{-196,-30},{-118,46}})));
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
          inService_G=inService_G,
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
          TregOff=TregOff,
          Mtmax=Mtmax,
          Mtmin=Mtmin,
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
        Turbines.ASR_Regulator_ ASR(Sigma=Sigma, Tauc=Tauc)
          annotation (Placement(transformation(extent={{-80,-100},{-20,-56}})));
        parameter Real Tauc=0.15 "Slip deviation time constant"
         annotation(Dialog(tab="Turbine"));
        parameter Boolean inService_G=true "Generator topological condition"
        annotation(Dialog(tab="General"));
      equation

        connect(AVR.dV1_pin, AVR.dV_pin) annotation (Line(
            points={{-196.325,23.96},{-196.325,42.2}},
            color={255,255,0},
            thickness=0.5));
        connect(exciter.dEr_pin, AVR.out_pin) annotation (Line(
            points={{-78,3.94},{-104,3.94},{-104,4},{-112,4},{-112,4.96},{
                -117.675,4.96}},
            color={255,255,0},
            thickness=0.5));
        connect(exciter.Er_pin, G.Ef_pin) annotation (Line(
            points={{-24,-1},{-24,0},{-18,0}},
            color={255,255,0},
            thickness=0.5));
        connect(G.Stator_pin, inp) annotation (Line(points={{74,0},{100,0}},
                             color={28,108,200}));

        connect(G.dIg_pin, exciter.dIg_pin) annotation (Line(
            points={{-18.92,17.48},{-30,17.48},{-30,50},{-78,50},{-78,8.88}},
            color={255,255,0},
            thickness=0.5));
        connect(G.Er0_pin, exciter.Er0_pin) annotation (Line(
            points={{-18.92,34.96},{-18.92,56},{-108,56},{-108,-2},{-88,-2},{
                -88,-1},{-78,-1}},
            color={255,255,0},
            thickness=0.5));
        connect(G.dIf_pin, exciter.dIf_pin) annotation (Line(
            points={{5.92,46},{5.92,64},{-88,64},{-88,-12},{-84,-12},{-84,
                -11.26},{-78,-11.26}},
            color={255,255,0},
            thickness=0.5));
        connect(G.Ugen_pin, exciter.Ut_pin) annotation (Line(
            points={{50.08,46},{42,46},{42,68},{-98,68},{-98,-4},{-90,-4},{-90,
                -5.56},{-78,-5.56}},
            color={255,255,0},
            thickness=0.5));
        connect(G.Ut_pin, AVR.Ut_pin) annotation (Line(
            points={{-8.8,46},{-8.8,76},{-8,76},{-8,104},{-202,104},{-202,
                -23.92},{-196,-23.92}},
            color={255,255,0},
            thickness=0.5));
        connect(G.dUtr_pin, AVR.dV_pin) annotation (Line(
            points={{63.88,46},{63.88,56},{54,56},{54,60},{-224,60},{-224,42.2},
                {-196.325,42.2}},
            color={255,255,0},
            thickness=0.5));
        connect(G.dWf_pin, AVR.dfU_pin) annotation (Line(
            points={{35.36,46},{35.36,76},{-212,76},{-212,-8},{-204,-8},{-204,
                -0.36},{-196.325,-0.36}},
            color={255,255,0},
            thickness=0.5));
        connect(G.dIf_pin, AVR.dif1_pin) annotation (Line(
            points={{5.92,46},{5.92,70},{4,70},{4,94},{-206,94},{-206,-16},{
                -202,-16},{-202,-12.52},{-196.325,-12.52}},
            color={255,255,0},
            thickness=0.5));
        connect(G.dWu_pin, AVR.dfsys_pin) annotation (Line(
            points={{20.64,46},{20.64,66},{16,66},{16,84},{-218,84},{-218,4},{
                -208,4},{-208,13.32},{-196.325,13.32}},
            color={255,255,0},
            thickness=0.5));
        connect(G.Mu0_pin, ASR.Mu0_pin) annotation (Line(
            points={{-18,-45.08},{-92,-45.08},{-92,-69.64},{-80.25,-69.64}},
            color={255,255,0},
            thickness=0.5));
        connect(G.slip_pin, ASR.ds_pin) annotation (Line(
            points={{-18,-32.2},{-88,-32.2},{-88,-79.76},{-80.25,-79.76}},
            color={255,255,0},
            thickness=0.5));
        connect(ASR.out_pin, G.Mt_pin) annotation (Line(
            points={{-20.25,-78},{-18,-78},{-18,-54},{-82,-54},{-82,-17.48},{
                -18,-17.48}},
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
              extent={{-240,-100},{100,120}},
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
</html>"),Diagram(coordinateSystem(extent={{-240,-100},{100,120}})));
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
        parameter Real Mu0(fixed=false);
       parameter Real TregOff=50 "Turbine speed regulator off-time, s"
        annotation(Dialog(tab="Turbine"));

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
        OMLET.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
            Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        Interfaces.Signal_pin Mt_pin annotation (Placement(transformation(extent={{-112,
                  -10},{-92,10}}),  iconTransformation(extent={{-112,-10},{-92,10}})));
        Interfaces.Signal_pin slip_pin annotation (Placement(transformation(extent={{-10,92},
                  {10,112}}),     iconTransformation(extent={{-10,92},{10,112}})));

        Interfaces.Signal_pin Mu0_pin annotation (Placement(transformation(extent={{-62,92},
                  {-42,112}}),    iconTransformation(extent={{-62,92},{-42,112}})));
      initial equation
        // additional variables in p.u.
        Ut_pu = Ut/Ugnom;
        Pg_pu = Pg/Sbaz;
        Qg_pu = Qg/Sbaz;

        // equations of currents, voltages, and flux densities
        s = 0;
        DGi = Dg;
        Mu0 = EQ*Iq;

        Pg = Pgen;
        Qg=min(Qmax, max(Qmin, Qgen));

        EQ = sqrt((Ut_pu + X1d*Qg_pu/Ut_pu)^2 + (X1d*Pg_pu/Ut_pu)^2);
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
        der(s) = (Mt_pp/(1+s) - Me/(1+s))/Tj;

        //--------------------------------------------------------------------------------

        Me = (uq*iq + ud*id);

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
        Mu0 = Mu0_pin.Signal;
        slip_pin.Signal = if time >= TregOff then 0 else s;

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
              Text(extent={{-76,-64},{84,-106}},
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
                thickness=1),
              Line(
                points={{-32,58},{-54,100}},
                color={0,0,255},
                thickness=1),
              Text(
                extent={{-36,110},{0,96}},
                textColor={0,0,0},
                textString="S"),
              Text(
                extent={{-92,110},{-60,96}},
                textColor={0,0,0},
                textString="Mu0"),
              Text(
                extent={{-122,28},{-90,14}},
                textColor={0,0,0},
                textString="Mt")},
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

        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[78,-4; 98,16],
          layer="icon",
          Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        Turbines.ASR_Regulator_   ASC_Regulator_1(Sigma=Sigma, Tauc=Tauc)
          annotation (Placement(transformation(extent={{-72,-22},{-18,24}})));

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
          Mtmin=Mtmin,
          TregOff=TregOff)
          annotation (Placement(transformation(extent={{-2,-36},{70,36}})));
        parameter Real Ugnom=330 "Nominal voltage";
        parameter Real Tj_p=7 "Inertia coefficient";

        parameter Real TregOff=50 "Turbine speed regulator off-time, s";
      initial equation
          ASC_Regulator_1.out_pin.Signal = G.Me;

      equation

        connect(G.Stator_pin, inp) annotation (Line(points={{70,0},{100,0}},
                     color={28,108,200}));
        connect(G.slip_pin, ASC_Regulator_1.ds_pin) annotation (Line(
            points={{34,36.72},{34,52},{-84,52},{-84,-0.84},{-72.225,-0.84}},
            color={255,255,0},
            thickness=0.5));
        connect(ASC_Regulator_1.out_pin, G.Mt_pin) annotation (Line(
            points={{-18.225,1},{-10,1},{-10,0},{-2.72,0}},
            color={255,255,0},
            thickness=0.5));
        connect(G.Mu0_pin, ASC_Regulator_1.Mu0_pin) annotation (Line(
            points={{15.28,36.72},{15.28,48},{-78,48},{-78,10},{-76,10},{-76,
                9.74},{-72.225,9.74}},
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
</html>"),Diagram(coordinateSystem(extent={{-120,-100},{100,100}})));
      end Infinite_bus_simple;

      model Equation_motion_prototype
        outer SysData sysData;

        // PQ-diagram parameter
        parameter OMLET.Data.PQ_CapabilityTable pq_table=OMLET.Data.TVV_500_2;

         parameter Boolean inService_G = true "Generator topological condition"
        annotation(Dialog(tab="General"));
         parameter Real TgenOff=1000 "Time of generator's disconnection, s"
         annotation(Dialog(tab="General"));
        parameter Real dTgenOff=10 "Duration of generator's disconnection, s"
         annotation(Dialog(tab="General"));
         parameter Real Kd=5 "damping coefficient"
        annotation(Dialog(tab="Synchronous machine"));

        //------------------------------------------------------------------------------------
        parameter Real Sbaz=sysData.Sbaz "Bazis power, MWA"
        annotation(Dialog(tab="General"));
        parameter Real fbaz=sysData.fbaz "Bazic frequency, Hz"
        annotation(Dialog(tab="General"));
        parameter Real Pg = 500 "Active power, MW"
        annotation(Dialog(tab="General"));
        parameter Real Qg(fixed=false) "Reactive power";
        parameter Real Ut=20 "ARV voltage reference value"
        annotation(Dialog(tab="General"));
        parameter Real Pnom=500 "Set PV-generator power"
        annotation(Dialog(tab="General"));
        parameter Real Ugnom=20 "Nominal voltage"
        annotation(Dialog(tab="General"));
        parameter Real cosfi_nom=0.85 "Nominal maschine power coefficient, p.u."
        annotation(Dialog(tab="General"));
        parameter Real Ignom(fixed=false) "stator nomunal current, kA";

          // Limitation variables
        Real Qmax "Current limit of overexcitation, MVar";
        Real Qmin "Current limit of underexcitation, MVar";

        // Auxiliary variables for the interpolator (Modelica syntax requirement)
        Real P_clipped_max "Sliced P for Qmax interpolation";
        Real P_clipped_min "Sliced P for Qmin interpolation";
        Integer i_max_dummy;
        Integer i_min_dummy;

        parameter Real X1d_p=0.05 "D-axis transient reactance"
        annotation(Dialog(tab="Synchronous machine"));
        parameter Real Tj_p=7 "Inertia coefficient"
        annotation(Dialog(tab="Synchronous machine"));
        parameter Real Mtmax=1.1 "Turbine overloading coefficient"
        annotation(Dialog(tab="Turbine"));
        parameter Real Mtmin=0 "Turbine minimum-loading coefficient"
        annotation(Dialog(tab="Turbine"));
        parameter Real TregOff=50 "Turbine speed regulator off-time, s"
        annotation(Dialog(tab="Turbine"));

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
        parameter Real Mu0(fixed=false);
        input Real DeltaIJ;
        input Real Ssys "system slip";
        //------------------------------------------------------------------
        // Integrated Variables

        Real s "generator slip";
        Real su;
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
        OMLET.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
            Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        Interfaces.Signal_pin Mt_pin annotation (Placement(transformation(extent={{-112,
                  -10},{-92,10}}),  iconTransformation(extent={{-112,-10},{-92,10}})));
        Interfaces.Signal_pin slip_pin annotation (Placement(transformation(extent={{-10,92},
                  {10,112}}),     iconTransformation(extent={{-10,92},{10,112}})));

        Interfaces.Signal_pin Mu0_pin annotation (Placement(transformation(extent={{30,
                  92},{50,112}}), iconTransformation(extent={{32,90},{52,110}})));
      initial equation
        // additional variables in p.u.
        Ut_pu = Ut/Ugnom;
        Pg_pu = Pg/Sbaz;
        Qg_pu = Qg/Sbaz;
        Ignom = Pnom/cosfi_nom/sqrt(3)/Ugnom;


        // equations of currents, voltages, and flux densities
        s = 0;

        EQ = sqrt((Ut_pu + X1d*Qg_pu/Ut_pu)^2 + (X1d*Pg_pu/Ut_pu)^2);
        Dg = atan(X1d*Pg_pu/(Ut_pu^2 + X1d*Qg_pu));
          //----------------------
        Uq = Ut_pu*cos(Dg);
        Ud = -Ut_pu*sin(Dg);
          //----------------------

        if inService_G then
          Pg = Pgen;
          Qg=min(Qmax, max(Qmin, Qgen));
          Id = (Uq - EQ)/X1d;
          Iq = (-Ud)/X1d;
          Mu0 = EQ*Iq;
          DGi = Dg;
        else
          Qg=0;
          Id = 0;
          Iq = 0;
          Mu0 = 0;
          DGi = 0;
        end if;

      equation

          // 1. EXTRAPOLATION PROTECTION (We limit Pgen to table boundaries so that math doesn't fly away)
        P_clipped_max = max(pq_table.P_max[1], min(Pgen, pq_table.P_max[end]));
        P_clipped_min = max(pq_table.P_min[1], min(Pgen, pq_table.P_min[end]));

         // 2. AUTOMATIC INTERPOLATION AT EACH CALCULATION STEP
        // The interpolate function returns a tuple (value of I, index_interval)
        (Qmax, i_max_dummy) = Modelica.Math.Vectors.interpolate(
          pq_table.P_max,
          pq_table.Qmax,
          P_clipped_max);

        (Qmin, i_min_dummy) = Modelica.Math.Vectors.interpolate(
          pq_table.P_min,
          pq_table.Qmin,
          P_clipped_min);

        Tj = Tj_p*Pnom/Sbaz;

        X1d = X1d_p*Sbaz/Pnom*cosfi_nom;
        //--------------------------------------------------------------------------------
        der(DGi) = Wc*s;
        der(-DeltaIJ-DGi) = Wc*su;
        der(s) = (Mt_pp/(1+s) - Me/(1+s) - Kd/2*s)/Tj;

        //--------------------------------------------------------------------------------

        Me = (uq*iq + ud*id);

        id = if not inService_G then 0 else if time >= TgenOff and time < TgenOff + dTgenOff then 0 else (uq-EQ)/X1d;
        iq = if not inService_G then 0 else if time >= TgenOff and time < TgenOff + dTgenOff then 0 else -ud/X1d;

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
        Mu0 = Mu0_pin.Signal;

        slip_pin.Signal = if time >= TregOff then 0 else s;

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
                thickness=1),
              Line(
                points={{28,62},{40,98}},
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

      model Equation_motion_grid

        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[78,-4; 98,16],
          layer="icon",
          Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        Turbines.ASR_Regulator_ ASC_Regulator_1(Sigma=Sigma, Tauc=Tauc)
          annotation (Placement(transformation(extent={{-86,-20},{-20,28}})));

        parameter Real Ut=1 "ARV voltage reference value"
        annotation(Dialog(tab="General"));

        parameter Real X1d_p=0.3016 "D-axis transient reactance"
        annotation(Dialog(tab="Synchronous machine"));

        parameter Real Mtmax=1.1 "Turbine overloading coefficient";
        parameter Real Mtmin=0 "Turbine minimum-loading coefficient";

        parameter Real Sigma=0.0001 "Slip deviation control coefficient";
        parameter Real Tauc=0.0001 "Slip deviation time constant";

        parameter Boolean displayPowerFlow=true "Display power flow"
        annotation(Dialog(tab="General"));

        parameter Real Sbaz=G.sysData.Sbaz "Bazis power, MWA"
        annotation(Dialog(tab="General"));
        parameter Real fbaz=G.sysData.fbaz "Bazic frequency, Hz"
        annotation(Dialog(tab="General"));
        parameter Real cosfi_nom=0.9 "Nominal maschine power coefficient, p.u."
        annotation(Dialog(tab="Synchronous machine"));
        parameter Real Pnom=500 "Set PV-generator power"
        annotation(Dialog(tab="Synchronous machine"));
        parameter Real Ugnom=20 "Nominal voltage"
        annotation(Dialog(tab="Synchronous machine"));
        parameter Real Tj_p=7 "Inertia coefficient"
        annotation(Dialog(tab="Synchronous machine"));

        Equation_motion_prototype G(
          pq_table=pq_table,
          inService_G=inService_G,
          TgenOff=TgenOff,
          dTgenOff=dTgenOff,
          Sbaz=Sbaz,
          fbaz=fbaz,
          Pg=Pg,
          Ut=Ut,
          Pnom=Pnom,
          Ugnom=Ugnom,
          cosfi_nom=cosfi_nom,
          Kd=Kd,
          X1d_p=X1d_p,
          Tj_p=Tj_p,
          Mtmax=Mtmax,
          Mtmin=Mtmin,
          TregOff=TregOff)
          annotation (Placement(transformation(extent={{8,-22},{64,32}})));
        parameter Data.PQ_CapabilityTable pq_table=OMLET.Data.TVV_500_2
        annotation(Dialog(tab="Synchronous machine"));
        parameter Real Pg=500 "Active power, MW"
        annotation(Dialog(tab="General"));
        parameter Real Kd=5 "Damping coefficient"
        annotation(Dialog(tab="Synchronous machine"));
        parameter Real TgenOff=1000 "Time of generator's disconnection, s";
        parameter Real dTgenOff=10 "Duration of generator's disconnection, s";
        parameter Real TregOff=50 "Turbine speed regulator off-time, s";
        parameter Boolean inService_G=true "Generator topological condition"
        annotation(Dialog(tab="General"));
      initial equation
          ASC_Regulator_1.out_pin.Signal = G.Me;

      equation

        connect(G.slip_pin, ASC_Regulator_1.ds_pin) annotation (Line(
            points={{36,32.54},{36,34},{-90,34},{-90,2.08},{-86.275,2.08}},
            color={255,255,0},
            thickness=0.5));
        connect(ASC_Regulator_1.out_pin, G.Mt_pin) annotation (Line(
            points={{-20.275,4},{-2,4},{-2,5},{7.44,5}},
            color={255,255,0},
            thickness=0.5));
        connect(G.Stator_pin, inp) annotation (Line(points={{64,5},{84,5},{84,0},{100,
                0}}, color={28,108,200}));
        connect(G.Mu0_pin, ASC_Regulator_1.Mu0_pin) annotation (Line(
            points={{47.76,32},{47.76,40},{-92,40},{-92,13.12},{-86.275,13.12}},
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
</html>"),Diagram(coordinateSystem(extent={{-120,-100},{100,100}})));
      end Equation_motion_grid;

      model Equation_motion_prototype_old
        outer SysData sysData;

        // PQ-diagram parameter
        parameter OMLET.Data.PQ_CapabilityTable pq_table=OMLET.Data.TVV_500_2;

         parameter Real TgenOff=1000 "Time of generator's disconnection, s"
         annotation(Dialog(tab="General"));
        parameter Real dTgenOff=10 "Duration of generator's disconnection, s"
         annotation(Dialog(tab="General"));
         parameter Real Kd=5 "damping coefficient"
        annotation(Dialog(tab="Synchronous machine"));

        //------------------------------------------------------------------------------------
        parameter Real Sbaz=sysData.Sbaz "Bazis power, MWA"
        annotation(Dialog(tab="General"));
        parameter Real fbaz=sysData.fbaz "Bazic frequency, Hz"
        annotation(Dialog(tab="General"));
        parameter Real Pg = 500 "Active power, MW"
        annotation(Dialog(tab="General"));
        parameter Real Qg(fixed=false) "Reactive power";
        parameter Real Ut=20 "ARV voltage reference value"
        annotation(Dialog(tab="General"));
        parameter Real Pnom=500 "Set PV-generator power"
        annotation(Dialog(tab="General"));
        parameter Real Ugnom=20 "Nominal voltage"
        annotation(Dialog(tab="General"));
        parameter Real cosfi_nom=0.85 "Nominal maschine power coefficient, p.u."
        annotation(Dialog(tab="General"));
        parameter Real Ignom(fixed=false) "stator nomunal current, kA";

          // Limitation variables
        Real Qmax "Current limit of overexcitation, MVar";
        Real Qmin "Current limit of underexcitation, MVar";

        // Auxiliary variables for the interpolator (Modelica syntax requirement)
        Real P_clipped_max "Sliced P for Qmax interpolation";
        Real P_clipped_min "Sliced P for Qmin interpolation";
        Integer i_max_dummy;
        Integer i_min_dummy;

        parameter Real X1d_p=0.05 "D-axis transient reactance"
        annotation(Dialog(tab="Synchronous machine"));
        parameter Real Tj_p=7 "Inertia coefficient"
        annotation(Dialog(tab="Synchronous machine"));
        parameter Real Mtmax=1.1 "Turbine overloading coefficient"
        annotation(Dialog(tab="Turbine"));
        parameter Real Mtmin=0 "Turbine minimum-loading coefficient"
        annotation(Dialog(tab="Turbine"));
        parameter Real TregOff=50 "Turbine speed regulator off-time, s"
        annotation(Dialog(tab="Turbine"));

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

        parameter Real Mu0(fixed=false) "Turbine rotation moment initial value";
        Real Ro;
        Real Mu "Turbine valve position / moment";
        parameter Real Sigma=0.0475 "Turbine statism coefficient, p.u.";
        parameter Real TauC =0.8 "Time constant of servo motor while valving control, s";
        Real MT_MAX "Turbine overloading coefficient actual value";
        Real MT_MIN "Turbine minimum-loading coefficient actual value";

        Real Tj "Inertia coefficient actual value";
        Real f "frequency";
        parameter Real Ut_pu(fixed=false) "stator voltage, p.u.";
        parameter Real Pg_pu(fixed=false) "Active power, p.u.";
        parameter Real Qg_pu(fixed=false) "Reactive power, p.u.";
        OMLET.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
            Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));

      initial equation
        // additional variables in p.u.
        Ut_pu = Ut/Ugnom;
        Pg_pu = Pg/Sbaz;
        Qg_pu = Qg/Sbaz;
        Ignom = Pnom/cosfi_nom/sqrt(3)/Ugnom;

        Pg = Pgen;
        Qg=min(Qmax, max(Qmin, Qgen));

        // equations of currents, voltages, and flux densities
        DGi = Dg;
        s = 0;

        EQ = sqrt(((Ut_pu + X1d*Qg_pu)/Ut_pu)^2 + (X1d*Pg_pu/Ut_pu)^2);
        Dg = atan(X1d*Pg_pu/(Ut_pu^2 + X1d*Qg_pu));
          //----------------------
        Uq = Ut_pu*cos(Dg);
        Ud = -Ut_pu*sin(Dg);
          //----------------------
        Id = (Uq - EQ)/X1d;
        Iq = (-Ud)/X1d;

        Mu0 = EQ*Iq;
        Mu = Mu0;

      equation

          // 1. EXTRAPOLATION PROTECTION (We limit Pgen to table boundaries so that math doesn't fly away)
        P_clipped_max = max(pq_table.P_max[1], min(Pgen, pq_table.P_max[end]));
        P_clipped_min = max(pq_table.P_min[1], min(Pgen, pq_table.P_min[end]));

         // 2. AUTOMATIC INTERPOLATION AT EACH CALCULATION STEP
        // The interpolate function returns a tuple (value of I, index_interval)
        (Qmax, i_max_dummy) = Modelica.Math.Vectors.interpolate(
          pq_table.P_max,
          pq_table.Qmax,
          P_clipped_max);

        (Qmin, i_min_dummy) = Modelica.Math.Vectors.interpolate(
          pq_table.P_min,
          pq_table.Qmin,
          P_clipped_min);

        Tj = Tj_p*Pnom/Sbaz;

        X1d = X1d_p*Sbaz/Pnom*cosfi_nom;
        //--------------------------------------------------------------------------------
        der(DGi) = Wc*s;
        der(s) = (Mt_pp - Me - Kd*s)/Tj;

        //--------------------------------------------------------------------------------

        Me = (uq*iq + ud*id)/(1 - s);

        id = if time >= TgenOff and time < TgenOff + dTgenOff then 0 else (uq-EQ)/X1d;
        iq = if time >= TgenOff and time < TgenOff + dTgenOff then 0 else -ud/X1d;

        Ro = -Mu + Mu0 - s/Sigma;

        der(Mu) = if time >= TregOff then Ro/10e6 else Ro/TauC;
        //--------------------------------------------------------------------------------
        MT_MIN = Mtmin*Pg_pu;
        MT_MAX = Mtmax*Pg_pu;

        Mt_pp = if Mu >= MT_MIN and Mu <= MT_MAX then Mu else if Mu > MT_MAX then
          MT_MAX else MT_MIN;

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
      end Equation_motion_prototype_old;

      model SM_without_exciter_old
        outer SysData sysData;

        // PQ-diagram parameter
        parameter OMLET.Data.PQ_CapabilityTable pq_table=OMLET.Data.TVV_500_2;

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
        Real Qmax "Current limit of overexcitation, MVar";
        Real Qmin "Current limit of underexcitation, MVar";

        // Auxiliary variables for the interpolator (Modelica syntax requirement)
        Real P_clipped_max "Sliced P for Qmax interpolation";
        Real P_clipped_min "Sliced P for Qmin interpolation";
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

        OMLET.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
            Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        OMLET.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
            Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        OMLET.Interfaces.Signal_pin dUtr_pin annotation (
          extent=[-60,66; -40,86],
          layer="icon",
          Placement(transformation(extent={{-64,90},{-44,110}}, rotation=0),
              iconTransformation(extent={{-64,90},{-44,110}})));
        OMLET.Interfaces.Signal_pin dWu_pin annotation (
          extent=[-26,66; -6,86],
          layer="icon",
          Placement(transformation(extent={{-36,90},{-16,110}}, rotation=0),
              iconTransformation(extent={{-36,90},{-16,110}})));
        OMLET.Interfaces.Signal_pin dWf_pin annotation (
          extent=[6,66; 26,86],
          layer="icon",
          Placement(transformation(extent={{-10,90},{10,110}}, rotation=0),
              iconTransformation(extent={{-10,90},{10,110}})));
        OMLET.Interfaces.Signal_pin dIf_pin annotation (
          extent=[40,66; 60,86],
          layer="icon",
          Placement(transformation(extent={{18,90},{38,110}}, rotation=0),
              iconTransformation(extent={{18,90},{38,110}})));
        OMLET.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
                extent={{46,90},{66,110}}), iconTransformation(extent={{46,90},
                  {66,110}})));
        Interfaces.Signal_pin       Er0_pin
          annotation (Placement(transformation(extent={{70,90},{90,110}}),
              iconTransformation(extent={{70,90},{90,110}})));
        Interfaces.Signal_pin       Ugen_pin
          annotation (Placement(transformation(extent={{-90,90},{-70,110}}),
              iconTransformation(extent={{-90,90},{-70,110}})));
        Interfaces.Signal_pin dIg_pin annotation (Placement(transformation(extent={{94,90},
                  {114,110}}),     iconTransformation(extent={{94,90},{114,110}})));
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

        // 1. EXTRAPOLATION PROTECTION (We limit Pgen to table boundaries so that math doesn't fly away)
        P_clipped_max = max(pq_table.P_max[1], min(Pgen, pq_table.P_max[end]));
        P_clipped_min = max(pq_table.P_min[1], min(Pgen, pq_table.P_min[end]));

         // 2. AUTOMATIC INTERPOLATION AT EACH CALCULATION STEP
        // The interpolate function returns a tuple (value of I, index_interval)
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
        der(s) = (Mt_pp/(1+s) - Me/(1+s) - Kd*s)/Tj;

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
      end SM_without_exciter_old;

      model SM_with_exciter_and_AVR_SD_old

        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[78,-4; 98,16],
          layer="icon",
          Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
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
        parameter Data.PQ_CapabilityTable pq_table=OMLET.Data.TVV_500_2
         annotation(Dialog(tab="Synchronous machine"));
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
</html>"),Diagram(coordinateSystem(extent={{-180,-100},{100,100}})));
      end SM_with_exciter_and_AVR_SD_old;

      model SM_EMF_Form "Синхронная машина в форме ЭДС (Рустаб-стиль)"
        outer SysData sysData;

        // PQ-diagram parameter
        parameter OMLET.Data.PQ_CapabilityTable pq_table=OMLET.Data.TVV_500_2;

        parameter Boolean inService_G = true "Generator topological condition"
        annotation(Dialog(tab="General"));
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
        Real Qmax "Current limit of overexcitation, MVar";
        Real Qmin "Current limit of underexcitation, MVar";

        Real P_clipped_max;
        Real P_clipped_min;
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

        Real Xad "D-axis resistance to mutual induction";

        parameter Real Tj_p=7 "Inertia coefficient, s"
         annotation(Dialog(tab="Synchronous machine"));
        parameter Real Td0=10 "D-axis transient time constant, s"
         annotation(Dialog(tab="Synchronous machine"));
        parameter Real T2d_p=0.02 "D-axis subtransient time constant, s"
         annotation(Dialog(tab="Synchronous machine"));
        parameter Real T2q_p=0.05 "Q-axis subtransient time constant, s"
         annotation(Dialog(tab="Synchronous machine"));

        parameter Real TregOff=50 "Turbine speed regulator off-time, s"
         annotation(Dialog(tab="Turbine"));
        parameter Real Mtmax=1.1 "Turbine overloading coefficient, p.u."
         annotation(Dialog(tab="Turbine"));
        parameter Real Mtmin=0 "Turbine minimum-loading coefficient, p.u."
         annotation(Dialog(tab="Turbine"));
        parameter Real TkzOn=1000 "Generators dropping on-time, s"
         annotation(Dialog(tab="General"));
        parameter Real Pg_new=100 "New power of power plant, MW"
         annotation(Dialog(tab="General"));

        //------------------------------------------------------------------------------------
        Real dUtr, dWu, dIf, dWf;
        Real Er;
        constant Real PI=4*atan(1);
        parameter Real Wc=2*PI*fbaz;
        parameter Real Xt=0.0;

        constant Real Ra=0;
        constant Real Rt=0;
        parameter Real EQ(fixed=false);
        parameter Real Dg(fixed=false);
        parameter Real Uq(fixed=false);
        parameter Real Ud(fixed=false);
        parameter Real Id(fixed=false);
        parameter Real Iq(fixed=false);
        parameter Real Er0(fixed=false);
        parameter Real Ir(fixed=false);

        Real Ugen, Igen;
        parameter Real Mu0(fixed=false);
        Real Mt_pp, Pgen, Qgen, UdG, UqG, IdG, IqG;
        input Real DeltaIJ;
        input Real Ssys;

        // Integrated Variables (ЭДС вместо потоков)
        Real Eqp "Transient EMF E'q";
        Real Eqpp "Subtransient EMF E''q";
        Real Edpp "Subtransient EMF E''d";
        Real s "generator slip";
        Real DGi "Generator power angle";
        Real Me "electrical moment";

        Real id, iq, ud, uq, ir;
        Real MT_MAX, MT_MIN;
        Real Xd, Xq, Xs, X1d, X2d, X2q, Tj, f;

        parameter Real Ut_pu(fixed=false);
        parameter Real Pg_pu(fixed=false);
        parameter Real Qg_pu(fixed=false);

        OMLET.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
            Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        OMLET.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
            Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        OMLET.Interfaces.Signal_pin dUtr_pin annotation (
          extent=[-60,66; -40,86],
          layer="icon",
          Placement(transformation(extent={{-64,90},{-44,110}}, rotation=0),
              iconTransformation(extent={{-64,90},{-44,110}})));
        OMLET.Interfaces.Signal_pin dWu_pin annotation (
          extent=[-26,66; -6,86],
          layer="icon",
          Placement(transformation(extent={{-36,90},{-16,110}}, rotation=0),
              iconTransformation(extent={{-36,90},{-16,110}})));
        OMLET.Interfaces.Signal_pin dWf_pin annotation (
          extent=[6,66; 26,86],
          layer="icon",
          Placement(transformation(extent={{-10,90},{10,110}}, rotation=0),
              iconTransformation(extent={{-10,90},{10,110}})));
        OMLET.Interfaces.Signal_pin dIf_pin annotation (
          extent=[40,66; 60,86],
          layer="icon",
          Placement(transformation(extent={{18,90},{38,110}}, rotation=0),
              iconTransformation(extent={{18,90},{38,110}})));
        OMLET.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
                extent={{46,90},{66,110}}), iconTransformation(extent={{46,90},
                  {66,110}})));
        Interfaces.Signal_pin       Er0_pin
          annotation (Placement(transformation(extent={{70,90},{90,110}}),
              iconTransformation(extent={{70,90},{90,110}})));
        Interfaces.Signal_pin       Ugen_pin
          annotation (Placement(transformation(extent={{-90,90},{-70,110}}),
              iconTransformation(extent={{-90,90},{-70,110}})));
        Interfaces.Signal_pin dIg_pin annotation (Placement(transformation(extent={{94,90},
                  {114,110}}),     iconTransformation(extent={{94,90},{114,110}})));
        Interfaces.Signal_pin slip_pin annotation (Placement(transformation(extent={{-110,
                  30},{-90,50}}), iconTransformation(extent={{-110,30},{-90,50}})));
        Interfaces.Signal_pin Mu0_pin annotation (Placement(transformation(extent={{-110,66},
                  {-90,86}}),       iconTransformation(extent={{-110,66},{-90,86}})));
        Interfaces.Signal_pin Mt_pin annotation (Placement(transformation(extent={{-110,
                  66},{-90,86}}), iconTransformation(extent={{-110,-48},{-90,-28}})));
      initial equation
        // additional variables in p.u.
        Ut_pu = Ut/Ugnom;
        Pg_pu = Pg/Sbaz;
        Qg_pu = Qg/Sbaz;
        Ignom = Pnom/cosfi_nom/sqrt(3)/Ugnom;


        // equations of currents, voltages, and flux densities
        s = 0;

        EQ = sqrt((Ut_pu + ((Ra + Rt)*Pg_pu + (Xq + Xt)*Qg_pu)/Ut_pu)^2 + (((Xq + Xt)*Pg_pu - (Ra + Rt)*Qg_pu)/Ut_pu)^2);
        Dg = atan((((Xq + Xt)*Pg_pu - (Ra + Rt)*Qg_pu)/Ut_pu)/(Ut_pu + ((Ra + Rt)*Pg_pu + (Xq + Xt)*Qg_pu)/Ut_pu));

        Uq = Ut_pu*cos(Dg);
        Ud = -Ut_pu*sin(Dg);

        Er0  = Eqp - Id*(Xd - X1d);
        Ir = Er0/Xad;

        if inService_G then
          Qg=min(Qmax, max(Qmin, Qgen));
          Pg=Pgen;
          Id = ((Uq - EQ)*(Xq + Xt) - (Ra + Rt)*Ud)/((Ra + Rt)^2 + (Xq + Xt)^2);
          Iq = (-Ud - (Ra + Rt)*Id)/(Xq + Xt);
          Mu0 = EQ*Iq;
          DGi = Dg;
          Eqpp = Uq - Id*X2d;
          Edpp = Ud + Iq*X2q;
          Eqp  = Eqpp - Id*(X1d - X2d);
        else
          Qg=0;
          Id = 0;
          Iq = 0;
          Mu0 = 0;
          DGi = 0;
          Eqpp = 0;
          Edpp = 0;
          Eqp  = 0;
        end if;


      equation
        P_clipped_max = max(pq_table.P_max[1], min(Pgen, pq_table.P_max[end]));
        P_clipped_min = max(pq_table.P_min[1], min(Pgen, pq_table.P_min[end]));

        (Qmax, i_max_dummy) = Modelica.Math.Vectors.interpolate(pq_table.P_max, pq_table.Qmax, P_clipped_max);
        (Qmin, i_min_dummy) = Modelica.Math.Vectors.interpolate(pq_table.P_min, pq_table.Qmin, P_clipped_min);

        // Пересчет параметров на системную базу
        Xad = Xd - Xs;

        Xd  = if time < TkzOn then Xd_p*Sbaz/Pnom*cosfi_nom else Xd_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
        Xq  = if time < TkzOn then Xq_p*Sbaz/Pnom*cosfi_nom else Xq_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
        Xs  = if time < TkzOn then Xs_p*Sbaz/Pnom*cosfi_nom else Xs_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
        X1d = if time < TkzOn then X1d_p*Sbaz/Pnom*cosfi_nom else X1d_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
        X2d = if time < TkzOn then X2d_p*Sbaz/Pnom*cosfi_nom else X2d_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
        X2q = if time < TkzOn then X2q_p*Sbaz/Pnom*cosfi_nom else X2q_p*Sbaz/Pnom*cosfi_nom*Pg/Pg_new;
        Tj  = if time < TkzOn then Tj_p*Pnom/Sbaz else Tj_p*Pnom/Sbaz*Pg_new/Pg;

        // --- ДИФФЕРЕНЦИАЛЬНЫЕ УРАВНЕНИЯ МОДЕЛИ ПГО (РУСТАБ) ---
        Td0*der(Eqp) = Er - Eqp + id*(Xd - X1d);
        T2d_p*der(Eqpp) = Eqp - Eqpp + id*(X1d - X2d);
        T2q_p*der(Edpp) = -Edpp - iq*(Xq - X2q);

        der(DGi) = Wc*s;
        der(s)   = (Mt_pp/(1+s) - Me/(1+s) - Kd/2*s)/Tj;

        MT_MIN = if time < TkzOn then Mtmin*Pg_pu else Pg_new/Sbaz - 0.01;
        MT_MAX = if time < TkzOn then Mtmax*Pg_pu else Pg_new/Sbaz + 0.01;

        // --- АЛГЕБРАИЧЕСКИЕ СВЯЗИ СТАТОРА И ТОКОВ ---
        id = if not inService_G then 0 else if time >= TgenOff and time < TgenOff + dTgenOff then 0 else (uq - Eqpp)/X2d;
        iq = if not inService_G then 0 else if time >= TgenOff and time < TgenOff + dTgenOff then 0 else (-ud + Edpp)/X2q;
        ir = if not inService_G then 0 else if time >= TgenOff and time < TgenOff + dTgenOff then 0 else (Eqp - id*(Xd - X1d))/Xad;


        Me = Eqpp*iq + Edpp*id + (X2d - X2q)*id*iq;

        Ugen = (sqrt(ud^2 + uq^2))*Ugnom;
        Igen = (sqrt(IqG^2 + IdG^2))*Sbaz/sqrt(3)/Ugnom;
        dUtr = sqrt(ud^2 + uq^2) - Ut_pu;
        dWu  = Wc*Ssys; // Ssys приходит извне как input
        dWf  = if UqG > 0.0 or UqG < 0.0 then atan2(UdG, UqG) else atan2(UdG, 0.001);
        dIf  = (ir - Ir)*Xad;

        Pgen = (uq*iq + ud*id)*Sbaz;
        Qgen = (-uq*id + ud*iq)*Sbaz;

        // Связь осей ротора и сети через DeltaIJ (приходит извне как input)
        uq = UqG*cos(DeltaIJ) - UdG*sin(DeltaIJ);
        ud = UqG*sin(DeltaIJ) + UdG*cos(DeltaIJ);

        IqG = iq*cos(DeltaIJ) + id*sin(DeltaIJ);
        IdG = id*cos(DeltaIJ) - iq*sin(DeltaIJ);

        f = Wc*(1-s)/2/PI;

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

        Mt_pp = max(MT_MIN, min(MT_MAX,Mt_pin.Signal))  "таким хитрым образом выбирается сигнал с регулятора, если он не ограничен Mtmax, Mtmin";
        slip_pin.Signal = if time >= TregOff then 0 else s;
        Mu0 = Mu0_pin.Signal;


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
                thickness=1),
              Line(
                points={{-64,14},{-98,40}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-64,-14},{-100,-42}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-80,58},{-98,76}},
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
      end SM_EMF_Form;
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
        OMLET.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
            Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        OMLET.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
            Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        OMLET.Interfaces.Signal_pin dUtr_pin annotation (
          extent=[-60,66; -40,86],
          layer="icon",
          Placement(transformation(extent={{-64,90},{-44,110}}, rotation=0),
              iconTransformation(extent={{-64,90},{-44,110}})));
        OMLET.Interfaces.Signal_pin dWu_pin annotation (
          extent=[-26,66; -6,86],
          layer="icon",
          Placement(transformation(extent={{-36,90},{-16,110}}, rotation=0),
              iconTransformation(extent={{-36,90},{-16,110}})));
        OMLET.Interfaces.Signal_pin dWf_pin annotation (
          extent=[6,66; 26,86],
          layer="icon",
          Placement(transformation(extent={{-10,90},{10,110}}, rotation=0),
              iconTransformation(extent={{-10,90},{10,110}})));
        OMLET.Interfaces.Signal_pin dIf_pin annotation (
          extent=[40,66; 60,86],
          layer="icon",
          Placement(transformation(extent={{18,90},{38,110}}, rotation=0),
              iconTransformation(extent={{18,90},{38,110}})));
        OMLET.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
                extent={{46,90},{66,110}}), iconTransformation(extent={{46,90},
                  {66,110}})));
        Interfaces.Signal_pin Pg_pin annotation (Placement(transformation(extent={{-110,
                  -38},{-90,-18}}), iconTransformation(extent={{-110,-38},{-90,-18}})));
        Interfaces.Signal_pin slip_pin annotation (Placement(transformation(extent={{76,
                  90},{96,110}}), iconTransformation(extent={{76,90},{96,110}})));

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
        OMLET.Interfaces.Pin_v2 Stator_pin annotation (extent=[68,-8; 88,12],
            Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        OMLET.Interfaces.Signal_pin Ef_pin annotation (extent=[-90,-8; -70,12],
            Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        OMLET.Interfaces.Signal_pin dUtr_pin annotation (
          extent=[-60,66; -40,86],
          layer="icon",
          Placement(transformation(extent={{-64,90},{-44,110}}, rotation=0),
              iconTransformation(extent={{-64,90},{-44,110}})));
        OMLET.Interfaces.Signal_pin dWu_pin annotation (
          extent=[-26,66; -6,86],
          layer="icon",
          Placement(transformation(extent={{-36,90},{-16,110}}, rotation=0),
              iconTransformation(extent={{-36,90},{-16,110}})));
        OMLET.Interfaces.Signal_pin dWf_pin annotation (
          extent=[6,66; 26,86],
          layer="icon",
          Placement(transformation(extent={{-10,90},{10,110}}, rotation=0),
              iconTransformation(extent={{-10,90},{10,110}})));
        OMLET.Interfaces.Signal_pin dIf_pin annotation (
          extent=[40,66; 60,86],
          layer="icon",
          Placement(transformation(extent={{18,90},{38,110}}, rotation=0),
              iconTransformation(extent={{18,90},{38,110}})));
        OMLET.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
                extent={{46,90},{66,110}}), iconTransformation(extent={{46,90},
                  {66,110}})));
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

        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[78,-4; 98,16],
          layer="icon",
          Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        OMLET.Basic.Excitation_systems.Regulators.AVR_standart AVR annotation (
            extent=[-84,-90; -32,82], Placement(transformation(extent={{-84,-90},
                  {-32,82}}, rotation=0)));
        OMLET.Basic.Generators.Per_units.SM G annotation (extent=[-28,-72; 70,
              80], Placement(transformation(extent={{-28,-72},{70,80}},
                rotation=0)));
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
    annotation (Icon(graphics={Bitmap(extent={{-106,-130},{160,132}}, fileName=
                "modelica://OMLET/Images/vecteezy_black-electric-motor-icon-with-cooling-fins-and-shaft-on_87172233/vecteezy_black-electric-motor-icon-with-cooling-fins-and-shaft-on_87172233.jpg")}),
        Documentation(info="<html>
<p>The image is downloaded from https://www.vecteezy.com/</p>
</html>"));
  end Generators;

  package Branches

    package Branches_numerical_units
      model El_Braking_Series
        outer SysData sysData;

        parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
        parameter Real Unom=20 "Nominal voltage, kV";
        parameter Real Rline=0.2 "Active resistance of electrical braking device, Ω";
        parameter Real Rl(fixed=false) "Active resistance of electrical braking device, p.u.";
        //---------------------------------------------
        parameter Real TLineOff=1000 "Time of electrical braking";
        parameter Real dTLineOff=10 "Duration of electrical braking";
        //---------------------------------------------

        Real U1d "D-axis voltage at the beginning of series electrical braking";
        Real U1q "Q-axis voltage at the beginning of series electrical braking";
        Real U2d "D-axis voltage at the end of series electrical braking";
        Real U2q "Q-axis voltage at the end of series electrical braking";
        Real I12d "D-axis current of series electrical braking";
        Real I12q "Q-axis current of series electrical braking";
        Real I12m "Full current of series electrical braking";
        Real U1m "Full voltage at the beginning of series electrical braking";
        Real U2m "Full voltage at the end of series electrical braking";
        Real RL "Actual resistanse of series electrical braking";
        OMLET.Interfaces.Pin_v2 inp annotation (extent=[-98,0; -78,20],
            Placement(transformation(extent={{-110,-26},{-90,-6}}, rotation=0),
              iconTransformation(extent={{-110,-26},{-90,-6}})));
        OMLET.Interfaces.Pin_v2 out annotation (extent=[78,0; 98,20], Placement(
              transformation(extent={{90,-26},{110,-6}}, rotation=0),
              iconTransformation(extent={{90,-26},{110,-6}})));
      initial equation
        // conversion from Ω to p.u.
        Rl = Rline/Unom^(2)*Sbaz;

      equation
        // the algorithm of series electrical braking start
        RL = if time >= TLineOff and time < TLineOff + dTLineOff then Rl else 0;

        //---------series impedance between nodes--------------------
        U1q = U2q + RL*I12q;
        U1d = U2d + RL*I12d;

        //---------measurements--------------------------------------
        I12m = (sqrt(I12d^2 + I12q^2))*Sbaz/Unom/sqrt(3);
        U1m = (sqrt(U1d^2 + U1q^2))*Unom;
        U2m = (sqrt(U2d^2 + U2q^2))*Unom;

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
                extent={{-38,0},{42,-32}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-38,-16},{-92,-16}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{94,-16},{42,-16}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-58,-16},{-58,14},{-18,14}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{22,14},{62,14},{62,-16}},
                color={0,0,255},
                thickness=1.0),
              Rectangle(
                extent={{-18,22},{22,20}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{24,12},{20,16}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-16,12},{-20,16}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Text(extent={{-98,70},{102,30}},
                textColor={0,0,0},
                textString="%name")},
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
<p><span style=\"background-color: #ffffff;\">Model of series electric braking device. </span></p>
<p><span style=\"background-color: #ffffff;\">Модель устройства последовательного электрического торможения.</span></p>
</html>"));
      end El_Braking_Series;

      model Breaker
        outer SysData sysData;

        parameter Boolean inService = true "breaker topological condition";
        parameter Real R_off = 1e8 "disconnecrion resistance, p.u.";
        parameter Real G_off = 1e-5 "transverse grounding conductivity, p.u.";

        parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
        parameter Real Unom=330 "Nominal line voltage, kV";
        //---------------------------------------------
        parameter Real TLineOff=1000 "Time of line disconnection, s";
        parameter Real dTLineOff=10 "Duration of line disconnection, s";
        parameter Real Koff=2 "Degree of line disconnection, p.u.";
        parameter Real TLineOff_1=2000 "Time of line second disconnection, s";
        parameter Real dTLineOff_1=20 "Duration of line second disconnection, s";
        parameter Real Koff_1=4 "Degree of line second disconnection, p. u.";

        parameter Boolean displayPowerFlow=true "Display power flow";
        //---------------------------------------------

        Real U1d "D-axis voltage at the beginning of HVline";
        Real U1q "Q-axis voltage at the beginning of HVline";
        Real U2d "D-axis voltage at the end of HVline";
        Real U2q "Q-axis voltage at the end of HVline";
        Real I12d "D-axis current in the middle of HVline";
        Real I12q "Q-axis current in the middle of HVline";
        Real I12m "Full current in the middle of HVline";
        Real U1m "Full voltage at the beginning of HVline";
        Real U2m "Full voltage at the end of HVline";

        flow Real I1d "D-axis current at the beginning of HVline";
        flow Real I1q "Q-axis current at the beginning of HVline";
        flow Real I2d "D-axis current at the end of HVline";
        flow Real I2q "Q-axis current at the end of HVline";

        Real Idc1 "D-axis capacitive current at the beginning of HVline";
        Real Iqc1 "Q-axis capacitive current at the beginning of HVline";
        Real Idc2 "D-axis capacitive current at the end of HVline";
        Real Iqc2 "Q-axis capacitive current at the end of HVline";
        Real DU1 "angle at the beginning of HVline";
        Real DU2 "angle at the end of HVline";
        Real P1 "active power at the beginning of HVline";
        Real Q1 "reactive power at the beginning of HVline";
        Real P2 "active power at the end of HVline";
        Real Q2 "reactive power at the end of HVline";
        Real RL "actual active resistance of HVline";
        Real XL "actual reactive resistance of HVline";
        Real G_gnd1 "calculation grounding conductivity";
        Real G_gnd2 "calculation grounding conductivity";

        OMLET.Interfaces.Pin_v2 inp annotation (extent=[-86,40; -66,60],
            Placement(transformation(extent={{-108,-12},{-88,8}}, rotation=0),
              iconTransformation(extent={{-108,-12},{-88,8}})));
        OMLET.Interfaces.Pin_v2 out annotation (extent=[68,42; 88,62],
            Placement(transformation(extent={{90,-12},{110,8}}, rotation=0),
              iconTransformation(extent={{90,-12},{110,8}})));
      equation
        // the algorithm of triping transmission line
        RL = if not inService then R_off else
        (if (time >= TLineOff and time < TLineOff + dTLineOff) then (R_off)
          else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (R_off) else (0.00001)));
        XL = if not inService then R_off else
        (if (time >= TLineOff and time < TLineOff + dTLineOff) then (R_off)
          else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (R_off) else (0.00001)));
        G_gnd1 = if not inService then G_off else 0.00001;
        G_gnd2 = if not inService then G_off else 0.00001;

        // series impedance between nodes
        U1q = U2q + RL*I12q - XL*I12d;
        U1d = U2d + RL*I12d + XL*I12q;

        // line capacitances
        Idc1 = U1d*G_gnd1;
        Iqc1 = U1q*G_gnd1;
        Idc2 = U2d*G_gnd2;
        Iqc2 = U2q*G_gnd2;

        // balance of current
        I1d = Idc1 + I12d;
        I1q = Iqc1 + I12q;
        I12d = Idc2 + I2d;
        I12q = Iqc2 + I2q;

        // measurements
        I12m = (sqrt(I12d^2 + I12q^2))*Sbaz/Unom/sqrt(3);
        U1m = (sqrt(U1d^2 + U1q^2))*Unom;
        U2m = (sqrt(U2d^2 + U2q^2))*Unom;
        DU1 = atan2(U1d, U1q);
        DU2 = atan2(U2d, U2q);

        // powers
        P1 = (U1q*I1q + U1d*I1d)*Sbaz;
        Q1 = (-U1q*I1d + U1d*I1q)*Sbaz;
        P2 = (U2q*I2q + U2d*I2d)*Sbaz;
        Q2 = (-U2q*I2d + U2d*I2q)*Sbaz;

        //---connector1---
        inp.Vd = U1d;
        inp.Vq = U1q;
        inp.Id = -I1d;
        inp.Iq = -I1q;

        ////---connector2---
        out.Vd = U2d;
        out.Vq = U2q;
        out.Id = I2d;
        out.Iq = I2q;

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
              extent={{-100,-140},{100,100}},
              grid={2,2},
              initialScale=0), graphics),
          Icon(
            coordinateSystem(
              preserveAspectRatio=false,
              preserveOrientation=false,
              extent={{-100,-140},{100,100}},
              grid={2,2},
              initialScale=0),
            graphics={
              Text(extent={{-64,96},{64,64}},
                textColor={0,0,0},
                textString="%name"),
              Text(
                textString=DynamicSelect("P MW",
                if P1>=0 then
                  String(P1, significantDigits=3) + " MW →"
                else
                  String(abs(P1), significantDigits=3) + " MW ←"),
                visible=displayPowerFlow,
                extent={{-96,-70},{102,-108}},
                textColor={0,168,6}),
              Text(
                textString=DynamicSelect("Q MVar",
                if Q1>=0 then
                  String(Q1, significantDigits=3) + " MVar →"
                else
                  String(abs(Q1), significantDigits=3) + " MVar ←"),
                visible=displayPowerFlow,
                extent={{-94,-96},{104,-134}},
                textColor={102,44,145}),
              Line(
                points={{-20,0},{-98,0}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{30,-2},{30,32}},
                lineColor={0,0,255},
                lineThickness=2.5,
                visible=DynamicSelect(not inService, not inService)),
              Text(
                extent={{-34,30},{36,-76}},
                textColor={255,0,0},
                textString="DISC",
                visible=DynamicSelect(not inService, not inService)),
              Rectangle(
                extent={{-40,46},{40,-48}},
                lineColor={0,0,255},
                lineThickness=1),
              Line(
                points={{100,0},{30,0}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{28,30},{-20,0}},
                color={0,0,255},
                thickness=1.0)},
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
<p>Breaker model.</p>
<p>Модель выключателя. </p>
</html>"));
      end Breaker;

      model HVline
        outer SysData sysData;

        parameter Boolean inService = true "HVline topological condition"
        annotation(Dialog(tab="General"));
        parameter Real R_off = 1e8 "disconnecrion resistance, p.u."
        annotation(Dialog(tab="P-model parameters"));
        parameter Real G_off = 1e-5 "transverse grounding conductivity, p.u."
        annotation(Dialog(tab="P-model parameters"));

        parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA"
        annotation(Dialog(tab="General"));
        parameter Real Unom=330 "Nominal line voltage, kV"
        annotation(Dialog(tab="General"));
        parameter Real Rline=0.01 "Active resistance of Pi-model, Ω"
        annotation(Dialog(tab="P-model parameters"));
        parameter Real Xline=0.1 "Reactance of Pi-model, Ω"
        annotation(Dialog(tab="P-model parameters"));
        parameter Real Bline1=0 "Reactive conductivity of Pi-model beginning, mkS"
        annotation(Dialog(tab="P-model parameters"));
        parameter Real Bline2=0 "Reactive conductivity of Pi-model end, mkS"
        annotation(Dialog(tab="P-model parameters"));
        //---------------------------------------------
        parameter Real TLineOff=1000 "Time of line disconnection, s"
        annotation(Dialog(tab="General"));
        parameter Real dTLineOff=10 "Duration of line disconnection, s"
        annotation(Dialog(tab="General"));
        parameter Real Koff=2 "Degree of line disconnection, p.u."
        annotation(Dialog(tab="General"));
        parameter Real TLineOff_1=2000 "Time of line second disconnection, s"
        annotation(Dialog(tab="General"));
        parameter Real dTLineOff_1=20 "Duration of line second disconnection, s"
        annotation(Dialog(tab="General"));
        parameter Real Koff_1=4 "Degree of line second disconnection, p. u."
        annotation(Dialog(tab="General"));

        parameter Boolean displayPowerFlow=true "Display power flow"
        annotation(Dialog(tab="General"));
        //---------------------------------------------

        Real U1d "D-axis voltage at the beginning of HVline";
        Real U1q "Q-axis voltage at the beginning of HVline";
        Real U2d "D-axis voltage at the end of HVline";
        Real U2q "Q-axis voltage at the end of HVline";
        Real I12d "D-axis current in the middle of HVline";
        Real I12q "Q-axis current in the middle of HVline";
        Real I12m "Full current in the middle of HVline";
        Real U1m "Full voltage at the beginning of HVline";
        Real U2m "Full voltage at the end of HVline";

        flow Real I1d "D-axis current at the beginning of HVline";
        flow Real I1q "Q-axis current at the beginning of HVline";
        flow Real I2d "D-axis current at the end of HVline";
        flow Real I2q "Q-axis current at the end of HVline";

        Real Idc1 "D-axis capacitive current at the beginning of HVline";
        Real Iqc1 "Q-axis capacitive current at the beginning of HVline";
        Real Idc2 "D-axis capacitive current at the end of HVline";
        Real Iqc2 "Q-axis capacitive current at the end of HVline";
        Real DU1 "angle at the beginning of HVline";
        Real DU2 "angle at the end of HVline";
        Real P1 "active power at the beginning of HVline";
        Real Q1 "reactive power at the beginning of HVline";
        Real P2 "active power at the end of HVline";
        Real Q2 "reactive power at the end of HVline";
        Real RL "actual active resistance of HVline";
        Real XL "actual reactive resistance of HVline";
        Real BL1 "capacitive conductivity at the beginning of HVline";
        Real BL2 "capacitive conductivity at the end of HVline";
        Real G_gnd1 "calculation grounding conductivity";
        Real G_gnd2 "calculation grounding conductivity";

        OMLET.Interfaces.Pin_v2 inp annotation (extent=[-86,40; -66,60],
            Placement(transformation(extent={{-108,-12},{-88,8}}, rotation=0),
              iconTransformation(extent={{-108,-12},{-88,8}})));
        OMLET.Interfaces.Pin_v2 out annotation (extent=[68,42; 88,62],
            Placement(transformation(extent={{90,-12},{110,8}}, rotation=0),
              iconTransformation(extent={{90,-12},{110,8}})));
      equation
        // the algorithm of triping transmission line
        RL = if not inService then R_off else
        (if (time >= TLineOff and time < TLineOff + dTLineOff) then (Koff*Rline*Sbaz/Unom^(2))
          else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Koff_1*Rline*Sbaz/Unom^(2)) else (Rline*Sbaz/Unom^(2))));
        XL = if not inService then R_off else
        (if (time >= TLineOff and time < TLineOff + dTLineOff) then (Koff*Xline*Sbaz/Unom^(2))
          else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Koff_1*Xline*Sbaz/Unom^(2)) else (Xline*Sbaz/Unom^(2))));
        BL1 = if not inService then 0 else
        (if (time >= TLineOff and time < TLineOff + dTLineOff) then (Bline1/Sbaz*Unom^(2)/10^(6)/Koff)
          else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Bline1/Sbaz*Unom^(2)/10^(6)/Koff_1) else (Bline1/Sbaz*Unom^(2)/10^(6))));
        BL2 = if not inService then 0 else
        (if (time >= TLineOff and time < TLineOff + dTLineOff) then (Bline2/Sbaz*Unom^(2)/10^(6)/Koff)
          else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (Bline2/Sbaz*Unom^(2)/10^(6)/Koff_1) else (Bline2/Sbaz*Unom^(2)/10^(6))));
        G_gnd1 = if not inService then G_off else 0.0;
        G_gnd2 = if not inService then G_off else 0.0;

        // series impedance between nodes
        U1q = U2q + RL*I12q - XL*I12d;
        U1d = U2d + RL*I12d + XL*I12q;

        // line capacitances
        Idc1 = U1q*BL1 + U1d*G_gnd1;
        Iqc1 = -U1d*BL1 + U1q*G_gnd1;
        Idc2 = U2q*BL2 + U2d*G_gnd2;
        Iqc2 = -U2d*BL2 + U2q*G_gnd2;

        // balance of current
        I1d = Idc1 + I12d;
        I1q = Iqc1 + I12q;
        I12d = Idc2 + I2d;
        I12q = Iqc2 + I2q;

        // measurements
        I12m = (sqrt(I12d^2 + I12q^2))*Sbaz/Unom/sqrt(3);
        U1m = (sqrt(U1d^2 + U1q^2))*Unom;
        U2m = (sqrt(U2d^2 + U2q^2))*Unom;
        DU1 = atan2(U1d, U1q);
        DU2 = atan2(U2d, U2q);

        // powers
        P1 = (U1q*I1q + U1d*I1d)*Sbaz;
        Q1 = (-U1q*I1d + U1d*I1q)*Sbaz;
        P2 = (U2q*I2q + U2d*I2d)*Sbaz;
        Q2 = (-U2q*I2d + U2d*I2q)*Sbaz;

        //---connector1---
        inp.Vd = U1d;
        inp.Vq = U1q;
        inp.Id = -I1d;
        inp.Iq = -I1q;

        ////---connector2---
        out.Vd = U2d;
        out.Vq = U2q;
        out.Id = I2d;
        out.Iq = I2q;

              // ТЕКСТ "ОТКЛ" (опционально)

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
              extent={{-100,-140},{100,100}},
              grid={2,2},
              initialScale=0), graphics),
          Icon(
            coordinateSystem(
              preserveAspectRatio=false,
              preserveOrientation=false,
              extent={{-100,-140},{100,100}},
              grid={2,2},
              initialScale=0),
            graphics={
              Rectangle(
                extent={{32,32},{36,26}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Line(
                points={{0,62},{-30,-60}},
                color={0,0,255},
                thickness=1.0),
              Text(extent={{-64,96},{64,64}},
                textColor={0,0,0},
                textString="%name"),
              Text(
                textString=DynamicSelect("P MW",
                if P1>=0 then
                  String(P1, significantDigits=3) + " MW →"
                else
                  String(abs(P1), significantDigits=3) + " MW ←"),
                visible=displayPowerFlow,
                extent={{-96,-70},{102,-108}},
                textColor={0,168,6}),
              Text(
                textString=DynamicSelect("Q MVar",
                if Q1>=0 then
                  String(Q1, significantDigits=3) + " MVar →"
                else
                  String(abs(Q1), significantDigits=3) + " MVar ←"),
                visible=displayPowerFlow,
                extent={{-94,-96},{104,-134}},
                textColor={102,44,145}),
              Line(
                points={{0,62},{32,-60}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{24,-32},{-30,-60}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-18,-10},{24,-32}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-18,-10},{14,6}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{14,6},{-10,20}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{8,30},{-10,20}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-6,40},{8,30}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-48,0},{50,0}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-28,40},{30,40}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-28,40},{-40,32}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{40,32},{30,40}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-48,0},{-60,-8}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{60,-8},{50,0}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-40,32},{40,32}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-60,-8},{60,-8}},
                color={0,0,255},
                thickness=1.0),
              Rectangle(
                extent={{-60,-60},{60,-66}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-36,32},{-32,26}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-56,-8},{-52,-14}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{52,-8},{56,-14}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-48,-8},{-48,0}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{50,-8},{50,0}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-28,32},{-28,40}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-40,0},{-48,-8}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-32,-8},{-32,0}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-24,0},{-32,-8}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-16,-8},{-16,0}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-8,0},{-16,-8}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{0,-8},{0,0}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{8,0},{0,-8}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{16,-8},{16,0}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{24,0},{16,-8}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{32,-8},{32,0}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{40,0},{32,-8}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-20,40},{-28,32}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-12,32},{-12,40}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-4,40},{-12,32}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{4,32},{4,40}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{12,40},{4,32}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{20,32},{20,40}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{28,40},{20,32}},
                color={0,0,255},
                thickness=1.0),
              Ellipse(
                extent={{-2,64},{2,60}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-40,40},{40,-40}},
                lineColor={255,0,0},
                lineThickness=3.5,
                visible=DynamicSelect(not inService, not inService)),
              Line(
                points={{-40,-40},{40,40}},
                lineColor={255,0,0},
                lineThickness=3.5,
                visible=DynamicSelect(not inService, not inService)),
              Text(
                extent={{-34,-20},{36,-76}},
                textColor={238,0,0},
                textString="DISC",
                visible=DynamicSelect(not inService, not inService))},
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
<p><span style=\"background-color: #ffffff;\">The Pi-model of a high voltage power transmission line. </span></p>
<p><span style=\"background-color: #ffffff;\">П-образная модель линии электропередачи. </span></p>
</html>"));
      end HVline;

      model El_Braking_Shunt
        outer SysData sysData;

        parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
        parameter Real Unom=20 "Nominal voltage, kV";
        parameter Real Rline=0.2 "Active resistance of electrical braking device, Ω";
        parameter Real Rl(fixed=false) "Active resistance of electrical braking device, p.u.";
        //---------------------------------------------
        parameter Real TLineOff=1000 "Time of electrical braking, s";
        parameter Real dTLineOff=10 "Duration of electrical braking, s";
        //---------------------------------------------

        Real Ud "D-axis voltage of shunt electrical braking";
        Real Uq "Q-axis voltage of shunt electrical braking";
        Real I12d "D-axis current of shunt electrical braking";
        Real I12q "Q-axis current of shunt electrical braking";
        Real I12m "Full current of shunt electrical braking";
        Real Um "Full voltage of shunt electrical braking";
        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[-10,78; 10,98],
          layer="icon",
          Placement(transformation(extent={{-10,88},{10,108}}, rotation=0),
              iconTransformation(extent={{-10,88},{10,108}})));
      initial equation
        // conversion from Ω to p.u.
        Rl = Rline/Unom^(2)*Sbaz;

      equation
        // the algorithm of shunt electrical braking start
        I12d = if time >= TLineOff and time < TLineOff + dTLineOff then Ud/Rl
           else 0;
        I12q = if time >= TLineOff and time < TLineOff + dTLineOff then Uq/Rl
           else 0;

        //---------measurements-----------------------------------------------------
        I12m = (sqrt(I12d^2 + I12q^2))*Sbaz/Unom/sqrt(3);
        Um = (sqrt(Ud^2 + Uq^2))*Unom;

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
<p><span style=\"background-color: #ffffff;\">Model of parallel electric braking device. </span></p>
<p><span style=\"background-color: #ffffff;\">Модель устройства параллельного электрического торможения.</span></p>
</html>"));
      end El_Braking_Shunt;
    end Branches_numerical_units;

    package Branches_per_units
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

        Real U1d "D-axis voltage at the beginning of HVline";
        Real U1q "Q-axis voltage at the beginning of HVline";
        Real U2d "D-axis voltage at the end of HVline";
        Real U2q "Q-axis voltage at the end of HVline";
        Real I12d "D-axis current in the middle of HVline";
        Real I12q "Q-axis current in the middle of HVline";
        Real I12m "Full current in the middle of HVline";
        Real U1m "Full voltage at the beginning of HVline";
        Real U2m "Full voltage at the end of HVline";

        flow Real I1d "D-axis current at the beginning of HVline";
        flow Real I1q "Q-axis current at the beginning of HVline";
        flow Real I2d "D-axis current at the end of HVline";
        flow Real I2q "Q-axis current at the end of HVline";

        Real Idc1 "D-axis capacitive current at the beginning of HVline";
        Real Iqc1 "Q-axis capacitive current at the beginning of HVline";
        Real Idc2 "D-axis capacitive current at the end of HVline";
        Real Iqc2 "Q-axis capacitive current at the end of HVline";
        Real DU1 "angle at the beginning of HVline";
        Real DU2 "angle at the end of HVline";
        Real P1 "active power at the beginning of HVline";
        Real Q1 "reactive power at the beginning of HVline";
        Real P2 "active power at the end of HVline";
        Real Q2 "reactive power at the end of HVline";
        Real RL "actual active resistance of HVline";
        Real XL "actual reactive resistance of HVline";
        Real BL1 "capacitive conductivity at the beginning of HVline";
        Real BL2 "capacitive conductivity at the end of HVline";

        OMLET.Interfaces.Pin_v2 inp annotation (extent=[-86,40; -66,60],
            Placement(transformation(extent={{-108,30},{-88,50}}, rotation=0),
              iconTransformation(extent={{-108,30},{-88,50}})));
        OMLET.Interfaces.Pin_v2 out annotation (extent=[68,42; 88,62],
            Placement(transformation(extent={{90,30},{110,50}}, rotation=0),
              iconTransformation(extent={{90,30},{110,50}})));
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

        ////---connector2---
        out.Vd = U2d;
        out.Vq = U2q;
        out.Id = I2d;
        out.Iq = I2q;

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
                extent={{-36,54},{36,26}},
                lineColor={0,0,255},
                lineThickness=1.0),
              Rectangle(
                extent={{-74,6},{-46,-46}},
                lineColor={0,0,255},
                lineThickness=1.0),
              Rectangle(
                extent={{46,6},{74,-46}},
                lineColor={0,0,255},
                lineThickness=1.0),
              Line(
                points={{-60,-46},{-60,-66}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-74,-66},{-46,-66}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{60,-46},{60,-66}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{46,-66},{74,-66}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-60,6},{-60,40}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-36,40},{-90,40}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{60,6},{60,40}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{94,40},{36,40}},
                color={0,0,255},
                thickness=1.0),
              Text(extent={{-64,96},{64,64}},
                textColor={0,0,0},
                textString="%name"),
              Text(
                textString=String(P1),
                extent={{-96,-78},{102,-116}},
                textColor={0,0,0})},
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

      model El_Braking_Shunt
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
        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[-10,78; 10,98],
          layer="icon",
          Placement(transformation(extent={{-10,88},{10,108}}, rotation=0),
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
      end El_Braking_Shunt;

      model El_Braking_Series
        parameter Real Rline=0.2 "Active resistance of electrical braking device";
        //---------------------------------------------
        parameter Real TLineOff=1000 "Time of electrical braking";
        parameter Real dTLineOff=10 "Duration of electrical braking";
        //---------------------------------------------

        Real U1d "D-axis voltage at the beginning of series electrical braking";
        Real U1q "Q-axis voltage at the beginning of series electrical braking";
        Real U2d "D-axis voltage at the end of series electrical braking";
        Real U2q "Q-axis voltage at the end of series electrical braking";
        Real I12d "D-axis current of series electrical braking";
        Real I12q "Q-axis current of series electrical braking";
        Real I12m "Full current of series electrical braking";
        Real U1m "Full voltage at the beginning of series electrical braking";
        Real U2m "Full voltage at the end of series electrical braking";
        Real RL "Actual resistanse of series electrical braking";
        OMLET.Interfaces.Pin_v2 inp annotation (extent=[-98,0; -78,20],
            Placement(transformation(extent={{-110,-26},{-90,-6}}, rotation=0),
              iconTransformation(extent={{-110,-26},{-90,-6}})));
        OMLET.Interfaces.Pin_v2 out annotation (extent=[78,0; 98,20], Placement(
              transformation(extent={{90,-26},{110,-6}}, rotation=0),
              iconTransformation(extent={{90,-26},{110,-6}})));
      equation
        // the algorithm of series electrical braking start
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
                extent={{-38,0},{42,-32}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-38,-16},{-92,-16}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{94,-16},{42,-16}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-58,-16},{-58,14},{-18,14}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{22,14},{62,14},{62,-16}},
                color={0,0,255},
                thickness=1.0),
              Rectangle(
                extent={{-18,22},{22,20}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{24,12},{20,16}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-16,12},{-20,16}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Text(extent={{-98,70},{102,30}},
                textColor={0,0,0},
                textString="%name")},
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
      end El_Braking_Series;
    end Branches_per_units;
    annotation (Icon(graphics={Bitmap(extent={{-130,-126},{156,108}}, fileName=
                "modelica://OMLET/Images/vecteezy_high-voltage-power-line-tower-icon-set-with-electrical-wires_86910970/vecteezy_high-voltage-power-line-tower-icon-set-with-electrical-wires_86910970.jpg")}),
        Documentation(info="<html>
<p>The image is downloaded from https://www.vecteezy.com/</p>
</html>"));
  end Branches;

  package Transformers

    package Transformers_numerical_units
      model Transformer
        outer SysData sysData;

        parameter Boolean inService = true "Transformer topological condition"
        annotation(Dialog(tab="General"));
        parameter Real R_off = 1000000
        annotation(Dialog(tab="G-model parameters"));
        parameter Real G_off = 1e-5 "transverse grounding conductivity, p.u."
        annotation(Dialog(tab="G-model parameters"));

        parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA"
        annotation(Dialog(tab="General"));
        Real kt "transformation coeffitient, p.u.";
        parameter Real k_step=0.015 "OLTC step"
        annotation(Dialog(tab="OLTC"));
        parameter Integer n_step=0 "current OLTC position"
        annotation(Dialog(tab="OLTC"));
        parameter Real Unom=330 "Nominal transformer voltage, kV"
        annotation(Dialog(tab="General"));
        parameter Real Rtrans=0.001 "Active resistance of T-model, Ω"
        annotation(Dialog(tab="G-model parameters"));
        parameter Real Xtrans=0.01 "Reactance of T-model, Ω"
        annotation(Dialog(tab="G-model parameters"));
        parameter Real Btrans=40 "Reactive conductivity of T-model, mkS"
        annotation(Dialog(tab="G-model parameters"));
        //---------------------------------------------
        parameter Real TtOff=1000 "Time of transformer disconnection, s"
        annotation(Dialog(tab="General"));
        parameter Real dTtOff=10 "Duration of transformer disconnection, s"
        annotation(Dialog(tab="General"));
        parameter Real Koff=100000 "Degree of transformer disconnection, s"
        annotation(Dialog(tab="General"));

        parameter Boolean displayPowerFlow=true "Display power flow"
        annotation(Dialog(tab="General"));
        //---------------------------------------------

        Real U1d "D-axis voltage at the beginning of transformer";
        Real U1q "Q-axis voltage at the beginning of transformer";
        Real U2d "D-axis voltage at the end of transformer";
        Real U2q "Q-axis voltage at the end of transformer";
        Real U1m "Full voltage at the beginning of transformer";
        Real U2m "Full voltage at the end of transformer";

        flow Real I1d "D-axis current at the beginning of transformer";
        flow Real I1q "Q-axis current at the beginning of transformer";
        flow Real I2d "D-axis current at the end of transformer";
        flow Real I2q "Q-axis current at the end of transformer";
        Real Idl "D-axis inductive current of T-model";
        Real Iql "Q-axis inductive current of T-model";
        Real I1m "Full current at the beginning of transformer";
        Real I2m "Full current at the end of transformer";

        Real P1 "active power at the beginning of transformer";
        Real Q1 "reactive power at the beginning of transformer";
        Real P2 "active power at the end of transformer";
        Real Q2 "reactive power at the end of transformer";
        Real Rt "actual active resistance of transformer";
        Real Xt "actual reactive resistance of transformer";
        Real Bt "actual reactive conductivity of transformer";
        Real G_gnd "calculation grounding conductivity";

        Real DU1 "angle at the beginning of transformer";
        Real DU2 "angle at the end of transformer";

        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[-88,0; -68,20],
          layer="icon",
          Placement(transformation(extent={{-110,-4},{-90,16}}, rotation=0),
              iconTransformation(extent={{-110,-4},{-90,16}})));
        OMLET.Interfaces.Pin_v2 out annotation (
          extent=[70,0; 90,20],
          layer="icon",
          Placement(transformation(extent={{90,-4},{110,16}}, rotation=0),
              iconTransformation(extent={{90,-4},{110,16}})));
      equation
        // transformation coeffitient calculation
        kt = 1.0 - k_step*n_step;

        // the algorithm of triping transformer
        Rt = if not inService then R_off else
        (if time >= TtOff and time < TtOff + dTtOff then Koff*Rtrans*kt^(2)*Sbaz/Unom^(2) else Rtrans*kt^(2)*Sbaz/Unom^(2));
        Xt = if not inService then R_off else
        (if time >= TtOff and time < TtOff + dTtOff then Koff*Xtrans*kt^(2)*Sbaz/Unom^(2) else Xtrans*kt^(2)*Sbaz/Unom^(2));
        Bt = if not inService then 0 else
        (if (time >= TtOff and time < TtOff + dTtOff) then (Btrans/Sbaz*Unom^(2)/10^(6)/Koff/kt^(2)) else Btrans/Sbaz*Unom^(2)/10^(6)/kt^(2));
        G_gnd = if not inService then G_off else 0.0;

        // series impedance between nodes
        U1q = kt*U2q + Rt*I2q - Xt*I2d;
        U1d = kt*U2d + Rt*I2d + Xt*I2q;

        // line inductances
        Idl = U1q*Bt + U1d*G_gnd;
        Iql = -U1d*Bt + U1q*G_gnd;

        // balance of current
        I1d = Idl + I2d;
        I1q = Iql + I2q;

        // measurements
        I1m = (sqrt(I1d^2 + I1q^2))*Sbaz/Unom/sqrt(3);
        I2m = (sqrt(I2d^2 + I2q^2))*Sbaz/Unom/sqrt(3);
        U1m = (sqrt(U1d^2 + U1q^2))*Unom;
        U2m = (sqrt(U2d^2 + U2q^2))*Unom;
        DU1 = atan2(U1d, U1q);
        DU2 = atan2(U2d, U2q);

        // powers
        P1 = (-inp.Vq*inp.Iq -inp.Vd*inp.Id)*Sbaz;
        Q1 = (inp.Vq*inp.Id -inp.Vd*inp.Iq)*Sbaz;
        P2 = (out.Vq*out.Iq + out.Vd*out.Id)*Sbaz;
        Q2 = (-out.Vq*out.Id + out.Vd*out.Iq)*Sbaz;

        //------connectors-----
        inp.Vd = U1d;
        inp.Vq = U1q;

        out.Vd = U2d;
        out.Vq = U2q;

        inp.Id = -I1d;
        inp.Iq = -I1q;

        out.Id = kt*I2d;
        out.Iq = kt*I2q;

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
              extent={{-100,-120},{100,120}},
              grid={2,2},
              initialScale=0),
            graphics={
              Text(extent={{-64,126},{66,98}},
                textColor={0,0,0},
                textString="%name"),
              Text(
                textString=DynamicSelect("P MW",
                if P1>=0 then
                  String(P1, significantDigits=3) + " MW →"
                else
                  String(abs(P1), significantDigits=3) + " MW ←"),
                visible=displayPowerFlow,
                extent={{-98,-56},{102,-96}},
                textColor={0,168,6}),
              Text(
                textString=DynamicSelect("Q MVar",
                if Q1>=0 then
                  String(Q1, significantDigits=3) + " MVar →"
                else
                  String(abs(Q1), significantDigits=3) + " MVar ←"),
                visible=displayPowerFlow,
                extent={{-96,-88},{102,-126}},
                textColor={102,44,145}),
              Text(
                textString=String(n_step),
                visible=displayPowerFlow,
                extent={{-66,72},{-2,40}},
                textColor={0,0,0}),
              Line(
                points={{0,66},{0,-48}},
                color={0,0,0},
                thickness=1.5),
              Rectangle(
                extent={{-50,72},{50,-56}},
                lineColor={0,0,255},
                lineThickness=1.0),
              Line(
                points={{-14,6},{-94,6}},
                color={0,0,0},
                thickness=1.5),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={16.5,16.5},
                rotation=270),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={16.5,34.5},
                rotation=270),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={16.5,52.5},
                rotation=270),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={16.5,-3.5},
                rotation=270),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={16.5,-21.5},
                rotation=270),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={16.5,-39.5},
                rotation=270),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={-15.5,16.5},
                rotation=90),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={-15.5,34.5},
                rotation=90),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={-15.5,-3.5},
                rotation=90),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={-15.5,-21.5},
                rotation=90),
              Line(
                points={{94,6},{16,6}},
                color={0,0,0},
                thickness=1.5),
              Rectangle(
                extent={{-2,86},{2,72}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-30,86},{-26,72}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{28,86},{32,72}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-52,92},{-40,80}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-48,72},{-48,80}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-42,72},{-42,82}},
                color={0,0,255},
                thickness=1),
              Text(
                extent={{20,-34},{48,-58}},
                textColor={0,0,0},
                textString="HV"),
              Text(
                extent={{-48,-34},{-20,-58}},
                textColor={0,0,0},
                textString="LV"),
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
                extent={{-34,-10},{36,-66}},
                textColor={238,0,0},
                textString="DISC",
                visible=DynamicSelect(not inService, not inService))},
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
<p>The model of a two-winding transformer. </p>
<p>Модель двухобмоточного трансформатора. </p>
</html>"),Diagram(coordinateSystem(extent={{-100,-120},{100,120}})));
      end Transformer;

      model Autotransformer
        outer SysData sysData;

        parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA"
        annotation(Dialog(tab="General"));
        Real kt_hm "transformation coeffitient high - middle voltage, p.u.";
        parameter Real k_step=0.015 "OLTC step"
        annotation(Dialog(tab="OLTC"));
        parameter Integer n_step=0 "current OLTC position"
        annotation(Dialog(tab="OLTC"));
        parameter Real Unom_HV=330 "Nominal transformer voltage, kV"
        annotation(Dialog(tab="General"));
        parameter Real Unom_MV=110 "Nominal transformer voltage, kV"
        annotation(Dialog(tab="General"));
        parameter Real Unom_LV=10 "Nominal transformer voltage, kV"
        annotation(Dialog(tab="General"));
        parameter Real Rline_HV=0.001 "Active resistance of high voltage side, Ω"
        annotation(Dialog(tab="3‑ray model parameters"));
        parameter Real Xline_HV=0.01 "Reactance of of high voltage side, Ω"
        annotation(Dialog(tab="3‑ray model parameters"));
        parameter Real Rline_MV=0.001 "Active resistance of middle voltage side, Ω"
        annotation(Dialog(tab="3‑ray model parameters"));
        parameter Real Xline_MV=0.01 "Reactance of middle voltage side, Ω"
        annotation(Dialog(tab="3‑ray model parameters"));
        parameter Real Rline_LV=0.001 "Active resistance of low voltage side, Ω"
        annotation(Dialog(tab="3‑ray model parameters"));
        parameter Real Xline_LV=0.01 "Reactance of low voltage side, Ω"
        annotation(Dialog(tab="3‑ray model parameters"));
        //---------------------------------------------
        parameter Real TtOff=1000 "Time of transformer disconnection, s"
        annotation(Dialog(tab="General"));
        parameter Real dTtOff=10 "Duration of transformer disconnection, s"
        annotation(Dialog(tab="General"));
        parameter Real Koff=100000 "Degree of transformer disconnection, s"
        annotation(Dialog(tab="General"));

        parameter Boolean displayPowerFlow=true "Display power flow"
        annotation(Dialog(tab="General"));
        //---------------------------------------------

        Real U1d_HV "D-axis voltage at the beginning of HV side";
        Real U1q_HV "Q-axis voltage at the beginning of HV side";
        Real U1d_MV "D-axis voltage at the beginning of MV side";
        Real U1q_MV "Q-axis voltage at the beginning of MV side";
        Real U1d_LV "D-axis voltage at the beginning of LV side";
        Real U1q_LV "Q-axis voltage at the beginning of LV side";
        Real U2d_HV "D-axis voltage at the end of HV side";
        Real U2q_HV "Q-axis voltage at the end of HV side";
        Real U2d_MV "D-axis voltage at the end of MV side";
        Real U2q_MV "Q-axis voltage at the end of MV side";
        Real U2d_LV "D-axis voltage at the end of LV side";
        Real U2q_LV "Q-axis voltage at the end of LV side";
        Real I12d_HV "D-axis current in the middle of HV side";
        Real I12q_HV "Q-axis current in the middle of HV side";
        Real I12d_MV "D-axis current in the middle of MV side";
        Real I12q_MV "Q-axis current in the middle of MV side";
        Real I12d_LV "D-axis current in the middle of LV side";
        Real I12q_LV "Q-axis current in the middle of LV side";
        Real I12m_HV "Full current in the middle of HV side";
        Real I12m_MV "Full current in the middle of MV side";
        Real I12m_LV "Full current in the middle of LV side";
        Real U1m_HV "Full voltage at the beginning of HV side";
        Real U1m_MV "Full voltage at the beginning of MV side";
        Real U1m_LV "Full voltage at the beginning of LV side";
        Real U2m_HV "Full voltage at the end of HV side";
        Real U2m_MV "Full voltage at the end of MV side";
        Real U2m_LV "Full voltage at the end of LV side";
        Real P1_HV "active power at the beginning of HV side";
        Real P1_MV "active power at the beginning of MV side";
        Real P1_LV "active power at the beginning of LV side";
        Real Q1_HV "reactive power at the beginning of HV side";
        Real Q1_MV "reactive power at the beginning of MV side";
        Real Q1_LV "reactive power at the beginning of LV side";
        Real P2_HV "active power at the end of HV sid";
        Real P2_MV "active power at the end of MV side";
        Real P2_LV "active power at the end of LV side";
        Real Q2_HV "reactive power at the end of HV side";
        Real Q2_MV "reactive power at the end of MV side";
        Real Q2_LV "reactive power at the end of LV side";
        Real RL_HV "actual active resistance of HV side";
        Real RL_MV "actual active resistance of MV side";
        Real RL_LV "actual active resistance of LV side";
        Real XL_HV "actual reactive resistance of HV side";
        Real XL_MV "actual reactive resistance of MV side";
        Real XL_LV "actual reactive resistance of LV side";

        OMLET.Interfaces.Pin_v2 HV_pin annotation (
          extent=[-88,0; -68,20],
          layer="icon",
          Placement(transformation(extent={{-110,-4},{-90,16}}, rotation=0),
              iconTransformation(extent={{-110,-4},{-90,16}})));
        OMLET.Interfaces.Pin_v2 MV_pin annotation (
          extent=[70,0; 90,20],
          layer="icon",
          Placement(transformation(extent={{90,20},{110,40}}, rotation=0),
              iconTransformation(extent={{90,20},{110,40}})));
        Interfaces.Pin_v2 LV_pin annotation (
          extent=[-88,0; -68,20],
          layer="icon",
          Placement(transformation(extent={{-10,-108},{10,-88}}, rotation=0),
              iconTransformation(extent={{88,-90},{108,-70}})));
      equation
        // transformation coeffitient calculation
        kt_hm = 1.0 + k_step*n_step;

        // the algorithm of triping transmission line
        RL_HV = if time >= TtOff and time < TtOff + dTtOff then Koff*Rline_HV*Sbaz/Unom_HV^(2) else Rline_HV*Sbaz/Unom_HV^(2);
        XL_HV = if time >= TtOff and time < TtOff + dTtOff then Koff*Xline_HV*Sbaz/Unom_HV^(2) else Xline_HV*Sbaz/Unom_HV^(2);
        RL_MV = if time >= TtOff and time < TtOff + dTtOff then Koff*Rline_MV*kt_hm^(2)*Sbaz/Unom_HV^(2) else Rline_MV*kt_hm^(2)*Sbaz/Unom_HV^(2);
        XL_MV = if time >= TtOff and time < TtOff + dTtOff then Koff*Xline_MV*kt_hm^(2)*Sbaz/Unom_HV^(2) else Xline_MV*kt_hm^(2)*Sbaz/Unom_HV^(2);
        RL_LV = if time >= TtOff and time < TtOff + dTtOff then Koff*Rline_LV*Sbaz/Unom_HV^(2) else Rline_LV*Sbaz/Unom_HV^(2);
        XL_LV = if time >= TtOff and time < TtOff + dTtOff then Koff*Xline_LV*Sbaz/Unom_HV^(2) else Xline_LV*Sbaz/Unom_HV^(2);

        // series impedance between nodes
        U1q_HV = U2q_HV + RL_HV*I12q_HV - XL_HV*I12d_HV;
        U1d_HV = U2d_HV + RL_HV*I12d_HV + XL_HV*I12q_HV;
        kt_hm*U1q_MV = U2q_MV + RL_MV*I12q_MV - XL_MV*I12d_MV;
        kt_hm*U1d_MV = U2d_MV + RL_MV*I12d_MV + XL_MV*I12q_MV;
        U1q_LV = U2q_LV + RL_LV*I12q_LV - XL_LV*I12d_LV;
        U1d_LV = U2d_LV + RL_LV*I12d_LV + XL_LV*I12q_LV;

        //connections of HV, MV and LV sides
        U2q_HV = U1q_MV;
        U2d_HV = U1d_MV;
        U2q_HV = U1q_LV;
        U2d_HV = U1d_LV;

        I12d_HV = I12d_MV + I12d_LV;
        I12q_HV = I12q_MV + I12q_LV;

        // measurements
        I12m_HV = (sqrt(I12d_HV^2 + I12q_HV^2))*Sbaz/Unom_HV/sqrt(3);
        I12m_MV = (sqrt(I12d_MV^2 + I12q_MV^2))*Sbaz/Unom_MV/sqrt(3);
        I12m_LV = (sqrt(I12d_LV^2 + I12q_LV^2))*Sbaz/Unom_LV/sqrt(3);

        U1m_HV = (sqrt(U1d_HV^2 + U1q_HV^2))*Unom_HV;
        U2m_HV = (sqrt(U2d_HV^2 + U2q_HV^2))*Unom_HV;

        U1m_MV = (sqrt(U1d_MV^2 + U1q_MV^2))*Unom_MV;
        U2m_MV = (sqrt(U2d_MV^2 + U2q_MV^2))*Unom_MV;

        U1m_LV = (sqrt(U1d_LV^2 + U1q_LV^2))*Unom_LV;
        U2m_LV = (sqrt(U2d_LV^2 + U2q_LV^2))*Unom_LV;

        // powers
        P1_HV = (HV_pin.Vq*HV_pin.Iq + HV_pin.Vd*HV_pin.Id)*Sbaz;
        Q1_HV = (-HV_pin.Vq*HV_pin.Id + HV_pin.Vd*HV_pin.Iq)*Sbaz;

        P2_HV = (U2q_HV*I12q_HV + U2d_HV*I12d_HV)*Sbaz;
        Q2_HV = (-U2q_HV*I12d_HV + U2d_HV*I12q_HV)*Sbaz;

        P1_MV = (U1q_MV*I12q_MV + U1d_MV*I12d_MV)*Sbaz;
        Q1_MV = (-U1q_MV*I12d_MV + U1d_MV*I12q_MV)*Sbaz;

        P2_MV = (-MV_pin.Vq*MV_pin.Iq - MV_pin.Vd*MV_pin.Id)*Sbaz;
        Q2_MV = (MV_pin.Vq*MV_pin.Id - MV_pin.Vd*MV_pin.Iq)*Sbaz;

        P1_LV = (U1q_LV*I12q_LV + U1d_LV*I12d_LV)*Sbaz;
        Q1_LV = (-U1q_LV*I12d_LV + U1d_LV*I12q_LV)*Sbaz;

        P2_LV = (-LV_pin.Vq*LV_pin.Iq - LV_pin.Vd*LV_pin.Id)*Sbaz;
        Q2_LV = (LV_pin.Vq*LV_pin.Id - LV_pin.Vd*LV_pin.Iq)*Sbaz;

        //------connectors-----
        HV_pin.Vd = U1d_HV;
        HV_pin.Vq = U1q_HV;

        MV_pin.Vd = U2d_MV;
        MV_pin.Vq = U2q_MV;

        LV_pin.Vd = U2d_LV;
        LV_pin.Vq = U2q_LV;

        HV_pin.Id = I12d_HV;
        HV_pin.Iq = I12q_HV;

        kt_hm*MV_pin.Id = -I12d_MV;
        kt_hm*MV_pin.Iq = -I12q_MV;

        LV_pin.Id = I12d_LV;
        LV_pin.Iq = I12q_LV;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Text(extent={{-64,126},{66,98}},
                textColor={0,0,0},
                textString="%name"),
              Text(
                textString=DynamicSelect("P MW",
                if P1_HV>=0 then
                  String(P1_HV, significantDigits=3) + " MW →"
                else
                  String(abs(P1_HV), significantDigits=3) + " MW ←"),
                visible=displayPowerFlow,
                extent={{-244,54},{-44,14}},
                textColor={0,168,6}),
              Text(
                textString=DynamicSelect("Q MVar",
                if Q1_HV>=0 then
                  String(Q1_HV, significantDigits=3) + " MVar →"
                else
                  String(abs(Q1_HV), significantDigits=3) + " MVar ←"),
                visible=displayPowerFlow,
                extent={{-248,2},{-50,-36}},
                textColor={102,44,145}),
              Text(
                textString=String(n_step),
                visible=displayPowerFlow,
                extent={{-66,72},{-2,40}},
                textColor={0,0,0}),
              Line(
                points={{0,54},{0,-48}},
                color={0,0,0},
                thickness=1.5),
              Rectangle(
                extent={{-50,72},{50,-56}},
                lineColor={0,0,255},
                lineThickness=1.0),
              Line(
                points={{-14,6},{-94,6}},
                color={0,0,0},
                thickness=1.5),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={16.5,16.5},
                rotation=270),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={16.5,34.5},
                rotation=270),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={16.5,-3.5},
                rotation=270),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={16.5,-21.5},
                rotation=270),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={-15.5,16.5},
                rotation=90),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={-15.5,34.5},
                rotation=90),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={-15.5,-3.5},
                rotation=90),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={-15.5,-21.5},
                rotation=90),
              Line(
                points={{16,-80},{16,-30}},
                color={0,0,0},
                thickness=1.5),
              Rectangle(
                extent={{-2,86},{2,72}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-30,86},{-26,72}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{28,86},{32,72}},
                lineColor={0,0,255},
                lineThickness=1.0,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-52,92},{-40,80}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-48,72},{-48,80}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-42,72},{-42,82}},
                color={0,0,255},
                thickness=1),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={-15.5,52.5},
                rotation=90),
              Ellipse(
                extent={{-9.5,9.5},{9.5,-9.5}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                closure=EllipseClosure.None,
                startAngle=0,
                endAngle=180,
                origin={-15.5,-39.5},
                rotation=90),
              Line(
                points={{66,62},{-16,62}},
                color={0,0,0},
                thickness=1.5),
              Line(
                points={{66,30},{66,62}},
                color={0,0,0},
                thickness=1.5),
              Line(
                points={{100,30},{66,30}},
                color={0,0,0},
                thickness=1.5),
              Text(
                textString=DynamicSelect("P MW",
                if P1_MV>=0 then
                  String(P1_MV, significantDigits=3) + " MW →"
                else
                  String(abs(P1_MV), significantDigits=3) + " MW ←"),
                visible=displayPowerFlow,
                extent={{36,84},{236,44}},
                textColor={0,168,6}),
              Text(
                textString=DynamicSelect("Q MVar",
                if Q1_MV>=0 then
                  String(Q1_MV, significantDigits=3) + " MVar →"
                else
                  String(abs(Q1_MV), significantDigits=3) + " MVar ←"),
                visible=displayPowerFlow,
                extent={{40,24},{238,-14}},
                textColor={102,44,145}),
              Text(
                textString=DynamicSelect("P MW",
                if P1_LV>=0 then
                  String(P1_LV, significantDigits=3) + " MW ←"
                else
                  String(abs(P1_LV), significantDigits=3) + " MW →"),
                visible=displayPowerFlow,
                extent={{36,-32},{236,-72}},
                textColor={0,168,6}),
              Text(
                textString=DynamicSelect("Q MVar",
                if Q1_LV>=0 then
                  String(Q1_LV, significantDigits=3) + " MVar ←"
                else
                  String(abs(Q1_LV), significantDigits=3) + " MVar →"),
                visible=displayPowerFlow,
                extent={{40,-90},{238,-128}},
                textColor={102,44,145}),
              Text(
                extent={{-48,34},{-16,-2}},
                textColor={0,0,0},
                textString="HV"),
              Text(
                extent={{20,64},{48,34}},
                textColor={0,0,0},
                textString="MV"),
              Text(
                extent={{20,-30},{50,-58}},
                textColor={0,0,0},
                textString="LV"),
              Line(
                points={{98,-80},{16,-80}},
                color={0,0,0},
                thickness=1.5)}),                                      Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Autotransformer model.</p>
<p>Модель  автотрансформатора. </p>
</html>"));
      end Autotransformer;
    end Transformers_numerical_units;

    package Transformers_per_units
      model Transformer
        parameter Real Rline=0.001 "Active resistance of T-model";
        parameter Real Xline=0.01 "Reactance of T-model";
        //---------------------------------------------
        parameter Real TtOff=1000 "Time of transformer disconnection";
        parameter Real dTtOff=10 "Duration of transformer disconnection";
        parameter Real Koff=100000 "Degree of transformer disconnection";
        //---------------------------------------------

        Real U1d "D-axis voltage at the beginning of HVline";
        Real U1q "Q-axis voltage at the beginning of HVline";
        Real U2d "D-axis voltage at the end of HVline";
        Real U2q "Q-axis voltage at the end of HVline";
        Real I12d "D-axis current in the middle of HVline";
        Real I12q "Q-axis current in the middle of HVline";
        Real I12m "Full current in the middle of HVline";
        Real U1m "Full voltage at the beginning of HVline";
        Real U2m "Full voltage at the end of HVline";
        Real P1 "active power at the beginning of HVline";
        Real Q1 "reactive power at the beginning of HVline";
        Real P2 "active power at the end of HVline";
        Real Q2 "reactive power at the end of HVline";
        Real RL "actual active resistance of HVline";
        Real XL "actual reactive resistance of HVline";

        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[-88,0; -68,20],
          layer="icon",
          Placement(transformation(extent={{-108,0},{-88,20}}, rotation=0),
              iconTransformation(extent={{-108,0},{-88,20}})));
        OMLET.Interfaces.Pin_v2 out annotation (
          extent=[70,0; 90,20],
          layer="icon",
          Placement(transformation(extent={{88,0},{108,20}}, rotation=0),
              iconTransformation(extent={{88,0},{108,20}})));
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
                extent={{-60,74},{60,-54}},
                lineColor={0,0,255},
                lineThickness=1.0),
              Line(
                points={{-20,10},{-90,10}},
                color={0,0,0},
                thickness=1.5),
              Line(
                points={{92,10},{22,10}},
                color={0,0,0},
                thickness=1.0),
              Text(extent={{-64,104},{66,76}},
                textColor={0,0,0},
                textString="%name"),
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
                thickness=1.0),
              Text(
                textString=String(P1),
                extent={{-98,-60},{100,-98}},
                textColor={0,0,0})},
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
    end Transformers_per_units;
    annotation (Icon(graphics={Bitmap(extent={{-204,-156},{230,154}}, fileName=
                "modelica://OMLET/Images/transformer-icon-design-template-simple-and-clean-vector.jpg")}),
        Documentation(info="<html>
<p>The image is downloaded from https://www.vecteezy.com/</p>
</html>"));
  end Transformers;

  package Shunts

    package Shunts_numerical_units
      model Constant_Conductivity_Load
        outer SysData sysData;

        parameter Boolean inService = true "Load topological condition";

        parameter Real Sbaz=sysData.Sbaz "Bazic power, MVA";
        parameter Real Unom=330 "Nominal load voltage, kV";
        parameter Real Pn=10 "Active load, MW";
        parameter Real Qn=1 "Reactive load, MVar";
        parameter Real Gn(fixed=false) "Active load, S";
        parameter Real Bn(fixed=false) "Reactive load, S";
        //-------------------------------------------------------------
        parameter Real TloadOff=1000 "Time of load disconnection, s";
        parameter Real dTloadOff=10 "Duration of load disconnection, s";
        parameter Real Koff=0.7 "Degree of load disconnection, p.u.";

        parameter Boolean displayPowerFlow = true;
        //-------------------------------------------------------------
        Real Udn "D-axis voltage of load";
        Real Uqn "Q-axis voltage of load";
        Real Iqn "D-axis current of load";
        Real Idn "Q-axis current of load";
        Real Pn_fact "Active power of load fact";
        Real Qn_fact "Reactive power of load fact";
        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[-10,76; 10,96],
          layer="icon",
          Placement(transformation(extent={{-10,88},{10,108}}, rotation=0),
              iconTransformation(extent={{-10,88},{10,108}})));
      initial equation
        // calculating conductivity from power
        Gn = if not inService then 0.00001 else
        Pn/Sbaz;
        Bn = if not inService then -0.00001 else
        -Qn/Sbaz;

      equation

        // active and reactive load
        Pn_fact = (Uqn*Iqn + Udn*Idn)*Sbaz;
        Qn_fact = (-Uqn*Idn + Udn*Iqn)*Sbaz;

        //the algorithm of triping load
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
              Line(
                points={{80,-60},{-80,-60}},
                color={0,0,0},
                thickness=1),
              Text(extent={{-98,-62},{102,-98}},
                textColor={0,0,0},
                textString="%name"),
                Text(
                textString=DynamicSelect("Pn MW", String(Pn_fact, significantDigits=3) + " MW"),
                visible=displayPowerFlow,
                extent={{-94,-102},{104,-140}},
                textColor={0,168,6}),
              Text(
                textString=DynamicSelect("Qn MVar", String(Qn_fact, significantDigits=3) + " MVar"),
                visible=displayPowerFlow,
                extent={{-94,-140},{104,-178}},
                textColor={102,44,145}),
              Line(
                points={{-80,0},{-80,-60}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{80,20},{80,-60}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-80,0},{-40,20}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-40,0},{0,20}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{0,0},{40,20}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{40,0},{80,20}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-40,20},{-40,0}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{0,20},{0,0}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{40,20},{40,0}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-60,-20},{-20,-20}},
                color={28,108,200},
                thickness=1),
              Line(
                points={{-60,-40},{-20,-40}},
                color={28,108,200},
                thickness=1),
              Line(
                points={{-60,-20},{-60,-40}},
                color={28,108,200},
                thickness=1),
              Line(
                points={{-20,-20},{-20,-40}},
                color={28,108,200},
                thickness=1),
              Line(
                points={{20,-20},{60,-20}},
                color={28,108,200},
                thickness=1),
              Line(
                points={{20,-40},{60,-40}},
                color={28,108,200},
                thickness=1),
              Line(
                points={{20,-20},{20,-40}},
                color={28,108,200},
                thickness=1),
              Line(
                points={{60,-20},{60,-40}},
                color={28,108,200},
                thickness=1),
              Line(
                points={{-74,2},{-70,60}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-50,16},{-54,60}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-54,60},{-70,60}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-60,70},{-58,80},{-56,84},{-62,70},{-66,72},{-54,90}},
                pattern=LinePattern.None,
                thickness=1),
              Line(
                points={{-6,54},{38,46}},
                pattern=LinePattern.None,
                thickness=1),
              Line(
                points={{-58,82},{-60,70}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-48,76},{-60,70}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-58,92},{-58,82}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-52,98},{-58,92}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-40,100},{-52,98}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-26,100},{-40,100}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-26,100},{-20,96}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-42,82},{-48,76}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-36,84},{-42,82}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-24,84},{-36,84}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-20,90},{-24,84}},
                color={0,0,0},
                thickness=1),
              Line(
                points={{-20,96},{-20,90}},
                color={0,0,0},
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
                visible=DynamicSelect(not inService, not inService))},
            Rectangle(extent=[-20, 60; 20, -40], style(thickness=2)),
            Line(points=[0, -40; 0, -60], style(thickness=2)),
            Line(points=[-20, -60; 20, -60], style(thickness=2)),
            Line(points=[0, 80; 0, 60], style(thickness=2)),
            Text(extent=[-100, -64; 100, -100], string="%name")),
          Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">A load model defined as a constant conductivity. </span></p>
<p><span style=\"background-color: #ffffff;\">Модель нагрузки постоянной проводимости. </span></p>
</html>"));
      end Constant_Conductivity_Load;

      model ShortCircuitShunt
        outer SysData sysData;

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
        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[-10,38; 10,58],
          layer="icon",
          Placement(transformation(extent={{-10,88},{10,108}}, rotation=0),
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
</html>"),Diagram(coordinateSystem(extent={{-60,-60},{60,100}})));
      end ShortCircuitShunt;
    end Shunts_numerical_units;

    package Shunts_per_units
      model Constant_Conductivity_Load
        parameter Real Gn=0.7 "Active load";
        parameter Real Bn=-0.35 "Reactive load";
        //-------------------------------------------------------------
        parameter Real TloadOff=1000 "Time of load disconnection";
        parameter Real dTloadOff=10 "Duration of load disconnection";
        parameter Real Koff=0.7 "Degree of load disconnection";
        //-------------------------------------------------------------
        Real Udn "D-axis voltage of load";
        Real Uqn "Q-axis voltage of load";
        Real Iqn "D-axis current of load";
        Real Idn "Q-axis current of load";
        Real Pn "Active power of load";
        Real Qn "Reactive power of load";
        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[-10,76; 10,96],
          layer="icon",
          Placement(transformation(extent={{-10,88},{10,108}}, rotation=0),
              iconTransformation(extent={{-10,88},{10,108}})));
      equation
        // active and reactive load
        Pn = Uqn*Iqn + Udn*Idn;
        Qn = -Uqn*Idn + Udn*Iqn;

        //the algorithm of triping load
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
                extent={{-20,72},{20,-28}},
                lineColor={0,0,255},
                lineThickness=1.0),
              Line(
                points={{0,-28},{0,-48}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{-20,-48},{20,-48}},
                color={0,0,255},
                thickness=1.0),
              Line(
                points={{0,92},{0,72}},
                color={0,0,255},
                thickness=1.0),
              Text(extent={{-98,-60},{102,-96}},
                textColor={0,0,0},
                textString="%name")},
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

        Real id "D-axis current of short-circuit";
        Real iq "Q-axis current of short-circuit";
        Real Ud  "D-axis voltage of short-circuit";
        Real Uq "Q-axis voltage of short-circuit";
        OMLET.Interfaces.Pin_v2 inp annotation (
          extent=[-10,38; 10,58],
          layer="icon",
          Placement(transformation(extent={{-10,88},{10,108}}, rotation=0),
              iconTransformation(extent={{-10,88},{10,108}})));
      equation
        // short-circuit current
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
                thickness=1,
                arrow={Arrow.None,Arrow.Filled}),
              Text(extent={{-56,-28},{58,-56}},
                textColor={0,0,0},
                textString="%name")},
            Line(points=[-20, -60; 20, -60], style(thickness=4)),
            Line(points=[0, -60; 0, 40], style(thickness=4)),
            Line(points=[34, 4; 6, -26; 30, -26; 0, -60], style(
                color=41,
                thickness=4,
                arrow=1)),
            Text(extent=[-54, -64; 60, -92], string="%name")),
          Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">Short-Circuit Shunt Model</span></p>
</html>"));
      end ShortCircuitShunt;
    end Shunts_per_units;
    annotation (Icon(graphics={Bitmap(extent={{-212,-170},{222,190}}, fileName=
                "modelica://OMLET/Images/vecteezy_factory-building-icons-vector_7855400_49/vecteezy_factory-building-icons-vector_7855400-1.jpg")}),
        Documentation(info="<html>
<p>The image is downloaded from https://www.vecteezy.com/</p>
</html>"));
  end Shunts;

  package Buses
    model Bus
      parameter Integer busNumber = 1;
      parameter Real Unom=330 "Nominal bus voltage, kV";
      Real Um(start = 1.0, fixed = false) "Full bus voltage, kV";
      parameter Boolean displayVoltage=true "Display bus voltage";
      Interfaces.Pin_v2 bus_pin annotation (Placement(transformation(extent={{-12,-12},
                {10,10}}), iconTransformation(extent={{-12,-12},{10,10}})));
    equation
      // full bus voltage calculation
      Um = (sqrt(bus_pin.Vd^(2) + bus_pin.Vq^(2)))*Unom;
      bus_pin.Id = 0;
      bus_pin.Iq = 0;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,
                -140},{80,160}}),                                   graphics={
              Rectangle(
              extent={{-10,100},{8,-102}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid), Text(
              textString=DynamicSelect("U kV", String(Um, significantDigits=4) + " kV"),
              visible=displayVoltage,
              extent={{-100,-108},{100,-148}},
              textColor={0,0,127}),Text(
              textString=String(busNumber),
              extent={{-130,172},{128,94}},
              textColor={0,0,255})}),
              Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-80,-140},{80,160}})),
        Documentation(info="<html>
<p><span style=\"background-color: #ffffff;\">Bus model. </span></p>
<p><span style=\"background-color: #ffffff;\">Модель шин. </span></p>
</html>"));
    end Bus;
    annotation (Icon(graphics={Bitmap(extent={{-144,-102},{146,110}}, fileName=
                "modelica://OMLET/Images/vecteezy_electrical-power-transformer-substation-outline-icon_82178950/vecteezy_electrical-power-transformer-substation-outline-icon_82178950.jpg")}),
        Documentation(info="<html>
<p>The image is downloaded from https://www.vecteezy.com/</p>
</html>"));
  end Buses;

  package Excitation_systems

    package Logic
      model Summator_4
        OMLET.Interfaces.Signal_pin inp1 annotation (
          extent=[-94,14; -74,66],
          layer="icon",
          Placement(transformation(extent={{-110,46},{-90,98}}, rotation=0),
              iconTransformation(extent={{-110,46},{-90,98}})));
        OMLET.Interfaces.Signal_pin inp2 annotation (
          extent=[-94,-66; -74,-14],
          layer="icon",
          Placement(transformation(extent={{-110,0},{-90,52}}, rotation=0),
              iconTransformation(extent={{-110,0},{-90,52}})));
        OMLET.Interfaces.Signal_pin out annotation (
          extent=[74,-26; 94,26],
          layer="icon",
          Placement(transformation(extent={{90,-26},{110,26}}, rotation=0),
              iconTransformation(extent={{90,-26},{110,26}})));
        Interfaces.Signal_pin       inp3 annotation (
          extent=[-94,-66; -74,-14],
          layer="icon",
          Placement(transformation(extent={{-110,-46},{-90,6}},  rotation=0),
              iconTransformation(extent={{-110,-46},{-90,6}})));
        Interfaces.Signal_pin       inp4 annotation (
          extent=[-94,-66; -74,-14],
          layer="icon",
          Placement(transformation(extent={{-110,-92},{-90,-40}},rotation=0),
              iconTransformation(extent={{-110,-92},{-90,-40}})));
      equation
        // the sum of 2 input signals
        out.Signal = inp1.Signal + inp2.Signal + inp3.Signal + inp4.Signal;
        connect(inp2, inp2) annotation (Line(
            points={{-100,26},{-100,26}},
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
              extent={{-100,-100},{100,100}},
              grid={2,2},
              initialScale=0),
            graphics={
              Rectangle(
                extent={{-60,98},{60,-98}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={255,255,255},
                fillPattern=FillPattern.Forward),
              Line(
                points={{-60,70},{-94,70}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-60,-64},{-96,-64}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{96,0},{60,0}},
                color={0,0,255},
                thickness=1),
              Rectangle(
                extent={{-50,72},{-22,68}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-38,86},{-34,54}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Line(
                points={{-60,-20},{-94,-20}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-60,26},{-94,26}},
                color={0,0,255},
                thickness=1),
              Rectangle(
                extent={{-50,28},{-22,24}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-38,42},{-34,10}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-38,-4},{-34,-36}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-50,-18},{-22,-22}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-38,-48},{-34,-80}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-50,-62},{-22,-66}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1)},
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
<p>The adder model with 4 inputs. </p>
<p>Модель сумматора с 4 входами. </p>
</html>"));
      end Summator_4;

      model Summator_2
        OMLET.Interfaces.Signal_pin inp1 annotation (
          extent=[-94,14; -74,66],
          layer="icon",
          Placement(transformation(extent={{-110,16},{-90,68}}, rotation=0),
              iconTransformation(extent={{-110,16},{-90,68}})));
        OMLET.Interfaces.Signal_pin inp2 annotation (
          extent=[-94,-66; -74,-14],
          layer="icon",
          Placement(transformation(extent={{-110,-66},{-90,-14}}, rotation=0),
              iconTransformation(extent={{-110,-66},{-90,-14}})));
        OMLET.Interfaces.Signal_pin out annotation (
          extent=[74,-26; 94,26],
          layer="icon",
          Placement(transformation(extent={{90,-26},{110,26}}, rotation=0),
              iconTransformation(extent={{90,-26},{110,26}})));
      equation
        // the sum of 2 input signals
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
                lineThickness=1,
                fillColor={255,255,255},
                fillPattern=FillPattern.Forward),
              Line(
                points={{-60,40},{-94,40}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-60,-40},{-96,-40}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{96,0},{60,0}},
                color={0,0,255},
                thickness=1),
              Rectangle(
                extent={{-50,42},{-14,38}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-34,60},{-30,20}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-34,-20},{-30,-60}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-50,-38},{-14,-42}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1)},
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
<p>The adder model with 2 inputs</p>
<p>Модель сумматора с 2входами. </p>
</html>"));
      end Summator_2;

      model Summator_3
        OMLET.Interfaces.Signal_pin inp1 annotation (
          extent=[-94,14; -74,66],
          layer="icon",
          Placement(transformation(extent={{-110,34},{-90,86}}, rotation=0),
              iconTransformation(extent={{-110,34},{-90,86}})));
        OMLET.Interfaces.Signal_pin inp2 annotation (
          extent=[-94,-66; -74,-14],
          layer="icon",
          Placement(transformation(extent={{-110,-28},{-90,24}}, rotation=0),
              iconTransformation(extent={{-110,-28},{-90,24}})));
        OMLET.Interfaces.Signal_pin out annotation (
          extent=[74,-26; 94,26],
          layer="icon",
          Placement(transformation(extent={{90,-26},{110,26}}, rotation=0),
              iconTransformation(extent={{90,-26},{110,26}})));
        Interfaces.Signal_pin       inp3 annotation (
          extent=[-94,-66; -74,-14],
          layer="icon",
          Placement(transformation(extent={{-110,-28},{-90,24}}, rotation=0),
              iconTransformation(extent={{-110,-86},{-90,-34}})));
      equation
        // the sum of 2 input signals
        out.Signal = inp1.Signal + inp2.Signal + inp3.Signal;
        connect(inp2, inp2) annotation (Line(
            points={{-100,-2},{-100,-2}},
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
              extent={{-100,-100},{100,100}},
              grid={2,2},
              initialScale=0),
            graphics={
              Rectangle(
                extent={{-60,98},{60,-98}},
                lineColor={0,0,255},
                lineThickness=1,
                fillColor={255,255,255},
                fillPattern=FillPattern.Forward),
              Line(
                points={{-60,60},{-94,60}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-60,-60},{-96,-60}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{96,0},{60,0}},
                color={0,0,255},
                thickness=1),
              Rectangle(
                extent={{-50,62},{-14,58}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-34,80},{-30,40}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-34,-40},{-30,-80}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-50,-58},{-14,-62}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Line(
                points={{-60,0},{-94,0}},
                color={0,0,255},
                thickness=1),
              Rectangle(
                extent={{-34,20},{-30,-20}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-50,2},{-14,-2}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1)},
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
<p>The adder model with 3 inputs. </p>
<p>Модель сумматора с 3 входами. </p>
</html>"));
      end Summator_3;

      model Summator_2_negative
        OMLET.Interfaces.Signal_pin inp1 annotation (
          extent=[-94,14; -74,66],
          layer="icon",
          Placement(transformation(extent={{-110,16},{-90,68}}, rotation=0),
              iconTransformation(extent={{-110,16},{-90,68}})));
        OMLET.Interfaces.Signal_pin inp2 annotation (
          extent=[-94,-66; -74,-14],
          layer="icon",
          Placement(transformation(extent={{-110,-66},{-90,-14}}, rotation=0),
              iconTransformation(extent={{-110,-66},{-90,-14}})));
        OMLET.Interfaces.Signal_pin out annotation (
          extent=[74,-26; 94,26],
          layer="icon",
          Placement(transformation(extent={{90,-26},{110,26}}, rotation=0),
              iconTransformation(extent={{90,-26},{110,26}})));
      equation
        // the sum of 2 input signals
        out.Signal = inp1.Signal - inp2.Signal;
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
                lineThickness=1,
                fillColor={255,255,255},
                fillPattern=FillPattern.Forward),
              Line(
                points={{-60,40},{-94,40}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-60,-40},{-96,-40}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{96,0},{60,0}},
                color={0,0,255},
                thickness=1),
              Rectangle(
                extent={{-50,42},{-14,38}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-34,60},{-30,20}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1),
              Rectangle(
                extent={{-50,-38},{-14,-42}},
                lineColor={28,108,200},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=1)},
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
<p>The adder model with 1 powitive and 1 negative inputs. </p>
<p>Модель сумматора с положительным и отрицательным входами. </p>
</html>"));
      end Summator_2_negative;

      model logical_switch
        parameter Real a1 "Uforc, Voltage of field forcing input";
        parameter Real a2 "Udeforc, Voltage of field forcing removing";
        parameter Real a3 "K0U, Voltage deviation control coefficient";
        parameter Real a4 "Tforcedelay, Delay of field forcing removing";
        Real T_force_on "moment of time, when forcing starts";

        OMLET.Interfaces.Signal_pin inp1 annotation (
          extent=[-94,14; -74,66],
          layer="icon",
          Placement(transformation(extent={{-110,8},{-90,60}}, rotation=0),
              iconTransformation(extent={{-110,8},{-90,60}})));
        OMLET.Interfaces.Signal_pin inp2 annotation (
          extent=[-94,-66; -74,-14],
          layer="icon",
          Placement(transformation(extent={{-110,-62},{-90,-10}}, rotation=0),
              iconTransformation(extent={{-110,-62},{-90,-10}})));
        OMLET.Interfaces.Signal_pin inp2inf annotation (
          extent=[-94,-66; -74,-14],
          layer="icon",
          Placement(transformation(
              extent={{-10,-26},{10,26}},
              rotation=90,
              origin={2,-118}), iconTransformation(
              extent={{-10,-26},{10,26}},
              rotation=90,
              origin={2,-118})));
        OMLET.Interfaces.Signal_pin out annotation (
          extent=[74,-26; 94,26],
          layer="icon",
          Placement(transformation(extent={{90,-34},{110,18}}, rotation=0),
              iconTransformation(extent={{90,-34},{110,18}})));
        Interfaces.Signal_pin inp1inf annotation (Placement(transformation(extent={{-24,110},
                  {26,130}}),          iconTransformation(extent={{-24,110},{26,
                  130}})));

      initial equation
        pre(T_force_on) = 0;

        // the condition of forcing's start
      equation
        when abs(inp1inf.Signal) < (inp2inf.Signal - a2) then
          T_force_on = time;
        end when;

        // the value of output signal
        out.Signal = if (abs(inp1inf.Signal) > (inp2inf.Signal - a1)) then (inp1.Signal)
           else (if (abs(inp1inf.Signal) > (inp2inf.Signal - a2)) then (inp1.Signal)
           else (if (time < T_force_on + a4) then (inp1.Signal) else (inp2.Signal)));

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
                extent={{-58,74},{62,-86}},
                lineColor={0,0,255},
                lineThickness=1,
                fillPattern=FillPattern.Forward,
                fillColor={244,125,35}),
              Line(
                points={{-46,34},{-94,34}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-48,-34},{-94,-34}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{98,-6},{44,-6}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-162,80}},
                color={162,29,33},
                thickness=1,
                smooth=Smooth.Bezier),
              Line(
                points={{-6,-6},{-46,34}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{16,-6},{-6,-6}},
                color={28,108,200},
                thickness=1),
              Line(
                points={{50,-6},{16,-6}},
                color={0,0,255},
                thickness=1),
              Text(extent={{-158,176},{162,136}},
                textColor={0,0,0},
                textString="%name"),
              Line(
                points={{10,6},{-16,6}},
                color={0,0,255},
                thickness=1,
                origin={8,-96},
                rotation=90),
              Line(
                points={{0,118},{0,74}},
                color={0,0,255},
                thickness=1)},
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
<p>The model of the logic key of the automatic excitation regulator for excitation forcing. </p>
<p>Модель логического ключа АРВ для реализации функции форсировки возбуждения. </p>
</html>"));
      end logical_switch;

      model Transfer_Function
        parameter Real b[:]={1}
        "Numerator coefficients of transfer function.";
        parameter Real a[:]={1,1}
        "Denominator coefficients of transfer function.";
        output Real x[size(a, 1) - 1]
        "State of transfer function from controller canonical form";

      protected
        parameter Integer na=size(a, 1)
          "Size of Denominator of transfer function.";
        parameter Integer nb(max=na) = size(b, 1)
          "Size of Numerator of transfer function.";
        parameter Integer nx=size(a, 1) - 1;
        Real x1dot
        "Derivative of first state of TransferFcn";
        Real xn
        "Highest order state of TransferFcn";
        Real u
        "input variable";
        Real y
        "output variable";

      public
        OMLET.Interfaces.Signal_pin inp annotation (
          extent=[-92,-10; -72,10],
          layer="icon",
          Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        OMLET.Interfaces.Signal_pin out annotation (
          extent=[70,-10; 90,10],
          layer="icon",
          Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
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
                lineColor={0,0,255},
                lineThickness=1),
              Text(extent={{-40,28},{40,2}}, textString=
                                                 "Transfer"),
              Text(extent={{-38,4},{42,-22}}, textString=
                                                  "function"),
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
                thickness=1)},
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
<p>The model of the transfer function. </p>
<p>Модель передаточной функции. </p>
</html>"));
      end Transfer_Function;

      model Reactive_power_limiter
        input Real Qgen;
        input Real Qmax;
        input Real Qmin;
        parameter Boolean inService = true "Excitation limiter condition";

      equation
        out.Signal = if inService then
        if Qgen > Qmax then
          0 else if Qgen < Qmin
        then 0 else inp.Signal else inp.Signal;

      public
        Interfaces.Signal_pin       inp annotation (
          extent=[-92,-10; -72,10],
          layer="icon",
          Placement(transformation(extent={{-110,-10},{-90,10}},rotation=0),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        Interfaces.Signal_pin       out annotation (
          extent=[70,-10; 90,10],
          layer="icon",
          Placement(transformation(extent={{90,-10},{110,10}},rotation=0),
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
                thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Reactive_power_limiter model - limits AVR signal afer reaching Qmin/Qmax. </p>
<p>Модель блока ограничения сигнала при достижении Qmin/Qmax. </p>
</html>"));
      end Reactive_power_limiter;

      model Excitation_limiter
        parameter Boolean selfExcitation = true "Sign of self‑excitation (dependence on Ut)";
        parameter Real Kemax = 2.0 "Multiplicity of forcing on, p.u.";
        parameter Real Kemin = -0.6 "Multiplicity of forcing off, p.u.";

        Real Er_max_dyn "Dynamic upper limit";
        Real Er_min_dyn "Dynamic lower limit";
        Real Er0_val;
        Real Ut_val;

      public
        Interfaces.Signal_pin Ut_pin annotation (
          extent=[-92,-10; -72,10],
          layer="icon",
          Placement(transformation(extent={{-30,-70},{-10,-50}},rotation=0),
              iconTransformation(extent={{-30,-70},{-10,-50}})));
      public
        Interfaces.Signal_pin Er0_pin
                                     annotation (
          extent=[-92,-10; -72,10],
          layer="icon",
          Placement(transformation(extent={{12,-70},{32,-50}},  rotation=0),
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
        Interfaces.Signal_pin       inp annotation (
          extent=[-92,-10; -72,10],
          layer="icon",
          Placement(transformation(extent={{-110,-10},{-90,10}},rotation=0),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        Interfaces.Signal_pin       out annotation (
          extent=[70,-10; 90,10],
          layer="icon",
          Placement(transformation(extent={{90,-10},{110,10}},rotation=0),
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

      model AVR_signal_limiter
        parameter Real Umax "AVR upper limit";
        parameter Real Umin "AVR lower limit";
        parameter Boolean inService_1 = true "AVR_signal limiter condition";

      equation
        out.Signal = if inService_1 then
        if inp.Signal > (Umax-1) then
          (Umax-1) else if inp.Signal < (Umin+1)
        then (Umin+1) else inp.Signal else inp.Signal;

      public
        Interfaces.Signal_pin       inp annotation (
          extent=[-92,-10; -72,10],
          layer="icon",
          Placement(transformation(extent={{-110,-10},{-90,10}},rotation=0),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        Interfaces.Signal_pin       out annotation (
          extent=[70,-10; 90,10],
          layer="icon",
          Placement(transformation(extent={{90,-10},{110,10}},rotation=0),
              iconTransformation(extent={{90,-10},{110,10}})));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-60,30},{58,-28}},
                lineColor={0,0,255},
                lineThickness=1),
              Text(extent={{-40,16},{40,-10}},
                textColor={0,0,0},
                textString="dU limiter"),
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
                thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Reactive_power_limiter model - limits AVR signal afer reaching Qmin/Qmax. </p>
<p>Модель блока ограничения сигнала при достижении Qmin/Qmax. </p>
</html>"));
      end AVR_signal_limiter;

      model Delayed_Derivative
        parameter Real t1 = 0.02 "Time delay (sec)";

        Real u "Входной сигнал";
        Real u_delayed "Задержанный входной сигнал";
        Real y "Выходной сигнал (производная)";

      public
        OMLET.Interfaces.Signal_pin inp
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        OMLET.Interfaces.Signal_pin out
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));

      equation
        u = inp.Signal;

        // Оператор delay(выражение, время_задержки)
        // Вторым аргументом может быть указано максимальное время задержки (обычно равно t1)
        u_delayed = delay(u, t1);

        // Дифференцирование задержанного сигнала
        y = der(u_delayed);

        out.Signal = y;

        annotation (
          Icon(
            coordinateSystem(extent={{-100,-100},{100,100}}),
            graphics={
              Rectangle(
                extent={{-60,30},{58,-28}},
                lineColor={0,0,255},
                lineThickness=1),
              Text(
                extent={{-55,25},{55,-25}},
                lineColor={0,0,255},
                textString="p*exp(-t1*p)"),
              Text(
                extent={{-100,60},{100,40}},
                textColor={0,0,0},
                textString="%name"),
              Line(points={{-60,0},{-94,0}}, color={0,0,255}),
              Line(points={{98,0},{58,0}}, color={0,0,255})}),
          Documentation(info="<html>
<p>Differentiation block with delay.</p>
<p>Блок дифференцирования с чистым запаздыванием: W(p) = p * exp(-t1*p)</p>
</html>"));
      end Delayed_Derivative;
      annotation (Icon(graphics={Bitmap(extent={{-132,-120},{154,110}},
                fileName=
                  "modelica://OMLET/Images/vecteezy_algorithm-flowchart-logic-icon-set-representing-programming_87105896/vecteezy_algorithm-flowchart-logic-icon-set-representing-programming_87105896.jpg")}));
    end Logic;

    package Exciters
      model Exciter
         //--- Параметры возбудителя ---
        parameter Real Te = 0.02 "Exciter time constant, с";
        parameter Real Kemax = 2.0 "Multiplicity of forcing on, p.u.";
        parameter Real Kemin = -0.6 "Multiplicity of forcing off, p.u.";
        parameter Boolean selfExcitation = true "Sign of self‑excitation (dependence on Ut)";
        parameter Real Kig_exc = 1.0;
        parameter Real Kif_exc = 1.0;
        parameter Real Ku_exc = 1.0;

        //--- Внутренние переменные ---

        Interfaces.Signal_pin Er0_pin annotation (extent=[-90,-8; -70,12], Placement(
              transformation(extent={{-110,-10},{-90,10}}, rotation=0),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        Interfaces.Signal_pin dEr_pin annotation (
          extent=[-60,66; -40,86],
          layer="icon",
          Placement(transformation(extent={{-110,16},{-90,36}}, rotation=0),
              iconTransformation(extent={{-110,16},{-90,36}})));
        Interfaces.Signal_pin Er_pin annotation (extent=[-90,-8; -70,12], Placement(
              transformation(extent={{170,-10},{190,10}},rotation=0),
              iconTransformation(extent={{170,-10},{190,10}})));
        Interfaces.Signal_pin Ut_pin annotation (extent=[-90,-8; -70,12], Placement(
              transformation(extent={{-110,-34},{-90,-14}}, rotation=0),
              iconTransformation(extent={{-110,-34},{-90,-14}})));

        Interfaces.Signal_pin dIg_pin annotation (
          extent=[-60,66; -40,86],
          layer="icon",
          Placement(transformation(extent={{-110,44},{-90,64}}, rotation=0),
              iconTransformation(extent={{-110,42},{-90,62}})));
        Interfaces.Signal_pin dIf_pin
                                     annotation (extent=[-90,-8; -70,12], Placement(
              transformation(extent={{-110,-64},{-90,-44}}, rotation=0),
              iconTransformation(extent={{-110,-64},{-90,-44}})));
        Logic.Transfer_Function Excitation_delay(b={1}, a={Te,1})
          annotation (Placement(transformation(extent={{52,-22},{100,24}})));
        Logic.Transfer_Function Rotor_current_deviation(b={Kif_exc}, a={1})
          annotation (Placement(transformation(extent={{-76,-80},{-12,-28}})));
        Logic.Transfer_Function AVR_signal(b={Ku_exc}, a={1})
          annotation (Placement(transformation(extent={{-76,0},{-12,52}})));
        Logic.Transfer_Function Stator_current_deviation(b={Kig_exc}, a={1})
          annotation (Placement(transformation(extent={{-76,28},{-12,80}})));
        Logic.Excitation_limiter excitation_limiter(
          selfExcitation=selfExcitation,
          Kemax=Kemax,
          Kemin=Kemin)
          annotation (Placement(transformation(extent={{112,-20},{154,24}})));
        Logic.Summator_4 summator_4_1
          annotation (Placement(transformation(extent={{8,-16},{42,18}})));
      equation

        connect(dIf_pin, dIf_pin) annotation (Line(
            points={{-100,-54},{-100,-54}},
            color={255,255,0},
            thickness=0.5));
        connect(dIg_pin, Stator_current_deviation.inp) annotation (Line(
            points={{-100,54},{-76,54}},
            color={255,255,0},
            thickness=0.5));
        connect(dIf_pin, Rotor_current_deviation.inp) annotation (Line(
            points={{-100,-54},{-76,-54}},
            color={255,255,0},
            thickness=0.5));
        connect(dEr_pin, AVR_signal.inp) annotation (Line(
            points={{-100,26},{-76,26}},
            color={255,255,0},
            thickness=0.5));
        connect(excitation_limiter.inp, Excitation_delay.out) annotation (Line(
            points={{112,2},{112,1},{100,1}},
            color={255,255,0},
            thickness=0.5));
        connect(excitation_limiter.out, Er_pin) annotation (Line(
            points={{154,2},{168,2},{168,0},{180,0}},
            color={255,255,0},
            thickness=0.5));
        connect(Ut_pin, excitation_limiter.Ut_pin) annotation (Line(
            points={{-100,-24},{134,-24},{134,-18},{128.8,-18},{128.8,-11.2}},
            color={255,255,0},
            thickness=0.5));
        connect(summator_4_1.out, Excitation_delay.inp) annotation (Line(
            points={{42,1},{52,1}},
            color={255,255,0},
            thickness=0.5));
        connect(AVR_signal.out, summator_4_1.inp2) annotation (Line(
            points={{-12,26},{2,26},{2,5.42},{8,5.42}},
            color={255,255,0},
            thickness=0.5));
        connect(Stator_current_deviation.out, summator_4_1.inp1) annotation (Line(
            points={{-12,54},{4,54},{4,13.24},{8,13.24}},
            color={255,255,0},
            thickness=0.5));
        connect(Er0_pin, summator_4_1.inp3) annotation (Line(
            points={{-100,0},{-80,0},{-80,-4},{4,-4},{4,-2.4},{8,-2.4}},
            color={255,255,0},
            thickness=0.5));
        connect(Rotor_current_deviation.out, summator_4_1.inp4) annotation (Line(
            points={{-12,-54},{-2,-54},{-2,-10.22},{8,-10.22}},
            color={255,255,0},
            thickness=0.5));
        connect(Er0_pin, excitation_limiter.Er0_pin) annotation (Line(
            points={{-100,0},{-80,0},{-80,-4},{4,-4},{4,-26},{137.2,-26},{137.2,-11.2}},
            color={255,255,0},
            thickness=0.5));

        annotation (Diagram(coordinateSystem(extent={{-100,-100},{180,100}})),
                                Icon(coordinateSystem(extent={{-100,-100},{180,100}}),
                                     graphics={
              Ellipse(
                extent={{-52,84},{126,-86}},
                lineColor={0,0,255},
                lineThickness=1),
              Text(extent={{6,38},{82,-36}},
                textString="Exciter",
                textColor={0,0,0}),
              Text(extent={{-42,-90},{118,-132}},
                textColor={0,0,0},
                textString="%name"),
              Line(
                points={{-52,0},{-94,0}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{176,0},{126,0}},
                color={0,0,255},
                thickness=1)}),
          Documentation(info="<html>
<p>Exciter model. </p>
<p>Модель возбудителя. </p>
</html>"));
      end Exciter;
      annotation (Icon(graphics={Bitmap(extent={{-120,-114},{130,100}},
                fileName=
                  "modelica://OMLET/Images/vecteezy_electric-motor-generating-power-with-blue-energy-bolts_70470711_683/vecteezy_electric-motor-generating-power-with-blue-energy-bolts_70470711.jpg")}));
    end Exciters;

    package Regulators
      model AVR_standart
        parameter Real K0u=-10 "Voltage deviation control coefficient";
        parameter Real K1u=0 "Voltage derivative control coefficient";
        parameter Real K0w=0 "Frequency deviation control coefficient";
        parameter Real K1w=0 "Frequency derivative control coefficient";
        parameter Real K1if=0 "Rotor current derivative control coefficient";
        parameter Real Uforc=0.85 "Voltage of field forcing input";
        parameter Real Udeforc=0.9 "Voltage of field forcing removing";
        parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
        parameter Real DL0=0;

        parameter Real Tokp=0.05 "The main channel of regulation time constant";
        constant Real T0u=0.02 "Voltage deviation time constant";
        constant Real T1u=0.039 "Voltage derivative time constant";
        constant Real Tfb=0.07 "Frequency block time constant";
        constant Real T0w=1.0 "Frequency deviation time constant";
        constant Real T1w=0.026 "Frequency derivative time constant";
        constant Real T1if=0.03 "Field current derivative time constant";

        Logic.Transfer_Function VoltageDeviation(b={K0u}, a={T0u,1})
          annotation (extent=[-74,57.3333; -27.3333,104], Placement(
              transformation(extent={{-86,37.3333},{-39.3333,84}}, rotation=0)));
        Logic.Transfer_Function VoltageDerivative(b={K1u,0}, a={T1u,1})
          annotation (extent=[-73.3333,17.3333; -26.6667,64], Placement(
              transformation(extent={{-85.3333,15.3333},{-38.6667,62}},
                rotation=0)));
        Logic.Transfer_Function FrequencyBlockD(b={1}, a={Tfb,1}) annotation (
           extent=[-82.6667,-22.6667; -48,24], Placement(transformation(
                extent={{-86.6667,-12.6667},{-52,34}}, rotation=0)));
        Logic.Transfer_Function FrequencyBlockU(b={1,0}, a={Tfb,1})
          annotation (extent=[-82,-63.3333; -48,-16], Placement(
              transformation(extent={{-86,-43.3333},{-52,4}}, rotation=0)));
        Logic.Transfer_Function FrequencyDeviation(b={K0w,0}, a={T0w,1})
          annotation (extent=[-28,-46; 10,2], Placement(transformation(extent
                ={{-32,-44},{6,4}}, rotation=0)));
        Logic.Transfer_Function FrequencyDerivative(b={K1w,0}, a={T1w,1})
          annotation (extent=[-24.6667,-19.3333; 10,28], Placement(
              transformation(extent={{-30.6667,-5.3333},{4,42}}, rotation=0)));
        Logic.Transfer_Function ExcitationCurrent(b={K1if,0}, a={T1if,1})
          annotation (extent=[-74,-102; -27.3333,-55.3333], Placement(
              transformation(extent={{-86,-68},{-39.3333,-21.3333}}, rotation
                =0)));
        Logic.Transfer_Function SimpleExciter(b={1}, a={Tokp,1}) annotation (
            extent=[56,-24; 83.3333,22.6667], Placement(transformation(extent
                ={{90,6},{117.333,52.6667}}, rotation=0)));
        OMLET.Interfaces.Signal_pin dV_pin annotation (
          extent=[-96,64; -86,76],
          layer="icon",
          Placement(transformation(extent={{-106,44},{-96,56}}, rotation=0),
              iconTransformation(extent={{-106,44},{-96,56}})));
        OMLET.Interfaces.Signal_pin dV1_pin annotation (
          extent=[-96,34; -86,46],
          layer="icon",
          Placement(transformation(extent={{-106,14},{-96,26}}, rotation=0),
              iconTransformation(extent={{-106,14},{-96,26}})));
        OMLET.Interfaces.Signal_pin dfsys_pin annotation (
          extent=[-96,4; -86,16],
          layer="icon",
          Placement(transformation(extent={{-106,-16},{-96,-4}}, rotation=0),
              iconTransformation(extent={{-106,-16},{-96,-4}})));
        OMLET.Interfaces.Signal_pin dfU_pin annotation (
          extent=[-96,-26; -86,-14],
          layer="icon",
          Placement(transformation(extent={{-106,-46},{-96,-34}}, rotation=0),
              iconTransformation(extent={{-106,-46},{-96,-34}})));
        OMLET.Interfaces.Signal_pin dif1_pin annotation (
          extent=[-96,-56; -86,-44],
          layer="icon",
          Placement(transformation(extent={{-106,-70},{-96,-58}}, rotation=0),
              iconTransformation(extent={{-106,-70},{-96,-58}})));
        OMLET.Interfaces.Signal_pin out_pin annotation (
          extent=[86,2; 96,22],
          layer="icon",
          Placement(transformation(extent={{136,-18},{146,2}}, rotation=0),
              iconTransformation(extent={{136,-18},{146,2}})));
        OMLET.Basic.Excitation_systems.Logic.Summator_2 Summator1 annotation (
            extent=[-44,-32; -30,-12], Placement(transformation(extent={{-50,-4},
                  {-36,16}}, rotation=0)));
        OMLET.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
                extent={{-106,-90},{-94,-78}}), iconTransformation(extent={{-106,
                  -90},{-94,-78}})));
        OMLET.Basic.Excitation_systems.Logic.logical_switch logical_switch1(
          a1=Uforc,
          a2=Udeforc,
          a3=K0u,
          a4=Tforcedelay)
          annotation (Placement(transformation(extent={{66,20},{86,40}})));
        Logic.Summator_4 summator_4_1
          annotation (Placement(transformation(extent={{34,10},{50,44}})));
        Logic.Summator_2 summator_2_1
          annotation (Placement(transformation(extent={{-18,36},{2,56}})));
      equation
        connect(dfsys_pin, FrequencyBlockD.inp) annotation (points=[-91, 10; -
              79.5467, 0.666667], Line(points={{-101,-10},{-86.6667,10.6666}}));
        connect(dfU_pin, FrequencyBlockU.inp) annotation (points=[-91, -20; -
              78.94, -39.6667], Line(points={{-101,-40},{-101,-19.6667},{-86,
                -19.6667}}));
        connect(FrequencyBlockD.out, Summator1.inp1) annotation (points=[-
              51.4667, 0.666667; -42.88, -18], Line(points={{-52,10.6666},{
                -52,10.2},{-50,10.2}}));
        connect(FrequencyBlockU.out, Summator1.inp2) annotation (points=[-51.4,
              -39.6667; -42.88, -26], Line(points={{-52,-19.6667},{-50,
                -19.6667},{-50,2}}));
        connect(dif1_pin, ExcitationCurrent.inp) annotation (points=[-91, -50; -
              69.8, -78.6667], Line(points={{-101,-64},{-101,-44.6667},{-86,
                -44.6667}}));
        connect(Summator1.out, FrequencyDeviation.inp) annotation (points=[-
              31.12, -22; -24.58, -22], Line(points={{-36,6},{-32,6},{-32,-20},{
                -32,-20}}));
        connect(FrequencyDerivative.inp, FrequencyDeviation.inp) annotation (
            points=[-21.5467, 4.33333; -24.58, -22], Line(points={{-30.6667,
                18.3333},{-30.6667,18},{-32,18},{-32,-20},{-32,-20}}));
        connect(VoltageDerivative.inp, dV1_pin) annotation (points=[-69.1333,
              40.6667; -91, 40], Line(points={{-85.3333,38.6666},{-85.3333,20},
                {-101,20}}));
        connect(VoltageDeviation.inp, dV_pin) annotation (points=[-69.8, 80.6667;
                -91, 70], Line(points={{-86,60.6667},{-86,50},{-101,50}}));
        when initial() then
          reinit(FrequencyBlockU.x[1], DL0);
          //     reinit(FrequencyDeviation.x[1],DL0);
          //     reinit(FrequencyDerivative.x[1],DL0);
        end when;

        connect(logical_switch1.out, SimpleExciter.inp) annotation (Line(points={{86,
                29.3333},{88,29.3333},{88,30},{88,29.3334},{88,29.3333},{90,
                29.3333}},                                                color={0,
                0,0}));
        connect(Ut_pin, logical_switch1.inp2inf) annotation (Line(points={{-100,
                -84},{56,-84},{56,20.1667},{76.2,20.1667}},
                                                     color={0,0,0}));
        connect(VoltageDeviation.out, logical_switch1.inp1) annotation (Line(points={{
                -39.3333,60.6667},{-6,60.6667},{-6,60},{54,60},{54,32.8333},{
                66,32.8333}},
                           color={0,0,0}));
        connect(VoltageDeviation.inp, logical_switch1.inp1inf) annotation (Line(
              points={{-86,60.6667},{-86,74},{70,74},{70,56},{76.1,56},{76.1,
                40}},                                                       color={
                0,0,0}));
        connect(SimpleExciter.out, out_pin) annotation (Line(points={{117.333,
                29.3333},{130,29.3333},{130,-8},{141,-8}},
                                                 color={0,0,0}));
        connect(summator_4_1.out, logical_switch1.inp2)
          annotation (Line(points={{50,27},{66,27}}, color={0,0,0}));
        connect(ExcitationCurrent.out, summator_4_1.inp4) annotation (Line(
              points={{-39.3333,-44.6667},{-39.3333,-38},{-34,-38},{-34,-48},
                {28,-48},{28,-20},{30,-20},{30,15.78},{34,15.78}},color={0,0,0}));
        connect(FrequencyDeviation.out, summator_4_1.inp3) annotation (Line(
              points={{6,-20},{28,-20},{28,16},{30,16},{30,23.6},{34,23.6}},
              color={0,0,0}));
        connect(FrequencyDerivative.out, summator_4_1.inp2) annotation (Line(
              points={{4,18.3333},{28,18.3333},{28,31.42},{34,31.42}}, color={0,
                0,0}));
        connect(summator_2_1.out, summator_4_1.inp1) annotation (Line(points={{
                2,46},{28,46},{28,39.24},{34,39.24}}, color={0,0,0}));
        connect(VoltageDerivative.out, summator_2_1.inp2) annotation (Line(
              points={{-38.6667,38.6666},{-20,38.6666},{-20,38},{-18,38},{-18,
                42}}, color={0,0,0}));
        connect(VoltageDeviation.out, summator_2_1.inp1) annotation (Line(
              points={{-39.3333,60.6667},{-22,60.6667},{-22,50.2},{-18,50.2}},
              color={0,0,0}));
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
                extent={{-68,72},{104,-94}},
                lineColor={0,0,255},
                lineThickness=1),
              Text(extent={{-22,38},{60,-40}}, textString=
                                                   "Excitation"),
              Text(extent={{-14,14},{56,-52}}, textString=
                                                   "regulator"),
              Line(
                points={{-68,-10},{-98,-10}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,-40},{-100,-40}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,-84},{-96,-84}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,20},{-98,20}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,50},{-98,50}},
                color={0,0,255},
                thickness=1),
              Text(extent={{-64,106},{96,74}},
                textColor={0,0,0},
                textString="%name"),
              Line(
                points={{138,-8},{104,-8}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,-64},{-98,-64}},
                color={0,0,255},
                thickness=1)},
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
<p>The standart model of Automatic Voltage Regulator (AVR). </p>
<p>Стандартная модель автоматического регулятора возбуждения. </p>
</html>"));
      end AVR_standart;

      model AVR_SD
        parameter Real K0u=10 "Voltage deviation control coefficient";
        parameter Real K1u=0 "Voltage derivative control coefficient";
        parameter Real K0w=0 "Frequency deviation control coefficient";
        parameter Real K1w=0 "Frequency derivative control coefficient";
        parameter Real K1if=0 "Rotor current derivative control coefficient";
        parameter Real Uforc=0.85 "Voltage of field forcing input";
        parameter Real Udeforc=0.9 "Voltage of field forcing removing";
        parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
        parameter Real DL0=0;

        parameter Real Tokp=0.05 "The main channel of regulation time constant";
        constant Real T1u=0.04 "Voltage derivative time constant";
        constant Real Tfb=0.07 "Frequency block time constant";
        constant Real T0w=0.9 "Frequency deviation time constant";
        constant Real T1w=0.04 "Frequency derivative time constant";
        constant Real T1if=0.04 "Field current derivative time constant";

        input Real Qgen;
        input Real Qmax;
        input Real Qmin;

        Logic.Transfer_Function VoltageDeviation(b={-K0u}, a={1}) annotation (
           extent=[-74,57.3333; -27.3333,104], Placement(transformation(
                extent={{-80,45.3333},{-33.3333,92}}, rotation=0)));
        Logic.Transfer_Function VoltageDerivative(b={-K1u,0}, a={T1u,1})
          annotation (extent=[-73.3333,17.3333; -26.6667,64], Placement(
              transformation(extent={{-79.3333,19.3333},{-32.6667,66}},
                rotation=0)));
        Logic.Transfer_Function FrequencyBlockD(b={T0w,0}, a={T0w,1})
          annotation (extent=[-82.6667,-22.6667; -48,24], Placement(
              transformation(extent={{-92.6667,-8.6667},{-58,38}},  rotation=
                  0)));
        Logic.Transfer_Function FrequencyBlockU(b={1,0}, a={T1w,1})
          annotation (extent=[-82,-63.3333; -48,-16], Placement(
              transformation(extent={{-90,-45.3333},{-56,2}}, rotation=0)));
        Logic.Transfer_Function FrequencyDeviation(b={1}, a={Tfb,1})
          annotation (extent=[-28,-46; 10,2], Placement(transformation(extent={{0,-28},
                  {38,20}},          rotation=0)));
        Logic.Transfer_Function ExcitationCurrent(b={-K1if,0}, a={T1if,1})
          annotation (extent=[-74,-102; -27.3333,-55.3333], Placement(
              transformation(extent={{-84,-78},{-37.3333,-31.3333}}, rotation
                =0)));
        Logic.Transfer_Function SimpleExciter(b={1}, a={Tokp,1}) annotation (
            extent=[56,-24; 83.3333,22.6667], Placement(transformation(extent
                ={{90,6},{117.333,52.6667}}, rotation=0)));
        OMLET.Interfaces.Signal_pin dV_pin annotation (
          extent=[-96,64; -86,76],
          layer="icon",
          Placement(transformation(extent={{-106,84},{-96,96}}, rotation=0),
              iconTransformation(extent={{-106,84},{-96,96}})));
        OMLET.Interfaces.Signal_pin dV1_pin annotation (
          extent=[-96,34; -86,46],
          layer="icon",
          Placement(transformation(extent={{-106,36},{-96,48}}, rotation=0),
              iconTransformation(extent={{-106,36},{-96,48}})));
        OMLET.Interfaces.Signal_pin dfsys_pin annotation (
          extent=[-96,4; -86,16],
          layer="icon",
          Placement(transformation(extent={{-106,8},{-96,20}},   rotation=0),
              iconTransformation(extent={{-106,8},{-96,20}})));
        OMLET.Interfaces.Signal_pin dfU_pin annotation (
          extent=[-96,-26; -86,-14],
          layer="icon",
          Placement(transformation(extent={{-106,-28},{-96,-16}}, rotation=0),
              iconTransformation(extent={{-106,-28},{-96,-16}})));
        OMLET.Interfaces.Signal_pin dif1_pin annotation (
          extent=[-96,-56; -86,-44],
          layer="icon",
          Placement(transformation(extent={{-106,-60},{-96,-48}}, rotation=0),
              iconTransformation(extent={{-106,-60},{-96,-48}})));
        OMLET.Interfaces.Signal_pin out_pin annotation (
          extent=[86,2; 96,22],
          layer="icon",
          Placement(transformation(extent={{136,-18},{146,2}}, rotation=0),
              iconTransformation(extent={{136,-18},{146,2}})));
        OMLET.Basic.Excitation_systems.Logic.Summator_2 Summator1 annotation (
            extent=[-44,-32; -30,-12], Placement(transformation(extent={{-16,-14},
                  {-2,6}}, rotation=0)));
        OMLET.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
                extent={{-106,-90},{-94,-78}}), iconTransformation(extent={{-106,
                  -90},{-94,-78}})));
        OMLET.Basic.Excitation_systems.Logic.logical_switch logical_switch1(
          a1=Uforc,
          a2=Udeforc,
          a3=K0u,
          a4=Tforcedelay)
          annotation (Placement(transformation(extent={{66,20},{86,40}})));
        Logic.Transfer_Function FrequencyBlockD1(b={K0w}, a={1}) annotation (
            extent=[-82.6667,-22.6667; -48,24], Placement(transformation(
                extent={{-52.6667,-8.6667},{-18,38}},  rotation=0)));
        Logic.Transfer_Function FrequencyBlockD2(b={-K1w}, a={1}) annotation (
           extent=[-82.6667,-22.6667; -48,24], Placement(transformation(
                extent={{-50.6667,-44.6667},{-16,2}}, rotation=0)));
        Logic.Reactive_power_limiter under_overexcitation_limiter(
          Qgen=Qgen,
          Qmax=Qmax,
          Qmin=Qmin,
          inService=inService)
          annotation (Placement(transformation(extent={{122,16},{152,42}})));
        parameter Boolean inService=true "Excitation limiter condition";
        Logic.Summator_4 summator_4_1
          annotation (Placement(transformation(extent={{40,12},{60,42}})));
        Logic.AVR_signal_limiter aVR_signal_limiter(
          Umax=Umax,
          Umin=Umin,
          inService_1=inService_1)
          annotation (Placement(transformation(extent={{98,-22},{132,8}})));
        parameter Real Umax "AVR upper limit";
        parameter Real Umin "AVR lower limit";
        parameter Boolean inService_1=true "AVR_signal limiter condition";
      equation
        connect(dfsys_pin, FrequencyBlockD.inp) annotation (points=[-91, 10; -
              79.5467, 0.666667], Line(points={{-101,14},{-101,14.6666},{
                -92.6667,14.6666}}));
        connect(dfU_pin, FrequencyBlockU.inp) annotation (points=[-91, -20; -
              78.94, -39.6667], Line(points={{-101,-22},{-101,-21.6667},{-90,
                -21.6667}}));
        connect(dif1_pin, ExcitationCurrent.inp) annotation (points=[-91, -50; -
              69.8, -78.6667], Line(points={{-101,-54},{-90,-54},{-90,-54.6667},
                {-84,-54.6667}}));
        connect(Summator1.out, FrequencyDeviation.inp) annotation (points=[-
              31.12, -22; -24.58, -22], Line(points={{-2,-4},{0,-4}}));
        connect(VoltageDerivative.inp, dV1_pin) annotation (points=[-69.1333,
              40.6667; -91, 40], Line(points={{-79.3333,42.6667},{-79.3333,42},
                {-101,42}}));
        when initial() then
          reinit(FrequencyDeviation.x[1], DL0);
          //     reinit(FrequencyDeviation.x[1],DL0);
          //     reinit(FrequencyDerivative.x[1],DL0);
        end when;

        connect(logical_switch1.out, SimpleExciter.inp) annotation (Line(points={{86,
                29.3333},{88,29.3333},{88,30},{88,29.3334},{88,29.3333},{90,
                29.3333}},                                                color={0,
                0,0}));
        connect(Ut_pin, logical_switch1.inp2inf) annotation (Line(points={{-100,
                -84},{76,-84},{76,20.1667},{76.2,20.1667}},
                                                     color={0,0,0}));
        connect(VoltageDeviation.out, logical_switch1.inp1) annotation (Line(points={{
                -33.3333,68.6667},{34,68.6667},{34,46},{66,46},{66,32.8333}},
                           color={0,0,0}));
        connect(VoltageDeviation.inp, logical_switch1.inp1inf) annotation (Line(
              points={{-80,68.6667},{-80,90},{76.1,90},{76.1,40}},          color={
                0,0,0}));
        connect(FrequencyBlockU.out, FrequencyBlockD2.inp) annotation (Line(
            points={{-56,-21.6667},{-56,-21.3333},{-50.6667,-21.3333}},
            color={0,0,0}));
        connect(Summator1.inp2, FrequencyBlockD2.out) annotation (Line(
            points={{-16,-8},{-16,-21.3333}},
            color={0,0,0}));
        connect(Summator1.inp1, FrequencyBlockD1.out) annotation (Line(
            points={{-16,0.2},{-16,14.6666},{-18,14.6666}},
            color={0,0,0}));
        connect(FrequencyBlockD.out, FrequencyBlockD1.inp) annotation (Line(points={{-58,
                14.6666},{-58,14},{-58,14},{-56,14},{-56,14.6666},{-52.6667,
                14.6666}},                                                color={0,0,0}));
        connect(SimpleExciter.out, under_overexcitation_limiter.inp)
          annotation (Line(points={{117.333,29.3333},{117.333,29},{122,29}},
              color={0,0,0}));
        connect(VoltageDeviation.out, summator_4_1.inp1) annotation (Line(points={{
                -33.3333,68.6667},{34,68.6667},{34,37.8},{40,37.8}},
                                                           color={0,0,0}));
        connect(VoltageDerivative.out, summator_4_1.inp2) annotation (Line(points={{
                -32.6667,42.6667},{30,42.6667},{30,30.9},{40,30.9}},
                                                            color={0,0,0}));
        connect(FrequencyDeviation.out, summator_4_1.inp3)
          annotation (Line(points={{38,-4},{38,24},{40,24}}, color={0,0,0}));
        connect(ExcitationCurrent.out, summator_4_1.inp4) annotation (Line(points={{
                -37.3333,-54.6667},{40,-54.6667},{40,17.1}},        color={0,0,0}));
        connect(summator_4_1.out, logical_switch1.inp2)
          annotation (Line(points={{60,27},{66,27}}, color={0,0,0}));
        connect(dV_pin, VoltageDeviation.inp) annotation (Line(points={{-101,90},
                {-80,90},{-80,68.6667}},                   color={0,0,0}));
        connect(aVR_signal_limiter.inp, under_overexcitation_limiter.out)
          annotation (Line(points={{98,-7},{98,-8},{92,-8},{92,14},{152,14},{
                152,29}},                            color={0,0,0}));
        connect(aVR_signal_limiter.out, out_pin) annotation (Line(points={{132,-7},
                {132,-8},{141,-8}},                       color={0,0,0}));
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
                extent={{-68,72},{104,-94}},
                lineColor={0,0,255},
                lineThickness=1),
              Text(extent={{-22,38},{60,-40}}, textString=
                                                   "Excitation"),
              Text(extent={{-14,14},{56,-52}}, textString=
                                                   "regulator"),
              Line(
                points={{-68,-10},{-98,-10}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,-40},{-100,-40}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,-84},{-96,-84}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,20},{-98,20}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,50},{-98,50}},
                color={0,0,255},
                thickness=1),
              Text(extent={{-64,106},{96,74}},
                textColor={0,0,0},
                textString="%name"),
              Line(
                points={{138,-8},{104,-8}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,-64},{-98,-64}},
                color={0,0,255},
                thickness=1)},
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
                extent={{-36,82},{-26,72}},
                textColor={0,0,0},
                textString="ΔU"),
              Text(
                extent={{-36,56},{-24,44}},
                textColor={0,0,0},
                textString="ΔU'"),
              Text(
                extent={{-18,30},{-6,20}},
                textColor={0,0,0},
                textString="ΔF"),
              Text(
                extent={{-14,-22},{-2,-32}},
                textColor={0,0,0},
                textString="ΔF'"),
              Text(
                extent={{-36,-40},{-24,-50}},
                textColor={0,0,0},
                textString="ΔIf'"),
              Text(
                extent={{-38,-72},{-26,-82}},
                textColor={0,0,0},
                textString="Utr")}),
          Documentation(info="<html>
<p>The model of Automatic Voltage Regulator (AVR), type &quot;AVR-SD&quot;. </p>
<p>Модель регулятора возбуждения типа &quot;АРВ-СД&quot;. </p>
</html>"));
      end AVR_SD;

      model Excitation_Regulator_Q_limit
        parameter Real K0u=20 "Voltage deviation control coefficient";
        parameter Real K1u=0 "Voltage derivative control coefficient";
        parameter Real K0w=0 "Frequency deviation control coefficient";
        parameter Real K1w=0 "Frequency derivative control coefficient";
        parameter Real K1if=0 "Rotor current derivative control coefficient";
        parameter Real Uforc=0.85 "Voltage of field forcing input";
        parameter Real Udeforc=0.9 "Voltage of field forcing removing";
        parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
        parameter Real DL0=0;

        parameter Real Tokp=0.05 "The main channel of regulation time constant";
        constant Real T0u=0.02 "Voltage deviation time constant";
        constant Real T1u=0.039 "Voltage derivative time constant";
        constant Real Tfb=0.07 "Frequency block time constant";
        constant Real T0w=1.0 "Frequency deviation time constant";
        constant Real T1w=0.026 "Frequency derivative time constant";
        constant Real T1if=0.03 "Field current derivative time constant";

        input Real Qgen;
        input Real Qmax;
        input Real Qmin;

        Logic.Transfer_Function VoltageDeviation(b={-K0u}, a={T0u,1})
          annotation (extent=[-74,57.3333; -27.3333,104], Placement(
              transformation(extent={{-86,37.3333},{-39.3333,84}}, rotation=0)));
        Logic.Transfer_Function VoltageDerivative(b={-K1u,0}, a={T1u,1})
          annotation (extent=[-73.3333,17.3333; -26.6667,64], Placement(
              transformation(extent={{-85.3333,15.3333},{-38.6667,62}},
                rotation=0)));
        Logic.Transfer_Function FrequencyBlockD(b={1}, a={Tfb,1}) annotation (
           extent=[-82.6667,-22.6667; -48,24], Placement(transformation(
                extent={{-86.6667,-12.6667},{-52,34}}, rotation=0)));
        Logic.Transfer_Function FrequencyBlockU(b={1,0}, a={Tfb,1})
          annotation (extent=[-82,-63.3333; -48,-16], Placement(
              transformation(extent={{-86,-43.3333},{-52,4}}, rotation=0)));
        Logic.Transfer_Function FrequencyDeviation(b={K0w,0}, a={T0w,1})
          annotation (extent=[-28,-46; 10,2], Placement(transformation(extent
                ={{-32,-44},{6,4}}, rotation=0)));
        Logic.Transfer_Function FrequencyDerivative(b={-K1w,0}, a={T1w,1})
          annotation (extent=[-24.6667,-19.3333; 10,28], Placement(
              transformation(extent={{-30.6667,-5.3333},{4,42}}, rotation=0)));
        Logic.Transfer_Function ExcitationCurrent(b={K1if,0}, a={T1if,1})
          annotation (extent=[-74,-102; -27.3333,-55.3333], Placement(
              transformation(extent={{-86,-68},{-39.3333,-21.3333}}, rotation
                =0)));
        Logic.Transfer_Function SimpleExciter(b={1}, a={Tokp,1}) annotation (
            extent=[56,-24; 83.3333,22.6667], Placement(transformation(extent
                ={{90,6},{117.333,52.6667}}, rotation=0)));
        OMLET.Interfaces.Signal_pin dV_pin annotation (
          extent=[-96,64; -86,76],
          layer="icon",
          Placement(transformation(extent={{-106,44},{-96,56}}, rotation=0),
              iconTransformation(extent={{-106,44},{-96,56}})));
        OMLET.Interfaces.Signal_pin dV1_pin annotation (
          extent=[-96,34; -86,46],
          layer="icon",
          Placement(transformation(extent={{-106,14},{-96,26}}, rotation=0),
              iconTransformation(extent={{-106,14},{-96,26}})));
        OMLET.Interfaces.Signal_pin dfsys_pin annotation (
          extent=[-96,4; -86,16],
          layer="icon",
          Placement(transformation(extent={{-106,-16},{-96,-4}}, rotation=0),
              iconTransformation(extent={{-106,-16},{-96,-4}})));
        OMLET.Interfaces.Signal_pin dfU_pin annotation (
          extent=[-96,-26; -86,-14],
          layer="icon",
          Placement(transformation(extent={{-106,-46},{-96,-34}}, rotation=0),
              iconTransformation(extent={{-106,-46},{-96,-34}})));
        OMLET.Interfaces.Signal_pin dif1_pin annotation (
          extent=[-96,-56; -86,-44],
          layer="icon",
          Placement(transformation(extent={{-106,-70},{-96,-58}}, rotation=0),
              iconTransformation(extent={{-106,-70},{-96,-58}})));
        OMLET.Interfaces.Signal_pin out_pin annotation (
          extent=[86,2; 96,22],
          layer="icon",
          Placement(transformation(extent={{136,-18},{146,2}}, rotation=0),
              iconTransformation(extent={{136,-18},{146,2}})));
        OMLET.Basic.Excitation_systems.Logic.Summator_2 Summator1 annotation (
            extent=[-44,-32; -30,-12], Placement(transformation(extent={{-50,-4},
                  {-36,16}}, rotation=0)));
        OMLET.Basic.Excitation_systems.Logic.Summator_2 Summator2 annotation (
            extent=[12,-18; 26,2], Placement(transformation(extent={{10,-26},{
                  24,-6}}, rotation=0)));
        OMLET.Basic.Excitation_systems.Logic.Summator_2 Summator3 annotation (
            extent=[8,48; 22,68], Placement(transformation(extent={{-12,32},{2,
                  52}}, rotation=0)));
        OMLET.Basic.Excitation_systems.Logic.Summator_2 Summator5 annotation (
            extent=[26,18; 40,38], Placement(transformation(extent={{12,18},{26,
                  38}}, rotation=0)));
        OMLET.Basic.Excitation_systems.Logic.Summator_2 Summator6 annotation (
            extent=[40,-10; 54,10], Placement(transformation(extent={{30,14},{
                  44,34}}, rotation=0)));
        OMLET.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
                extent={{-106,-90},{-94,-78}}), iconTransformation(extent={{-106,
                  -90},{-94,-78}})));
        OMLET.Basic.Excitation_systems.Logic.logical_switch logical_switch1(
          a1=Uforc,
          a2=Udeforc,
          a3=K0u,
          a4=Tforcedelay)
          annotation (Placement(transformation(extent={{60,18},{80,38}})));
        Logic.Reactive_power_limiter under_overexcitation_limiter(
          Qgen=Qgen,
          Qmax=Qmax,
          Qmin=Qmin,
          inService=inService)
          annotation (Placement(transformation(extent={{128,20},{148,40}})));
        parameter Boolean inService=true "Excitation limiter condition";
      equation
        connect(dfsys_pin, FrequencyBlockD.inp) annotation (points=[-91, 10; -
              79.5467, 0.666667], Line(points={{-101,-10},{-86.6667,10.6666}}));
        connect(dfU_pin, FrequencyBlockU.inp) annotation (points=[-91, -20; -
              78.94, -39.6667], Line(points={{-101,-40},{-101,-19.6667},{-86,
                -19.6667}}));
        connect(FrequencyBlockD.out, Summator1.inp1) annotation (points=[-
              51.4667, 0.666667; -42.88, -18], Line(points={{-52,10.6666},{-52,
                10.2},{-50,10.2}}));
        connect(FrequencyBlockU.out, Summator1.inp2) annotation (points=[-51.4,
              -39.6667; -42.88, -26], Line(points={{-52,-19.6667},{-50,-19.6667},
                {-50,2}}));
        connect(dif1_pin, ExcitationCurrent.inp) annotation (points=[-91, -50; -
              69.8, -78.6667], Line(points={{-101,-64},{-101,-44.6667},{-86,
                -44.6667}}));
        connect(Summator1.out, FrequencyDeviation.inp) annotation (points=[-
              31.12, -22; -24.58, -22], Line(points={{-36,6},{-32,6},{-32,-20},{
                -32,-20}}));
        connect(FrequencyDerivative.inp, FrequencyDeviation.inp) annotation (
            points=[-21.5467, 4.33333; -24.58, -22], Line(points={{-30.6667,
                18.3333},{-30.6667,18},{-32,18},{-32,-20},{-32,-20}}));
        connect(Summator2.inp2, FrequencyDeviation.out) annotation (points=[
              13.12, -12; 6.2, -22], Line(points={{10,-20},{6,-20}}));
        connect(FrequencyDerivative.out, Summator2.inp1) annotation (points=[
              6.53333, 4.33333; 13.12, -4], Line(points={{4,18.3333},{6,18.3333},
                {6,-11.8},{10,-11.8}}));
        connect(VoltageDerivative.inp, dV1_pin) annotation (points=[-69.1333,
              40.6667; -91, 40], Line(points={{-85.3333,38.6666},{-85.3333,20},
                {-101,20}}));
        connect(VoltageDeviation.inp, dV_pin) annotation (points=[-69.8, 80.6667;
                -91, 70], Line(points={{-86,60.6667},{-86,50},{-101,50}}));
        connect(VoltageDeviation.out, Summator3.inp1) annotation (points=[-32,
              80.6667; 9.12, 62], Line(points={{-39.3333,60.6667},{-18,60.6667},
                {-18,46.2},{-12,46.2}}));
        connect(VoltageDerivative.out, Summator3.inp2) annotation (points=[-
              31.3333, 40.6667; 9.12, 54], Line(points={{-38.6667,38.6666},{
                -38.6667,38},{-12,38}}));
        connect(Summator5.inp1, Summator3.out) annotation (points=[27.12, 32;
              20.88, 58], Line(points={{12,32.2},{6,32.2},{6,42},{2,42}}));
        connect(Summator5.inp2, Summator2.out) annotation (points=[27.12, 24;
              24.88, -8], Line(points={{12,24},{10,24},{10,-4},{26,-4},{26,-16},{
                24,-16}}));
        connect(Summator6.inp1, Summator5.out) annotation (points=[41.12, 4;
              38.88, 28], Line(points={{30,28.2},{29.12,28.2},{29.12,28},{26,28}}));
        connect(Summator6.inp2, ExcitationCurrent.out) annotation (points=[41.12,
                -4; -32, -78.6667], Line(points={{30,20},{30,-44.6667},{
                -39.3333,-44.6667}}));
        when initial() then
          reinit(FrequencyBlockU.x[1], DL0);
          //     reinit(FrequencyDeviation.x[1],DL0);
          //     reinit(FrequencyDerivative.x[1],DL0);
        end when;

        connect(logical_switch1.out, SimpleExciter.inp) annotation (Line(points={{80,
                27.3333},{86,27.3333},{86,29.3333},{90,29.3333}},         color={0,
                0,0}));
        connect(Ut_pin, logical_switch1.inp2inf) annotation (Line(points={{-100,
                -84},{56,-84},{56,18.1667},{70.2,18.1667}},
                                                     color={0,0,0}));
        connect(Summator6.out, logical_switch1.inp2) annotation (Line(points={{44,24},
                {52,24},{52,25},{60,25}},                       color={0,0,0}));
        connect(VoltageDeviation.out, logical_switch1.inp1) annotation (Line(points={{
                -39.3333,60.6667},{-6,60.6667},{-6,60},{54,60},{54,30.8333},{60,
                30.8333}}, color={0,0,0}));
        connect(VoltageDeviation.inp, logical_switch1.inp1inf) annotation (Line(
              points={{-86,60.6667},{-86,74},{70,74},{70,56},{70.1,56},{70.1,38}},
                                                                            color={
                0,0,0}));
        connect(under_overexcitation_limiter.inp, SimpleExciter.out) annotation (Line(
              points={{128,30},{128,29.3333},{117.333,29.3333}}, color={0,0,0}));
        connect(under_overexcitation_limiter.out, out_pin) annotation (Line(points={{148,
                30},{152,30},{152,-8},{141,-8}}, color={0,0,0}));
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
                extent={{-68,72},{104,-94}},
                lineColor={0,0,255},
                lineThickness=1),
              Text(extent={{-22,38},{60,-40}}, textString=
                                                   "Excitation"),
              Text(extent={{-14,14},{56,-52}}, textString=
                                                   "regulator"),
              Line(
                points={{-68,-10},{-98,-10}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,-40},{-100,-40}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,-84},{-96,-84}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,20},{-98,20}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,50},{-98,50}},
                color={0,0,255},
                thickness=1),
              Text(extent={{-64,106},{96,74}},
                textColor={0,0,0},
                textString="%name"),
              Line(
                points={{138,-8},{104,-8}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-68,-64},{-98,-64}},
                color={0,0,255},
                thickness=1)},
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
<p>The standart model of Automatic Voltage Regulator (AVR) with Q-limiter. </p>
<p>Стандартная модель автоматического регулятора возбуждения с ограничителем сигнала по реактивной мощности. </p>
</html>"));
      end Excitation_Regulator_Q_limit;

      model AVR_M
        parameter Real K0u=10 "Voltage deviation control coefficient";
        parameter Real K1u=0 "Voltage derivative control coefficient";
        parameter Real K0w=0 "Frequency deviation control coefficient";
        parameter Real K1w=0 "Frequency derivative control coefficient";
        parameter Real K1if=0 "Rotor current derivative control coefficient";
        parameter Real Uforc=0.85 "Voltage of field forcing input";
        parameter Real Udeforc=0.9 "Voltage of field forcing removing";
        parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
        parameter Real DL0=0;

        constant Real T1=0.06;
        constant Real T2=2;
        constant Real T3=0.02;
        constant Real T4=0.08;
        constant Real T5=0.135;
        constant Real Tokp=2 "The main channel of regulation time constant";
        constant Real tau1=0.02;
        constant Real tau2=0.05;
        constant Real tau3=0.02;

        input Real Qgen;
        input Real Qmax;
        input Real Qmin;

        Logic.Transfer_Function VoltageDeviation(b={-K0u}, a={1}) annotation (
           extent=[-74,57.3333; -27.3333,104], Placement(transformation(
                extent={{-102,63.3333},{-55.3333,110}}, rotation=0)));
        Logic.Transfer_Function VoltageDerivative(b={-K1u}, a={T1,1})
          annotation (extent=[-73.3333,17.3333; -26.6667,64], Placement(
              transformation(extent={{-71.3333,13.3333},{-24.6667,60}},
                rotation=0)));
        Logic.Transfer_Function FrequencyBlockD(b={T2,0}, a={T2,1})
          annotation (extent=[-82.6667,-22.6667; -48,24], Placement(
              transformation(extent={{-128.667,-22.6667},{-94,24}}, rotation=
                  0)));
        Logic.Transfer_Function ExcitationCurrent(b={K1if}, a={T5,1})
          annotation (extent=[-74,-102; -27.3333,-55.3333], Placement(
              transformation(extent={{-68,-88},{-21.3333,-41.3333}}, rotation
                =0)));
        Logic.Transfer_Function SimpleExciter(b={1}, a={Tokp,1}) annotation (
            extent=[56,-24; 83.3333,22.6667], Placement(transformation(extent
                ={{-12,14},{26,58}}, rotation=0)));
        OMLET.Interfaces.Signal_pin dV_pin annotation (
          extent=[-96,64; -86,76],
          layer="icon",
          Placement(transformation(extent={{-146,74},{-136,86}}, rotation=0),
              iconTransformation(extent={{-146,74},{-136,86}})));
        OMLET.Interfaces.Signal_pin dV1_pin annotation (
          extent=[-96,34; -86,46],
          layer="icon",
          Placement(transformation(extent={{-146,36},{-136,48}}, rotation=0),
              iconTransformation(extent={{-146,36},{-136,48}})));
        OMLET.Interfaces.Signal_pin dfsys_pin annotation (
          extent=[-96,4; -86,16],
          layer="icon",
          Placement(transformation(extent={{-146,-6},{-136,6}}, rotation=0),
              iconTransformation(extent={{-146,-6},{-136,6}})));
        OMLET.Interfaces.Signal_pin dfU_pin annotation (
          extent=[-96,-26; -86,-14],
          layer="icon",
          Placement(transformation(extent={{-146,-46},{-136,-34}}, rotation=0),
              iconTransformation(extent={{-146,-46},{-136,-34}})));
        OMLET.Interfaces.Signal_pin dif1_pin annotation (
          extent=[-96,-56; -86,-44],
          layer="icon",
          Placement(transformation(extent={{-146,-70},{-136,-58}}, rotation=0),
              iconTransformation(extent={{-146,-70},{-136,-58}})));
        OMLET.Interfaces.Signal_pin out_pin annotation (
          extent=[86,2; 96,22],
          layer="icon",
          Placement(transformation(extent={{194,-10},{204,10}}, rotation=0),
              iconTransformation(extent={{194,-10},{204,10}})));
        OMLET.Basic.Excitation_systems.Logic.Summator_2 Summator1 annotation (
            extent=[-44,-32; -30,-12], Placement(transformation(extent={{-4,-16},
                  {10,4}}, rotation=0)));
        OMLET.Basic.Excitation_systems.Logic.Summator_2 Summator5 annotation (
            extent=[26,18; 40,38], Placement(transformation(extent={{76,14},{90,
                  34}}, rotation=0)));
        OMLET.Interfaces.Signal_pin Ut_pin annotation (Placement(transformation(
                extent={{-146,-90},{-134,-78}}), iconTransformation(extent={{-146,
                  -90},{-134,-78}})));
        OMLET.Basic.Excitation_systems.Logic.logical_switch logical_switch1(
          a1=Uforc,
          a2=Udeforc,
          a3=K0u,
          a4=Tforcedelay)
          annotation (Placement(transformation(extent={{118,-10},{138,10}})));
        Logic.Transfer_Function FrequencyBlockD1(b={K0w}, a={T3,1})
          annotation (extent=[-82.6667,-22.6667; -48,24], Placement(
              transformation(extent={{-74.6667,-22.6667},{-32,24}}, rotation=
                  0)));
        Logic.Transfer_Function FrequencyBlockD2(b={-K1w}, a={T4,1})
          annotation (extent=[-82.6667,-22.6667; -48,24], Placement(
              transformation(extent={{-64.6667,-58.6667},{-22,-12}}, rotation
                =0)));
        Logic.Delayed_Derivative delayed_Derivative(t1=tau1)
          annotation (Placement(transformation(extent={{-124,20},{-82,62}})));
        Logic.Delayed_Derivative delayed_Derivative1(t1=tau2) annotation (
            Placement(transformation(extent={{-126,-60},{-84,-18}})));
        Logic.Delayed_Derivative delayed_Derivative2(t1=tau3) annotation (
            Placement(transformation(extent={{-124,-86},{-82,-44}})));
        Logic.Summator_2_negative negative_summator
          annotation (Placement(transformation(extent={{50,26},{70,46}})));
        Logic.Summator_2_negative negative_summator1
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Logic.Transfer_Function SimpleExciter1(b={1}, a={Tokp,1}) annotation (
           extent=[56,-24; 83.3333,22.6667], Placement(transformation(extent=
                  {{18,-28},{56,16}}, rotation=0)));
        Logic.Transfer_Function SimpleExciter2(b={1}, a={Tokp,1}) annotation (
           extent=[56,-24; 83.3333,22.6667], Placement(transformation(extent=
                  {{-10,-86},{28,-42}}, rotation=0)));
        Logic.Reactive_power_limiter under_overexcitation_limiter(
          Qgen=Qgen,
          Qmax=Qmax,
          Qmin=Qmin,
          inService=inService)
          annotation (Placement(transformation(extent={{152,-10},{172,10}})));
        parameter Boolean inService=true "Excitation limiter condition";
      equation
        connect(dfsys_pin, FrequencyBlockD.inp) annotation (points=[-91, 10; -
              79.5467, 0.666667], Line(points={{-141,0},{-141,0.66665},{-128.667,0.66665}}));
        connect(VoltageDeviation.inp, dV_pin) annotation (points=[-69.8, 80.6667;
                -91, 70], Line(points={{-102,86.6667},{-130,86.6667},{-130,80},
                {-141,80}}));
        when initial() then
          //     reinit(FrequencyBlockD2.x[1], DL0);
          //     reinit(FrequencyDeviation.x[1],DL0);
          //     reinit(FrequencyDerivative.x[1],DL0);
        end when;

        connect(Ut_pin, logical_switch1.inp2inf) annotation (Line(points={{-140,-84},{
                128.2,-84},{128.2,-9.83333}},        color={0,0,0}));
        connect(VoltageDeviation.out, logical_switch1.inp1) annotation (Line(points={{
                -55.3333,86.6667},{54,86.6667},{54,56},{118,56},{118,2.83333}},
                           color={0,0,0}));
        connect(VoltageDeviation.inp, logical_switch1.inp1inf) annotation (Line(
              points={{-102,86.6667},{-110,86.6667},{-110,64},{128.1,64},{128.1,
                10}},                                                       color={
                0,0,0}));
        connect(FrequencyBlockD.out, FrequencyBlockD1.inp) annotation (Line(
            points={{-94,0.66665},{-74.6667,0.66665}},
            color={0,0,0}));
        connect(delayed_Derivative.inp, dV1_pin) annotation (Line(
            points={{-124,41},{-124,42},{-141,42}},
            color={255,255,0},
            thickness=0.5));
        connect(delayed_Derivative.out, VoltageDerivative.inp) annotation (Line(
            points={{-82,41},{-82,36.6666},{-71.3333,36.6666}},
            color={0,0,0}));
        connect(dfU_pin, delayed_Derivative1.inp) annotation (Line(points={{-141,-40},
                {-140,-39},{-126,-39}}, color={0,0,0}));
        connect(delayed_Derivative1.out, FrequencyBlockD2.inp) annotation (Line(
              points={{-84,-39},{-84,-34},{-64,-34},{-64,-35.3333},{-64.6667,
                -35.3333}},
              color={0,0,0}));
        connect(dif1_pin, delayed_Derivative2.inp) annotation (Line(points={{-141,-64},
                {-140,-65},{-124,-65}}, color={0,0,0}));
        connect(delayed_Derivative2.out, ExcitationCurrent.inp) annotation (Line(
              points={{-82,-65},{-82,-64.6667},{-68,-64.6667}}, color={0,0,0}));
        connect(negative_summator.inp1, VoltageDeviation.out) annotation (Line(points={{50,40.2},
                {42,40.2},{42,56},{54,56},{54,86.6667},{-55.3333,86.6667}},
              color={0,0,0}));
        connect(negative_summator.out, Summator5.inp1) annotation (Line(
            points={{70,36},{72,36},{72,28.2},{76,28.2}},
            color={255,255,0},
            thickness=0.5));
        connect(Summator5.out, negative_summator1.inp1) annotation (Line(points={{90,24},
                {88,24},{88,6},{78,6},{78,4.2},{90,4.2}}, color={0,0,0}));
        connect(negative_summator1.out, logical_switch1.inp2) annotation (Line(points
              ={{110,0},{114,0},{114,-3},{118,-3}}, color={0,0,0}));
        connect(ExcitationCurrent.out, SimpleExciter2.inp) annotation (Line(
              points={{-21.3333,-64.6667},{-22,-64},{-10,-64}}, color={0,0,0}));
        connect(FrequencyBlockD1.out, Summator1.inp1) annotation (Line(points={{
                -32,0.66665},{-10,0.66665},{-10,-1.8},{-4,-1.8}}, color={0,0,0}));
        connect(FrequencyBlockD2.out, Summator1.inp2) annotation (Line(points={{-22,
                -35.3333},{-10,-35.3333},{-10,-10},{-4,-10}},     color={0,0,0}));
        connect(Summator1.out, SimpleExciter1.inp) annotation (Line(
            points={{10,-6},{18,-6}},
            color={255,255,0},
            thickness=0.5));
        connect(SimpleExciter1.out, Summator5.inp2) annotation (Line(points={{56,
                -6},{70,-6},{70,20},{76,20}}, color={0,0,0}));
        connect(VoltageDerivative.out, SimpleExciter.inp) annotation (Line(points={{
                -24.6667,36.6666},{-24,36},{-12,36}},  color={0,0,0}));
        connect(SimpleExciter.out, negative_summator.inp2) annotation (Line(
              points={{26,36},{44,36},{44,32},{50,32}}, color={0,0,0}));
        connect(SimpleExciter2.out, negative_summator1.inp2) annotation (Line(
              points={{28,-64},{84,-64},{84,-4},{90,-4}}, color={0,0,0}));
        connect(logical_switch1.out, under_overexcitation_limiter.inp)
          annotation (Line(points={{138,-0.666667},{138,0},{152,0}}, color={0,0,
                0}));
        connect(under_overexcitation_limiter.out, out_pin)
          annotation (Line(points={{172,0},{199,0}}, color={0,0,0}));
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
              extent={{-140,-100},{200,100}},
              grid={2,2},
              initialScale=0),
            graphics={
              Rectangle(
                extent={{-108,92},{164,-94}},
                lineColor={0,0,255},
                lineThickness=1),
              Text(extent={{-6,32},{76,-46}},  textString=
                                                   "Excitation"),
              Text(extent={{4,10},{74,-56}},   textString=
                                                   "regulator"),
              Line(
                points={{-106,0},{-136,0}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-106,-40},{-138,-40}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-108,-84},{-136,-84}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-108,42},{-138,42}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-108,80},{-138,80}},
                color={0,0,255},
                thickness=1),
              Text(extent={{-46,64},{114,32}},
                textColor={0,0,0},
                textString="%name"),
              Line(
                points={{198,0},{164,0}},
                color={0,0,255},
                thickness=1),
              Line(
                points={{-108,-64},{-138,-64}},
                color={0,0,255},
                thickness=1)},
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
          Diagram(coordinateSystem(extent={{-140,-100},{200,100}}), graphics={
              Text(
                extent={{-98,78},{-88,68}},
                textColor={0,0,0},
                textString="ΔU"),
              Text(
                extent={{-92,32},{-80,20}},
                textColor={0,0,0},
                textString="ΔU'"),
              Text(
                extent={{-94,16},{-82,6}},
                textColor={0,0,0},
                textString="ΔF"),
              Text(
                extent={{-82,-20},{-70,-30}},
                textColor={0,0,0},
                textString="ΔF'"),
              Text(
                extent={{-74,-68},{-62,-78}},
                textColor={0,0,0},
                textString="ΔIf'")}),
          Documentation(info="<html>
<p>The  model of Automatic Voltage Regulator, type &quot;AVR-M&quot;. </p>
<p>Модель регулятора возбуждения типа &quot;АРВ-М&quot;. </p>
</html>"));
      end AVR_M;
      annotation (Icon(graphics={Bitmap(extent={{-186,-130},{218,128}},
                fileName=
                  "modelica://OMLET/Images/vecteezy_electric-stabilizer-icon-vector-design-template-simple-and__347/vecteezy_electric-stabilizer-icon-vector-design-template-simple-and_.jpg")}));
    end Regulators;
    annotation (Icon(graphics={Bitmap(extent={{-114,-92},{120,84}}, fileName=
                "modelica://OMLET/Images/vecteezy_uninterrupted-power-supply-icon-thin-light-regular-and_28284671_425/vecteezy_uninterrupted-power-supply-icon-thin-light-regular-and_28284671.jpg")}),
        Documentation(info="<html>
<p>The image is downloaded from https://www.vecteezy.com/</p>
</html>"));
  end Excitation_systems;

  package Compensating_devices
    model Shunt_reactor
     outer SysData sysData;

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
      OMLET.Interfaces.Pin_v2 inp annotation (
        extent=[-10,76; 10,96],
        layer="icon",
        Placement(transformation(extent={{-10,88},{10,108}}, rotation=0),
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

    model Battery_of_static_capacitors
     outer SysData sysData;

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
      OMLET.Interfaces.Pin_v2 inp annotation (
        extent=[-10,76; 10,96],
        layer="icon",
        Placement(transformation(extent={{-10,88},{10,108}}, rotation=0),
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
    annotation (Icon(graphics={Bitmap(extent={{-188,-110},{206,112}}, fileName=
                "modelica://OMLET/Images/vecteezy_electrical-cabinet-cartoon-vector-free-space-for-text_18849952_493/vecteezy_electrical-cabinet-cartoon-vector-free-space-for-text_18849952.jpg")}),
        Documentation(info="<html>
<p>The image is downloaded from https://www.vecteezy.com/</p>
</html>"));
  end Compensating_devices;

  package Turbines
    model ASR_Regulator_IB

      parameter Real Sigma=0.0475 "Slip deviation control coefficient";
      parameter Real Tauc=0.15 "Slip deviation time constant";

      Excitation_systems.Logic.Transfer_Function SlipDeviation(b={-1/Sigma},
          a={Tauc,1}) annotation (extent=[-74,57.3333; -27.3333,104],
          Placement(transformation(extent={{-64,-32},{-11.3333,16}}, rotation
              =0)));
      OMLET.Interfaces.Signal_pin ds_pin annotation (
        extent=[-96,64; -86,76],
        layer="icon",
        Placement(transformation(extent={{-106,-14},{-96,-2}}, rotation=0),
            iconTransformation(extent={{-106,-14},{-96,-2}})));
      OMLET.Interfaces.Signal_pin out_pin annotation (
        extent=[86,2; 96,22],
        layer="icon",
        Placement(transformation(extent={{134,-10},{144,10}}, rotation=0),
            iconTransformation(extent={{134,-10},{144,10}})));
      Excitation_systems.Logic.Transfer_Function SlipI_Dif(b={1}, a={1,0})
        annotation (Placement(transformation(extent={{10,-28},{66,12}})));
      Excitation_systems.Logic.Transfer_Function Slip_Prop(b={1}, a={1})
        annotation (Placement(transformation(extent={{10,-68},{66,-28}})));
      Excitation_systems.Logic.Transfer_Function Slip_Int(b={1,0}, a={1,1})
        annotation (Placement(transformation(extent={{10,12},{66,52}})));
      Excitation_systems.Logic.Summator_3 summator_3_1
        annotation (Placement(transformation(extent={{92,-18},{112,2}})));

    equation

      connect(SlipDeviation.inp,ds_pin)  annotation (points=[-69.8,80.6667; -91,70],
          Line(points={{-64,-8},{-101,-8}},                   thickness=0.5));

      connect(SlipDeviation.out, SlipI_Dif.inp)
        annotation (Line(points={{-11.3333,-8},{10,-8}}, color={0,0,0}));
      connect(Slip_Prop.inp, SlipI_Dif.inp) annotation (Line(
          points={{10,-48},{0,-48},{0,-8},{10,-8}},
          color={0,0,0},
          thickness=0.5));
      connect(Slip_Int.inp, SlipI_Dif.inp) annotation (Line(
          points={{10,32},{0,32},{0,-8},{10,-8}},
          color={0,0,0},
          thickness=0.5));
      connect(SlipI_Dif.out, summator_3_1.inp2) annotation (Line(
          points={{66,-8},{68,-8.2},{92,-8.2}},
          color={0,0,0},
          thickness=0.5));
      connect(Slip_Int.out, summator_3_1.inp1) annotation (Line(
          points={{66,32},{86,32},{86,-2},{92,-2}},
          color={0,0,0},
          thickness=0.5));
      connect(Slip_Prop.out, summator_3_1.inp3) annotation (Line(
          points={{66,-48},{86,-48},{86,-14},{92,-14}},
          color={0,0,0},
          thickness=0.5));
      connect(summator_3_1.out, out_pin) annotation (Line(
          points={{112,-8},{128,-8},{128,0},{139,0}},
          color={0,0,0},
          thickness=0.5));
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
              extent={{-68,72},{104,-94}},
              lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-6,26},{38,-10}},
              textString="Slip",
              textColor={0,0,0}),
            Text(extent={{-14,20},{56,-46}}, textString=
                                                 "regulator"),
            Text(extent={{-64,106},{96,74}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{138,-2},{104,-2}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,-8},{-100,-8}},
              color={0,0,255},
              thickness=1)},
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
              extent={{-90,10},{-80,0}},
              textColor={0,0,0},
              textString="s")}),
        Documentation(info="<html>
<p>Automatic Slip Regulator (ASR) model. </p>
<p>Модель автоматического регулятора скольжения. </p>
</html>"));
    end ASR_Regulator_IB;

    model ASR_Regulator_

      parameter Real Sigma=0.0475 "Slip deviation control coefficient";
      parameter Real Tauc=0.15 "Slip deviation time constant";

      Excitation_systems.Logic.Transfer_Function SlipDeviation(b={-1/Sigma},
          a={1})      annotation (extent=[-74,57.3333; -27.3333,104],
          Placement(transformation(extent={{-64,-32},{-11.3333,16}}, rotation
              =0)));
      OMLET.Interfaces.Signal_pin ds_pin annotation (
        extent=[-96,64; -86,76],
        layer="icon",
        Placement(transformation(extent={{-106,-14},{-96,-2}}, rotation=0),
            iconTransformation(extent={{-106,-14},{-96,-2}})));
      OMLET.Interfaces.Signal_pin out_pin annotation (
        extent=[86,2; 96,22],
        layer="icon",
        Placement(transformation(extent={{134,-10},{144,10}}, rotation=0),
            iconTransformation(extent={{134,-10},{144,10}})));

      Excitation_systems.Logic.Transfer_Function Time_constant(b={1}, a={Tauc,
            1})
        annotation (Placement(transformation(extent={{64,-24},{118,22}})));
      Interfaces.Signal_pin       Mu0_pin
                                         annotation (
        extent=[-96,64; -86,76],
        layer="icon",
        Placement(transformation(extent={{-106,34},{-96,46}},rotation=0),
            iconTransformation(extent={{-106,32},{-96,44}})));
      Excitation_systems.Logic.Summator_2 summator_2_1
        annotation (Placement(transformation(extent={{16,-10},{36,10}})));
    equation

      connect(SlipDeviation.inp,ds_pin)  annotation (points=[-69.8,80.6667; -91,70],
          Line(points={{-64,-8},{-101,-8}},                   thickness=0.5));

      connect(Time_constant.out, out_pin) annotation (Line(
          points={{118,-1},{118,-2},{130,-2},{130,0},{139,0}},
          color={255,255,0},
          thickness=0.5));
      connect(Mu0_pin, summator_2_1.inp1) annotation (Line(
          points={{-101,40},{10,40},{10,4.2},{16,4.2}},
          color={255,255,0},
          thickness=0.5));
      connect(SlipDeviation.out, summator_2_1.inp2) annotation (Line(
          points={{-11.3333,-8},{10,-8},{10,-4},{16,-4}},
          color={255,255,0},
          thickness=0.5));
      connect(summator_2_1.out, Time_constant.inp) annotation (Line(
          points={{36,0},{56,0},{56,-1},{64,-1}},
          color={255,255,0},
          thickness=0.5));
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
              extent={{-68,72},{104,-94}},
              lineColor={0,0,255},
              lineThickness=1),
            Text(extent={{-6,26},{38,-10}},
              textString="Slip",
              textColor={0,0,0}),
            Text(extent={{-14,20},{56,-46}}, textString=
                                                 "regulator"),
            Text(extent={{-64,106},{96,74}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{138,-2},{104,-2}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,-8},{-100,-8}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,38},{-100,38}},
              color={0,0,255},
              thickness=1)},
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
              extent={{-90,10},{-80,0}},
              textColor={0,0,0},
              textString="s"),
            Text(
              extent={{-94,66},{-82,54}},
              textColor={0,0,0},
              textString="Mu0")}),
        Documentation(info="<html>
<p>Automatic Slip Regulator (ASR) model. </p>
<p>Модель автоматического регулятора скольжения. </p>
</html>"));
    end ASR_Regulator_;
    annotation (Icon(graphics={Bitmap(extent={{-174,-192},{196,174}}, fileName=
                "modelica://OMLET/Images/vecteezy_turbine-icon-symbol-flat-vector-illustration-for-graphic-and_6605293_265/vecteezy_turbine-icon-symbol-flat-vector-illustration-for-graphic-and_6605293.jpg")}),
        Documentation(info="<html>
<p>The image is downloaded from https://www.vecteezy.com/</p>
</html>"));
  end Turbines;

  package FACTS

    annotation (Icon(graphics={Bitmap(extent={{-102,-90},{110,80}}, fileName=
                "modelica://OMLET/Images/vecteezy_energy-illustration-design_47412612_55/vecteezy_energy-illustration-design_47412612.jpg")}),
        Documentation(info="<html>
<p>The image is downloaded from https://www.vecteezy.com/</p>
</html>"));
  end FACTS;
  annotation (__Dymola_UserMetaData(MetaData(category="User Meta Data 1",
          value={ERROR})), Icon(graphics={Bitmap(extent={{-108,-96},{108,96}},
            fileName="modelica://OMLET/Images/PTL.png")}));
end Basic;
