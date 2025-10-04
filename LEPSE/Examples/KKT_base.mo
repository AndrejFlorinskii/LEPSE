within Examples;
model KKT_base
  Real delta_G07_G01(start=-1.2780330181121826),
                      delta_G13_G01(start=-0.5716190934181213),
                                     delta_G23_G01(start=
        0.24687373638153076),                       delta_G24_G01(start=
        0.1558079868555069),                                       delta_G33_G01(start=-0.8314602375030518),
                                                                                  delta_G36_G01(start=-0.544788122177124),
                                                                                                 delta_G44_G01(start=-0.31162023544311523),
                                                                                                                delta_G53_G01(start=-1.0288209915161133),
                                                                                                                               delta_G54_G01(start=-0.7352678179740906)
                                                                                                                                             "Mutual angles";

  LEPSE.Basic.HVline L0102(
    Rline=0.0274,
    Xline=0.1876,
    Bline1=0.01305,
    Bline2=0.01305)
    annotation (Placement(transformation(extent={{-16,6},{4,26}})));
  LEPSE.Basic.HVline L0103(
    Rline=100000,
    Xline=100000,
    Bline1=1e-006,
    Bline2=1e-006)
    annotation (Placement(transformation(extent={{-4,34},{16,54}})));
  LEPSE.Basic.HVline L0203(
    Rline=0.879,
    Xline=0.6,
    Bline1=0.0417,
    Bline2=0.0417)
    annotation (Placement(transformation(extent={{14,6},{34,26}})));
  LEPSE.Basic.HVline L0304(
    Rline=0.0228,
    Xline=0.1787,
    Bline1=0.05,
    Bline2=0.05)
    annotation (Placement(transformation(extent={{50,6},{70,26}})));
  LEPSE.Basic.HVline L0405(
    Rline=0.0296,
    Xline=0.2313,
    Bline1=0.06535,
    Bline2=0.06535)
    annotation (Placement(transformation(extent={{92,6},{112,26}})));
  LEPSE.Basic.HVline L0506(
    Rline=0.212,
    Xline=0.1486,
    Bline1=0.04295,
    Bline2=0.04295)
    annotation (Placement(transformation(extent={{142,6},{162,26}})));
  LEPSE.Basic.HVline L0607(
    Rline=0.0157,
    Xline=0.1102,
    Bline1=0.03185,
    Bline2=0.03185)
    annotation (Placement(transformation(extent={{216,6},{236,26}})));
  LEPSE.Basic.HVline L0708(
    Rline=0.0279,
    Xline=0.1679,
    Bline1=0.012,
    Bline2=0.012) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={242,-8})));
  LEPSE.Basic.HVline L0709_1(
    Rline=0.0122,
    Xline=0.0981,
    Bline1=0.02875,
    Bline2=0.02875,
    TLineOff=100.44,
    dTLineOff=4.5,
    Koff=100000)
    annotation (Placement(transformation(extent={{254,6},{274,26}})));
  LEPSE.Basic.HVline L0910(
    Rline=0.0138,
    Xline=0.0829,
    Bline1=0.0059,
    Bline2=0.0059)
    annotation (Placement(transformation(extent={{282,6},{302,26}})));
  LEPSE.Basic.HVline L1011(
    Rline=0.0446,
    Xline=0.2689,
    Bline1=0.0192,
    Bline2=0.0192)
    annotation (Placement(transformation(extent={{314,6},{334,26}})));
  LEPSE.Basic.HVline L1112(
    Rline=0.0048,
    Xline=0.0452,
    Bline1=0.00325,
    Bline2=0.00325)
    annotation (Placement(transformation(extent={{410,8},{430,28}})));
  LEPSE.Basic.HVline L1213(
    Rline=0.0322,
    Xline=0.2799,
    Bline1=0.0202,
    Bline2=0.0202)
    annotation (Placement(transformation(extent={{442,8},{462,28}})));
  LEPSE.Basic.Constant_Conductivity_Load N01(Gn=52.9, Bn=-24.69)
                                                                annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,-2})));
  LEPSE.Basic.Constant_Conductivity_Load N03(Gn=0, Bn=-0.0883) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={64,50})));
  LEPSE.Basic.Constant_Conductivity_Load N07(Gn=0.11, Bn=-0.0047)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={244,72})));
  LEPSE.Basic.Constant_Conductivity_Load N08(Gn=0.0006, Bn=-0.002)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={290,-24})));
  LEPSE.Basic.Constant_Conductivity_Load N09(Gn=0.0, Bn=0.0007) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={278,56})));
  LEPSE.Basic.Constant_Conductivity_Load N10(Gn=0.0867, Bn=-0.04)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={308,56})));
  LEPSE.Basic.Constant_Conductivity_Load N13(Gn=0.0001, Bn=-0.0001)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={494,42})));
  LEPSE.Basic.Transformer T0121(Rline=0.0049, Xline=0.1946) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-26,-16})));
  LEPSE.Basic.Transformer T0222(Rline=0.101, Xline=0.3857) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-16})));
  LEPSE.Basic.Transformer T0323(Rline=0.0035, Xline=0.1356) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={38,-16})));
  LEPSE.Basic.HVline L2122(
    Rline=0.1,
    Xline=0.5934,
    Bline1=0.0054,
    Bline2=0.0054)
    annotation (Placement(transformation(extent={{-20,-46},{0,-26}})));
  LEPSE.Basic.HVline L2223(
    Rline=0.3089,
    Xline=1.7297,
    Bline1=0.01585,
    Bline2=0.01585)
    annotation (Placement(transformation(extent={{12,-46},{32,-26}})));
  LEPSE.Basic.Transformer T0424(Rline=0.0055, Xline=0.2043) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={92,-4})));
  LEPSE.Basic.Transformer T2351(Rline=0.0125, Xline=0.3456) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={48,-46})));
  LEPSE.Basic.HVline L5152(
    Rline=1.1919,
    Xline=2.7983,
    Bline1=0.0046,
    Bline2=0.0046)
    annotation (Placement(transformation(extent={{66,-60},{86,-40}})));
  LEPSE.Basic.Transformer T2452(Rline=0.0123, Xline=0.4493) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={92,-30})));
  LEPSE.Basic.Constant_Conductivity_Load N51(Gn=0.07, Bn=-0.0562)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={62,-64})));
  LEPSE.Basic.Constant_Conductivity_Load N52(Gn=0.0115, Bn=0.0049)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={92,-64})));
  LEPSE.Basic.Transformer T0631(Rline=0.0099, Xline=0.3901) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={190,2})));
  LEPSE.Basic.HVline L3132(
    Rline=0.001,
    Xline=0.001,
    Bline1=0.0005,
    Bline2=0.0005) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={172,-20})));
  LEPSE.Basic.Transformer T3253(Rline=0.011, Xline=0.5216) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={152,-56})));
  LEPSE.Basic.HVline L5253(
    Rline=3.6794,
    Xline=8.1367,
    Bline1=0.00565,
    Bline2=0.00565)
    annotation (Placement(transformation(extent={{110,-62},{130,-42}})));
  LEPSE.Basic.HVline L5354(
    Rline=0.3285,
    Xline=0.655,
    Bline1=0.0018,
    Bline2=0.0018)
    annotation (Placement(transformation(extent={{158,-110},{178,-90}})));
  LEPSE.Basic.Constant_Conductivity_Load N53(Gn=0.025, Bn=-0.0114)
    annotation (Placement(transformation(extent={{156,-90},{176,-70}})));
  LEPSE.Basic.Constant_Conductivity_Load N23(Gn=0.0123, Bn=0.0164)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={36,-66})));
  LEPSE.Basic.Constant_Conductivity_Load N21(Gn=0.0, Bn=0.0164) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-28,-62})));
  LEPSE.Basic.Constant_Conductivity_Load N22(Gn=0.128, Bn=-0.0513)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={8,-62})));
  LEPSE.Basic.Constant_Conductivity_Load N24(Gn=0.151, Bn=-0.0354)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={62,-16})));
  LEPSE.Basic.HVline L3234(
    Rline=0.3015,
    Xline=1.0723,
    Bline1=0.00195,
    Bline2=0.00195) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={194,-48})));
  LEPSE.Basic.HVline L3233(
    Rline=0.2311,
    Xline=1.0116,
    Bline1=0.00175,
    Bline2=0.00175) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={194,-64})));
  LEPSE.Basic.HVline L3334(
    Rline=0.74,
    Xline=1.959,
    Bline1=0.0034,
    Bline2=0.0034) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={238,-64})));
  LEPSE.Basic.Constant_Conductivity_Load N33(Gn=0.0036, Bn=0.001)
    annotation (Placement(transformation(extent={{214,-90},{234,-70}})));
  LEPSE.Basic.HVline L3438(
    Rline=0.3209,
    Xline=0.8665,
    Bline1=0.00595,
    Bline2=0.00595) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={304,-56})));
  LEPSE.Basic.HVline L3536(
    Rline=0.0392,
    Xline=0.2201,
    Bline1=0.0021,
    Bline2=0.0021) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={274,-94})));
  LEPSE.Basic.HVline L5455(
    Rline=0.571,
    Xline=1.2117,
    Bline1=0.00345,
    Bline2=0.00345) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={216,-154})));
  LEPSE.Basic.Transformer T3655(Rline=0.0135, Xline=0.342) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={264,-142})));
  LEPSE.Basic.Constant_Conductivity_Load N54(Gn=0.13, Bn=-0.0296)
    annotation (Placement(transformation(extent={{176,-186},{196,-166}})));
  LEPSE.Basic.Constant_Conductivity_Load N55(Gn=0.06, Bn=-0.0039)
    annotation (Placement(transformation(extent={{232,-188},{252,-168}})));
  LEPSE.Basic.Constant_Conductivity_Load N36(Gn=0.145, Bn=-0.0641)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={288,-158})));
  LEPSE.Basic.Constant_Conductivity_Load N35(Gn=0.0796, Bn=-0.0512)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={298,-74})));
  LEPSE.Basic.Transformer T0835(Rline=0.0045, Xline=0.1913) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={272,-42})));
  LEPSE.Basic.HVline L3639(
    Rline=0.0603,
    Xline=0.3032,
    Bline1=0.0058,
    Bline2=0.0058) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={316,-90})));
  LEPSE.Basic.Constant_Conductivity_Load N34(Gn=0.023, Bn=-0.0142)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={252,-76})));
  LEPSE.Basic.HVline L3839(
    Rline=0.021,
    Xline=0.0156,
    Bline1=0.00015,
    Bline2=0.00015) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={372,-64})));
  LEPSE.Basic.HVline L3738(
    Rline=0.0013,
    Xline=0.0131,
    Bline1=0.00005,
    Bline2=0.00005) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={372,-22})));
  LEPSE.Basic.HVline L3739(
    Rline=0.0059,
    Xline=0.0439,
    Bline1=0.00015,
    Bline2=0.00015) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={342,-26})));
  LEPSE.Basic.Transformer T0937(Rline=0.0027, Xline=0.1004) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={308,-6})));
  LEPSE.Basic.HVline L3840(
    Rline=0.4373,
    Xline=1.0875,
    Bline1=0.0079,
    Bline2=0.0079) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={386,-46})));
  LEPSE.Basic.Transformer T1140(Rline=0.0044, Xline=0.1894) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={404,-8})));
  LEPSE.Basic.Constant_Conductivity_Load N37(Gn=0.0055, Bn=-0.01)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={380,10})));
  LEPSE.Basic.Constant_Conductivity_Load N38(Gn=0.0474, Bn=-0.0189)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={354,-66})));
  LEPSE.Basic.Constant_Conductivity_Load N39(Gn=0.05, Bn=-0.0103)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={338,-112})));
  LEPSE.Basic.Constant_Conductivity_Load N40(Gn=0.05, Bn=-0.0211)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={404,-74})));
  LEPSE.Basic.Constant_Conductivity_Load N42(Gn=0.057, Bn=-0.03)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={438,-72})));
  LEPSE.Basic.Constant_Conductivity_Load N44(Gn=0.013, Bn=-0.03)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={470,-76})));
  LEPSE.Basic.HVline L4042(
    Rline=0.0455,
    Xline=0.1556,
    Bline1=0.0012,
    Bline2=0.0012) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={420,-46})));
  LEPSE.Basic.HVline L4244(
    Rline=0.8606,
    Xline=2.8247,
    Bline1=0.00575,
    Bline2=0.00575) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={454,-46})));
  LEPSE.Basic.HVline L4445(
    Rline=0.0468,
    Xline=0.1657,
    Bline1=0.0012,
    Bline2=0.0012) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={486,-46})));
  LEPSE.Basic.Transformer T1345(Rline=0.0052, Xline=0.1903) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={490,4})));
  LEPSE.Basic.Transformer T1242(Rline=0.009, Xline=0.3966) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={436,-8})));
  Submodel3 G54(G54_Regulator(
      ExcitationCurrent(x(start={-0.023175831884145737})),
      FrequencyBlockD(x(start={0.47270649671554565})),
      FrequencyDerivative(x(start={0.47276583313941956})),
      FrequencyDeviation(x(start={0.47277745604515076})),
      SimpleExciter(x(start={-0.09808942675590515})),
      VoltageDerivative(x(start={0.003923555836081505})),
      VoltageDeviation(x(start={0.0039235432632267475}))))
                "Niva HPP"
                annotation (Placement(transformation(origin={-37.4642,
            33.3892},                                                    extent={{151.464,
            -199.389},{183.466,-167.389}})));
  Submodel4 G07(G07_Regulator(
      ExcitationCurrent(x(start={-0.26756539940834045})),
      FrequencyBlockD(x(start={0.47270649671554565})),
      FrequencyDerivative(x(start={0.47276681661605835})),
      FrequencyDeviation(x(start={0.47277846932411194})),
      SimpleExciter(x(start={-0.3302517831325531})),
      VoltageDerivative(x(start={0.013200302608311176})),
      VoltageDeviation(x(start={0.01319999247789383}))))
                "Kolskaya NPP"
                annotation (Placement(transformation(rotation=0, extent={{-16,-16},
            {16,16}},
        origin={166,48})));
  Submodel6 G44(G44_Regulator(
      ExcitationCurrent(x(start={-0.03847995400428772})),
      FrequencyBlockD(x(start={0.47270649671554565})),
      FrequencyDerivative(x(start={0.4727666974067688})),
      FrequencyDeviation(x(start={0.47277843952178955})),
      SimpleExciter(x(start={-0.22746887803077698})),
      VoltageDerivative(x(start={0.009098716080188751})),
      VoltageDeviation(x(start={0.009098692797124386}))))
                "Serebryanskaya HPP-16"
                annotation (Placement(transformation(rotation=0, extent={{-16,-17},
            {16,17}},
        origin={470,-109})));
  Submodel7 G53(G53_Regulator(
      ExcitationCurrent(x(start={-0.07316956669092178})),
      FrequencyBlockD(x(start={0.47270649671554565})),
      FrequencyDerivative(x(start={0.4727654457092285})),
      FrequencyDeviation(x(start={0.47277697920799255})),
      SimpleExciter(x(start={-0.440280944108963})),
      VoltageDerivative(x(start={0.017611216753721237})),
      VoltageDeviation(x(start={0.017611203715205193}))))
                "Knyazhegubskaya HPP"
                annotation (Placement(transformation(rotation=0, extent={{70,-126},
            {102,-94}})));
  Submodel8 G36(G36_Regulator(
      ExcitationCurrent(x(start={0.010285085998475552})),
      FrequencyBlockD(x(start={0.47270649671554565})),
      FrequencyDerivative(x(start={0.4727649688720703})),
      FrequencyDeviation(x(start={0.4727763831615448})),
      SimpleExciter(x(start={0.07171475887298584})),
      VoltageDerivative(x(start={-0.0028685845900326967})),
      VoltageDeviation(x(start={-0.002868581097573042}))))
                "Apatitskaya TPP"
                annotation (Placement(transformation(rotation=180,
                                                                 extent={{-16,-17},
            {16,17}},
        origin={346,-147})));
  Submodel9 G33(G33_Regulator(
      ExcitationCurrent(x(start={-0.04945843666791916})),
      FrequencyBlockD(x(start={0.47270649671554565})),
      FrequencyDerivative(x(start={0.47276630997657776})),
      FrequencyDeviation(x(start={0.4727780222892761})),
      SimpleExciter(x(start={-0.22212731838226318})),
      VoltageDerivative(x(start={0.008885062299668789})),
      VoltageDeviation(x(start={0.008885042741894722}))))
                "Iovskaya + Kumskaya HPP"
                annotation (Placement(transformation(rotation=180,
                                                                 extent={{-16,-17},
            {16,17}},
        origin={234,-115})));
  Submodel10 G01(G01_Regulator(
      ExcitationCurrent(x(start={-0.36905884742736816})),
      FrequencyBlockD(x(start={0.47270649671554565})),
      FrequencyDerivative(x(start={0.4727068543434143})),
      FrequencyDeviation(x(start={0.4727068543434143})),
      SimpleExciter(x(start={-0.01379958726465702})),
      VoltageDerivative(x(start={0.000275991769740358})),
      VoltageDeviation(x(start={0.0002759917115326971}))))
                 "Petrozavodsk - infinite bus"
                 annotation (Placement(transformation(rotation=0, extent={{-17,-17},
            {17,17}},
        origin={-53,33})));
  Submodel1_1 G23(G23_Regulator(
      ExcitationCurrent(x(start={0.007613298017531633})),
      FrequencyBlockD(x(start={0.47270649671554565})),
      FrequencyDerivative(x(start={0.4727334678173065})),
      FrequencyDeviation(x(start={0.4727388024330139})),
      SimpleExciter(x(start={0.07452328503131866})),
      VoltageDerivative(x(start={-0.0029810427222400904})),
      VoltageDeviation(x(start={-0.002981110941618681}))))
                  "Onda HPP"
                  annotation (Placement(transformation(
        rotation=0,
        extent={{-23,-19},{23,19}},
        origin={-11,-89})));
  Submodel2_1 G24(G24_Regulator(
      ExcitationCurrent(x(start={0.01093677245080471})),
      FrequencyBlockD(x(start={0.47270649671554565})),
      FrequencyDerivative(x(start={0.4727424681186676})),
      FrequencyDeviation(x(start={0.47274959087371826})),
      SimpleExciter(x(start={0.15797199308872223})),
      VoltageDerivative(x(start={-0.006319026928395033})),
      VoltageDeviation(x(start={-0.006319116335362196}))))
                  "Putkinskaya HPP"
                  annotation (Placement(transformation(
        rotation=180,
        extent={{-16,-16},{16,16}},
        origin={146,-16})));
  Submodel5_1 G13(G013_Regulator(
      ExcitationCurrent(x(start={-0.030580386519432068})),
      FrequencyBlockD(x(start={0.47270649671554565})),
      FrequencyDerivative(x(start={0.472766637802124})),
      FrequencyDeviation(x(start={0.4727783799171448})),
      SimpleExciter(x(start={-0.37765565514564514})),
      VoltageDerivative(x(start={0.0151061387732625})),
      VoltageDeviation(x(start={0.015106085687875748}))))
                  "Serebryanskaya HPP-15"
                  annotation (Placement(transformation(
        rotation=0,
        extent={{-17,-16},{17,16}},
        origin={431,68})));
  LEPSE.Basic.Constant_Conductivity_Load N11(Gn=0.0, Bn=-0.01) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={404,56})));
  LEPSE.Basic.Transformer T4344(Rline=0.0135, Xline=0.4959) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={496,-76})));
  LEPSE.Basic.Transformer T1314(Rline=0.0106, Xline=0.4067) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={472,50})));
  LEPSE.Basic.Transformer T0715(Rline=0.0016, Xline=0.0013) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={218,50})));
  LEPSE.Basic.Transformer T3646(Rline=0.0131, Xline=0.4179) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={304,-130})));
  LEPSE.Basic.HVline L3347(
    Rline=0.0472,
    Xline=0.7569,
    Bline1=0.0,
    Bline2=0.0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={210,-98})));
  LEPSE.Basic.Transformer T4853(Rline=0.0321, Xline=0.6775) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={128,-110})));
  LEPSE.Basic.Transformer T1623(Rline=0.0526, Xline=0.8401) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={22,-74})));
  LEPSE.Basic.Transformer T1724(Rline=0.0285, Xline=1.0535) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={112,-14})));
  LEPSE.Interfaces.Node node_1 annotation (Placement(transformation(extent=
            {{-30,18},{-24,24}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_2 annotation (Placement(transformation(extent=
            {{6,18},{12,24}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_3 annotation (Placement(transformation(extent=
            {{36,18},{42,24}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_4 annotation (Placement(transformation(extent=
            {{74,18},{80,24}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_5 annotation (Placement(transformation(extent=
            {{124,18},{130,24}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_6 annotation (Placement(transformation(extent=
            {{186,18},{192,24}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_7 annotation (Placement(transformation(extent=
            {{242,18},{248,24}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_8 annotation (Placement(transformation(extent=
            {{262,-28},{268,-22}}), iconTransformation(extent={{-120,-100},
            {-100,-80}})));
  LEPSE.Interfaces.Node node_9 annotation (Placement(transformation(extent=
            {{274,18},{280,24}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_10 annotation (Placement(transformation(extent
          ={{304,18},{310,24}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_11 annotation (Placement(transformation(extent
          ={{400,20},{406,26}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_12 annotation (Placement(transformation(extent
          ={{432,20},{438,26}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_13 annotation (Placement(transformation(extent
          ={{468,20},{474,26}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_14 annotation (Placement(transformation(extent
          ={{468,66},{474,72}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_15 annotation (Placement(transformation(extent
          ={{192,46},{198,52}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_16 annotation (Placement(transformation(extent
          ={{18,-92},{24,-86}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_17 annotation (Placement(transformation(extent
          ={{124,-18},{130,-12}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_21 annotation (Placement(transformation(extent
          ={{-30,-34},{-24,-28}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_22 annotation (Placement(transformation(extent
          ={{6,-34},{12,-28}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_23 annotation (Placement(transformation(extent
          ={{34,-34},{40,-28}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_24 annotation (Placement(transformation(extent
          ={{88,-20},{94,-14}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_31 annotation (Placement(transformation(extent
          ={{186,-16},{192,-10}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_32 annotation (Placement(transformation(extent
          ={{162,-48},{168,-42}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_33 annotation (Placement(transformation(extent
          ={{212,-62},{218,-56}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_34 annotation (Placement(transformation(extent
          ={{250,-62},{256,-56}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_35 annotation (Placement(transformation(extent
          ={{268,-76},{274,-70}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_36 annotation (Placement(transformation(extent
          ={{284,-124},{290,-118}}), iconTransformation(extent={{-120,-100},
            {-100,-80}})));
  LEPSE.Interfaces.Node node_48 annotation (Placement(transformation(extent
          ={{110,-112},{116,-106}}), iconTransformation(extent={{-120,-100},
            {-100,-80}})));
  LEPSE.Interfaces.Node node_53 annotation (Placement(transformation(extent
          ={{132,-74},{138,-68}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_51 annotation (Placement(transformation(extent
          ={{60,-50},{66,-44}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_52 annotation (Placement(transformation(extent
          ={{88,-50},{94,-44}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_47 annotation (Placement(transformation(extent
          ={{202,-120},{208,-114}}), iconTransformation(extent={{-120,-100},
            {-100,-80}})));
  LEPSE.Interfaces.Node node_54 annotation (Placement(transformation(extent
          ={{182,-152},{188,-146}}), iconTransformation(extent={{-120,-100},
            {-100,-80}})));
  LEPSE.Interfaces.Node node_55 annotation (Placement(transformation(extent
          ={{238,-152},{244,-146}}), iconTransformation(extent={{-120,-100},
            {-100,-80}})));
  LEPSE.Interfaces.Node node_46 annotation (Placement(transformation(extent
          ={{312,-152},{318,-146}}), iconTransformation(extent={{-120,-100},
            {-100,-80}})));
  LEPSE.Interfaces.Node node_39 annotation (Placement(transformation(extent
          ={{334,-88},{340,-82}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_37 annotation (Placement(transformation(extent
          ={{334,-10},{340,-4}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
  LEPSE.Interfaces.Node node_38 annotation (Placement(transformation(extent
          ={{364,-54},{370,-48}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_40 annotation (Placement(transformation(extent
          ={{400,-44},{406,-38}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_45 annotation (Placement(transformation(extent
          ={{486,-22},{492,-16}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_43 annotation (Placement(transformation(extent
          ={{492,-96},{498,-90}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_44 annotation (Placement(transformation(extent
          ={{466,-44},{472,-38}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Interfaces.Node node_42 annotation (Placement(transformation(extent
          ={{434,-44},{440,-38}}), iconTransformation(extent={{-120,-100},{
            -100,-80}})));
  LEPSE.Basic.HVline L0709_2(
    TLineOff=40,
    dTLineOff=1000,
    Koff=100000,
    Rline=0.0122,
    Xline=0.0981,
    Bline1=0.02875,
    Bline2=0.02875)
    annotation (Placement(transformation(extent={{254,-12},{274,8}})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt(
    Bn=-12,
    TkzOn=40.0,
    dTkzOn=0.11) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={260,56})));
  LEPSE.Basic.ShortCircuitShunt shortCircuitShunt1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={270,56})));
  LEPSE.Basic.Transformer T5054(Rline=0.0321, Xline=0.6775) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={168,-150})));
  LEPSE.Interfaces.Node node_18 annotation (Placement(transformation(extent={{
            148,-152},{154,-146}}), iconTransformation(extent={{-120,-100},{-100,
            -80}})));
equation

  der(delta_G07_G01) = G01.G01.Wc*(G01.G01.s - G07.G07.s);
  der(delta_G13_G01) = G01.G01.Wc*(G01.G01.s - G13.G13.s);
  der(delta_G23_G01) = G01.G01.Wc*(G01.G01.s - G23.G23.s);
  der(delta_G24_G01) = G01.G01.Wc*(G01.G01.s - G24.G24.s);
  der(delta_G33_G01) = G01.G01.Wc*(G01.G01.s - G33.G33.s);
  der(delta_G36_G01) = G01.G01.Wc*(G01.G01.s - G36.G36.s);
  der(delta_G44_G01) = G01.G01.Wc*(G01.G01.s - G44.G44.s);
  der(delta_G53_G01) = G01.G01.Wc*(G01.G01.s - G53.G53.s);
  der(delta_G54_G01) = G01.G01.Wc*(G01.G01.s - G54.G54.s);

  G01.G01.DeltaIJ = 0;
  G07.G07.DeltaIJ = delta_G07_G01;
  G13.G13.DeltaIJ = delta_G13_G01;
  G23.G23.DeltaIJ = delta_G23_G01;
  G24.G24.DeltaIJ = delta_G24_G01;
  G33.G33.DeltaIJ = delta_G33_G01;
  G36.G36.DeltaIJ = delta_G36_G01;
  G44.G44.DeltaIJ = delta_G44_G01;
  G53.G53.DeltaIJ = delta_G53_G01;
  G54.G54.DeltaIJ = delta_G54_G01;

  G01.G01.Ssys=G01.G01.s;
  G07.G07.Ssys=G01.G01.s;
  G13.G13.Ssys=G01.G01.s;
  G23.G23.Ssys=G01.G01.s;
  G24.G24.Ssys=G01.G01.s;
  G33.G33.Ssys=G01.G01.s;
  G36.G36.Ssys=G01.G01.s;
  G44.G44.Ssys=G01.G01.s;
  G53.G53.Ssys=G01.G01.s;
  G54.G54.Ssys=G01.G01.s;

  connect(L3840.inp, L3738.inp) annotation (Line(points={{376.2,-42},{376.2,
          -40},{368,-40},{368,-31.8}},color={28,108,200}));

  connect(T1242.inp, L4042.out) annotation (Line(points={{435,-17.8},{435,
          -32},{436,-32},{436,-42},{430,-42}},
                                        color={28,108,200}));
protected
  model KKT_1
    LEPSE.Basic.Synch_Machine G01(
      Pg=9,
      Qg=4.3589,
      Ut=1,
      Xd_p=0.282,
      Xq_p=0.282,
      Xs_p=0.02,
      X1d_p=0.038,
      X2d_p=0.027,
      X2q_p=0.027,
      Rf_p=9.34e-005,
      R1d_p=0.0002987,
      R1q_p=0.000161,
      Tj_p=49.7,
      Sigma=0.0475,
      TkzOn=1000,
      Pg_new=0.135) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-42,20})));
    LEPSE.Basic.Excitation_Regulator G01_Regulator(
      K0u=-25,
      K0w=0,
      K1w=0) annotation (Placement(transformation(
          extent={{-13,-13},{13,13}},
          rotation=0,
          origin={-65,37})));
    LEPSE.Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(
            rotation=0, extent={{70,-2},{90,18}})));
  equation
    connect(G01.dUtr_pin,G01_Regulator. dV_pin) annotation (Line(
        points={{-47,27.6},{-44,27.6},{-44,54},{-84,54},{-84,46.1},{-76.83,46.1}},
        color={255,255,0},
        thickness=0.5));
    connect(G01_Regulator.dV_pin,G01_Regulator. dV1_pin) annotation (Line(
        points={{-76.83,46.1},{-76.92,46.1},{-76.92,42.2},{-76.83,42.2}},
        color={255,255,0},
        thickness=0.5));
    connect(G01.dWu_pin,G01_Regulator. dfsys_pin) annotation (Line(
        points={{-43.6,27.6},{-46,27.6},{-46,52},{-82,52},{-82,38.3},{-76.83,38.3}},
        color={255,255,0},
        thickness=0.5));
    connect(G01.dWf_pin,G01_Regulator. dfU_pin) annotation (Line(
        points={{-40.4,27.6},{-40.4,56},{-84,56},{-84,34.4},{-76.83,34.4}},
        color={255,255,0},
        thickness=0.5));
    connect(G01.dIf_pin,G01_Regulator. dif1_pin) annotation (Line(
        points={{-37,27.6},{-37,58},{-86,58},{-86,30.5},{-76.83,30.5}},
        color={255,255,0},
        thickness=0.5));
    connect(G01_Regulator.out_pin,G01. Ef_pin) annotation (Line(
        points={{-53.17,38.56},{-54,38.56},{-54,20.2},{-50,20.2}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G01.Stator_pin)
      annotation (Line(points={{80,8},{-26,8},{-26,20.2},{-34.2,20.2}},
                                                        color={28,108,200}));
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
          Ellipse(
          extent={{-74,72},{72,-58}},
          lineColor={28,108,200}),
          Text(extent={{-44,54},{46,20}}, textString=
                                              "SM"),
          Text(extent={{-50,22},{50,-4}}, textString=
                                              "with"),
          Text(extent={{-78,-58},{74,-84}}, textString=
                                                "%name"),
          Line(points={{80,6},{72,6}}),
          Text(extent={{-50,-20},{50,-30}}, textString=
                                               "ARV")},
        Ellipse(extent=[-74, 72; 72, -58]),
        Text(extent=[-44, 54; 46, 20], string="SM"),
        Text(extent=[-50, 22; 50, -4], string="with"),
        Text(extent=[-78, -58; 74, -84], string="%name"),
        Line(points=[80, 6; 72, 6]),
        Text(extent=[-50, -20; 50, -30], string="ARV")),
      Window(
        x=0.28,
        y=0.01,
        width=0.6,
        height=0.88));
  end KKT_1;

  model Submodel3
    LEPSE.Basic.Synch_Machine G54(
      Pg=0.188,
      Qg=0.0389,
      Ut=1.019,
      Xd_p=4.836,
      Xq_p=3.269,
      Xs_p=0.602,
      X1d_p=1.806,
      X2d_p=1.214,
      X2q_p=1.242,
      Rf_p=0.004708,
      R1d_p=0.026201,
      R1q_p=0.012028,
      Tj_p=1.86,
      Sigma=0.0475,
      Mtmax=1.15,
      TkzOn=1000,
      Pg_new=0.135) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={19,-4})));
    LEPSE.Basic.Excitation_Regulator G54_Regulator(
      K0u=-25,
      K0w=0,
      K1w=0,
      K1if=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-5,-4})));
    LEPSE.Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(
            rotation=0, extent={{65.5,-1.5},{82,10}}), iconTransformation(
            extent={{66,-6},{82,10}})));
  equation
    connect(G54.dUtr_pin,G54_Regulator. dV_pin) annotation (Line(
        points={{13.6,6},{17,6},{17,10},{-23,10},{-23,1},{-15.0833,1}},
        color={255,255,0},
        thickness=0.5));
    connect(G54_Regulator.dV_pin,G54_Regulator. dV1_pin) annotation (Line(
        points={{-15.0833,1},{-15.0833,2},{-14,2},{-14.4,2},{-15.0833,2},{
            -15.0833,-2}},
        color={255,255,0},
        thickness=0.5));
    connect(G54.dWu_pin,G54_Regulator. dfsys_pin) annotation (Line(
        points={{16.4,6},{15,6},{15,8},{-21,8},{-21,-5},{-15.0833,-5}},
        color={255,255,0},
        thickness=0.5));
    connect(G54.dWf_pin,G54_Regulator. dfU_pin) annotation (Line(
        points={{19,6},{19,12},{-23,12},{-23,-8},{-15.0833,-8}},
        color={255,255,0},
        thickness=0.5));
    connect(G54.dIf_pin,G54_Regulator. dif1_pin) annotation (Line(
        points={{21.8,6},{21.8,14},{-25,14},{-25,-10.4},{-15.0833,-10.4}},
        color={255,255,0},
        thickness=0.5));
    connect(G54_Regulator.out_pin,G54. Ef_pin) annotation (Line(
        points={{5.08333,-4.8},{7,-4.8},{7,-4},{9,-4}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G54.Stator_pin)
      annotation (Line(points={{73.75,4.25},{73.75,-4},{29,-4}},
                                                      color={28,108,200}));
    connect(G54_Regulator.Ut_pin, G54.Ut_pin) annotation (Line(
        points={{-15,-12.4},{-15,-18},{-28,-18},{-28,16},{24.6,16},{24.6,6}},
        color={255,255,0},
        thickness=0.5));
      annotation (Line(points={{80,8},{-26,8},{-26,20.2},{-34.2,20.2}},
                                                        color={28,108,200}),
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
          Ellipse(
          extent={{-74,72},{72,-58}},
          lineColor={0,0,255}),
          Text(extent={{-44,54},{46,20}}, textString=
                                              "SM"),
          Text(extent={{-50,22},{50,-4}}, textString=
                                              "with"),
          Text(extent={{-78,104},{74,78}},  textString=
                                                "%name"),
          Text(extent={{-50,-20},{50,-30}}, textString=
                                               "ARV")},
        Ellipse(extent=[-74, 72; 72, -58]),
        Text(extent=[-44, 54; 46, 20], string="SM"),
        Text(extent=[-50, 22; 50, -4], string="with"),
        Text(extent=[-78, -58; 74, -84], string="%name"),
        Line(points=[80, 6; 72, 6]),
        Text(extent=[-50, -20; 50, -30], string="ARV")),
      Window(
        x=0.28,
        y=0.01,
        width=0.6,
        height=0.88));
  end Submodel3;

  model Submodel4
    LEPSE.Basic.Synch_Machine G07(
      Pg=1.33,
      Qg=0.31045,
      Ut=1.032,
      Xd_p=1.314,
      Xq_p=1.314,
      Xs_p=0.082,
      X1d_p=0.166,
      X2d_p=0.110,
      X2q_p=0.110,
      Rf_p=0.000601,
      R1d_p=0.000226,
      R1q_p=0.000240,
      Tj_p=19.712,
      Sigma=0.0475,
      Mtmax=1.15,
      TkzOn=1000,
      Pg_new=0.135,
      Kemax=2.0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={17,-10})));
    LEPSE.Basic.Excitation_Regulator G07_Regulator(
      K0u=-25,
      K0w=-5.0,
      K1w=0.8,
      K1if=-1,
      Udeforc=0.95) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-9,4})));
    LEPSE.Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(
            rotation=0, extent={{-90.5,-17},{-72,2}}), iconTransformation(
            extent={{66,-8},{86,12}})));
  equation
    connect(G07.dUtr_pin,G07_Regulator. dV_pin) annotation (Line(
        points={{11.6,0},{13,0},{13,18},{-27,18},{-27,9},{-19.0833,9}},
        color={255,255,0},
        thickness=0.5));
    connect(G07_Regulator.dV_pin,G07_Regulator. dV1_pin) annotation (Line(
        points={{-19.0833,9},{-18.25,9},{-18.25,6},{-19.0833,6}},
        color={255,255,0},
        thickness=0.5));
    connect(G07.dWu_pin,G07_Regulator. dfsys_pin) annotation (Line(
        points={{14.4,0},{11,0},{11,16},{-25,16},{-25,3},{-19.0833,3}},
        color={255,255,0},
        thickness=0.5));
    connect(G07.dWf_pin,G07_Regulator. dfU_pin) annotation (Line(
        points={{17,0},{17,20},{-27,20},{-27,0},{-19.0833,0}},
        color={255,255,0},
        thickness=0.5));
    connect(G07.dIf_pin,G07_Regulator. dif1_pin) annotation (Line(
        points={{19.8,0},{19.8,22},{-29,22},{-29,-2.4},{-19.0833,-2.4}},
        color={255,255,0},
        thickness=0.5));
    connect(G07_Regulator.out_pin,G07. Ef_pin) annotation (Line(
        points={{1.08333,3.2},{3,3.2},{3,-10},{7,-10}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G07.Stator_pin) annotation (Line(points={{-81.25,
            -7.5},{-82,-7.5},{-82,-28},{30,-28},{30,-10},{27,-10}},
                                      color={28,108,200}));
    connect(G07_Regulator.Ut_pin, G07.Ut_pin) annotation (Line(
        points={{-19,-4.4},{-19,-10},{-32,-10},{-32,24},{22.6,24},{22.6,0}},
        color={255,255,0},
        thickness=0.5));
      annotation (Line(points={{80,8},{-26,8},{-26,20.2},{-34.2,20.2}},
                                                        color={28,108,200}),
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
          Ellipse(
          extent={{-74,72},{72,-58}},
          lineColor={0,0,255}),
          Text(extent={{-44,54},{46,20}}, textString=
                                              "SM"),
          Text(extent={{-50,22},{50,-4}}, textString=
                                              "with"),
          Text(extent={{-78,104},{74,78}},  textString=
                                                "%name"),
          Text(extent={{-50,-20},{50,-30}}, textString=
                                               "ARV")},
        Ellipse(extent=[-74, 72; 72, -58]),
        Text(extent=[-44, 54; 46, 20], string="SM"),
        Text(extent=[-50, 22; 50, -4], string="with"),
        Text(extent=[-78, -58; 74, -84], string="%name"),
        Line(points=[80, 6; 72, 6]),
        Text(extent=[-50, -20; 50, -30], string="ARV")),
      Window(
        x=0.28,
        y=0.01,
        width=0.6,
        height=0.88),
      experiment(
        StopTime=50,
        __Dymola_NumberOfIntervals=5000,
        Tolerance=1e-06,
        __Dymola_Algorithm="Dassl"));
  end Submodel4;

  model Submodel6
    LEPSE.Basic.Synch_Machine G44(
      Pg=0.052,
      Qg=0.0094,
      Ut=0.978,
      Xd_p=6.557,
      Xq_p=4.068,
      Xs_p=0.644,
      X1d_p=1.579,
      X2d_p=1.214,
      X2q_p=1.457,
      Rf_p=0.0031941,
      R1d_p=0.195869,
      R1q_p=0.100175,
      Tj_p=1.457,
      Sigma=0.0475,
      TkzOn=1000,
      Pg_new=0.135) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-16,5})));
    LEPSE.Basic.Excitation_Regulator G44_Regulator(
      K0u=-25,
      K0w=0,
      K1w=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={16,3})));
    LEPSE.Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(
            rotation=0, extent={{-161,-7.5},{-146,8}}), iconTransformation(
            extent={{66,-8},{84,9.5}})));
  equation
    connect(G44.dUtr_pin,G44_Regulator. dV_pin) annotation (Line(
        points={{-10.6,-5},{-12,-5},{-12,-12},{30,-12},{30,-2},{26.0833,-2}},
        color={255,255,0},
        thickness=0.5));
    connect(G44_Regulator.dV_pin,G44_Regulator. dV1_pin) annotation (Line(
        points={{26.0833,-2},{26.0833,0},{26.0833,0},{26.0833,1}},
        color={255,255,0},
        thickness=0.5));
    connect(G44.dWu_pin,G44_Regulator. dfsys_pin) annotation (Line(
        points={{-13.4,-5},{-10,-5},{-10,-14},{32,-14},{32,4},{26.0833,4}},
        color={255,255,0},
        thickness=0.5));
    connect(G44.dWf_pin,G44_Regulator. dfU_pin) annotation (Line(
        points={{-16,-5},{-18,-5},{-18,-16},{34,-16},{34,7},{26.0833,7}},
        color={255,255,0},
        thickness=0.5));
    connect(G44.dIf_pin,G44_Regulator. dif1_pin) annotation (Line(
        points={{-18.8,-5},{-16,-5},{-16,-18},{36,-18},{36,9.4},{26.0833,
            9.4}},
        color={255,255,0},
        thickness=0.5));
    connect(G44_Regulator.out_pin,G44. Ef_pin) annotation (Line(
        points={{5.91667,3.8},{5.91667,5},{-6,5}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G44.Stator_pin) annotation (Line(points={{-153.5,
            0.25},{-32,0.25},{-32,5},{-26,5}},
                          color={28,108,200}));
    connect(G44_Regulator.Ut_pin, G44.Ut_pin) annotation (Line(
        points={{26,11.4},{26,10},{38,10},{38,-20},{-21.6,-20},{-21.6,-5}},
        color={255,255,0},
        thickness=0.5));
     annotation (Line(points={{80,8},{-26,8},{-26,20.2},{-34.2,20.2}},
                                                        color={28,108,200}),
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
          Ellipse(
          extent={{-74,72},{72,-58}},
          lineColor={0,0,255}),
          Text(extent={{-44,54},{46,20}}, textString=
                                              "SM"),
          Text(extent={{-50,22},{50,-4}}, textString=
                                              "with"),
          Text(extent={{-76,102},{76,76}},  textString=
                                                "%name"),
          Text(extent={{-50,-20},{50,-30}}, textString=
                                               "ARV")},
        Ellipse(extent=[-74, 72; 72, -58]),
        Text(extent=[-44, 54; 46, 20], string="SM"),
        Text(extent=[-50, 22; 50, -4], string="with"),
        Text(extent=[-78, -58; 74, -84], string="%name"),
        Line(points=[80, 6; 72, 6]),
        Text(extent=[-50, -20; 50, -30], string="ARV")),
      Window(
        x=0.28,
        y=0.01,
        width=0.6,
        height=0.88));
  end Submodel6;

  model Submodel7
    LEPSE.Basic.Synch_Machine G53(
      Pg=0.146,
      Qg=0,
      Ut=0.939,
      Xd_p=7.216,
      Xq_p=5.056,
      Xs_p=1.197,
      X1d_p=2.731,
      X2d_p=1.964,
      X2q_p=1.933,
      Rf_p=0.005142,
      R1d_p=0.135060,
      R1q_p=0.014478,
      Tj_p=0.695175,
      Sigma=0.0475,
      Mtmax=1.15,
      TkzOn=1000,
      Pg_new=0.135) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={0,-6})));
    LEPSE.Basic.Excitation_Regulator G53_Regulator(
      K0u=-25,
      K0w=0,
      K1w=0,
      K1if=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-24,-6})));
    LEPSE.Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(
            rotation=0, extent={{66,-10},{86,10}}), iconTransformation(
            extent={{66,-10},{86,10}})));
  equation
    connect(G53.dUtr_pin,G53_Regulator. dV_pin) annotation (Line(
        points={{-5.4,4},{-2,4},{-2,8},{-42,8},{-42,-1},{-34.0833,-1}},
        color={255,255,0},
        thickness=0.5));
    connect(G53_Regulator.dV_pin,G53_Regulator. dV1_pin) annotation (Line(
        points={{-34.0833,-1},{-34.0833,-1},{-34.0833,0},{-33.4,0},{
            -34.0833,0},{-34.0833,-4}},
        color={255,255,0},
        thickness=0.5));
    connect(G53.dWu_pin,G53_Regulator. dfsys_pin) annotation (Line(
        points={{-2.6,4},{-4,4},{-4,6},{-40,6},{-40,-7},{-34.0833,-7}},
        color={255,255,0},
        thickness=0.5));
    connect(G53.dWf_pin,G53_Regulator. dfU_pin) annotation (Line(
        points={{0,4},{0,10},{-42,10},{-42,-10},{-34.0833,-10}},
        color={255,255,0},
        thickness=0.5));
    connect(G53.dIf_pin,G53_Regulator. dif1_pin) annotation (Line(
        points={{2.8,4},{2.8,12},{-44,12},{-44,-12.4},{-34.0833,-12.4}},
        color={255,255,0},
        thickness=0.5));
    connect(G53_Regulator.out_pin,G53. Ef_pin) annotation (Line(
        points={{-13.9167,-6.8},{-12,-6.8},{-12,-6},{-10,-6}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G53.Stator_pin) annotation (Line(points={{76,0},{14,
            0},{14,-6},{10,-6}},          color={28,108,200}));
    connect(G53_Regulator.Ut_pin, G53.Ut_pin) annotation (Line(
        points={{-34,-14.4},{-46,-14.4},{-46,14},{5.6,14},{5.6,4}},
        color={255,255,0},
        thickness=0.5));
      annotation (Line(points={{80,8},{-26,8},{-26,20.2},{-34.2,20.2}},
                                                        color={28,108,200}),
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
          Ellipse(
          extent={{-74,72},{72,-58}},
          lineColor={0,0,255}),
          Text(extent={{-44,54},{46,20}}, textString=
                                              "SM"),
          Text(extent={{-50,22},{50,-4}}, textString=
                                              "with"),
          Text(extent={{-76,102},{76,76}},  textString=
                                                "%name"),
          Text(extent={{-50,-20},{50,-30}}, textString=
                                               "ARV")},
        Ellipse(extent=[-74, 72; 72, -58]),
        Text(extent=[-44, 54; 46, 20], string="SM"),
        Text(extent=[-50, 22; 50, -4], string="with"),
        Text(extent=[-78, -58; 74, -84], string="%name"),
        Line(points=[80, 6; 72, 6]),
        Text(extent=[-50, -20; 50, -30], string="ARV")),
      Window(
        x=0.28,
        y=0.01,
        width=0.6,
        height=0.88));
  end Submodel7;

  model Submodel8
    LEPSE.Basic.Synch_Machine G36(
      Pg=0.1046,
      Qg=0.0383,
      Ut=1.048,
      Xd_p=7.491,
      Xq_p=7.491,
      Xs_p=0.587,
      X1d_p=0.984,
      X2d_p=0.591,
      X2q_p=0.591,
      Rf_p=0.002591,
      R1d_p=0.005109,
      R1q_p=0.002554,
      Tj_p=1.98,
      Sigma=0.0475,
      TkzOn=1000,
      Pg_new=0.135) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-42,7})));
    LEPSE.Basic.Excitation_Regulator G36_Regulator(
      K0u=-25,
      K0w=0,
      K1w=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={4,5})));
    LEPSE.Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(
            rotation=0, extent={{63,-15.5},{83,10.5}}), iconTransformation(
            extent={{64,-8},{83,10.5}})));
  equation
    connect(G36.dUtr_pin,G36_Regulator. dV_pin) annotation (Line(
        points={{-36.4,-0.6},{-38,-0.6},{-38,-10},{18,-10},{18,-2},{13.25,-2}},
        color={255,255,0},
        thickness=0.5));
    connect(G36_Regulator.dV_pin,G36_Regulator. dV1_pin) annotation (Line(
        points={{13.25,-2},{11.1,-2},{11.1,1},{13.25,1}},
        color={255,255,0},
        thickness=0.5));
    connect(G36.dWu_pin,G36_Regulator. dfsys_pin) annotation (Line(
        points={{-38.8,-0.6},{-36,-0.6},{-36,-12},{20,-12},{20,4},{13.25,4}},
        color={255,255,0},
        thickness=0.5));
    connect(G36.dWf_pin,G36_Regulator. dfU_pin) annotation (Line(
        points={{-41.2,-0.6},{-44,-0.6},{-44,-14},{22,-14},{22,7},{13.25,7}},
        color={255,255,0},
        thickness=0.5));
    connect(G36.dIf_pin,G36_Regulator. dif1_pin) annotation (Line(
        points={{-43.8,-0.6},{-42,-0.6},{-42,-16},{24,-16},{24,9.4},{13.25,
            9.4}},
        color={255,255,0},
        thickness=0.5));
    connect(G36_Regulator.out_pin,G36. Ef_pin) annotation (Line(
        points={{-5.08333,3.8},{-28,3.8},{-28,6.8},{-34,6.8}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G36.Stator_pin) annotation (Line(points={{73,-2.5},{26,
            -2.5},{26,-18},{-56,-18},{-56,6.8},{-49.8,6.8}},
                          color={28,108,200}));
    connect(G36_Regulator.Ut_pin, G36.Ut_pin) annotation (Line(
        points={{13.1667,11.4},{13.1667,12},{18,12},{18,22},{-60,22},{-60,
            -6},{-46.2,-6},{-46.2,-0.6}},
        color={255,255,0},
        thickness=0.5));
     annotation (Line(points={{80,8},{-26,8},{-26,20.2},{-34.2,20.2}},
                                                        color={28,108,200}),
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
          Ellipse(
          extent={{-74,72},{72,-58}},
          lineColor={0,0,255}),
          Text(extent={{-44,54},{46,20}}, textString=
                                              "SM"),
          Text(extent={{-50,22},{50,-4}}, textString=
                                              "with"),
          Text(extent={{-78,-58},{74,-84}}, textString=
                                                "%name"),
          Text(extent={{-50,-20},{50,-30}}, textString=
                                               "ARV")},
        Ellipse(extent=[-74, 72; 72, -58]),
        Text(extent=[-44, 54; 46, 20], string="SM"),
        Text(extent=[-50, 22; 50, -4], string="with"),
        Text(extent=[-78, -58; 74, -84], string="%name"),
        Line(points=[80, 6; 72, 6]),
        Text(extent=[-50, -20; 50, -30], string="ARV")),
      Window(
        x=0.28,
        y=0.01,
        width=0.6,
        height=0.88));
  end Submodel8;

  model Submodel9
    LEPSE.Basic.Synch_Machine G33(
      Pg=0.161,
      Qg=0.0027,
      Ut=0.986,
      Xd_p=5.25,
      Xq_p=3.275,
      Xs_p=0.758,
      X1d_p=1.550,
      X2d_p=1.200,
      X2q_p=1.240,
      Rf_p=0.004823,
      R1d_p=0.088442,
      R1q_p=0.008319,
      Tj_p=1.567544,
      Sigma=0.0475,
      TkzOn=1000,
      Pg_new=0.135) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-39,5})));
    LEPSE.Basic.Excitation_Regulator G33_Regulator(
      K0u=-25,
      K0w=0,
      K1w=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={3,9})));
    LEPSE.Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(
            rotation=0, extent={{69.5,-3.5},{76.5,3.5}}),
          iconTransformation(extent={{65.5,-7.5},{84,10}})));
  equation
    connect(G33.dUtr_pin,G33_Regulator. dV_pin) annotation (Line(
        points={{-33.4,-2.6},{-36,-2.6},{-36,-8},{12.25,-8},{12.25,2}},
        color={255,255,0},
        thickness=0.5));
    connect(G33_Regulator.dV_pin,G33_Regulator. dV1_pin) annotation (Line(
        points={{12.25,2},{14.1,2},{14.1,5},{12.25,5}},
        color={255,255,0},
        thickness=0.5));
    connect(G33.dWu_pin,G33_Regulator. dfsys_pin) annotation (Line(
        points={{-35.8,-2.6},{-35.8,-4},{-40,-4},{-40,-12},{18,-12},{18,8},{
            12.25,8}},
        color={255,255,0},
        thickness=0.5));
    connect(G33.dWf_pin,G33_Regulator. dfU_pin) annotation (Line(
        points={{-38.2,-2.6},{-38.2,-14},{20,-14},{20,11},{12.25,11}},
        color={255,255,0},
        thickness=0.5));
    connect(G33.dIf_pin,G33_Regulator. dif1_pin) annotation (Line(
        points={{-40.8,-2.6},{-38,-2.6},{-38,-6},{-42,-6},{-42,-16},{22,-16},
            {22,13.4},{12.25,13.4}},
        color={255,255,0},
        thickness=0.5));
    connect(G33_Regulator.out_pin,G33. Ef_pin) annotation (Line(
        points={{-6.08333,7.8},{-24,7.8},{-24,4.8},{-31,4.8}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G33.Stator_pin) annotation (Line(points={{73,0},{24,0},
            {24,-18},{-56,-18},{-56,4.8},{-46.8,4.8}},
                                    color={28,108,200}));
    connect(G33_Regulator.Ut_pin, G33.Ut_pin) annotation (Line(
        points={{12.1667,15.4},{12.1667,24},{-56,24},{-56,2},{-54,2},{-54,
            -8},{-43.2,-8},{-43.2,-2.6}},
        color={255,255,0},
        thickness=0.5));
     annotation (Line(points={{80,8},{-26,8},{-26,20.2},{-34.2,20.2}},
                                                        color={28,108,200}),
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
          Ellipse(
          extent={{-74,72},{72,-58}},
          lineColor={0,0,255}),
          Text(extent={{-44,54},{46,20}}, textString=
                                              "SM"),
          Text(extent={{-50,22},{50,-4}}, textString=
                                              "with"),
          Text(extent={{-78,-58},{74,-84}}, textString=
                                                "%name"),
          Text(extent={{-50,-20},{50,-30}}, textString=
                                               "ARV")},
        Ellipse(extent=[-74, 72; 72, -58]),
        Text(extent=[-44, 54; 46, 20], string="SM"),
        Text(extent=[-50, 22; 50, -4], string="with"),
        Text(extent=[-78, -58; 74, -84], string="%name"),
        Line(points=[80, 6; 72, 6]),
        Text(extent=[-50, -20; 50, -30], string="ARV")),
      Window(
        x=0.28,
        y=0.01,
        width=0.6,
        height=0.88));
  end Submodel9;

  model Submodel10
    LEPSE.Basic.Synch_Machine G01(
      Pg=54.8714,
      Qg=26.5754,
      Ut=1.02,
      Xd_p=0.041,
      Xq_p=0.041,
      Xs_p=0.0036,
      X1d_p=0.0055,
      X2d_p=0.0039,
      X2q_p=0.0039,
      Rf_p=0.000014,
      R1d_p=0.000035,
      R1q_p=0.000048,
      Tj_p=378.88,
      Sigma=0.0475,
      TkzOn=1000,
      Pg_new=0.135) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-46,22})));
    LEPSE.Basic.Excitation_Regulator G01_Regulator(
      K0u=-50,
      K1u=-2,
      K0w=0,
      K1w=0) annotation (Placement(transformation(
          extent={{-13,-13},{13,13}},
          rotation=0,
          origin={-71,39})));
    LEPSE.Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(
            rotation=0, extent={{64,-10},{84,10}}), iconTransformation(
            extent={{64,-10},{84,10}})));
  equation
    connect(G01.dUtr_pin,G01_Regulator. dV_pin) annotation (Line(
        points={{-51.4,32},{-52,32},{-52,56},{-88,56},{-88,45.5},{-84.1083,
            45.5}},
        color={255,255,0},
        thickness=0.5));
    connect(G01_Regulator.dV_pin,G01_Regulator. dV1_pin) annotation (Line(
        points={{-84.1083,45.5},{-82.92,45.5},{-82.92,41.6},{-84.1083,41.6}},
        color={255,255,0},
        thickness=0.5));
    connect(G01.dWu_pin,G01_Regulator. dfsys_pin) annotation (Line(
        points={{-48.6,32},{-48,32},{-48,54},{-84,54},{-84,37.7},{-84.1083,
            37.7}},
        color={255,255,0},
        thickness=0.5));
    connect(G01.dWf_pin,G01_Regulator. dfU_pin) annotation (Line(
        points={{-46,32},{-46,58},{-90,58},{-90,33.8},{-84.1083,33.8}},
        color={255,255,0},
        thickness=0.5));
    connect(G01.dIf_pin,G01_Regulator. dif1_pin) annotation (Line(
        points={{-43.2,32},{-43.2,60},{-92,60},{-92,30.68},{-84.1083,30.68}},
        color={255,255,0},
        thickness=0.5));
    connect(G01_Regulator.out_pin,G01. Ef_pin) annotation (Line(
        points={{-57.8917,37.96},{-60,37.96},{-60,22},{-56,22}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G01.Stator_pin)
      annotation (Line(points={{74,0},{-30,0},{-30,22},{-36,22}},
                                                        color={28,108,200}));
    connect(G01_Regulator.Ut_pin, G01.Ut_pin) annotation (Line(
        points={{-84,28.08},{-94,28.08},{-94,62},{-40.4,62},{-40.4,32}},
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
          Ellipse(
          extent={{-74,72},{72,-58}},
          lineColor={0,0,255}),
          Text(extent={{-44,54},{46,20}}, textString=
                                              "SM"),
          Text(extent={{-50,22},{50,-4}}, textString=
                                              "with"),
          Text(extent={{-74,102},{78,76}},  textString=
                                                "%name"),
          Line(points={{80,6},{72,6}}),
          Text(extent={{-50,-20},{50,-30}}, textString=
                                               "ARV")},
        Ellipse(extent=[-74, 72; 72, -58]),
        Text(extent=[-44, 54; 46, 20], string="SM"),
        Text(extent=[-50, 22; 50, -4], string="with"),
        Text(extent=[-78, -58; 74, -84], string="%name"),
        Line(points=[80, 6; 72, 6]),
        Text(extent=[-50, -20; 50, -30], string="ARV")),
      Window(
        x=0.28,
        y=0.01,
        width=0.6,
        height=0.88));
  end Submodel10;

  model Submodel1_1
    LEPSE.Basic.Synch_Machine G23(
      Pg=0.048,
      Qg=0.01681,
      Ut=0.995,
      Xd_p=10.306,
      Xq_p=6.481,
      Xs_p=0.531,
      X1d_p=3.719,
      X2d_p=2.444,
      X2q_p=2.869,
      Rf_p=0.016728,
      R1d_p=0.083343,
      R1q_p=0.040406,
      Tj_p=0.676,
      Sigma=0.0475,
      TkzOn=1000,
      Pg_new=0.135) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-15,6})));
    LEPSE.Basic.Excitation_Regulator G23_Regulator(
      K0u=-25,
      K0w=0,
      K1w=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={7,4})));
    LEPSE.Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(
          rotation=180,
          extent={{-8,-8},{8,8}},
          origin={-132,4}), iconTransformation(extent={{64,-8},{82,10}})));
  equation
    connect(G23.dUtr_pin,G23_Regulator. dV_pin) annotation (Line(
        points={{-9.6,-4},{-9.6,-12},{19,-12},{19,-1},{17.0833,-1}},
        color={255,255,0},
        thickness=0.5));
    connect(G23_Regulator.dV_pin,G23_Regulator. dV1_pin) annotation (Line(
        points={{17.0833,-1},{14.1,-1},{14.1,2},{17.0833,2}},
        color={255,255,0},
        thickness=0.5));
    connect(G23.dWu_pin,G23_Regulator. dfsys_pin) annotation (Line(
        points={{-12.4,-4},{-12.4,-14},{21,-14},{21,5},{17.0833,5}},
        color={255,255,0},
        thickness=0.5));
    connect(G23.dWf_pin,G23_Regulator. dfU_pin) annotation (Line(
        points={{-15,-4},{-15,-16},{23,-16},{23,8},{17.0833,8}},
        color={255,255,0},
        thickness=0.5));
    connect(G23.dIf_pin,G23_Regulator. dif1_pin) annotation (Line(
        points={{-17.8,-4},{-17.8,-18},{25,-18},{25,6},{17.0833,6},{17.0833,
            10.4}},
        color={255,255,0},
        thickness=0.5));
    connect(G23_Regulator.out_pin,G23. Ef_pin) annotation (Line(
        points={{-3.08333,4.8},{-5,4.8},{-5,2},{-5,2},{-5,6}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G23.Stator_pin)
      annotation (Line(points={{-132,4},{-30,4},{-30,6},{-25,6}},
                                     color={28,108,200}));
    connect(G23_Regulator.Ut_pin, G23.Ut_pin) annotation (Line(
        points={{17,12.4},{17,18},{30,18},{30,-20},{-20.6,-20},{-20.6,-4}},
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
          extent={{-160,-120},{120,120}},
          grid={2,2},
          initialScale=0),
        graphics={
          Ellipse(
          extent={{-74,72},{72,-58}},
          lineColor={0,0,255}),
          Text(extent={{-44,54},{46,20}}, textString=
                                              "SM"),
          Text(extent={{-50,22},{50,-4}}, textString=
                                              "with"),
          Text(extent={{-78,108},{74,82}},  textString=
                                                "%name"),
          Text(extent={{-50,-20},{50,-30}}, textString=
                                               "ARV")},
        Ellipse(extent=[-74, 72; 72, -58]),
        Text(extent=[-44, 54; 46, 20], string="SM"),
        Text(extent=[-50, 22; 50, -4], string="with"),
        Text(extent=[-78, -58; 74, -84], string="%name"),
        Line(points=[80, 6; 72, 6]),
        Text(extent=[-50, -20; 50, -30], string="ARV")),
      Window(
        x=0.28,
        y=0.01,
        width=0.6,
        height=0.88),
      Diagram(coordinateSystem(extent={{-160,-120},{120,120}})));
  end Submodel1_1;

  model Submodel2_1
    LEPSE.Basic.Excitation_Regulator G24_Regulator(
      K0u=-25,
      K0w=0,
      K1w=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={6,8})));
    LEPSE.Basic.Synch_Machine G24(
      Pg=0.0412,
      Qg=0.031,
      Ut=1.001,
      Xd_p=15.714,
      Xq_p=10.286,
      Xs_p=1.288,
      X1d_p=5.929,
      X2d_p=3.857,
      X2q_p=4.286,
      Rf_p=0.018811,
      R1d_p=0.107755,
      R1q_p=0.053144,
      Tj_p=0.45304,
      Sigma=0.0475,
      TkzOn=1000,
      Pg_new=0.135) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-30,-2})));
    LEPSE.Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(
            rotation=0, extent={{71,1.5},{77,7.5}}), iconTransformation(
            extent={{65,-6.5},{82,10}})));
  equation
    connect(G24.dUtr_pin,G24_Regulator. dV_pin) annotation (Line(
        points={{-24.6,-12},{-24.6,-16},{20,-16},{20,3},{16.0833,3}},
        color={255,255,0},
        thickness=0.5));
    connect(G24_Regulator.dV_pin,G24_Regulator. dV1_pin) annotation (Line(
        points={{16.0833,3},{16.0833,2},{16,2},{15.4,2},{16.0833,2},{
            16.0833,6}},
        color={255,255,0},
        thickness=0.5));
    connect(G24.dWu_pin,G24_Regulator. dfsys_pin) annotation (Line(
        points={{-27.4,-12},{-24,-12},{-24,-18},{22,-18},{22,9},{16.0833,9}},
        color={255,255,0},
        thickness=0.5));
    connect(G24.dWf_pin,G24_Regulator. dfU_pin) annotation (Line(
        points={{-30,-12},{-32,-12},{-32,-20},{24,-20},{24,12},{16.0833,12}},
        color={255,255,0},
        thickness=0.5));
    connect(G24.dIf_pin,G24_Regulator. dif1_pin) annotation (Line(
        points={{-32.8,-12},{-32.8,-22},{26,-22},{26,14.4},{16.0833,14.4}},
        color={255,255,0},
        thickness=0.5));
    connect(G24_Regulator.out_pin,G24. Ef_pin) annotation (Line(
        points={{-4.08333,8.8},{-16,8.8},{-16,-2},{-20,-2}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G24.Stator_pin) annotation (Line(points={{74,4.5},{
            74,-26},{-44,-26},{-44,-2},{-40,-2}},
                                     color={28,108,200}));
    connect(G24_Regulator.Ut_pin, G24.Ut_pin) annotation (Line(
        points={{16,16.4},{28,16.4},{28,-24},{-35.6,-24},{-35.6,-12}},
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
          Ellipse(
          extent={{-74,72},{72,-58}},
          lineColor={0,0,255}),
          Text(extent={{-44,54},{46,20}}, textString=
                                              "SM"),
          Text(extent={{-50,22},{50,-4}}, textString=
                                              "with"),
          Text(extent={{-74,-68},{78,-94}}, textString=
                                                "%name"),
          Text(extent={{-50,-20},{50,-30}}, textString=
                                               "ARV")},
        Ellipse(extent=[-74, 72; 72, -58]),
        Text(extent=[-44, 54; 46, 20], string="SM"),
        Text(extent=[-50, 22; 50, -4], string="with"),
        Text(extent=[-78, -58; 74, -84], string="%name"),
        Line(points=[80, 6; 72, 6]),
        Text(extent=[-50, -20; 50, -30], string="ARV")),
      Window(
        x=0.28,
        y=0.01,
        width=0.6,
        height=0.88));
  end Submodel2_1;

  model Submodel5_1
    LEPSE.Basic.Synch_Machine G13(
      Pg=0.067,
      Qg=-0.0105,
      Ut=0.986,
      Xd_p=13.701,
      Xq_p=8.5,
      Xs_p=1.345,
      X1d_p=3.299,
      X2d_p=2.537,
      X2q_p=3.045,
      Rf_p=0.0066742,
      R1d_p=0.409279,
      R1q_p=0.209320,
      Tj_p=0.697,
      Sigma=0.0475,
      Mtmax=1.15,
      TkzOn=1000,
      Pg_new=0.135) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={26,-12})));
    LEPSE.Basic.Excitation_Regulator G013_Regulator(
      K0u=-25,
      K0w=0,
      K1w=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={2,2})));
    LEPSE.Interfaces.Pin_v2 Stator_pin annotation (Placement(transformation(
            rotation=0, extent={{59,-6.5},{81,7}}), iconTransformation(
            extent={{66,-8},{84,10}})));
  equation
    connect(G13.dUtr_pin,G013_Regulator. dV_pin) annotation (Line(
        points={{20.6,-2},{24,-2},{24,16},{-16,16},{-16,7},{-8.08333,7}},
        color={255,255,0},
        thickness=0.5));
    connect(G013_Regulator.dV_pin,G013_Regulator. dV1_pin) annotation (Line(
        points={{-8.08333,7},{-8.08333,8},{-8,8},{-7.4,8},{-8.08333,8},{
            -8.08333,4}},
        color={255,255,0},
        thickness=0.5));
    connect(G13.dWu_pin,G013_Regulator. dfsys_pin) annotation (Line(
        points={{23.4,-2},{22,-2},{22,14},{-14,14},{-14,1},{-8.08333,1}},
        color={255,255,0},
        thickness=0.5));
    connect(G13.dWf_pin,G013_Regulator. dfU_pin) annotation (Line(
        points={{26,-2},{26,16},{-20,16},{-20,-2},{-8.08333,-2}},
        color={255,255,0},
        thickness=0.5));
    connect(G13.dIf_pin,G013_Regulator. dif1_pin) annotation (Line(
        points={{28.8,-2},{28.8,20},{-18,20},{-18,-4.4},{-8.08333,-4.4}},
        color={255,255,0},
        thickness=0.5));
    connect(G013_Regulator.out_pin,G13. Ef_pin) annotation (Line(
        points={{12.0833,1.2},{14,1.2},{14,-12},{16,-12}},
        color={255,255,0},
        thickness=0.5));
    connect(Stator_pin, G13.Stator_pin) annotation (Line(points={{70,0.25},
            {80,0.25},{80,-12},{36,-12}},
                           color={28,108,200}));
    connect(G013_Regulator.Ut_pin, G13.Ut_pin) annotation (Line(
        points={{-8,-6.4},{-24,-6.4},{-24,22},{31.6,22},{31.6,-2}},
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
          Ellipse(
          extent={{-74,72},{72,-58}},
          lineColor={0,0,255}),
          Text(extent={{-44,54},{46,20}}, textString=
                                              "SM"),
          Text(extent={{-50,22},{50,-4}}, textString=
                                              "with"),
          Text(extent={{-76,104},{76,78}},  textString=
                                                "%name"),
          Text(extent={{-50,-20},{50,-30}}, textString=
                                               "ARV")},
        Ellipse(extent=[-74, 72; 72, -58]),
        Text(extent=[-44, 54; 46, 20], string="SM"),
        Text(extent=[-50, 22; 50, -4], string="with"),
        Text(extent=[-78, -58; 74, -84], string="%name"),
        Line(points=[80, 6; 72, 6]),
        Text(extent=[-50, -20; 50, -30], string="ARV")),
      Window(
        x=0.28,
        y=0.01,
        width=0.6,
        height=0.88));
  end Submodel5_1;
equation
  connect(L0102.out, node_2)
    annotation (Line(points={{4,20},{4,21},{9,21}},       color={28,108,200}));
  connect(node_2, L0203.inp)
    annotation (Line(points={{9,21},{12,21},{12,20},{14.2,20}},
                                                color={28,108,200}));
  connect(node_2, T0222.out)
    annotation (Line(points={{9,21},{9,-6.2}},
                                             color={28,108,200}));
  connect(L0203.out, node_3) annotation (Line(points={{34,20},{34,21},{39,
          21}}, color={28,108,200}));
  connect(node_3, L0304.inp)
    annotation (Line(points={{39,21},{46,21},{46,20},{50.2,20}},
                                                 color={28,108,200}));
  connect(N03.inp, node_3) annotation (Line(points={{64,40.2},{64,32},{39,
          32},{39,21}},
                   color={28,108,200}));
  connect(node_3, T0323.out) annotation (Line(points={{39,21},{39,6.5},{37,
          6.5},{37,-6.2}},
                    color={28,108,200}));
  connect(L0304.out, node_4) annotation (Line(points={{70,20},{74,20},{74,
          21},{77,21}},
                color={28,108,200}));
  connect(node_4, L0405.inp)
    annotation (Line(points={{77,21},{86,21},{86,20},{92.2,20}},
                                                 color={28,108,200}));
  connect(node_4, T0424.out) annotation (Line(points={{77,21},{76,21},{76,
          5.8},{91,5.8}},        color={28,108,200}));
  connect(L0405.out, node_5) annotation (Line(points={{112,20},{124,20},{
          124,21},{127,21}}, color={28,108,200}));
  connect(node_5, L0506.inp)
    annotation (Line(points={{127,21},{136,21},{136,20},{142.2,20}},
                                                   color={28,108,200}));
  connect(L0506.out, node_6) annotation (Line(points={{162,20},{162,21},{
          189,21}}, color={28,108,200}));
  connect(T0631.out, node_6) annotation (Line(points={{189,11.8},{189,21}},
                     color={28,108,200}));
  connect(node_6, L0607.inp)
    annotation (Line(points={{189,21},{204,21},{204,20},{216.2,20}},
                                                   color={28,108,200}));
  connect(N08.inp, node_8) annotation (Line(points={{280.2,-24},{280.2,-25},
          {265,-25}},
                 color={28,108,200}));
  connect(T0835.out, node_8) annotation (Line(points={{271,-32.2},{271,-31},
          {265,-31},{265,-25}},
                           color={28,108,200}));
  connect(L0708.out, node_8) annotation (Line(points={{246,-18},{246,-25},{
          265,-25}},  color={28,108,200}));
  connect(N10.inp, node_10) annotation (Line(points={{308,46.2},{307,46.2},
          {307,21}},
                color={28,108,200}));
  connect(L0910.out, node_10) annotation (Line(points={{302,20},{302,21},{
          307,21}},  color={28,108,200}));
  connect(node_10, L1011.inp)
    annotation (Line(points={{307,21},{312,21},{312,20},{314.2,20}},
                                                   color={28,108,200}));
  connect(node_11, L1112.inp)
    annotation (Line(points={{403,23},{408,23},{408,22},{410.2,22}},
                                                   color={28,108,200}));
  connect(node_11, T1140.out) annotation (Line(points={{403,23},{403,1.8}},
                          color={28,108,200}));
  connect(node_11, N11.inp) annotation (Line(points={{403,23},{403,34.5},{
          404,34.5},{404,46.2}},
                             color={28,108,200}));
  connect(node_11, L1011.out) annotation (Line(points={{403,23},{340,23},{
          340,20},{334,20}},   color={28,108,200}));
  connect(L1112.out, node_12) annotation (Line(points={{430,22},{430,23},{
          435,23}},  color={28,108,200}));
  connect(node_12, L1213.inp)
    annotation (Line(points={{435,23},{440,23},{440,22},{442.2,22}},
                                                   color={28,108,200}));
  connect(node_12, T1242.out)
    annotation (Line(points={{435,23},{435,1.8}},
                                                color={28,108,200}));
  connect(L1213.out, node_13) annotation (Line(points={{462,22},{462,23},{
          471,23}},  color={28,108,200}));
  connect(node_13, N13.inp) annotation (Line(points={{471,23},{494,23},{494,
          32.2}},      color={28,108,200}));
  connect(node_13, T1345.out)
    annotation (Line(points={{471,23},{489,23},{489,13.8}},
                                                          color={28,108,200}));
  connect(node_13, T1314.inp) annotation (Line(points={{471,23},{471,40.2}},
                                   color={28,108,200}));
  connect(T1314.out, node_14)
    annotation (Line(points={{471,59.8},{471,69}},
                                                 color={28,108,200}));
  connect(node_14, G13.Stator_pin) annotation (Line(points={{471,69},{452,
          69},{452,68},{443.75,68},{443.75,68.16}},
                                     color={28,108,200}));
  connect(G07.Stator_pin, node_15) annotation (Line(points={{178.16,48.32},
          {188,48.32},{188,49},{195,49}},
                            color={28,108,200}));
  connect(node_15, T0715.out) annotation (Line(points={{195,49},{208.2,49}},
                         color={28,108,200}));
  connect(T1623.inp, node_16)
    annotation (Line(points={{21,-83.8},{21,-89}},   color={28,108,200}));
  connect(G23.Stator_pin, node_16) annotation (Line(points={{4.27857,
          -88.8417},{4.27857,-89},{21,-89}},
                                    color={28,108,200}));
  connect(T1724.inp, node_17)
    annotation (Line(points={{121.8,-15},{127,-15}}, color={28,108,200}));
  connect(node_17, G24.Stator_pin) annotation (Line(points={{127,-15},{
          134.24,-15},{134.24,-16.28}},
                                    color={28,108,200}));
  connect(T0121.inp, node_21)
    annotation (Line(points={{-27,-25.8},{-27,-31}}, color={28,108,200}));
  connect(node_21, L2122.inp)
    annotation (Line(points={{-27,-31},{-22,-31},{-22,-32},{-19.8,-32}},
                                                     color={28,108,200}));
  connect(node_21, N21.inp) annotation (Line(points={{-27,-31},{-28,-31},{
          -28,-52.2}},
                   color={28,108,200}));
  connect(T0222.inp, node_22)
    annotation (Line(points={{9,-25.8},{9,-31}}, color={28,108,200}));
  connect(L2122.out, node_22) annotation (Line(points={{0,-32},{0,-31},{9,
          -31}}, color={28,108,200}));
  connect(node_22, L2223.inp)
    annotation (Line(points={{9,-31},{12,-31},{12,-32},{12.2,-32}},
                                                  color={28,108,200}));
  connect(node_22, N22.inp) annotation (Line(points={{9,-31},{9,-40.5},{8,
          -40.5},{8,-52.2}},
                      color={28,108,200}));
  connect(T0323.inp, node_23)
    annotation (Line(points={{37,-25.8},{37,-31}}, color={28,108,200}));
  connect(L2223.out, node_23) annotation (Line(points={{32,-32},{32,-31},{
          37,-31}},  color={28,108,200}));
  connect(T2351.out, node_23) annotation (Line(points={{38.2,-47},{38.2,-31},
          {37,-31}},               color={28,108,200}));
  connect(T1623.out, node_23) annotation (Line(points={{21,-64.2},{20,-64.2},
          {20,-50},{37,-50},{37,-31}},
                          color={28,108,200}));
  connect(N24.inp, node_24) annotation (Line(points={{71.8,-16},{72,-16},{
          72,-17},{91,-17}},
                          color={28,108,200}));
  connect(node_24, T1724.out) annotation (Line(points={{91,-17},{91,-15},{
          102.2,-15}},
                 color={28,108,200}));
  connect(T0424.inp, node_24)
    annotation (Line(points={{91,-13.8},{91,-17}}, color={28,108,200}));
  connect(node_24, T2452.out)
    annotation (Line(points={{91,-17},{91,-20.2}},
                                                 color={28,108,200}));
  connect(T0631.inp, node_31)
    annotation (Line(points={{189,-7.8},{189,-13}}, color={28,108,200}));
  connect(node_31, L3132.out) annotation (Line(points={{189,-13},{190,-13},
          {190,-14},{182,-14},{182,-16}},  color={28,108,200}));
  connect(L3132.inp, node_32)
    annotation (Line(points={{162.2,-16},{162.2,-42},{165,-42},{165,-45}},
                                                     color={28,108,200}));
  connect(T3253.out, node_32) annotation (Line(points={{161.8,-55},{161.8,
          -50},{165,-50},{165,-45}},
                           color={28,108,200}));
  connect(node_32, L3234.inp) annotation (Line(points={{165,-45},{176.5,-45},
          {176.5,-44},{184.2,-44}},color={28,108,200}));
  connect(L3233.inp, node_32) annotation (Line(points={{184.2,-60},{176.2,
          -60},{176.2,-45},{165,-45}},
                                  color={28,108,200}));
  connect(L3233.out, node_33) annotation (Line(points={{204,-60},{204,-59},
          {215,-59}}, color={28,108,200}));
  connect(node_33, L3334.inp)
    annotation (Line(points={{215,-59},{222,-59},{222,-60},{228.2,-60}},
                                                     color={28,108,200}));
  connect(node_33, N33.inp) annotation (Line(points={{215,-59},{216,-59},{
          216,-62},{224,-62},{224,-70.2}},
                                       color={28,108,200}));
  connect(node_33, L3347.out) annotation (Line(points={{215,-59},{215,-74.5},
          {206,-74.5},{206,-88}},      color={28,108,200}));
  connect(L3234.out, node_34) annotation (Line(points={{204,-44},{256,-44},
          {256,-52},{253,-52},{253,-59}}, color={28,108,200}));
  connect(L3334.out, node_34) annotation (Line(points={{248,-60},{248,-59},
          {253,-59}}, color={28,108,200}));
  connect(node_34, N34.inp) annotation (Line(points={{253,-59},{254,-59},{
          254,-62},{252,-62},{252,-66.2}},
                                       color={28,108,200}));
  connect(node_34, L3438.inp) annotation (Line(points={{253,-59},{274.5,-59},
          {274.5,-52},{294.2,-52}},color={28,108,200}));
  connect(node_35, N35.inp) annotation (Line(points={{271,-73},{272,-73},{
          272,-74},{288.2,-74}},
                             color={28,108,200}));
  connect(node_35, L3536.out) annotation (Line(points={{271,-73},{271,-78.5},
          {270,-78.5},{270,-84}},      color={28,108,200}));
  connect(node_35, T0835.inp)
    annotation (Line(points={{271,-73},{271,-51.8}}, color={28,108,200}));
  connect(L3536.inp, node_36) annotation (Line(points={{270,-103.8},{270,
          -112},{287,-112},{287,-121}},
                                  color={28,108,200}));
  connect(L3639.inp, node_36) annotation (Line(points={{306.2,-86},{306.2,
          -112},{287,-112},{287,-121}},
                                  color={28,108,200}));
  connect(T3655.out, node_36) annotation (Line(points={{263,-132.2},{262,
          -132.2},{262,-121},{287,-121}},
                                 color={28,108,200}));
  connect(N36.inp, node_36) annotation (Line(points={{288,-148.2},{288,-121},
          {287,-121}},            color={28,108,200}));
  connect(T3646.out, node_36) annotation (Line(points={{303,-120.2},{300,
          -121},{287,-121}},     color={28,108,200}));
  connect(T4853.inp, node_48)
    annotation (Line(points={{118.2,-109},{113,-109}}, color={28,108,200}));
  connect(G53.Stator_pin, node_48)
    annotation (Line(points={{98.16,-110},{106,-110},{106,-109},{113,-109}},
                                                        color={28,108,200}));
  connect(L5253.out, node_53) annotation (Line(points={{130,-48},{135,-48},
          {135,-71}},                    color={28,108,200}));
  connect(T3253.inp, node_53) annotation (Line(points={{142.2,-55},{142.2,
          -56},{136,-56},{136,-70},{135,-70},{135,-71}},
                                                    color={28,108,200}));
  connect(T4853.out, node_53) annotation (Line(points={{137.8,-109},{137.8,
          -94},{135,-94},{135,-71}},                color={28,108,200}));
  connect(N53.inp, node_53) annotation (Line(points={{166,-70.2},{148,-70.2},
          {148,-71},{135,-71}},color={28,108,200}));
  connect(L5354.inp, node_53) annotation (Line(points={{158.2,-96},{150.2,
          -96},{150.2,-71},{135,-71}},
                                  color={28,108,200}));
  connect(T2351.inp, node_51)
    annotation (Line(points={{57.8,-47},{63,-47}}, color={28,108,200}));
  connect(node_51, L5152.inp)
    annotation (Line(points={{63,-47},{66,-47},{66,-46},{66.2,-46}},
                                                   color={28,108,200}));
  connect(node_51, N51.inp) annotation (Line(points={{63,-47},{62,-47},{62,
          -54.2}}, color={28,108,200}));
  connect(L5152.out, node_52) annotation (Line(points={{86,-46},{88,-46},{
          88,-47},{91,-47}},           color={28,108,200}));
  connect(T2452.inp, node_52)
    annotation (Line(points={{91,-39.8},{91,-47}}, color={28,108,200}));
  connect(node_52, N52.inp) annotation (Line(points={{91,-47},{92,-47},{92,
          -54.2}},              color={28,108,200}));
  connect(node_52, L5253.inp) annotation (Line(points={{91,-47},{102,-47},{
          102,-48},{110.2,-48}},   color={28,108,200}));
  connect(G33.Stator_pin, node_47) annotation (Line(points={{222.04,
          -115.213},{222.04,-117},{205,-117}},
                                  color={28,108,200}));
  connect(node_47, L3347.inp)
    annotation (Line(points={{205,-117},{205,-112},{205,-107.8},{206,-107.8}},
                                                       color={28,108,200}));
  connect(node_54, L5455.inp)
    annotation (Line(points={{185,-149},{196,-149},{196,-150},{206.2,-150}},
                                                       color={28,108,200}));
  connect(node_54, N54.inp) annotation (Line(points={{185,-149},{186,-149},
          {186,-166.2}},                  color={28,108,200}));
  connect(node_54, L5354.out) annotation (Line(points={{185,-149},{186,-149},
          {186,-96},{178,-96}},      color={28,108,200}));
  connect(L5455.out, node_55) annotation (Line(points={{226,-150},{234,-150},
          {234,-149},{241,-149}},         color={28,108,200}));
  connect(node_55, N55.inp) annotation (Line(points={{241,-149},{242,-149},
          {242,-168.2}},                  color={28,108,200}));
  connect(node_55, T3655.inp) annotation (Line(points={{241,-149},{251.5,
          -149},{251.5,-151.8},{263,-151.8}},
                                        color={28,108,200}));
  connect(T3646.inp, node_46) annotation (Line(points={{303,-139.8},{303,
          -148},{315,-148},{315,-149}},
                       color={28,108,200}));
  connect(node_46, G36.Stator_pin) annotation (Line(points={{315,-149},{316,
          -149},{316,-147.213},{334.24,-147.213}},
                                         color={28,108,200}));
  connect(L3639.out, node_39) annotation (Line(points={{326,-86},{326,-85},
          {337,-85}}, color={28,108,200}));
  connect(node_39, N39.inp) annotation (Line(points={{337,-85},{338,-85},{
          338,-102.2}},
                    color={28,108,200}));
  connect(node_39, L3739.inp) annotation (Line(points={{337,-85},{338,-85},
          {338,-42},{338,-35.8},{338,-35.8}},
                                       color={28,108,200}));
  connect(node_39, L3839.inp) annotation (Line(points={{337,-85},{338,-85},
          {338,-86},{368,-86},{368,-73.8}},
                                       color={28,108,200}));
  connect(T0937.inp, node_37)
    annotation (Line(points={{317.8,-7},{337,-7}}, color={28,108,200}));
  connect(node_37, L3739.out) annotation (Line(points={{337,-7},{338,-7},{
          338,-16}},     color={28,108,200}));
  connect(node_37, N37.inp) annotation (Line(points={{337,-7},{338,-7},{338,
          2},{354,2},{354,0.2},{380,0.2}},
                                      color={28,108,200}));
  connect(node_37, L3738.out) annotation (Line(points={{337,-7},{338,-7},{
          338,-8},{366,-8},{366,-12},{368,-12}},
                                       color={28,108,200}));
  connect(node_38, L3738.inp)
    annotation (Line(points={{367,-51},{368,-51},{368,-40},{368,-31.8},{368,
          -31.8}},                                   color={28,108,200}));
  connect(node_38, L3839.out) annotation (Line(points={{367,-51},{368,-51},
          {368,-54}},    color={28,108,200}));
  connect(N38.inp, node_38) annotation (Line(points={{354,-56.2},{354,-51},
          {367,-51}},
                 color={28,108,200}));
  connect(L3438.out, node_38) annotation (Line(points={{314,-52},{354,-52},
          {354,-51},{367,-51}}, color={28,108,200}));
  connect(T1140.inp, node_40) annotation (Line(points={{403,-17.8},{403,-41}},
                               color={28,108,200}));
  connect(L3840.out, node_40) annotation (Line(points={{396,-42},{396,-41},
          {403,-41}}, color={28,108,200}));
  connect(node_40, N40.inp) annotation (Line(points={{403,-41},{404,-41},{
          404,-64.2}},                 color={28,108,200}));
  connect(node_40, L4042.inp)
    annotation (Line(points={{403,-41},{408,-41},{408,-42},{410.2,-42}},
                                                     color={28,108,200}));
  connect(T1345.inp, node_45) annotation (Line(points={{489,-5.8},{489,-19}},
                     color={28,108,200}));
  connect(node_45, L4445.out) annotation (Line(points={{489,-19},{488,-19},
          {488,-28},{494,-28},{494,-42},{496,-42}},  color={28,108,200}));
  connect(T4344.inp, node_43) annotation (Line(points={{495,-85.8},{495,-93}},
                      color={28,108,200}));
  connect(node_43, G44.Stator_pin) annotation (Line(points={{495,-93},{496,
          -93},{496,-108.873},{482,-108.873}},
                                        color={28,108,200}));
  connect(L4244.out, node_44) annotation (Line(points={{464,-42},{464,-41},
          {469,-41}}, color={28,108,200}));
  connect(node_44, L4445.inp)
    annotation (Line(points={{469,-41},{474,-41},{474,-42},{476.2,-42}},
                                                     color={28,108,200}));
  connect(node_44, N44.inp) annotation (Line(points={{469,-41},{470,-41},{
          470,-66.2}},
                   color={28,108,200}));
  connect(node_44, T4344.out) annotation (Line(points={{469,-41},{470,-41},
          {470,-58},{496,-58},{496,-66.2},{495,-66.2}},
                                 color={28,108,200}));
  connect(L4042.out, node_42) annotation (Line(points={{430,-42},{430,-41},
          {437,-41}}, color={28,108,200}));
  connect(node_42, N42.inp) annotation (Line(points={{437,-41},{438,-41},{
          438,-62.2}},
                   color={28,108,200}));
  connect(node_42, L4244.inp)
    annotation (Line(points={{437,-41},{438,-41},{438,-42},{454,-42},{454,
          -42},{444.2,-42}},                         color={28,108,200}));
  connect(L0103.out, node_3) annotation (Line(points={{16,48},{16,49.6},{39,
          49.6},{39,21}},    color={28,108,200}));
  connect(node_1, G01.Stator_pin) annotation (Line(points={{-27,21},{-34,21},
          {-34,33},{-40.42,33}},color={28,108,200}));
  connect(node_1, L0103.inp) annotation (Line(points={{-27,21},{-28,21},{
          -28,20},{-26,20},{-26,48},{-3.8,48}},
                     color={28,108,200}));
  connect(node_1, L0102.inp)
    annotation (Line(points={{-27,21},{-20,21},{-20,20},{-15.8,20}},
                                                   color={28,108,200}));
  connect(node_1, N01.inp) annotation (Line(points={{-27,21},{-27,13.5},{
          -40,13.5},{-40,7.8}},
                            color={28,108,200}));
  connect(node_1, T0121.out) annotation (Line(points={{-27,21},{-26,21},{
          -26,20},{-28,20},{-28,-6.2},{-27,-6.2}},
                          color={28,108,200}));
  connect(node_7, L0607.out) annotation (Line(points={{245,21},{245,20},{
          236,20}},     color={28,108,200}));
  connect(node_7, L0709_1.inp)
    annotation (Line(points={{245,21},{250,21},{250,20},{254.2,20}},
                                                   color={28,108,200}));
  connect(node_7, L0708.inp) annotation (Line(points={{245,21},{246,21},{
          246,8},{246,1.8},{246,1.8}},
                               color={28,108,200}));
  connect(node_7, L0709_2.inp) annotation (Line(points={{245,21},{246,21},{
          246,8},{248,8},{248,2},{254.2,2}},
                                         color={28,108,200}));
  connect(T0715.inp, node_7) annotation (Line(points={{227.8,49},{244,49},{
          244,38},{245,38},{245,21}},
                    color={28,108,200}));
  connect(N07.inp, node_7) annotation (Line(points={{244,62.2},{244,38},{
          245,38},{245,21}},
                     color={28,108,200}));
  connect(shortCircuitShunt.inp, node_7) annotation (Line(points={{260,46.2},
          {260,32},{245,32},{245,21}},color={28,108,200}));
  connect(node_9, L0709_1.out) annotation (Line(points={{277,21},{278,20},{
          274,20}},     color={28,108,200}));
  connect(node_9, L0910.inp)
    annotation (Line(points={{277,21},{280,21},{280,20},{282.2,20}},
                                                   color={28,108,200}));
  connect(node_9, N09.inp) annotation (Line(points={{277,21},{278,21},{278,
          46.2}},               color={28,108,200}));
  connect(node_9, L0709_2.out) annotation (Line(points={{277,21},{278,21},{
          278,2},{274,2},{274,2}},   color={28,108,200}));
  connect(shortCircuitShunt1.inp, node_7) annotation (Line(points={{270,
          46.2},{260,46.2},{260,32},{245,32},{245,21}},
                                                 color={28,108,200}));
  connect(N23.inp, node_23) annotation (Line(points={{36,-56.2},{37,-56.2},
          {37,-31}},
                 color={28,108,200}));
  connect(T0937.out, node_9) annotation (Line(points={{298.2,-7},{280,-7},{
          280,2},{277,2},{277,21}}, color={28,108,200}));
  connect(T5054.out, node_54)
    annotation (Line(points={{177.8,-149},{185,-149}},
                                                     color={28,108,200}));
  connect(G54.Stator_pin, node_18) annotation (Line(points={{141.842,
          -149.68},{141.842,-149},{151,-149}},
                                    color={28,108,200}));
  connect(node_18, T5054.inp) annotation (Line(points={{151,-149},{158.2,
          -149}}, color={28,108,200}));
  annotation (Diagram(coordinateSystem(extent={{-80,-200},{520,100}}),
        graphics={
        Text(
          extent={{-30,32},{-12,24}},
          textColor={0,0,255},
          textString="1"),
        Text(
          extent={{468,32},{486,24}},
          textColor={0,0,255},
          textString="13"),
        Text(
          extent={{30,32},{40,24}},
          textColor={0,0,255},
          textString="3"),
        Text(
          extent={{240,30},{258,22}},
          textColor={0,0,255},
          textString="7"),
        Text(
          extent={{264,32},{282,24}},
          textColor={0,0,255},
          textString="9"),
        Text(
          extent={{10,-22},{28,-30}},
          textColor={0,0,255},
          textString="22"),
        Text(
          extent={{38,-22},{56,-30}},
          textColor={0,0,255},
          textString="23"),
        Text(
          extent={{74,36},{84,28}},
          textColor={0,0,255},
          textString="4"),
        Text(
          extent={{56,-28},{74,-36}},
          textColor={0,0,255},
          textString="51"),
        Text(
          extent={{96,-34},{114,-42}},
          textColor={0,0,255},
          textString="52"),
        Text(
          extent={{70,-6},{88,-14}},
          textColor={0,0,255},
          textString="24"),
        Text(
          extent={{184,36},{194,28}},
          textColor={0,0,255},
          textString="6"),
        Text(
          extent={{116,-66},{134,-74}},
          textColor={0,0,255},
          textString="53"),
        Text(
          extent={{-46,-26},{-28,-34}},
          textColor={0,0,255},
          textString="21"),
        Text(
          extent={{0,32},{18,24}},
          textColor={0,0,255},
          textString="2"),
        Text(
          extent={{122,36},{132,28}},
          textColor={0,0,255},
          textString="5"),
        Text(
          extent={{148,-34},{166,-42}},
          textColor={0,0,255},
          textString="32"),
        Text(
          extent={{190,-8},{208,-16}},
          textColor={0,0,255},
          textString="31"),
        Text(
          extent={{206,-48},{224,-56}},
          textColor={0,0,255},
          textString="33"),
        Text(
          extent={{240,-48},{258,-56}},
          textColor={0,0,255},
          textString="34"),
        Text(
          extent={{182,-134},{200,-142}},
          textColor={0,0,255},
          textString="54"),
        Text(
          extent={{232,-138},{250,-146}},
          textColor={0,0,255},
          textString="55"),
        Text(
          extent={{262,-12},{280,-20}},
          textColor={0,0,255},
          textString="8"),
        Text(
          extent={{286,-102},{304,-110}},
          textColor={0,0,255},
          textString="36"),
        Text(
          extent={{256,-64},{274,-72}},
          textColor={0,0,255},
          textString="35"),
        Text(
          extent={{304,32},{322,24}},
          textColor={0,0,255},
          textString="10"),
        Text(
          extent={{336,-90},{354,-98}},
          textColor={0,0,255},
          textString="39"),
        Text(
          extent={{350,-40},{368,-48}},
          textColor={0,0,255},
          textString="38"),
        Text(
          extent={{336,0},{354,-8}},
          textColor={0,0,255},
          textString="37"),
        Text(
          extent={{384,34},{402,26}},
          textColor={0,0,255},
          textString="11"),
        Text(
          extent={{404,-30},{422,-38}},
          textColor={0,0,255},
          textString="40"),
        Text(
          extent={{438,-30},{456,-38}},
          textColor={0,0,255},
          textString="42"),
        Text(
          extent={{468,-28},{486,-36}},
          textColor={0,0,255},
          textString="44"),
        Text(
          extent={{486,-8},{504,-16}},
          textColor={0,0,255},
          textString="45"),
        Text(
          extent={{426,36},{444,28}},
          textColor={0,0,255},
          textString="12"),
        Text(
          extent={{476,-88},{494,-96}},
          textColor={0,0,255},
          textString="43"),
        Text(
          extent={{462,80},{480,72}},
          textColor={0,0,255},
          textString="14"),
        Text(
          extent={{186,64},{204,56}},
          textColor={0,0,255},
          textString="15"),
        Text(
          extent={{310,-136},{328,-144}},
          textColor={0,0,255},
          textString="46"),
        Text(
          extent={{104,-94},{122,-102}},
          textColor={0,0,255},
          textString="48"),
        Text(
          extent={{20,-84},{38,-92}},
          textColor={0,0,255},
          textString="16"),
        Text(
          extent={{118,0},{136,-8}},
          textColor={0,0,255},
          textString="17"),
        Text(
          extent={{188,-108},{206,-116}},
          textColor={0,0,255},
          textString="47"),
        Text(
          extent={{142,-134},{160,-142}},
          textColor={0,0,255},
          textString="50")}), Icon(coordinateSystem(extent={{-80,-200},{520,
            100}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{56,-212},{388,112}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{168,68},{358,-40},{168,-146},{168,68}})}),
    experiment(
      StopTime=80,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_Algorithm="Dassl"));
end KKT_base;
