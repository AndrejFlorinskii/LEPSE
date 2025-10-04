within ;
model three_maschine_scheme
  Real delta_G1_G2(start=-0.663044810295105),
                    delta_G1_G3(start=0.36994481086730957),
                                 delta_G2_G3(start=1.0329896211624146);

  LEPSE.Basic.Transformer T_G1(Rline=0.002886, Xline=0.11)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  LEPSE.Basic.Transformer T_G2(Rline=0.000774982, Xline=0.05596)
    annotation (Placement(transformation(extent={{58,-64},{78,-44}})));
  LEPSE.Basic.HVline L1(
    Rline=0.07889,
    Xline=0.5391,
    Bline1=0.03745,
    Bline2=0.03745,
    TLineOff=50.2,
    dTLineOff=0.3,
    Koff=100000)
    annotation (Placement(transformation(extent={{14,56},{34,76}})));
  LEPSE.Basic.HVline L2(
    Rline=0.01052,
    Xline=0.13506,
    Bline1=-0.37019,
    Bline2=0.28981)
    annotation (Placement(transformation(extent={{18,-68},{38,-48}})));
  LEPSE.Basic.Transformer AT_HV(Rline=0.000435556, Xline=0.05255) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={14,-28})));
  LEPSE.Basic.Transformer AT_LV(Rline=0.00120889, Xline=0.08763) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={38,-12})));
  LEPSE.Basic.Transformer AT_MV(Rline=0.000435556, Xline=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={14,2})));
  LEPSE.Basic.Constant_Conductivity_Load N1(Gn=0.5, Bn=-0.05434)
    annotation (Placement(transformation(extent={{66,-34},{86,-14}})));
  LEPSE.Basic.HVline L6(
    Rline=0.02076,
    Xline=0.14187,
    Bline1=0.0098549,
    Bline2=0.0098549) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={8,42})));
  LEPSE.Basic.HVline L3(
    Rline=0.04152,
    Xline=0.22907,
    Bline1=0.01563,
    Bline2=0.01563)
    annotation (Placement(transformation(extent={{-56,56},{-36,76}})));
  LEPSE.Basic.HVline L4(
    Rline=0.04152,
    Xline=0.229,
    Bline1=0.01563,
    Bline2=0.01563)
    annotation (Placement(transformation(extent={{-42,22},{-22,42}})));
  LEPSE.Basic.HVline L5(
    Rline=0.0519,
    Xline=0.28633,
    Bline1=0.01954,
    Bline2=0.01954)
    annotation (Placement(transformation(extent={{-84,22},{-64,42}})));
  LEPSE.Basic.Transformer T1(Rline=0.00957628, Xline=0.24943) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-54,10})));
  LEPSE.Basic.Transformer T3(Rline=0.006094, Xline=0.15873) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={12,100})));
  LEPSE.Basic.Constant_Conductivity_Load N2(Gn=0.28, Bn=-0.05203)
    annotation (Placement(transformation(extent={{-64,-46},{-44,-24}})));
  LEPSE.Basic.Constant_Conductivity_Load N4(Gn=0.45, Bn=-0.06791) annotation (
     Placement(transformation(
        extent={{-10,-11},{10,11}},
        rotation=270,
        origin={-22,117})));
  LEPSE.Basic.Transformer T2_MV(Rline=0.0000435556, Xline=0)
    annotation (Placement(transformation(extent={{-122,60},{-102,80}})));
  LEPSE.Basic.Transformer T2_HV(Rline=0.0000435556, Xline=0.02255)
    annotation (Placement(transformation(extent={{-172,60},{-152,80}})));
  LEPSE.Basic.Transformer T2_LV(Rline=0.00120889, Xline=0.08759)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-138,44})));
  LEPSE.Basic.Constant_Conductivity_Load N3(Gn=0.45, Bn=-0.06791)
    annotation (Placement(transformation(extent={{-146,-12},{-126,10}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt(
    Bn=-1000000,
    TkzOn=50,
    dTkzOn=0.2)
    annotation (Placement(transformation(extent={{-16,44},{4,64}})));
  LEPSE.Basic.Electrical_Braking ElBr02(
    Rline=0.2,
    TLineOff=1000,
    dTLineOff=10)
    annotation (Placement(transformation(extent={{96,-64},{116,-44}})));
  LEPSE.Basic.Electrical_Braking_Parallel ElBrShun02(
    Rline=0.2,
    TLineOff=1000,
    dTLineOff=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,-76})));
  LEPSE.Basic.Electrical_Braking ElBr01(
    Rline=0.2,
    TLineOff=1000,
    dTLineOff=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={104,70})));
  LEPSE.Basic.Electrical_Braking_Parallel ElBrShunt01(
    Rline=0.2,
    TLineOff=1000,
    dTLineOff=10)
    annotation (Placement(transformation(extent={{42,38},{62,58}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt1
    annotation (Placement(transformation(extent={{112,-78},{132,-58}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt2
    annotation (Placement(transformation(extent={{76,-78},{96,-58}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt3(TkzOn=65, dTkzOn=0.15)
    annotation (Placement(transformation(extent={{26,-86},{46,-66}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt4 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,-50})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt5
    annotation (Placement(transformation(extent={{-22,-28},{-2,-8}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt6
    annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt7
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt8
    annotation (Placement(transformation(extent={{114,42},{134,62}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt9
    annotation (Placement(transformation(extent={{76,40},{96,60}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt10
    annotation (Placement(transformation(extent={{26,40},{46,60}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt11
    annotation (Placement(transformation(extent={{-16,90},{4,110}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt12
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,88})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt13 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-64,56})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt15
    annotation (Placement(transformation(extent={{-82,-44},{-62,-24}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt16
    annotation (Placement(transformation(extent={{-162,-10},{-142,10}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt17
    annotation (Placement(transformation(extent={{-164,36},{-144,56}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt18
    annotation (Placement(transformation(extent={{-190,36},{-170,56}})));
  G_2 G2(excitation_Regulator1(
      ExcitationCurrent(x(start={-0.15779177844524384})),
      FrequencyBlockD(x(start={-18.514678955078125})),
      FrequencyDerivative(x(start={-18.506269454956055})),
      FrequencyDeviation(x(start={-18.190698623657227})),
      SimpleExciter(x(start={-0.22632116079330444})),
      VoltageDerivative(x(start={0.011315987445414066})),
      VoltageDeviation(x(start={0.011315948329865932}))), G2(
      TauC_up=0.2,
      TregOff=500,
      TregOn=50,
      Aimp=0.8,
      Timp=65.1,
      TauC_down=0.05,
      Kemax=2.1))
         annotation (Placement(transformation(rotation=180,
                                                          extent={{-13,-13},
            {13,13}},
        origin={159,-53})));
  G_3 G3(G3_Regulator(
      ExcitationCurrent(x(start={0.11060376465320587})),
      FrequencyBlockD(x(start={-18.514678955078125})),
      FrequencyDerivative(x(start={-18.50632667541504})),
      FrequencyDeviation(x(start={-18.190702438354492})),
      SimpleExciter(x(start={0.004417701158672571})),
      VoltageDerivative(x(start={-8.836114284349605E-05})),
      VoltageDeviation(x(start={-8.836534834699705E-05}))), G3(Kemax=2.1))
         "infinite bus"
         annotation (Placement(transformation(rotation=0, extent={{-224,62},
            {-204,82}})));
  G_1 G1(excitation_Regulator(
      ExcitationCurrent(x(start={-0.4242546856403351})),
      FrequencyBlockD(x(start={-18.514678955078125})),
      FrequencyDerivative(x(start={-18.506282806396484})),
      FrequencyDeviation(x(start={-18.190702438354492})),
      SimpleExciter(x(start={0.3703387677669525})),
      VoltageDerivative(x(start={-0.018517008051276207})),
      VoltageDeviation(x(start={-0.01851704902946949}))), G1(TkzOn=50.4,
        Kemax=2.1))
         annotation (Placement(transformation(rotation=180,
                                                          extent={{-17,-17},
            {17,17}},
        origin={153,73})));
  LEPSE.Basic.Node node_14 annotation (Placement(transformation(extent={{-184,
            68},{-178,74}}), iconTransformation(extent={{-294,-8},{-274,12}})));
  LEPSE.Basic.Node node_13 annotation (Placement(transformation(extent={{-138,
            68},{-132,74}}), iconTransformation(extent={{-294,-14},{-274,6}})));
  LEPSE.Basic.Node node_15 annotation (Placement(transformation(extent={{-140,
            16},{-134,22}}), iconTransformation(extent={{-294,-26},{-274,-6}})));
  LEPSE.Basic.Node node_12 annotation (Placement(transformation(extent={{-86,68},
            {-80,74}}), iconTransformation(extent={{-294,-20},{-274,0}})));
  LEPSE.Basic.Node node_10 annotation (Placement(transformation(extent={{-58,34},
            {-52,40}}), iconTransformation(extent={{-294,-66},{-274,-46}})));
  LEPSE.Basic.Node node_11 annotation (Placement(transformation(extent={{-58,-16},
            {-52,-10}}), iconTransformation(extent={{-294,-78},{-274,-58}})));
  LEPSE.Basic.Node node_7 annotation (Placement(transformation(extent={{8,68},{
            14,74}}), iconTransformation(extent={{-276,-54},{-256,-34}})));
  LEPSE.Basic.Node node_16 annotation (Placement(transformation(extent={{8,114},
            {14,120}}), iconTransformation(extent={{-284,-12},{-264,8}})));
  LEPSE.Basic.Node node_8 annotation (Placement(transformation(extent={{50,68},
            {56,74}}), iconTransformation(extent={{-290,-18},{-270,2}})));
  LEPSE.Basic.Node node_21 annotation (Placement(transformation(extent={{120,68},
            {126,74}}), iconTransformation(extent={{-278,-14},{-258,6}})));
  LEPSE.Basic.Node node_9 annotation (Placement(transformation(extent={{82,68},
            {88,74}}), iconTransformation(extent={{-294,-34},{-274,-14}})));
  LEPSE.Basic.Node node_5 annotation (Placement(transformation(extent={{10,16},
            {16,22}}), iconTransformation(extent={{-294,-66},{-274,-46}})));
  LEPSE.Basic.Node node_4 annotation (Placement(transformation(extent={{10,-16},
            {16,-10}}), iconTransformation(extent={{-292,-76},{-272,-56}})));
  LEPSE.Basic.Node node_6 annotation (Placement(transformation(extent={{56,-16},
            {62,-10}}), iconTransformation(extent={{-292,-78},{-272,-58}})));
  LEPSE.Basic.Node node_3 annotation (Placement(transformation(extent={{10,-48},
            {16,-42}}), iconTransformation(extent={{-294,-118},{-274,-98}})));
  LEPSE.Basic.Node node_2 annotation (Placement(transformation(extent={{46,-56},
            {52,-50}}), iconTransformation(extent={{-294,-116},{-274,-96}})));
  LEPSE.Basic.Node node_1 annotation (Placement(transformation(extent={{82,-56},
            {88,-50}}), iconTransformation(extent={{-292,-118},{-272,-98}})));
  LEPSE.Basic.Node node_22 annotation (Placement(transformation(extent={{120,-56},
            {126,-50}}), iconTransformation(extent={{-294,-116},{-274,-96}})));
equation

  der(delta_G1_G2) = G1.G1.Wc*(G1.G1.s - G2.G2.s);
  der(delta_G1_G3) = G1.G1.Wc*(G1.G1.s - G3.G3.s);
  der(delta_G2_G3) = G1.G1.Wc*(G2.G2.s - G3.G3.s);

  G1.G1.DeltaIJ = 0;
  G2.G2.DeltaIJ = delta_G1_G2;
  G3.G3.DeltaIJ = delta_G1_G3;

  G1.G1.Ssys = G1.G1.s;
  G2.G2.Ssys = G1.G1.s;
  G3.G3.Ssys = G1.G1.s;

protected
  model G_2
    LEPSE.Basic.Synch_Machine G2(
      Pg=0.88,
      Qg=0.5466,
      Ut=1.066,
      Xd_p=1.55479,
      Xq_p=1.55479,
      Xs_p=0.12042,
      X1d_p=0.2125,
      X2d_p=0.13813,
      X2q_p=0.19904,
      Rf_p=0.0007,
      R1d_p=0.00197493,
      R1q_p=0.0051775,
      Tj_p=12.23136) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-42,22})));
    LEPSE.Basic.Excitation_Regulator excitation_Regulator1(
      K0u=-20,
      K0w=0,
      K1w=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-64,20})));
    LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(rotation
            =0, extent={{-16,14},{-2,28}}), iconTransformation(extent={{2,9},{
              22,29}})));
  equation
    connect(G2.dUtr_pin,excitation_Regulator1. dV_pin) annotation (Line(
        points={{-47.6,29.6},{-47.6,36},{-78,36},{-78,26},{-73.4167,26}},
        color={255,255,0},
        thickness=0.5));
    connect(excitation_Regulator1.dV_pin,excitation_Regulator1. dV1_pin)
      annotation (Line(
        points={{-73.4167,26},{-73.4167,24},{-73.25,24}},
        color={255,255,0},
        thickness=0.5));
    connect(G2.dWu_pin,excitation_Regulator1. dfsys_pin) annotation (Line(
        points={{-45.2,29.6},{-45.2,38},{-80,38},{-80,21},{-73.25,21}},
        color={255,255,0},
        thickness=0.5));
    connect(G2.dWf_pin,excitation_Regulator1. dfU_pin) annotation (Line(
        points={{-42.8,29.6},{-42.8,40},{-82,40},{-82,18},{-73.25,18}},
        color={255,255,0},
        thickness=0.5));
    connect(G2.dIf_pin,excitation_Regulator1. dif1_pin) annotation (Line(
        points={{-40.2,29.6},{-40.2,44},{-86,44},{-86,14},{-80,14},{-80,
            15.6},{-73.25,15.6}},
        color={255,255,0},
        thickness=0.5));
    connect(excitation_Regulator1.out_pin,G2. Ef_pin) annotation (Line(
        points={{-54.9167,21.2},{-50,21.2},{-50,22.2}},
        color={255,255,0},
        thickness=0.5));
    connect(G2.Ut_pin,excitation_Regulator1. Ut_pin) annotation (Line(
        points={{-37.8,29.6},{-37.8,46},{-88,46},{-88,12},{-73.1667,12},{
            -73.1667,13.6}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G2.Stator_pin) annotation (Line(points={{-9,21},{-8,
            22.2},{-34.2,22.2}},         color={28,108,200}));
    annotation (Diagram(coordinateSystem(extent={{-120,-40},{0,80}})), Icon(
          coordinateSystem(extent={{-120,-40},{0,80}}), graphics={
          Ellipse(
          extent={{-124,80},{4,-38}},
          lineColor={28,108,200}),
          Text(extent={{-102,58},{-18,32}},
                                          textString=
                                              "SM"),
          Text(extent={{-102,24},{-18,6}},textString=
                                              "with"),
          Text(extent={{-126,-40},{8,-58}}, textString=
                                                "%name"),
          Text(extent={{-114,-8},{-6,-24}}, textString=
                                               "ARV")}));
  end G_2;

protected
  model G_3
    LEPSE.Basic.Synch_Machine G3(
      Pg=0,
      Qg=0,
      Ut=1,
      Xd_p=0.04368,
      Xq_p=0.04368,
      Xs_p=0.00374903,
      X1d_p=0.00575475,
      X2d_p=0.00410518,
      X2q_p=0.00590471,
      Rf_p=1.44e-005,
      R1d_p=3.69367e-005,
      R1q_p=0.000121145,
      Tj_p=500) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={12,-4})));
    LEPSE.Basic.Excitation_Regulator G3_Regulator(K0u=-50) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-8,-4})));
    LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(rotation
            =0, extent={{51,3},{57,9}}), iconTransformation(extent={{47,-7},{58,
              4}})));
  equation
    connect(G3.dUtr_pin,G3_Regulator. dV_pin) annotation (Line(
        points={{6.4,3.6},{6.4,12},{-16,12},{-16,2},{-17.4167,2}},
        color={255,255,0},
        thickness=0.5));
    connect(G3_Regulator.dV_pin,G3_Regulator. dV1_pin) annotation (Line(
        points={{-17.4167,2},{-17.25,2},{-17.25,0}},
        color={255,255,0},
        thickness=0.5));
    connect(G3.dWu_pin,G3_Regulator. dfsys_pin) annotation (Line(
        points={{8.8,3.6},{8.8,14},{-18,14},{-18,-3},{-17.25,-3}},
        color={255,255,0},
        thickness=0.5));
    connect(G3.dWf_pin,G3_Regulator. dfU_pin) annotation (Line(
        points={{11.2,3.6},{11.2,16},{-20,16},{-20,-6},{-17.25,-6}},
        color={255,255,0},
        thickness=0.5));
    connect(G3.dIf_pin,G3_Regulator. dif1_pin) annotation (Line(
        points={{13.8,3.6},{13.8,20},{-24,20},{-24,-10},{-18,-10},{-18,-8.4},{-17.25,
            -8.4}},
        color={255,255,0},
        thickness=0.5));
    connect(G3_Regulator.out_pin,G3. Ef_pin) annotation (Line(
        points={{1.08333,-2.8},{4,-2.8},{4,-3.8}},
        color={255,255,0},
        thickness=0.5));
    connect(G3.Ut_pin,G3_Regulator. Ut_pin) annotation (Line(
        points={{16.2,3.6},{16.2,22},{-26,22},{-26,-20},{-17.1667,-20},{-17.1667,
            -10.4}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G3.Stator_pin) annotation (Line(points={{54,6},{54,-3.8},
            {19.8,-3.8}}, color={28,108,200}));
    annotation (Diagram(coordinateSystem(extent={{-30,-30},{30,30}})), Icon(
          coordinateSystem(extent={{-30,-30},{30,30}}), graphics={
          Ellipse(
          extent={{-42,38},{48,-42}},
          lineColor={28,108,200}),
          Text(extent={{-34,28},{36,10}}, textString=
                                              "SM"),
          Text(extent={{-36,8},{40,-8}},  textString=
                                              "with"),
          Text(extent={{-58,-42},{64,-54}}, textString=
                                                "%name"),
          Text(extent={{-48,-12},{52,-24}}, textString=
                                               "ARV")}));
  end G_3;

  model G_1
    LEPSE.Basic.Synch_Machine G1(
      Pg=0.36,
      Qg=0.1181,
      Ut=1.1147,
      Xd_p=2.07273,
      Xq_p=1.34727,
      Xs_p=0.22,
      X1d_p=0.50909,
      X2d_p=0.32727,
      X2q_p=0.36364,
      Rf_p=0.001283,
      R1d_p=0.00784215,
      R1q_p=0.00925389,
      Tj_p=13.2508,
      Sigma=0.0475,
      TkzOn=50.3,
      Pg_new=0.135) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={60,38})));
    LEPSE.Basic.Excitation_Regulator excitation_Regulator(K0u=-20) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={38,36})));
    LEPSE.Basic.Pin_v2 pin_v2_2 annotation (Placement(transformation(extent={{
              80,36},{84,40}}), iconTransformation(extent={{100,44},{114,58}})));
  equation
    connect(G1.dUtr_pin,excitation_Regulator. dV_pin) annotation (Line(
        points={{54.4,45.6},{54.4,52},{24,52},{24,42},{28.5833,42}},
        color={255,255,0},
        thickness=0.5));
    connect(excitation_Regulator.dV_pin,excitation_Regulator. dV1_pin)
      annotation (Line(
        points={{28.5833,42},{28.75,42},{28.75,40}},
        color={255,255,0},
        thickness=0.5));
    connect(G1.dWu_pin,excitation_Regulator. dfsys_pin) annotation (Line(
        points={{56.8,45.6},{56.8,54},{22,54},{22,37},{28.75,37}},
        color={255,255,0},
        thickness=0.5));
    connect(G1.dWf_pin,excitation_Regulator. dfU_pin) annotation (Line(
        points={{59.2,45.6},{59.2,56},{20,56},{20,34},{28.75,34}},
        color={255,255,0},
        thickness=0.5));
    connect(G1.dIf_pin,excitation_Regulator. dif1_pin) annotation (Line(
        points={{61.8,45.6},{61.8,60},{16,60},{16,30},{22,30},{22,31.6},{
            28.75,31.6}},
        color={255,255,0},
        thickness=0.5));
    connect(excitation_Regulator.out_pin,G1. Ef_pin) annotation (Line(
        points={{47.0833,37.2},{52,37.2},{52,38.2}},
        color={255,255,0},
        thickness=0.5));
    connect(G1.Stator_pin,pin_v2_2)  annotation (Line(points={{67.8,38.2},{
            68,38},{82,38}},
                       color={28,108,200}));
    connect(G1.Ut_pin,excitation_Regulator. Ut_pin) annotation (Line(
        points={{64.2,45.6},{64.2,48},{66,48},{66,64},{14,64},{14,29.6},{
            28.8333,29.6}},
        color={255,255,0},
        thickness=0.5));
    annotation (Diagram(coordinateSystem(extent={{-40,-40},{120,120}})), Icon(
          coordinateSystem(extent={{-40,-40},{120,120}}), graphics={
          Ellipse(
          extent={{-26,110},{102,-8}},
          lineColor={28,108,200}),
          Text(extent={{-4,88},{80,62}},  textString=
                                              "SM"),
          Text(extent={{-4,54},{80,36}},  textString=
                                              "with"),
          Text(extent={{-28,-10},{106,-28}},textString=
                                                "%name"),
          Text(extent={{-16,22},{92,6}},    textString=
                                               "ARV")}));
  end G_1;
equation
  connect(G3.Stator_pin, node_14) annotation (Line(points={{-196.5,71.5},{
          -196.5,71},{-181,71}}, color={28,108,200}));
  connect(shortCircuitShunt18.inp, node_14) annotation (Line(points={{-180,
          50.8},{-181,50.8},{-181,71}}, color={28,108,200}));
  connect(node_14, T2_HV.inp)
    annotation (Line(points={{-181,71},{-169.8,71}}, color={28,108,200}));
  connect(T2_HV.out, node_13)
    annotation (Line(points={{-154,71},{-135,71}}, color={28,108,200}));
  connect(T2_LV.inp, node_13) annotation (Line(points={{-137,51.8},{-136,
          51.8},{-136,71},{-135,71}}, color={28,108,200}));
  connect(node_13, T2_MV.inp)
    annotation (Line(points={{-135,71},{-119.8,71}}, color={28,108,200}));
  connect(T2_LV.out, node_15)
    annotation (Line(points={{-137,36},{-137,19}}, color={28,108,200}));
  connect(N3.inp, node_15) annotation (Line(points={{-136,8.46},{-136,12},{
          -137,12},{-137,19}}, color={28,108,200}));
  connect(shortCircuitShunt16.inp, node_15) annotation (Line(points={{-152,
          4.8},{-152,19},{-137,19}}, color={28,108,200}));
  connect(node_12, L3.inp)
    annotation (Line(points={{-83,71},{-53.6,71}}, color={28,108,200}));
  connect(shortCircuitShunt12.inp, node_12) annotation (Line(points={{-90,
          83.2},{-90,71},{-83,71}}, color={28,108,200}));
  connect(T2_MV.out, node_12)
    annotation (Line(points={{-104,71},{-83,71}}, color={28,108,200}));
  connect(node_12, L5.inp) annotation (Line(points={{-83,71},{-90,71},{-90,
          37},{-81.6,37}}, color={28,108,200}));
  connect(L5.out, node_10) annotation (Line(points={{-66.2,37.2},{-66.2,37},
          {-55,37}}, color={28,108,200}));
  connect(node_10, L4.inp)
    annotation (Line(points={{-55,37},{-39.6,37}}, color={28,108,200}));
  connect(node_10, shortCircuitShunt13.inp) annotation (Line(points={{-55,
          37},{-54,37},{-54,42},{-64,42},{-64,51.2}}, color={28,108,200}));
  connect(node_10, T1.out) annotation (Line(points={{-55,37},{-56,37},{-56,
          24},{-55,24},{-55,18}}, color={28,108,200}));
  connect(L3.out, node_7) annotation (Line(points={{-38.2,71.2},{-36,71},{
          11,71}}, color={28,108,200}));
  connect(shortCircuitShunt.inp, node_7) annotation (Line(points={{-6,58.8},
          {-6,71},{11,71}}, color={28,108,200}));
  connect(L4.out, node_7) annotation (Line(points={{-24.2,37.2},{-18,37.2},
          {-18,71},{11,71}}, color={28,108,200}));
  connect(L1.inp, node_7)
    annotation (Line(points={{16.4,71},{11,71}}, color={28,108,200}));
  connect(L6.inp, node_7) annotation (Line(points={{13,49.6},{13,58},{11,58},
          {11,71}}, color={28,108,200}));
  connect(T3.inp, node_7)
    annotation (Line(points={{11,92.2},{11,71}}, color={28,108,200}));
  connect(N4.inp, node_16)
    annotation (Line(points={{-12.54,117},{11,117}}, color={28,108,200}));
  connect(shortCircuitShunt11.inp, node_16) annotation (Line(points={{-6,
          104.8},{-6,117},{11,117}}, color={28,108,200}));
  connect(T3.out, node_16)
    annotation (Line(points={{11,108},{11,117}}, color={28,108,200}));
  connect(node_8, T_G1.inp)
    annotation (Line(points={{53,71},{62.2,71}}, color={28,108,200}));
  connect(L1.out, node_8) annotation (Line(points={{31.8,71.2},{31.8,71},{
          53,71}}, color={28,108,200}));
  connect(shortCircuitShunt10.inp, node_8) annotation (Line(points={{36,
          54.8},{36,71},{53,71}}, color={28,108,200}));
  connect(ElBrShunt01.inp, node_8) annotation (Line(points={{52,56.8},{52,
          71},{53,71}}, color={28,108,200}));
  connect(G1.pin_v2_2, node_21) annotation (Line(points={{138.762,70.6625},{138,
          71},{123,71}},      color={28,108,200}));
  connect(ElBr01.out, node_21)
    annotation (Line(points={{112.8,71},{123,71}}, color={28,108,200}));
  connect(shortCircuitShunt8.inp, node_21) annotation (Line(points={{124,
          56.8},{123,56},{123,71}}, color={28,108,200}));
  connect(ElBr01.inp,node_9)
    annotation (Line(points={{95.2,71},{85,71}}, color={28,108,200}));
  connect(T_G1.out,node_9)  annotation (Line(points={{78,71},{85,71}},
                    color={28,108,200}));
  connect(node_9, shortCircuitShunt9.inp) annotation (Line(points={{85,71},
          {85,61.5},{86,61.5},{86,54.8}}, color={28,108,200}));
  connect(shortCircuitShunt7.inp,node_5)  annotation (Line(points={{-10,
          14.8},{-10,19},{13,19}}, color={28,108,200}));
  connect(L6.out,node_5)  annotation (Line(points={{13.2,34.2},{13,34.2},{
          13,19}}, color={28,108,200}));
  connect(AT_MV.out,node_5)
    annotation (Line(points={{13,10},{13,19}}, color={28,108,200}));
  connect(shortCircuitShunt5.inp,node_4)  annotation (Line(points={{-12,
          -13.2},{-12,-13},{13,-13}}, color={28,108,200}));
  connect(AT_MV.inp,node_4)
    annotation (Line(points={{13,-5.8},{13,-13}}, color={28,108,200}));
  connect(AT_HV.out,node_4)
    annotation (Line(points={{13,-20},{13,-13}}, color={28,108,200}));
  connect(AT_LV.out,node_4)  annotation (Line(points={{30,-13},{13,-13}},
                 color={28,108,200}));
  connect(AT_LV.inp,node_6)
    annotation (Line(points={{45.8,-13},{59,-13}}, color={28,108,200}));
  connect(shortCircuitShunt6.inp,node_6)  annotation (Line(points={{60,
          -21.2},{59,-21.2},{59,-13}},
                                     color={28,108,200}));
  connect(N1.inp,node_6)  annotation (Line(points={{76,-15.4},{76,-13},{59,
          -13}}, color={28,108,200}));
  connect(AT_HV.inp,node_3)  annotation (Line(points={{13,-35.8},{14,-35.8},
          {14,-45},{13,-45}}, color={28,108,200}));
  connect(L2.inp,node_3)  annotation (Line(points={{20.4,-53},{13,-53},{13,
          -45}}, color={28,108,200}));
  connect(shortCircuitShunt4.inp,node_3)  annotation (Line(points={{-10,
          -45.2},{-10,-45},{13,-45}}, color={28,108,200}));
  connect(T_G2.out,node_1)  annotation (Line(points={{76,-53},{85,-53}},
                                   color={28,108,200}));
  connect(shortCircuitShunt2.inp,node_1)  annotation (Line(points={{86,
          -63.2},{85,-64},{85,-53}},          color={28,108,200}));
  connect(ElBr02.inp,node_1)
    annotation (Line(points={{97.2,-53},{85,-53}}, color={28,108,200}));
  connect(ElBr02.out, node_22)
    annotation (Line(points={{114.8,-53},{123,-53}}, color={28,108,200}));
  connect(G2.Stator_pin, node_22) annotation (Line(points={{143.4,-52.7833},{
          143.4,-53},{123,-53}},              color={28,108,200}));
  connect(shortCircuitShunt1.inp, node_22) annotation (Line(points={{122,
          -63.2},{123,-63.2},{123,-53}}, color={28,108,200}));
  connect(node_2, T_G2.inp)
    annotation (Line(points={{49,-53},{60.2,-53}}, color={28,108,200}));
  connect(node_2, ElBrShun02.inp) annotation (Line(points={{49,-53},{46,-53},
          {46,-54},{50,-54},{50,-67.2}}, color={28,108,200}));
  connect(node_13, shortCircuitShunt17.inp) annotation (Line(points={{-135,
          71},{-135,60.5},{-154,60.5},{-154,50.8}}, color={28,108,200}));
  connect(N2.inp, node_11) annotation (Line(points={{-54,-25.54},{-55,
          -25.54},{-55,-13}}, color={28,108,200}));
  connect(node_11, T1.inp)
    annotation (Line(points={{-55,-13},{-55,2.2}}, color={28,108,200}));
  connect(node_11, shortCircuitShunt15.inp) annotation (Line(points={{-55,
          -13},{-72,-13},{-72,-29.2}}, color={28,108,200}));
  connect(node_2, L2.out) annotation (Line(points={{49,-53},{50,-52.8},{
          35.8,-52.8}}, color={28,108,200}));
  connect(node_2, shortCircuitShunt3.inp) annotation (Line(points={{49,-53},
          {49,-61.5},{36,-61.5},{36,-71.2}}, color={28,108,200}));
  annotation (experiment(
      StopTime=80,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-240,-100},{180,140}}), graphics={
        Text(
          extent={{-190,84},{-172,74}},
          textColor={28,108,200},
          textString="14"),
        Text(
          extent={{-144,84},{-126,74}},
          textColor={28,108,200},
          textString="13"),
        Text(
          extent={{-134,24},{-116,14}},
          textColor={28,108,200},
          textString="15"),
        Text(
          extent={{-90,84},{-72,74}},
          textColor={28,108,200},
          textString="12"),
        Text(
          extent={{-58,32},{-40,22}},
          textColor={28,108,200},
          textString="10"),
        Text(
          extent={{-54,-6},{-36,-16}},
          textColor={28,108,200},
          textString="11"),
        Text(
          extent={{14,24},{32,14}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{50,4},{68,-6}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{-4,-4},{14,-14}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{14,-38},{32,-48}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{38,-38},{56,-48}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{78,-38},{96,-48}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{114,-36},{132,-46}},
          textColor={28,108,200},
          textString="22"),
        Text(
          extent={{8,84},{26,74}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{12,122},{30,112}},
          textColor={28,108,200},
          textString="16"),
        Text(
          extent={{38,86},{56,76}},
          textColor={28,108,200},
          textString="8"),
        Text(
          extent={{116,86},{134,76}},
          textColor={28,108,200},
          textString="21"),
        Text(
          extent={{78,86},{96,76}},
          textColor={28,108,200},
          textString="9")}),
    Icon(coordinateSystem(extent={{-240,-100},{180,140}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-138,-102},{106,140}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-70,110},{96,20},{-70,-70},{-70,110}})}),
    Documentation(info="<html>
<p>This scheme is widely used in Peter the Great St. Petersburg Polytechnic university as a part for bachelor&apos;s degree thesis last chapter, which is dedicated to dynamic stability investigarion. </p>
<p>Each node of this scheme has a short circuit shunt, which allows to simulate different types of short circuit. </p>
<p>The main purpose of this scheme is to show and teach the students the main ways to increase the degree of dynamic stability, which can be expressed in limit short circuit time. </p>
<p>Specifically in this scheme the scenario is as follows:</p>
<p><b>0 s</b>: start;</p>
<p><b>50 s</b>: 3-phase short circuit in node_7;</p>
<p><b>50.2 s</b>: end of short circuit, disconnection of L1;</p>
<p><b>50.4 s</b>: reduction of the G1 power plant active power generation;</p>
<p><b>50.5 s</b>: automatic reclosing of L1;</p>
<p><b>65 s</b>: 3-phase short circuit in node_2;</p>
<p><b>65.1 s: </b>start of fast G2&nbsp;turbine&nbsp;valving&nbsp;control;</p>
<p><b>65.15 s: </b>end of short circuit;</p>
<p><b>65.3 s</b>: end of G2 fast turbine valving control</p>
<p><b>80 s</b>: end. </p>
</html>"));
end three_maschine_scheme;
