within LEPSE;
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

    LEPSE.Interfaces.Pin_v2 inp;
    LEPSE.Interfaces.Pin_v2 out;
  equation 
    // the algorithm of triping transmission line
    RL = if (time >= TLineOff and time < TLineOff + dTLineOff) then (Koff*Rline)
       else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (
      Koff_1*Rline) else (Rline));
    XL = if (time >= TLineOff and time < TLineOff + dTLineOff) then (Koff*Xline)
       else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1) then (
      Koff_1*Xline) else (Xline));
    BL1 = if (time >= TLineOff and time < TLineOff + dTLineOff) then (Bline1/
      Koff) else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1)
       then (Bline1/Koff_1) else (Bline1));
    BL2 = if (time >= TLineOff and time < TLineOff + dTLineOff) then (Bline2/
      Koff) else (if (time >= TLineOff_1 and time < TLineOff_1 + dTLineOff_1)
       then (Bline2/Koff_1) else (Bline2));

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

  end HVline;

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

    LEPSE.Interfaces.Pin_v2 inp;
    LEPSE.Interfaces.Pin_v2 out;
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

  end Transformer;

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
    LEPSE.Interfaces.Pin_v2 inp;
  equation 
    // active and reactive load
    Pn = Uqn*Iqn + Udn*Idn;
    Qn = -Uqn*Idn + Udn*Iqn;

    //the algorithm of triping load
    Idn = if time >= TloadOff and time < TloadOff + dTloadOff then Koff*(Udn*Gn +
      Uqn*Bn) else Udn*Gn + Uqn*Bn;
    Iqn = if time >= TloadOff and time < TloadOff + dTloadOff then Koff*(Uqn*Gn -
      Udn*Bn) else Uqn*Gn - Udn*Bn;

    //-----connector-----
    inp.Vd = Udn;
    inp.Vq = Uqn;

    inp.Id = -Idn;
    inp.Iq = -Iqn;

  end Constant_Conductivity_Load;

  model ShortCircuitShunt
    parameter Real Bn=-100000 "Reactive conductivity of short sircuit";
    parameter Real Gn=-100000 "Active conductivity of short sircuit";
    parameter Real Yn=sqrt(Bn^(2) + Gn^(2)) 
      "Total conductivity of short sircuit";
    //-----------------------------------
    parameter Real TkzOn=1000 "Time of short sircuit";
    parameter Real dTkzOn=0.12 "Duration of short sircuit";
    //-----------------------------------

    Real id "D-axis current of short-circuit";
    Real iq "Q-axis current of short-circuit";
    Real Ud "D-axis voltage of short-circuit";
    Real Uq "Q-axis voltage of short-circuit";
    LEPSE.Interfaces.Pin_v2 inp;
  equation 
    // short-circuit current
    id = if time >= TkzOn and time < TkzOn + dTkzOn then Bn*Uq + Gn*Ud else 0;
    iq = if time >= TkzOn and time < TkzOn + dTkzOn then -Bn*Ud + Gn*Uq else 0;

    //-----connector-----
    inp.Vd = Ud;
    inp.Vq = Uq;

    inp.Id = -id;
    inp.Iq = -iq;

  end ShortCircuitShunt;

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
    LEPSE.Interfaces.Pin_v2 inp;
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

  end Electrical_Braking_Shunt;

  model Electrical_Braking_Series
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
    LEPSE.Interfaces.Pin_v2 inp;
    LEPSE.Interfaces.Pin_v2 out;
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

  end Electrical_Braking_Series;

  model Transfer_Function
    parameter Real b[:]={1} "Numerator coefficients of transfer function.";
    parameter Real a[:]={1,1} "Denominator coefficients of transfer function.";
    output Real x[size(a, 1) - 1] 
      "State of transfer function from controller canonical form";

  protected 
    parameter Integer na=size(a, 1) "Size of Denominator of transfer function.";
    parameter Integer nb(max=na) = size(b, 1) 
      "Size of Numerator of transfer function.";
    parameter Integer nx=size(a, 1) - 1;
    Real x1dot "Derivative of first state of TransferFcn";
    Real xn "Highest order state of TransferFcn";
    Real u "input variable";
    Real y "output variable";

  public 
    LEPSE.Interfaces.Single_Pin inp;
    LEPSE.Interfaces.Single_Pin out;
  equation 
    [der(x); xn] = [x1dot; x];
    [u] = transpose([a])*[x1dot; x];
    [y] = transpose([zeros(na - nb, 1); b])*[x1dot; x];

    //-----connector-----
    inp.Signal = u;
    out.Signal = y;

  end Transfer_Function;

  model Gen_with_ARV_control

    LEPSE.Interfaces.Pin_v2 inp;
    Basic.Excitation_Regulator AVR;
    Basic.Synch_Machine G;
  equation 
    connect(AVR.out_pin, G.Ef_pin);
    connect(AVR.dV1_pin, AVR.dV_pin);
    connect(G.dUtr_pin, AVR.dV_pin);
    connect(G.dWu_pin, AVR.dfsys_pin);
    connect(G.dWf_pin, AVR.dfU_pin);
    connect(G.dIf_pin, AVR.dif1_pin);
    connect(G.Stator_pin, inp);

    connect(G.Ut_pin, AVR.Ut_pin);
  end Gen_with_ARV_control;

  model Excitation_Regulator
    parameter Real K0u=-10 "Voltage deviation control coefficient";
    parameter Real K1u=0 "Voltage derivative control coefficient";
    parameter Real K0w=0 "Frequency deviation control coefficient";
    parameter Real K1w=0 "Frequency derivative control coefficient";
    parameter Real K1if=0 "Rotor current derivative control coefficient";
    parameter Real Uforc=0.85 "Voltage of field forcing input";
    parameter Real Udeforc=0.9 "Voltage of field forcing removing";
    parameter Real Tforcedelay=0.1 "Delay of field forcing removing";
    parameter Real DL0=0;

    constant Real Tokp=0.05 "The main channel of regulation time constant";
    constant Real T0u=0.02 "Voltage deviation time constant";
    constant Real T1u=0.039 "Voltage derivative time constant";
    constant Real Tfb=0.07 "Frequency block time constant";
    constant Real T0w=1.0 "Frequency deviation time constant";
    constant Real T1w=0.026 "Frequency derivative time constant";
    constant Real T1if=0.03 "Field current derivative time constant";

    Basic.Transfer_Function VoltageDeviation(b={K0u}, a={T0u,1});
    Basic.Transfer_Function VoltageDerivative(b={K1u,0}, a={T1u,1});
    Basic.Transfer_Function FrequencyBlockD(b={1}, a={Tfb,1});
    Basic.Transfer_Function FrequencyBlockU(b={1,0}, a={Tfb,1});
    Basic.Transfer_Function FrequencyDeviation(b={K0w,0}, a={T0w,1});
    Basic.Transfer_Function FrequencyDerivative(b={K1w,0}, a={T1w,1});
    Basic.Transfer_Function ExcitationCurrent(b={K1if,0}, a={T1if,1});
    Basic.Transfer_Function SimpleExciter(b={1}, a={Tokp,1});
    LEPSE.Interfaces.Single_Pin dV_pin;
    LEPSE.Interfaces.Single_Pin dV1_pin;
    LEPSE.Interfaces.Single_Pin dfsys_pin;
    LEPSE.Interfaces.Single_Pin dfU_pin;
    LEPSE.Interfaces.Single_Pin dif1_pin;
    LEPSE.Interfaces.Single_Pin out_pin;
    Basic.Summator Summator1;
    Basic.Summator Summator2;
    Basic.Summator Summator3;
    Basic.Summator Summator5;
    Basic.Summator Summator6;
    LEPSE.Interfaces.Single_Pin Ut_pin;
    Basic.logical_switch logical_switch1(
      a1=Uforc,
      a2=Udeforc,
      a3=K0u,
      a4=Tforcedelay);
  equation 
    connect(dfsys_pin, FrequencyBlockD.inp);
    connect(dfU_pin, FrequencyBlockU.inp);
    connect(FrequencyBlockD.out, Summator1.inp1);
    connect(FrequencyBlockU.out, Summator1.inp2);
    connect(dif1_pin, ExcitationCurrent.inp);
    connect(Summator1.out, FrequencyDeviation.inp);
    connect(FrequencyDerivative.inp, FrequencyDeviation.inp);
    connect(Summator2.inp2, FrequencyDeviation.out);
    connect(FrequencyDerivative.out, Summator2.inp1);
    connect(VoltageDerivative.inp, dV1_pin);
    connect(VoltageDeviation.inp, dV_pin);
    connect(VoltageDeviation.out, Summator3.inp1);
    connect(VoltageDerivative.out, Summator3.inp2);
    connect(Summator5.inp1, Summator3.out);
    connect(Summator5.inp2, Summator2.out);
    connect(Summator6.inp1, Summator5.out);
    connect(SimpleExciter.out, out_pin);
    connect(Summator6.inp2, ExcitationCurrent.out);
    when initial() then
      reinit(FrequencyBlockU.x[1], DL0);
      //     reinit(FrequencyDeviation.x[1],DL0);
      //     reinit(FrequencyDerivative.x[1],DL0);
    end when;

    connect(logical_switch1.out, SimpleExciter.inp);
    connect(Ut_pin, logical_switch1.inp2inf);
    connect(Summator6.out, logical_switch1.inp2);
    connect(VoltageDeviation.out, logical_switch1.inp1);
    connect(VoltageDeviation.inp, logical_switch1.inp1inf);
  end Excitation_Regulator;

  model Synch_Machine
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
    parameter Real TauC_up=0.8 
      "Time constant of servo motor while valving control";
    parameter Real TregOff=50 "Turbine speed regulator off-time";

    parameter Real TregOn=1000 "Turbine speed regulator on-time";
    parameter Real Mtmax=1.1 "Turbine overloading coefficient";
    parameter Real Mtmin=0 "Turbine minimum-loading coefficient";

    parameter Real Aimp=1 "Fast turbine valving control amplitude";
    parameter Real Timp=1000 "Fast turbine valving control on-time";
    parameter Real dTimp=0.2 "Fast turbine valving control duration";
    parameter Real TauC_down=5 
      "Time constant of servo motor after valving control end";

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
    LEPSE.Interfaces.Pin_v2 Stator_pin;
    LEPSE.Interfaces.Single_Pin Ef_pin;
    LEPSE.Interfaces.Single_Pin dUtr_pin;
    LEPSE.Interfaces.Single_Pin dWu_pin;
    LEPSE.Interfaces.Single_Pin dWf_pin;
    LEPSE.Interfaces.Single_Pin dIf_pin;
    LEPSE.Interfaces.Single_Pin Ut_pin;
  equation 
    // equations of currents, voltages, and flux densities
    when initial() then
      EQ = sqrt((Ut + ((Ra + Rt)*Pg + (Xq + Xt)*Qg)/Ut)^2 + (((Xq + Xt)*Pg - (
        Ra + Rt)*Qg)/Ut)^2);
      Dg = atan((((Xq + Xt)*Pg - (Ra + Rt)*Qg)/Ut)/(Ut + ((Ra + Rt)*Pg + (Xq +
        Xt)*Qg)/Ut));
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

    Uf_full = if (Uf*Xad/Rf + dEr) > Er_max then Er_max*Rf/Xad else if (Uf*Xad/
      Rf + dEr) < Er_min then Er_min*Rf/Xad else Uf + Rf*dEr/Xad;

    der(Yr) = Wc*(Uf_full - Rf*ir);
    der(Yrd) = -Wc*R1d*ird;
    der(Yrq) = -Wc*R1q*irq;
    der(s) = (Mt_pp - Me)/Tj;

    Ro = if time >= Timp and time < Timp + dTimp then -Aimp else -Mu + Mu0 - s/
      Sigma;

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
    f = Wc*(1 - s)/2/PI;

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
    connect(dUtr_pin, dUtr_pin);

  end Synch_Machine;

  model Summator
    LEPSE.Interfaces.Single_Pin inp1;
    LEPSE.Interfaces.Single_Pin inp2;
    LEPSE.Interfaces.Single_Pin out;
  equation 
    // the sum of 2 input signals
    out.Signal = inp1.Signal + inp2.Signal;
  end Summator;

  model logical_switch
    parameter Real a1 "Uforc, Voltage of field forcing input";
    parameter Real a2 "Udeforc, Voltage of field forcing removing";
    parameter Real a3 "K0U, Voltage deviation control coefficient";
    parameter Real a4 "Tforcedelay, Delay of field forcing removing";
    Real T_force_on "moment of time, when forcing starts";

    LEPSE.Interfaces.Single_Pin inp1;
    LEPSE.Interfaces.Single_Pin inp2;
    LEPSE.Interfaces.Single_Pin inp2inf;
    LEPSE.Interfaces.Single_Pin out;
    LEPSE.Interfaces.Single_Pin inp1inf;

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

  end logical_switch;
end Basic;
