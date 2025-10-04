within ;
package Examples

  model KKT_base
  Real delta_G07_G01, delta_G13_G01, delta_G23_G01, delta_G24_G01, delta_G33_G01, delta_G36_G01, delta_G44_G01, delta_G53_G01, delta_G54_G01;

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
    LEPSE.Basic.Constant_Conductivity_Load N01(Gn=52.89, Bn=-24.99)
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
      annotation (Placement(transformation(extent={{68,-62},{88,-42}})));
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
          origin={64,-16})));
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
    Submodel3 G54 "Niva HPP"
                  annotation (Placement(transformation(origin={-37.4642,
              33.3892},                                                    extent={{151.464,
              -199.389},{183.466,-167.389}})));
    Submodel4 G07 "Kolskaya NPP"
                  annotation (Placement(transformation(rotation=0, extent={{-16,-16},
              {16,16}},
          origin={166,48})));
    Submodel6 G44 "Serebryanskaya HPP-16"
                  annotation (Placement(transformation(rotation=0, extent={{-16,-17},
              {16,17}},
          origin={470,-109})));
    Submodel7 G53 "Knyazhegubskaya HPP"
                  annotation (Placement(transformation(rotation=0, extent={{70,-126},
              {102,-94}})));
    Submodel8 G36 "Apatitskaya TPP"
                  annotation (Placement(transformation(rotation=180,
                                                                   extent={{-16,-17},
              {16,17}},
          origin={346,-147})));
    Submodel9 G33 "Iovskaya + Kumskaya HPP"
                  annotation (Placement(transformation(rotation=180,
                                                                   extent={{-14,-17},
              {14,17}},
          origin={232,-115})));
    Submodel10 G01 "Petrozavodsk - infinite bus"
                   annotation (Placement(transformation(rotation=0, extent={{-17,-17},
              {17,17}},
          origin={-53,33})));
    Submodel1_1 G23 "Onda HPP"
                    annotation (Placement(transformation(
          rotation=0,
          extent={{-23,-19},{23,19}},
          origin={-11,-89})));
    Submodel2_1 G24 "Putkinskaya HPP"
                    annotation (Placement(transformation(
          rotation=180,
          extent={{-16,-16},{16,16}},
          origin={146,-16})));
    Submodel5_1 G13 "Serebryanskaya HPP-15"
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
    LEPSE.Basic.Node node_1 annotation (Placement(transformation(extent={{-30,
              18},{-24,24}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_2 annotation (Placement(transformation(extent={{6,
              18},{12,24}}), iconTransformation(extent={{-120,-100},{-100,-80}})));
    LEPSE.Basic.Node node_3 annotation (Placement(transformation(extent={{36,
              18},{42,24}}), iconTransformation(extent={{-120,-100},{-100,-80}})));
    LEPSE.Basic.Node node_4 annotation (Placement(transformation(extent={{74,
              18},{80,24}}), iconTransformation(extent={{-120,-100},{-100,-80}})));
    LEPSE.Basic.Node node_5 annotation (Placement(transformation(extent={{124,
              18},{130,24}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_6 annotation (Placement(transformation(extent={{186,
              18},{192,24}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_7 annotation (Placement(transformation(extent={{242,
              18},{248,24}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_8 annotation (Placement(transformation(extent={{262,
              -28},{268,-22}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_9 annotation (Placement(transformation(extent={{274,
              18},{280,24}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_10 annotation (Placement(transformation(extent={{
              304,18},{310,24}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_11 annotation (Placement(transformation(extent={{
              400,20},{406,26}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_12 annotation (Placement(transformation(extent={{
              432,20},{438,26}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_13 annotation (Placement(transformation(extent={{
              468,20},{474,26}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_14 annotation (Placement(transformation(extent={{
              468,66},{474,72}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_15 annotation (Placement(transformation(extent={{
              192,46},{198,52}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_16 annotation (Placement(transformation(extent={{18,
              -92},{24,-86}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_17 annotation (Placement(transformation(extent={{
              124,-18},{130,-12}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_21 annotation (Placement(transformation(extent={{-30,
              -34},{-24,-28}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_22 annotation (Placement(transformation(extent={{6,
              -34},{12,-28}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_23 annotation (Placement(transformation(extent={{34,
              -34},{40,-28}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_24 annotation (Placement(transformation(extent={{88,
              -20},{94,-14}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_31 annotation (Placement(transformation(extent={{
              186,-16},{192,-10}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_32 annotation (Placement(transformation(extent={{
              162,-48},{168,-42}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_33 annotation (Placement(transformation(extent={{
              212,-62},{218,-56}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_34 annotation (Placement(transformation(extent={{
              250,-62},{256,-56}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_35 annotation (Placement(transformation(extent={{
              268,-76},{274,-70}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_36 annotation (Placement(transformation(extent={{
              284,-124},{290,-118}}), iconTransformation(extent={{-120,-100},
              {-100,-80}})));
    LEPSE.Basic.Node node_48 annotation (Placement(transformation(extent={{110,
              -112},{116,-106}}),     iconTransformation(extent={{-120,-100},
              {-100,-80}})));
    LEPSE.Basic.Node node_53 annotation (Placement(transformation(extent={{
              132,-74},{138,-68}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_51 annotation (Placement(transformation(extent={{60,
              -50},{66,-44}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_52 annotation (Placement(transformation(extent={{88,
              -50},{94,-44}}), iconTransformation(extent={{-120,-100},{-100,
              -80}})));
    LEPSE.Basic.Node node_47 annotation (Placement(transformation(extent={{
              202,-120},{208,-114}}), iconTransformation(extent={{-120,-100},
              {-100,-80}})));
    LEPSE.Basic.Node node_54 annotation (Placement(transformation(extent={{
              182,-152},{188,-146}}), iconTransformation(extent={{-120,-100},
              {-100,-80}})));
    LEPSE.Basic.Node node_55 annotation (Placement(transformation(extent={{
              238,-152},{244,-146}}), iconTransformation(extent={{-120,-100},
              {-100,-80}})));
    LEPSE.Basic.Node node_46 annotation (Placement(transformation(extent={{
              312,-152},{318,-146}}), iconTransformation(extent={{-120,-100},
              {-100,-80}})));
    LEPSE.Basic.Node node_39 annotation (Placement(transformation(extent={{
              334,-88},{340,-82}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_37 annotation (Placement(transformation(extent={{
              334,-10},{340,-4}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_38 annotation (Placement(transformation(extent={{
              364,-54},{370,-48}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_40 annotation (Placement(transformation(extent={{
              400,-44},{406,-38}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_45 annotation (Placement(transformation(extent={{
              486,-22},{492,-16}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_43 annotation (Placement(transformation(extent={{
              492,-96},{498,-90}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_44 annotation (Placement(transformation(extent={{
              466,-44},{472,-38}}), iconTransformation(extent={{-120,-100},{
              -100,-80}})));
    LEPSE.Basic.Node node_42 annotation (Placement(transformation(extent={{
              434,-44},{440,-38}}), iconTransformation(extent={{-120,-100},{
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
      TkzOn=40,
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
    LEPSE.Basic.Node node_18 annotation (Placement(transformation(extent={{148,
              -152},{154,-146}}), iconTransformation(extent={{-120,-100},{-100,
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

    connect(L3840.inp, L3738.inp) annotation (Line(points={{378.4,-41},{378.4,-40},
            {367,-40},{367,-29.6}},     color={28,108,200}));

    connect(T1242.inp, L4042.out) annotation (Line(points={{435,-15.8},{435,
            -32},{436,-32},{436,-40.8},{427.8,-40.8}},
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
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
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
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
              rotation=0, extent={{65.5,-1.5},{82,10}}), iconTransformation(
              extent={{66,-6},{82,10}})));
    equation
      connect(G54.dUtr_pin,G54_Regulator. dV_pin) annotation (Line(
          points={{13.4,3.6},{17,3.6},{17,10},{-23,10},{-23,3},{-14.25,3}},
          color={255,255,0},
          thickness=0.5));
      connect(G54_Regulator.dV_pin,G54_Regulator. dV1_pin) annotation (Line(
          points={{-14.25,3},{-14.25,2},{-14,2},{-14.4,2},{-14.1,2},{-14.25,0}},
          color={255,255,0},
          thickness=0.5));
      connect(G54.dWu_pin,G54_Regulator. dfsys_pin) annotation (Line(
          points={{15.8,3.6},{15,3.6},{15,8},{-21,8},{-21,-3},{-14.25,-3}},
          color={255,255,0},
          thickness=0.5));
      connect(G54.dWf_pin,G54_Regulator. dfU_pin) annotation (Line(
          points={{18.2,3.6},{18.2,12},{-23,12},{-23,-6},{-14.25,-6}},
          color={255,255,0},
          thickness=0.5));
      connect(G54.dIf_pin,G54_Regulator. dif1_pin) annotation (Line(
          points={{20.8,3.6},{20.8,14},{-25,14},{-25,-9},{-14.25,-9}},
          color={255,255,0},
          thickness=0.5));
      connect(G54_Regulator.out_pin,G54. Ef_pin) annotation (Line(
          points={{4.08333,-2.8},{7,-2.8},{7,-3.8},{11,-3.8}},
          color={255,255,0},
          thickness=0.5));
      connect(Stator_pin, G54.Stator_pin)
        annotation (Line(points={{73.75,4.25},{73.75,-3.8},{26.8,-3.8}},
                                                        color={28,108,200}));
      connect(G54_Regulator.Ut_pin, G54.Ut_pin) annotation (Line(
          points={{-14.3333,-12},{-14.3333,-18},{-28,-18},{-28,16},{23.2,16},{
              23.2,3.6}},
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
            lineColor={28,108,200}),
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
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
              rotation=0, extent={{-90.5,-17},{-72,2}}), iconTransformation(
              extent={{66,-8},{86,12}})));
    equation
      connect(G07.dUtr_pin,G07_Regulator. dV_pin) annotation (Line(
          points={{11.4,-2.4},{13,-2.4},{13,18},{-27,18},{-27,10},{-18.4167,
              10}},
          color={255,255,0},
          thickness=0.5));
      connect(G07_Regulator.dV_pin,G07_Regulator. dV1_pin) annotation (Line(
          points={{-18.4167,10},{-18.4167,10},{-18.25,10},{-18.25,8}},
          color={255,255,0},
          thickness=0.5));
      connect(G07.dWu_pin,G07_Regulator. dfsys_pin) annotation (Line(
          points={{13.8,-2.4},{11,-2.4},{11,16},{-25,16},{-25,5},{-18.25,5}},
          color={255,255,0},
          thickness=0.5));
      connect(G07.dWf_pin,G07_Regulator. dfU_pin) annotation (Line(
          points={{16.2,-2.4},{16.2,20},{-27,20},{-27,2},{-18.25,2}},
          color={255,255,0},
          thickness=0.5));
      connect(G07.dIf_pin,G07_Regulator. dif1_pin) annotation (Line(
          points={{18.8,-2.4},{18.8,22},{-29,22},{-29,-0.4},{-18.25,-0.4}},
          color={255,255,0},
          thickness=0.5));
      connect(G07_Regulator.out_pin,G07. Ef_pin) annotation (Line(
          points={{0.0833333,5.2},{3,5.2},{3,-9.8},{9,-9.8}},
          color={255,255,0},
          thickness=0.5));
      connect(Stator_pin, G07.Stator_pin) annotation (Line(points={{-81.25,-7.5},
              {-82,-7.5},{-82,-28},{30,-28},{30,-9.8},{24.8,-9.8}},
                                        color={28,108,200}));
      connect(G07_Regulator.Ut_pin, G07.Ut_pin) annotation (Line(
          points={{-18.1667,-2.4},{-18.1667,-10},{-32,-10},{-32,24},{21.2,24},
              {21.2,-2.4}},
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
            lineColor={28,108,200}),
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
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
              rotation=0, extent={{-161,-7.5},{-146,8}}), iconTransformation(
              extent={{66,-8},{84,9.5}})));
    equation
      connect(G44.dUtr_pin,G44_Regulator. dV_pin) annotation (Line(
          points={{-10.4,-2.6},{-12,-2.6},{-12,-12},{30,-12},{30,-4},{25.25,-4}},
          color={255,255,0},
          thickness=0.5));
      connect(G44_Regulator.dV_pin,G44_Regulator. dV1_pin) annotation (Line(
          points={{25.25,-4},{25.25,-1}},
          color={255,255,0},
          thickness=0.5));
      connect(G44.dWu_pin,G44_Regulator. dfsys_pin) annotation (Line(
          points={{-12.8,-2.6},{-10,-2.6},{-10,-14},{32,-14},{32,2},{25.25,2}},
          color={255,255,0},
          thickness=0.5));
      connect(G44.dWf_pin,G44_Regulator. dfU_pin) annotation (Line(
          points={{-15.2,-2.6},{-18,-2.6},{-18,-16},{34,-16},{34,5},{25.25,5}},
          color={255,255,0},
          thickness=0.5));
      connect(G44.dIf_pin,G44_Regulator. dif1_pin) annotation (Line(
          points={{-17.8,-2.6},{-16,-2.6},{-16,-18},{36,-18},{36,8},{25.25,8}},
          color={255,255,0},
          thickness=0.5));
      connect(G44_Regulator.out_pin,G44. Ef_pin) annotation (Line(
          points={{6.91667,1.8},{6.91667,4.8},{-8,4.8}},
          color={255,255,0},
          thickness=0.5));
      connect(Stator_pin, G44.Stator_pin) annotation (Line(points={{-153.5,0.25},
              {-32,0.25},{-32,4.8},{-23.8,4.8}},
                            color={28,108,200}));
      connect(G44_Regulator.Ut_pin, G44.Ut_pin) annotation (Line(
          points={{25.3333,11},{25.3333,10},{38,10},{38,-20},{-20.2,-20},{-20.2,
              -2.6}},
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
            lineColor={28,108,200}),
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
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
              rotation=0, extent={{66,-10},{86,10}}), iconTransformation(
              extent={{66,-10},{86,10}})));
    equation
      connect(G53.dUtr_pin,G53_Regulator. dV_pin) annotation (Line(
          points={{-5.6,1.6},{-2,1.6},{-2,8},{-42,8},{-42,0},{-33.4167,0}},
          color={255,255,0},
          thickness=0.5));
      connect(G53_Regulator.dV_pin,G53_Regulator. dV1_pin) annotation (Line(
          points={{-33.4167,0},{-33.4167,0},{-34,0},{-33.4,0},{-33.25,0},{
              -33.25,-2}},
          color={255,255,0},
          thickness=0.5));
      connect(G53.dWu_pin,G53_Regulator. dfsys_pin) annotation (Line(
          points={{-3.2,1.6},{-4,1.6},{-4,6},{-40,6},{-40,-5},{-33.25,-5}},
          color={255,255,0},
          thickness=0.5));
      connect(G53.dWf_pin,G53_Regulator. dfU_pin) annotation (Line(
          points={{-0.8,1.6},{-0.8,10},{-42,10},{-42,-8},{-33.25,-8}},
          color={255,255,0},
          thickness=0.5));
      connect(G53.dIf_pin,G53_Regulator. dif1_pin) annotation (Line(
          points={{1.8,1.6},{1.8,12},{-44,12},{-44,-10.4},{-33.25,-10.4}},
          color={255,255,0},
          thickness=0.5));
      connect(G53_Regulator.out_pin,G53. Ef_pin) annotation (Line(
          points={{-14.9167,-4.8},{-12,-4.8},{-12,-5.8},{-8,-5.8}},
          color={255,255,0},
          thickness=0.5));
      connect(Stator_pin, G53.Stator_pin) annotation (Line(points={{76,0},{14,0},
              {14,-5.8},{7.8,-5.8}},        color={28,108,200}));
      connect(G53_Regulator.Ut_pin, G53.Ut_pin) annotation (Line(
          points={{-33.1667,-12.4},{-46,-12.4},{-46,14},{4.2,14},{4.2,1.6}},
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
            lineColor={28,108,200}),
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
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
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
          points={{-43.8,-0.6},{-42,-0.6},{-42,-16},{24,-16},{24,10},{13.25,10}},
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
          points={{13.3333,13},{13.3333,12},{18,12},{18,22},{-60,22},{-60,-6},{
              -46.2,-6},{-46.2,-0.6}},
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
            lineColor={28,108,200}),
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
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
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
          points={{-40.8,-2.6},{-38,-2.6},{-38,-6},{-42,-6},{-42,-16},{22,-16},{
              22,14},{12.25,14}},
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
          points={{12.3333,17},{12.3333,24},{-56,24},{-56,2},{-54,2},{-54,-8},{
              -43.2,-8},{-43.2,-2.6}},
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
            lineColor={28,108,200}),
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
        K0w=0,
        K1w=0) annotation (Placement(transformation(
            extent={{-13,-13},{13,13}},
            rotation=0,
            origin={-71,39})));
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
              rotation=0, extent={{64,-10},{84,10}}), iconTransformation(
              extent={{64,-10},{84,10}})));
    equation
      connect(G01.dUtr_pin,G01_Regulator. dV_pin) annotation (Line(
          points={{-51.6,29.6},{-52,29.6},{-52,56},{-88,56},{-88,46.8},{
              -83.2417,46.8}},
          color={255,255,0},
          thickness=0.5));
      connect(G01_Regulator.dV_pin,G01_Regulator. dV1_pin) annotation (Line(
          points={{-83.2417,46.8},{-82.92,46.8},{-82.92,44.2},{-83.025,44.2}},
          color={255,255,0},
          thickness=0.5));
      connect(G01.dWu_pin,G01_Regulator. dfsys_pin) annotation (Line(
          points={{-49.2,29.6},{-48,29.6},{-48,54},{-84,54},{-84,40.3},{-83.025,
              40.3}},
          color={255,255,0},
          thickness=0.5));
      connect(G01.dWf_pin,G01_Regulator. dfU_pin) annotation (Line(
          points={{-46.8,29.6},{-46.8,58},{-90,58},{-90,36.4},{-83.025,36.4}},
          color={255,255,0},
          thickness=0.5));
      connect(G01.dIf_pin,G01_Regulator. dif1_pin) annotation (Line(
          points={{-44.2,29.6},{-44.2,60},{-92,60},{-92,33.28},{-83.025,33.28}},
          color={255,255,0},
          thickness=0.5));
      connect(G01_Regulator.out_pin,G01. Ef_pin) annotation (Line(
          points={{-59.1917,40.56},{-60,40.56},{-60,22.2},{-54,22.2}},
          color={255,255,0},
          thickness=0.5));
      connect(Stator_pin, G01.Stator_pin)
        annotation (Line(points={{74,0},{-30,0},{-30,22.2},{-38.2,22.2}},
                                                          color={28,108,200}));
      connect(G01_Regulator.Ut_pin, G01.Ut_pin) annotation (Line(
          points={{-82.9167,30.68},{-94,30.68},{-94,62},{-41.8,62},{-41.8,
              29.6}},
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
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
            rotation=180,
            extent={{-8,-8},{8,8}},
            origin={-132,4}), iconTransformation(extent={{64,-8},{82,10}})));
    equation
      connect(G23.dUtr_pin,G23_Regulator. dV_pin) annotation (Line(
          points={{-9.4,-1.6},{-9.4,-12},{19,-12},{19,-3},{16.25,-3}},
          color={255,255,0},
          thickness=0.5));
      connect(G23_Regulator.dV_pin,G23_Regulator. dV1_pin) annotation (Line(
          points={{16.25,-3},{14.1,-3},{14.1,0},{16.25,0}},
          color={255,255,0},
          thickness=0.5));
      connect(G23.dWu_pin,G23_Regulator. dfsys_pin) annotation (Line(
          points={{-11.8,-1.6},{-11.8,-14},{21,-14},{21,3},{16.25,3}},
          color={255,255,0},
          thickness=0.5));
      connect(G23.dWf_pin,G23_Regulator. dfU_pin) annotation (Line(
          points={{-14.2,-1.6},{-14.2,-16},{23,-16},{23,6},{16.25,6}},
          color={255,255,0},
          thickness=0.5));
      connect(G23.dIf_pin,G23_Regulator. dif1_pin) annotation (Line(
          points={{-16.8,-1.6},{-16.8,-18},{25,-18},{25,6},{16.25,6},{16.25,9}},
          color={255,255,0},
          thickness=0.5));
      connect(G23_Regulator.out_pin,G23. Ef_pin) annotation (Line(
          points={{-2.08333,2.8},{-5,2.8},{-5,2},{-7,2},{-7,5.8}},
          color={255,255,0},
          thickness=0.5));
      connect(Stator_pin, G23.Stator_pin)
        annotation (Line(points={{-132,4},{-30,4},{-30,5.8},{-22.8,5.8}},
                                       color={28,108,200}));
      connect(G23_Regulator.Ut_pin, G23.Ut_pin) annotation (Line(
          points={{16.3333,12},{16.3333,18},{30,18},{30,-20},{-19.2,-20},{-19.2,
              -1.6}},
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
            lineColor={28,108,200}),
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
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
              rotation=0, extent={{71,1.5},{77,7.5}}), iconTransformation(
              extent={{65,-6.5},{82,10}})));
    equation
      connect(G24.dUtr_pin,G24_Regulator. dV_pin) annotation (Line(
          points={{-24.4,-9.6},{-24.4,-16},{20,-16},{20,1},{15.25,1}},
          color={255,255,0},
          thickness=0.5));
      connect(G24_Regulator.dV_pin,G24_Regulator. dV1_pin) annotation (Line(
          points={{15.25,1},{15.25,2},{16,2},{15.4,2},{15.1,2},{15.25,4}},
          color={255,255,0},
          thickness=0.5));
      connect(G24.dWu_pin,G24_Regulator. dfsys_pin) annotation (Line(
          points={{-26.8,-9.6},{-24,-9.6},{-24,-18},{22,-18},{22,7},{15.25,7}},
          color={255,255,0},
          thickness=0.5));
      connect(G24.dWf_pin,G24_Regulator. dfU_pin) annotation (Line(
          points={{-29.2,-9.6},{-32,-9.6},{-32,-20},{24,-20},{24,10},{15.25,10}},
          color={255,255,0},
          thickness=0.5));
      connect(G24.dIf_pin,G24_Regulator. dif1_pin) annotation (Line(
          points={{-31.8,-9.6},{-31.8,-22},{26,-22},{26,13},{15.25,13}},
          color={255,255,0},
          thickness=0.5));
      connect(G24_Regulator.out_pin,G24. Ef_pin) annotation (Line(
          points={{-3.08333,6.8},{-16,6.8},{-16,-2.2},{-22,-2.2}},
          color={255,255,0},
          thickness=0.5));
      connect(Stator_pin, G24.Stator_pin) annotation (Line(points={{74,4.5},{74,
              -26},{-44,-26},{-44,-2.2},{-37.8,-2.2}},
                                       color={28,108,200}));
      connect(G24_Regulator.Ut_pin, G24.Ut_pin) annotation (Line(
          points={{15.3333,16},{28,16},{28,-24},{-34.2,-24},{-34.2,-9.6}},
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
            lineColor={28,108,200}),
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
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
              rotation=0, extent={{59,-6.5},{81,7}}), iconTransformation(
              extent={{66,-8},{84,10}})));
    equation
      connect(G13.dUtr_pin,G013_Regulator. dV_pin) annotation (Line(
          points={{20.4,-4.4},{24,-4.4},{24,16},{-16,16},{-16,9},{-7.25,9}},
          color={255,255,0},
          thickness=0.5));
      connect(G013_Regulator.dV_pin,G013_Regulator. dV1_pin) annotation (Line(
          points={{-7.25,9},{-7.25,8},{-8,8},{-7.4,8},{-7.1,8},{-7.25,6}},
          color={255,255,0},
          thickness=0.5));
      connect(G13.dWu_pin,G013_Regulator. dfsys_pin) annotation (Line(
          points={{22.8,-4.4},{22,-4.4},{22,14},{-14,14},{-14,3},{-7.25,3}},
          color={255,255,0},
          thickness=0.5));
      connect(G13.dWf_pin,G013_Regulator. dfU_pin) annotation (Line(
          points={{25.2,-4.4},{25.2,16},{-20,16},{-20,0},{-7.25,0}},
          color={255,255,0},
          thickness=0.5));
      connect(G13.dIf_pin,G013_Regulator. dif1_pin) annotation (Line(
          points={{27.8,-4.4},{27.8,20},{-18,20},{-18,-3},{-7.25,-3}},
          color={255,255,0},
          thickness=0.5));
      connect(G013_Regulator.out_pin,G13. Ef_pin) annotation (Line(
          points={{11.0833,3.2},{14,3.2},{14,-11.8},{18,-11.8}},
          color={255,255,0},
          thickness=0.5));
      connect(Stator_pin, G13.Stator_pin) annotation (Line(points={{70,0.25},{80,
              0.25},{80,-11.8},{33.8,-11.8}},
                             color={28,108,200}));
      connect(G013_Regulator.Ut_pin, G13.Ut_pin) annotation (Line(
          points={{-7.33333,-6},{-24,-6},{-24,22},{30.2,22},{30.2,-4.4}},
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
            lineColor={28,108,200}),
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
    end Submodel5_1;
  equation
    connect(L0102.out, node_2)
      annotation (Line(points={{1.8,21.2},{1.8,21},{9,21}}, color={28,108,200}));
    connect(node_2, L0203.inp)
      annotation (Line(points={{9,21},{16.4,21}}, color={28,108,200}));
    connect(node_2, T0222.out)
      annotation (Line(points={{9,21},{9,-8}}, color={28,108,200}));
    connect(L0203.out, node_3) annotation (Line(points={{31.8,21.2},{31.8,21},{39,
            21}}, color={28,108,200}));
    connect(node_3, L0304.inp)
      annotation (Line(points={{39,21},{52.4,21}}, color={28,108,200}));
    connect(N03.inp, node_3) annotation (Line(points={{64,41.4},{64,32},{39,32},{
            39,21}}, color={28,108,200}));
    connect(node_3, T0323.out) annotation (Line(points={{39,21},{39,6.5},{37,6.5},
            {37,-8}}, color={28,108,200}));
    connect(L0304.out, node_4) annotation (Line(points={{67.8,21.2},{62,21},{77,
            21}}, color={28,108,200}));
    connect(node_4, L0405.inp)
      annotation (Line(points={{77,21},{94.4,21}}, color={28,108,200}));
    connect(node_4, T0424.out) annotation (Line(points={{77,21},{76,21},{76,4},{
            91,4}},                color={28,108,200}));
    connect(L0405.out, node_5) annotation (Line(points={{109.8,21.2},{124,21.2},{
            124,21},{127,21}}, color={28,108,200}));
    connect(node_5, L0506.inp)
      annotation (Line(points={{127,21},{144.4,21}}, color={28,108,200}));
    connect(L0506.out, node_6) annotation (Line(points={{159.8,21.2},{162,21},{
            189,21}}, color={28,108,200}));
    connect(T0631.out, node_6) annotation (Line(points={{189,10},{189,21}},
                       color={28,108,200}));
    connect(node_6, L0607.inp)
      annotation (Line(points={{189,21},{218.4,21}}, color={28,108,200}));
    connect(N08.inp, node_8) annotation (Line(points={{281.4,-24},{282,-25},{265,
            -25}}, color={28,108,200}));
    connect(T0835.out, node_8) annotation (Line(points={{271,-34},{271,-31},{265,
            -31},{265,-25}}, color={28,108,200}));
    connect(L0708.out, node_8) annotation (Line(points={{247.2,-15.8},{247.2,-25},
            {265,-25}}, color={28,108,200}));
    connect(N10.inp, node_10) annotation (Line(points={{308,47.4},{307,46},{307,
            21}}, color={28,108,200}));
    connect(L0910.out, node_10) annotation (Line(points={{299.8,21.2},{299.8,21},
            {307,21}}, color={28,108,200}));
    connect(node_10, L1011.inp)
      annotation (Line(points={{307,21},{316.4,21}}, color={28,108,200}));
    connect(node_11, L1112.inp)
      annotation (Line(points={{403,23},{412.4,23}}, color={28,108,200}));
    connect(node_11, T1140.out) annotation (Line(points={{403,23},{403,0}},
                            color={28,108,200}));
    connect(node_11, N11.inp) annotation (Line(points={{403,23},{403,34.5},{
            404,34.5},{404,47.4}},
                               color={28,108,200}));
    connect(node_11, L1011.out) annotation (Line(points={{403,23},{340,23},{340,
            21.2},{331.8,21.2}}, color={28,108,200}));
    connect(L1112.out, node_12) annotation (Line(points={{427.8,23.2},{427.8,23},
            {435,23}}, color={28,108,200}));
    connect(node_12, L1213.inp)
      annotation (Line(points={{435,23},{444.4,23}}, color={28,108,200}));
    connect(node_12, T1242.out)
      annotation (Line(points={{435,23},{435,0}}, color={28,108,200}));
    connect(L1213.out, node_13) annotation (Line(points={{459.8,23.2},{459.8,23},
            {471,23}}, color={28,108,200}));
    connect(node_13, N13.inp) annotation (Line(points={{471,23},{494,23},{494,
            33.4}},      color={28,108,200}));
    connect(node_13, T1345.out)
      annotation (Line(points={{471,23},{489,23},{489,12}}, color={28,108,200}));
    connect(node_13, T1314.inp) annotation (Line(points={{471,23},{471,42.2}},
                                     color={28,108,200}));
    connect(T1314.out, node_14)
      annotation (Line(points={{471,58},{471,69}}, color={28,108,200}));
    connect(node_14, G13.Stator_pin) annotation (Line(points={{471,69},{452,
            69},{452,68},{443.75,68},{443.75,68.16}},
                                       color={28,108,200}));
    connect(G07.Stator_pin, node_15) annotation (Line(points={{178.16,48.32},
            {188,48.32},{188,49},{195,49}},
                              color={28,108,200}));
    connect(node_15, T0715.out) annotation (Line(points={{195,49},{210,49}},
                           color={28,108,200}));
    connect(T1623.inp, node_16)
      annotation (Line(points={{21,-81.8},{21,-89}},   color={28,108,200}));
    connect(G23.Stator_pin, node_16) annotation (Line(points={{4.27857,-88.8417},
            {4.27857,-89},{21,-89}},  color={28,108,200}));
    connect(T1724.inp, node_17)
      annotation (Line(points={{119.8,-15},{127,-15}}, color={28,108,200}));
    connect(node_17, G24.Stator_pin) annotation (Line(points={{127,-15},{
            134.24,-15},{134.24,-16.28}},
                                      color={28,108,200}));
    connect(T0121.inp, node_21)
      annotation (Line(points={{-27,-23.8},{-27,-31}}, color={28,108,200}));
    connect(node_21, L2122.inp)
      annotation (Line(points={{-27,-31},{-17.6,-31}}, color={28,108,200}));
    connect(node_21, N21.inp) annotation (Line(points={{-27,-31},{-28,-31},{-28,
            -53.4}}, color={28,108,200}));
    connect(T0222.inp, node_22)
      annotation (Line(points={{9,-23.8},{9,-31}}, color={28,108,200}));
    connect(L2122.out, node_22) annotation (Line(points={{-2.2,-30.8},{-2.2,-31},
            {9,-31}},
                   color={28,108,200}));
    connect(node_22, L2223.inp)
      annotation (Line(points={{9,-31},{14.4,-31}}, color={28,108,200}));
    connect(node_22, N22.inp) annotation (Line(points={{9,-31},{9,-40.5},{8,-40.5},
            {8,-53.4}}, color={28,108,200}));
    connect(T0323.inp, node_23)
      annotation (Line(points={{37,-23.8},{37,-31}}, color={28,108,200}));
    connect(L2223.out, node_23) annotation (Line(points={{29.8,-30.8},{29.8,-31},
            {37,-31}}, color={28,108,200}));
    connect(T2351.out, node_23) annotation (Line(points={{40,-47},{40,-31},{37,
            -31}},                   color={28,108,200}));
    connect(T1623.out, node_23) annotation (Line(points={{21,-66},{20,-66},{20,
            -50},{37,-50},{37,-31}},
                            color={28,108,200}));
    connect(N24.inp, node_24) annotation (Line(points={{72.6,-16},{72,-16},{72,
            -17},{91,-17}}, color={28,108,200}));
    connect(node_24, T1724.out) annotation (Line(points={{91,-17},{92,-15},{104,
            -15}}, color={28,108,200}));
    connect(T0424.inp, node_24)
      annotation (Line(points={{91,-11.8},{91,-17}}, color={28,108,200}));
    connect(node_24, T2452.out)
      annotation (Line(points={{91,-17},{91,-22}}, color={28,108,200}));
    connect(T0631.inp, node_31)
      annotation (Line(points={{189,-5.8},{189,-13}}, color={28,108,200}));
    connect(node_31, L3132.out) annotation (Line(points={{189,-13},{190,-13},
            {190,-14},{179.8,-14},{179.8,-14.8}},
                                             color={28,108,200}));
    connect(L3132.inp, node_32)
      annotation (Line(points={{164.4,-15},{164.4,-42},{165,-42},{165,-45}},
                                                       color={28,108,200}));
    connect(T3253.out, node_32) annotation (Line(points={{160,-55},{160,-50},{165,
            -50},{165,-45}}, color={28,108,200}));
    connect(node_32, L3234.inp) annotation (Line(points={{165,-45},{176.5,-45},{
            176.5,-43},{186.4,-43}}, color={28,108,200}));
    connect(L3233.inp, node_32) annotation (Line(points={{186.4,-59},{176.2,-59},
            {176.2,-45},{165,-45}}, color={28,108,200}));
    connect(L3233.out, node_33) annotation (Line(points={{201.8,-58.8},{201.8,-59},
            {215,-59}}, color={28,108,200}));
    connect(node_33, L3334.inp)
      annotation (Line(points={{215,-59},{230.4,-59}}, color={28,108,200}));
    connect(node_33, N33.inp) annotation (Line(points={{215,-59},{216,-59},{
            216,-62},{224,-62},{224,-71.4}},
                                         color={28,108,200}));
    connect(node_33, L3347.out) annotation (Line(points={{215,-59},{215,-74.5},{
            204.8,-74.5},{204.8,-90.2}}, color={28,108,200}));
    connect(L3234.out, node_34) annotation (Line(points={{201.8,-42.8},{256,-42.8},
            {256,-52},{253,-52},{253,-59}}, color={28,108,200}));
    connect(L3334.out, node_34) annotation (Line(points={{245.8,-58.8},{245.8,-59},
            {253,-59}}, color={28,108,200}));
    connect(node_34, N34.inp) annotation (Line(points={{253,-59},{254,-59},{254,
            -62},{252,-62},{252,-67.4}}, color={28,108,200}));
    connect(node_34, L3438.inp) annotation (Line(points={{253,-59},{274.5,-59},{
            274.5,-51},{296.4,-51}}, color={28,108,200}));
    connect(node_35, N35.inp) annotation (Line(points={{271,-73},{272,-73},{272,
            -74},{289.4,-74}}, color={28,108,200}));
    connect(node_35, L3536.out) annotation (Line(points={{271,-73},{271,-78.5},{
            268.8,-78.5},{268.8,-86.2}}, color={28,108,200}));
    connect(node_35, T0835.inp)
      annotation (Line(points={{271,-73},{271,-49.8}}, color={28,108,200}));
    connect(L3536.inp, node_36) annotation (Line(points={{269,-101.6},{269,-112},
            {287,-112},{287,-121}}, color={28,108,200}));
    connect(L3639.inp, node_36) annotation (Line(points={{308.4,-85},{308.4,-112},
            {287,-112},{287,-121}}, color={28,108,200}));
    connect(T3655.out, node_36) annotation (Line(points={{263,-134},{262,-134},{
            262,-121},{287,-121}}, color={28,108,200}));
    connect(N36.inp, node_36) annotation (Line(points={{288,-149.4},{288,-121},
            {287,-121}},            color={28,108,200}));
    connect(T3646.out, node_36) annotation (Line(points={{303,-122},{300,-121},{
            287,-121}},            color={28,108,200}));
    connect(T4853.inp, node_48)
      annotation (Line(points={{120.2,-109},{113,-109}}, color={28,108,200}));
    connect(G53.Stator_pin, node_48)
      annotation (Line(points={{98.16,-110},{106,-110},{106,-109},{113,-109}},
                                                          color={28,108,200}));
    connect(L5253.out, node_53) annotation (Line(points={{127.8,-46.8},{135,-46.8},
            {135,-71}},                    color={28,108,200}));
    connect(T3253.inp, node_53) annotation (Line(points={{144.2,-55},{144.2,-56},
            {136,-56},{136,-70},{135,-70},{135,-71}}, color={28,108,200}));
    connect(T4853.out, node_53) annotation (Line(points={{136,-109},{136,-94},
            {135,-94},{135,-71}},                     color={28,108,200}));
    connect(N53.inp, node_53) annotation (Line(points={{166,-71.4},{148,-71.4},{
            148,-71},{135,-71}}, color={28,108,200}));
    connect(L5354.inp, node_53) annotation (Line(points={{160.4,-95},{150.2,-95},
            {150.2,-71},{135,-71}}, color={28,108,200}));
    connect(T2351.inp, node_51)
      annotation (Line(points={{55.8,-47},{63,-47}}, color={28,108,200}));
    connect(node_51, L5152.inp)
      annotation (Line(points={{63,-47},{70.4,-47}}, color={28,108,200}));
    connect(node_51, N51.inp) annotation (Line(points={{63,-47},{62,-47},{62,
            -55.4}}, color={28,108,200}));
    connect(L5152.out, node_52) annotation (Line(points={{85.8,-46.8},{85.8,-46},
            {88,-46},{88,-47},{91,-47}}, color={28,108,200}));
    connect(T2452.inp, node_52)
      annotation (Line(points={{91,-37.8},{91,-47}}, color={28,108,200}));
    connect(node_52, N52.inp) annotation (Line(points={{91,-47},{92,-47},{92,
            -55.4}},              color={28,108,200}));
    connect(node_52, L5253.inp) annotation (Line(points={{91,-47},{112.4,-47}},
                                     color={28,108,200}));
    connect(G33.Stator_pin, node_47) annotation (Line(points={{221.535,-115.213},
            {221.535,-117},{205,-117}},
                                    color={28,108,200}));
    connect(node_47, L3347.inp)
      annotation (Line(points={{205,-117},{205,-105.6}}, color={28,108,200}));
    connect(node_54, L5455.inp)
      annotation (Line(points={{185,-149},{208.4,-149}}, color={28,108,200}));
    connect(node_54, N54.inp) annotation (Line(points={{185,-149},{186,-149},{186,
            -167.4}},                       color={28,108,200}));
    connect(node_54, L5354.out) annotation (Line(points={{185,-149},{186,-149},{
            186,-94.8},{175.8,-94.8}}, color={28,108,200}));
    connect(L5455.out, node_55) annotation (Line(points={{223.8,-148.8},{234,
            -148.8},{234,-149},{241,-149}}, color={28,108,200}));
    connect(node_55, N55.inp) annotation (Line(points={{241,-149},{242,-149},{242,
            -169.4}},                       color={28,108,200}));
    connect(node_55, T3655.inp) annotation (Line(points={{241,-149},{251.5,-149},
            {251.5,-149.8},{263,-149.8}}, color={28,108,200}));
    connect(T3646.inp, node_46) annotation (Line(points={{303,-137.8},{303,-148},
            {315,-148},{315,-149}},
                         color={28,108,200}));
    connect(node_46, G36.Stator_pin) annotation (Line(points={{315,-149},{316,
            -149},{316,-147.213},{334.24,-147.213}},
                                           color={28,108,200}));
    connect(L3639.out, node_39) annotation (Line(points={{323.8,-84.8},{323.8,-85},
            {337,-85}}, color={28,108,200}));
    connect(node_39, N39.inp) annotation (Line(points={{337,-85},{338,-85},{338,
            -103.4}}, color={28,108,200}));
    connect(node_39, L3739.inp) annotation (Line(points={{337,-85},{338,-85},{338,
            -42},{337,-42},{337,-33.6}}, color={28,108,200}));
    connect(node_39, L3839.inp) annotation (Line(points={{337,-85},{338,-85},{338,
            -86},{367,-86},{367,-71.6}}, color={28,108,200}));
    connect(T0937.inp, node_37)
      annotation (Line(points={{315.8,-7},{337,-7}}, color={28,108,200}));
    connect(node_37, L3739.out) annotation (Line(points={{337,-7},{336.8,-7},{
            336.8,-18.2}}, color={28,108,200}));
    connect(node_37, N37.inp) annotation (Line(points={{337,-7},{338,-7},{338,
            2},{354,2},{354,1.4},{380,1.4}},
                                        color={28,108,200}));
    connect(node_37, L3738.out) annotation (Line(points={{337,-7},{338,-7},{338,
            -8},{366,-8},{366,-14.2},{366.8,-14.2}},
                                         color={28,108,200}));
    connect(node_38, L3738.inp)
      annotation (Line(points={{367,-51},{368,-51},{368,-40},{367,-40},{367,-29.6}},
                                                       color={28,108,200}));
    connect(node_38, L3839.out) annotation (Line(points={{367,-51},{366.8,-51},{
            366.8,-56.2}}, color={28,108,200}));
    connect(N38.inp, node_38) annotation (Line(points={{354,-57.4},{354,-51},{367,
            -51}}, color={28,108,200}));
    connect(L3438.out, node_38) annotation (Line(points={{311.8,-50.8},{354,-50.8},
            {354,-51},{367,-51}}, color={28,108,200}));
    connect(T1140.inp, node_40) annotation (Line(points={{403,-15.8},{403,-41}},
                                 color={28,108,200}));
    connect(L3840.out, node_40) annotation (Line(points={{393.8,-40.8},{393.8,-41},
            {403,-41}}, color={28,108,200}));
    connect(node_40, N40.inp) annotation (Line(points={{403,-41},{404,-41},{404,
            -65.4}},                     color={28,108,200}));
    connect(node_40, L4042.inp)
      annotation (Line(points={{403,-41},{412.4,-41}}, color={28,108,200}));
    connect(T1345.inp, node_45) annotation (Line(points={{489,-3.8},{489,-19}},
                       color={28,108,200}));
    connect(node_45, L4445.out) annotation (Line(points={{489,-19},{488,-19},{488,
            -28},{494,-28},{494,-40.8},{493.8,-40.8}}, color={28,108,200}));
    connect(T4344.inp, node_43) annotation (Line(points={{495,-83.8},{495,-93}},
                        color={28,108,200}));
    connect(node_43, G44.Stator_pin) annotation (Line(points={{495,-93},{496,
            -93},{496,-108.873},{482,-108.873}},
                                          color={28,108,200}));
    connect(L4244.out, node_44) annotation (Line(points={{461.8,-40.8},{461.8,-41},
            {469,-41}}, color={28,108,200}));
    connect(node_44, L4445.inp)
      annotation (Line(points={{469,-41},{478.4,-41}}, color={28,108,200}));
    connect(node_44, N44.inp) annotation (Line(points={{469,-41},{470,-41},{470,
            -67.4}}, color={28,108,200}));
    connect(node_44, T4344.out) annotation (Line(points={{469,-41},{470,-41},{470,
            -58},{496,-58},{496,-68},{495,-68}},
                                   color={28,108,200}));
    connect(L4042.out, node_42) annotation (Line(points={{427.8,-40.8},{427.8,
            -41},{437,-41}},
                        color={28,108,200}));
    connect(node_42, N42.inp) annotation (Line(points={{437,-41},{438,-41},{438,
            -63.4}}, color={28,108,200}));
    connect(node_42, L4244.inp)
      annotation (Line(points={{437,-41},{438,-41},{438,-42},{454,-42},{454,-41},
            {446.4,-41}},                              color={28,108,200}));
    connect(L0103.out, node_3) annotation (Line(points={{13.8,49.2},{13.8,49.6},{
            39,49.6},{39,21}}, color={28,108,200}));
    connect(node_1, G01.Stator_pin) annotation (Line(points={{-27,21},{-34,21},
            {-34,33},{-40.42,33}},color={28,108,200}));
    connect(node_1, L0103.inp) annotation (Line(points={{-27,21},{-28,21},{-28,20},
            {-26,20},{-26,49},{-1.6,49}},
                       color={28,108,200}));
    connect(node_1, L0102.inp)
      annotation (Line(points={{-27,21},{-13.6,21}}, color={28,108,200}));
    connect(node_1, N01.inp) annotation (Line(points={{-27,21},{-27,13.5},{-40,
            13.5},{-40,6.6}}, color={28,108,200}));
    connect(node_1, T0121.out) annotation (Line(points={{-27,21},{-26,21},{-26,20},
            {-28,20},{-28,-8},{-27,-8}},
                            color={28,108,200}));
    connect(node_7, L0607.out) annotation (Line(points={{245,21},{245,21.2},{
            233.8,21.2}}, color={28,108,200}));
    connect(node_7, L0709_1.inp)
      annotation (Line(points={{245,21},{256.4,21}}, color={28,108,200}));
    connect(node_7, L0708.inp) annotation (Line(points={{245,21},{246,21},{246,8},
            {247,8},{247,-0.4}}, color={28,108,200}));
    connect(node_7, L0709_2.inp) annotation (Line(points={{245,21},{246,21},{246,
            8},{248,8},{248,3},{256.4,3}}, color={28,108,200}));
    connect(T0715.inp, node_7) annotation (Line(points={{225.8,49},{244,49},{244,
            38},{245,38},{245,21}},
                      color={28,108,200}));
    connect(N07.inp, node_7) annotation (Line(points={{244,63.4},{244,38},{245,38},
            {245,21}}, color={28,108,200}));
    connect(shortCircuitShunt.inp, node_7) annotation (Line(points={{260,51.2},{
            260,32},{245,32},{245,21}}, color={28,108,200}));
    connect(node_9, L0709_1.out) annotation (Line(points={{277,21},{278,21.2},{
            271.8,21.2}}, color={28,108,200}));
    connect(node_9, L0910.inp)
      annotation (Line(points={{277,21},{284.4,21}}, color={28,108,200}));
    connect(node_9, N09.inp) annotation (Line(points={{277,21},{278,21},{278,47.4}},
                                  color={28,108,200}));
    connect(node_9, L0709_2.out) annotation (Line(points={{277,21},{278,21},{278,
            2},{271.8,2},{271.8,3.2}}, color={28,108,200}));
    connect(shortCircuitShunt1.inp, node_7) annotation (Line(points={{270,51.2},{
            260,51.2},{260,32},{245,32},{245,21}}, color={28,108,200}));
    connect(N23.inp, node_23) annotation (Line(points={{36,-57.4},{37,-57.4},{37,
            -31}}, color={28,108,200}));
    connect(T0937.out, node_9) annotation (Line(points={{300,-7},{280,-7},{
            280,2},{277,2},{277,21}}, color={28,108,200}));
    connect(T5054.out, node_54)
      annotation (Line(points={{176,-149},{185,-149}}, color={28,108,200}));
    connect(G54.Stator_pin, node_18) annotation (Line(points={{141.842,-149.68},
            {141.842,-149},{151,-149}},
                                      color={28,108,200}));
    connect(node_18, T5054.inp) annotation (Line(points={{151,-149},{160.2,
            -149}}, color={28,108,200}));
    annotation (Diagram(coordinateSystem(extent={{-80,-200},{520,100}}),
          graphics={
          Text(
            extent={{-30,32},{-12,24}},
            textColor={28,108,200},
            textString="1"),
          Text(
            extent={{468,32},{486,24}},
            textColor={28,108,200},
            textString="13"),
          Text(
            extent={{30,32},{40,24}},
            textColor={28,108,200},
            textString="3"),
          Text(
            extent={{240,30},{258,22}},
            textColor={28,108,200},
            textString="7"),
          Text(
            extent={{264,32},{282,24}},
            textColor={28,108,200},
            textString="9"),
          Text(
            extent={{10,-22},{28,-30}},
            textColor={28,108,200},
            textString="22"),
          Text(
            extent={{38,-22},{56,-30}},
            textColor={28,108,200},
            textString="23"),
          Text(
            extent={{74,36},{84,28}},
            textColor={28,108,200},
            textString="4"),
          Text(
            extent={{56,-28},{74,-36}},
            textColor={28,108,200},
            textString="51"),
          Text(
            extent={{96,-34},{114,-42}},
            textColor={28,108,200},
            textString="52"),
          Text(
            extent={{70,-6},{88,-14}},
            textColor={28,108,200},
            textString="24"),
          Text(
            extent={{184,36},{194,28}},
            textColor={28,108,200},
            textString="6"),
          Text(
            extent={{116,-66},{134,-74}},
            textColor={28,108,200},
            textString="53"),
          Text(
            extent={{-46,-26},{-28,-34}},
            textColor={28,108,200},
            textString="21"),
          Text(
            extent={{0,32},{18,24}},
            textColor={28,108,200},
            textString="2"),
          Text(
            extent={{122,36},{132,28}},
            textColor={28,108,200},
            textString="5"),
          Text(
            extent={{148,-34},{166,-42}},
            textColor={28,108,200},
            textString="32"),
          Text(
            extent={{190,-8},{208,-16}},
            textColor={28,108,200},
            textString="31"),
          Text(
            extent={{206,-48},{224,-56}},
            textColor={28,108,200},
            textString="33"),
          Text(
            extent={{240,-48},{258,-56}},
            textColor={28,108,200},
            textString="34"),
          Text(
            extent={{182,-134},{200,-142}},
            textColor={28,108,200},
            textString="54"),
          Text(
            extent={{232,-138},{250,-146}},
            textColor={28,108,200},
            textString="55"),
          Text(
            extent={{262,-12},{280,-20}},
            textColor={28,108,200},
            textString="8"),
          Text(
            extent={{286,-102},{304,-110}},
            textColor={28,108,200},
            textString="36"),
          Text(
            extent={{256,-64},{274,-72}},
            textColor={28,108,200},
            textString="35"),
          Text(
            extent={{304,32},{322,24}},
            textColor={28,108,200},
            textString="10"),
          Text(
            extent={{336,-90},{354,-98}},
            textColor={28,108,200},
            textString="39"),
          Text(
            extent={{350,-40},{368,-48}},
            textColor={28,108,200},
            textString="38"),
          Text(
            extent={{336,0},{354,-8}},
            textColor={28,108,200},
            textString="37"),
          Text(
            extent={{384,34},{402,26}},
            textColor={28,108,200},
            textString="11"),
          Text(
            extent={{404,-30},{422,-38}},
            textColor={28,108,200},
            textString="40"),
          Text(
            extent={{438,-30},{456,-38}},
            textColor={28,108,200},
            textString="42"),
          Text(
            extent={{468,-28},{486,-36}},
            textColor={28,108,200},
            textString="44"),
          Text(
            extent={{486,-8},{504,-16}},
            textColor={28,108,200},
            textString="45"),
          Text(
            extent={{426,36},{444,28}},
            textColor={28,108,200},
            textString="12"),
          Text(
            extent={{476,-88},{494,-96}},
            textColor={28,108,200},
            textString="43"),
          Text(
            extent={{462,80},{480,72}},
            textColor={28,108,200},
            textString="14"),
          Text(
            extent={{186,64},{204,56}},
            textColor={28,108,200},
            textString="15"),
          Text(
            extent={{310,-136},{328,-144}},
            textColor={28,108,200},
            textString="46"),
          Text(
            extent={{104,-94},{122,-102}},
            textColor={28,108,200},
            textString="48"),
          Text(
            extent={{20,-84},{38,-92}},
            textColor={28,108,200},
            textString="16"),
          Text(
            extent={{118,0},{136,-8}},
            textColor={28,108,200},
            textString="17"),
          Text(
            extent={{188,-108},{206,-116}},
            textColor={28,108,200},
            textString="47"),
          Text(
            extent={{142,-134},{160,-142}},
            textColor={28,108,200},
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
        StopTime=50,
        __Dymola_NumberOfIntervals=5000,
        __Dymola_Algorithm="Dassl"));
  end KKT_base;

  model KKT_1
    extends KKT_base(
      G53(G53_Regulator(
          K0u=-25.0,
          K0w=-3.211230714427489,
          K1if=4.987126045520432,
          K1u=-0.03537261038284817,
          K1w=-0.08784683862035261,
          Tforcedelay=0.0,
          Udeforc=0.89,
          ExcitationCurrent(x(start={-0.1043613851070404})),
          FrequencyBlockD(x(start={1.1517162322998047})),
          FrequencyBlockU(x(start={-0.8305912613868713})),
          FrequencyDerivative(x(start={1.1511017084121704})),
          FrequencyDeviation(x(start={1.1279988288879395})),
          SimpleExciter(x(start={-0.6285141706466675})),
          VoltageDerivative(x(start={0.022006390616297722})),
          VoltageDeviation(x(start={0.022006560117006302}))), G53(
          Kemax=2.5,
          DGi(start=60.021297454833984),
          Mu(start=0.09682215005159378),
          Yr(start=1.0511822700500488),
          Yrd(start=0.7649115920066833),
          Yrq(start=0.46064552664756775),
          s(start=0.002335949335247278))),
      N01(Gn=52.65, Bn=-26.4705),
      G01(G01(
          Pg=54.8714,
          Qg=26.5754,
          R1d_p=0.0001,
          R1q_p=0.000312,
          Rf_p=0.0008526259442905095,
          Tj_p=5.5700005656090985,
          Kemax=4,
          Kemin=0,
          DGi(start=60.42387008666992),
          Mu(start=54.82222366333008),
          Yr(start=1.0153467655181885),
          Yrd(start=0.9130327701568604),
          Yrq(start=0.6691593527793884),
          s(start=0.0023359504994004965),
          X1d_p=0.004828647396654221,
          X2d_p=0.004511958717023997,
          X2q_p=0.004020448867772941,
          Xd_p=0.04045753112755976,
          Xq_p=0.040889902430265274,
          Xs_p=0.003624845902948991), G01_Regulator(
          Tforcedelay=0.2,
          DL0=0,
          ExcitationCurrent(x(start={0.5856958627700806})),
          FrequencyBlockD(x(start={1.1517162322998047})),
          FrequencyBlockU(x(start={-0.8058086633682251})),
          FrequencyDerivative(x(start={1.1510953903198242})),
          FrequencyDeviation(x(start={1.127982258796692})),
          SimpleExciter(x(start={0.021572770550847054})),
          VoltageDerivative(x(start={-0.002152442466467619})),
          VoltageDeviation(x(start={-0.002152440370991826})),
          K0u=-9.99999913830246,
          K0w=-0.00025411566331470797,
          K1if=0.00026453812300699205,
          K1u=0.7799990525410792,
          K1w=0.0022730645851822178)),
      N07(Gn=0.65, Bn=-0.047),
      N10(
        TloadOff=40,
        dTloadOff=200,
        Koff=0.1),
      N09(Gn=0.08, Bn=-0.05),
      G07(G07(
          Qg=0.154,
          R1d_p=0.00035,
          R1q_p=0.000312,
          Kemax=5.0,
          Kemin=0.0,
          DGi(start=60.50016784667969),
          Mu(start=1.2808219194412231),
          Yr(start=0.6578963994979858),
          Yrd(start=0.5265114903450012),
          Yrq(start=0.8774608373641968),
          s(start=0.002335957484319806),
          Rf_p=0.0004352785916344514,
          Tj_p=22.770003806768155,
          X1d_p=0.16590193327059977,
          X2d_p=0.10992163285341909,
          X2q_p=0.10988105954865722,
          Xd_p=1.3140024241675932,
          Xq_p=1.3140105177829655,
          Xs_p=0.08201989737281001), G07_Regulator(
          K0w=-2.0000019475600297,
          K1if=7.061970714497031E-07,
          K1u=-10.000000021838456,
          K1w=1.999995254991324,
          Uforc=0.85,
          Udeforc=0.95,
          Tforcedelay=0.20000016118902114,
          ExcitationCurrent(x(start={-0.23709604144096375})),
          FrequencyBlockD(x(start={1.1517162322998047})),
          FrequencyBlockU(x(start={-0.9059736728668213})),
          FrequencyDerivative(x(start={1.151121735572815})),
          FrequencyDeviation(x(start={1.1279946565628052})),
          SimpleExciter(x(start={-0.29291802644729614})),
          VoltageDerivative(x(start={0.0029328784439712763})),
          VoltageDeviation(x(start={0.002933202311396599})),
          K0u=-100.00000006290571)),
      shortCircuitShunt(
        Bn=-11.6,
        Gn=-5.0,
        TkzOn=40,
        dTkzOn=0.14),
      L0709_1(
        Rline=0.0207,
        Xline=0.1792,
        Bline1=0.11695,
        Bline2=0.11695,
        TLineOff=1000,
        TLineOff_1=1000,
        dTLineOff_1=100,
        Koff_1=10000,
        dTLineOff=100,
        Koff=10000),
      L0709_2(
        Rline=0.0244,
        Xline=0.1960,
        Bline1=0.01435,
        Bline2=0.01435,
        TLineOff=40.14,
        dTLineOff=3.86,
        TLineOff_1=44,
        dTLineOff_1=100,
        Koff_1=10000),
      shortCircuitShunt1(
        Bn=-2.8,
        Gn=-0.5,
        TkzOn=44,
        dTkzOn=0.14),
      G36(G36_Regulator(
          Udeforc=0.95,
          Uforc=0.9,
          Tforcedelay=0.0,
          ExcitationCurrent(x(start={0.016833703964948654})),
          FrequencyBlockD(x(start={1.1517162322998047})),
          FrequencyBlockU(x(start={-0.982319176197052})),
          FrequencyDerivative(x(start={1.1515076160430908})),
          FrequencyDeviation(x(start={1.1279584169387817})),
          SimpleExciter(x(start={0.11641521751880646})),
          VoltageDerivative(x(start={-0.004655877128243446})),
          VoltageDeviation(x(start={-0.0046553402207791805}))),G36(
          DGi(start=59.87337875366211),
          Mu(start=0.055422309786081314),
          Yr(start=1.1766911745071411),
          Yrd(start=1.0695711374282837),
          Yrq(start=0.21794836223125458),
          s(start=0.0023359411861747503))),
      G13(G013_Regulator(
          Tforcedelay=0.0,
          Udeforc=0.85,
          ExcitationCurrent(x(start={-0.02965462952852249})),
          FrequencyBlockD(x(start={1.1517162322998047})),
          FrequencyBlockU(x(start={-0.9705310463905334})),
          FrequencyDerivative(x(start={1.151123285293579})),
          FrequencyDeviation(x(start={1.1279881000518799})),
          SimpleExciter(x(start={-0.3663289546966553})),
          VoltageDerivative(x(start={0.014653553254902363})),
          VoltageDeviation(x(start={0.01465385127812624}))),  G13(
          DGi(start=59.84128189086914),
          Mu(start=0.017822138965129852),
          Yr(start=1.1381173133850098),
          Yrd(start=0.974499523639679),
          Yrq(start=0.13942864537239075),
          s(start=0.002335949568077922))),
      G23(G23(
          Kemax=2.5,
          DGi(start=59.6690559387207),
          Mu(start=-0.0011778916232287884),
          Yr(start=1.492082118988037),
          Yrd(start=1.0052151679992676),
          Yrq(start=-4.260668706734805E-09),
          s(start=0.00233595073223114)), G23_Regulator(
          Tforcedelay=0.0,
          Udeforc=0.89,
          ExcitationCurrent(x(start={-0.026883678510785103})),
          FrequencyBlockD(x(start={1.1517162322998047})),
          FrequencyBlockU(x(start={-0.966542661190033})),
          FrequencyDerivative(x(start={1.151098370552063})),
          FrequencyDeviation(x(start={1.1279879808425903})),
          SimpleExciter(x(start={-0.26276153326034546})),
          VoltageDerivative(x(start={0.01051065232604742})),
          VoltageDeviation(x(start={0.010510796681046486})))),
      G24(G24(
          Kemax=2.5,
          DGi(start=59.70985412597656),
          Mu(start=-0.007977891713380814),
          Yr(start=1.5458375215530396),
          Yrd(start=1.0276553630828857),
          Yrq(start=-4.244277373999239E-09),
          s(start=0.00233595073223114)), G24_Regulator(
          Udeforc=0.89,
          ExcitationCurrent(x(start={-0.03618727996945381})),
          FrequencyBlockD(x(start={1.1517162322998047})),
          FrequencyBlockU(x(start={-1.0042787790298462})),
          FrequencyDerivative(x(start={1.151092290878296})),
          FrequencyDeviation(x(start={1.1279881000518799})),
          SimpleExciter(x(start={-0.5219812393188477})),
          VoltageDerivative(x(start={0.020879467949271202})),
          VoltageDeviation(x(start={0.020879637449979782})))),
      G33(G33(
          Kemax=2.5,
          DGi(start=59.85411071777344),
          Mu(start=0.11182212084531784),
          Yr(start=1.1574627161026),
          Yrd(start=0.9387310147285461),
          Yrq(start=0.28565365076065063),
          s(start=0.002335950266569853)), G33_Regulator(
          Tforcedelay=0.0,
          Udeforc=0.89,
          ExcitationCurrent(x(start={-0.06674576550722122})),
          FrequencyBlockD(x(start={1.1517162322998047})),
          FrequencyBlockU(x(start={-0.7606729865074158})),
          FrequencyDerivative(x(start={1.1510778665542603})),
          FrequencyDeviation(x(start={1.1280059814453125})),
          SimpleExciter(x(start={-0.2997623682022095})),
          VoltageDerivative(x(start={0.011991152539849281})),
          VoltageDeviation(x(start={0.011991636827588081})))),
      G44(G44_Regulator(
          Tforcedelay=0.0,
          Udeforc=0.85,
          ExcitationCurrent(x(start={-0.03380870074033737})),
          FrequencyBlockD(x(start={1.1517162322998047})),
          FrequencyBlockU(x(start={-0.9794394373893738})),
          FrequencyDerivative(x(start={1.1511064767837524})),
          FrequencyDeviation(x(start={1.1279877424240112})),
          SimpleExciter(x(start={-0.19987063109874725})),
          VoltageDerivative(x(start={0.007995096035301685})),
          VoltageDeviation(x(start={0.007995303720235825}))), G44(
          DGi(start=59.54927444458008),
          Mu(start=0.002822121139615774),
          Yr(start=1.1456183195114136),
          Yrd(start=0.9770076870918274),
          Yrq(start=0.010378217324614525),
          s(start=0.002335950266569853))),
      G54(G54(
          Kemax=2.5,
          DGi(start=59.86378479003906),
          Mu(start=0.13882212340831757),
          Yr(start=1.6088000535964966),
          Yrd(start=1.0226554870605469),
          Yrq(start=0.28313297033309937),
          s(start=0.00233595073223114)), G54_Regulator(
          Udeforc=0.89,
          ExcitationCurrent(x(start={-0.034668728709220886})),
          FrequencyBlockD(x(start={1.1517162322998047})),
          FrequencyBlockU(x(start={-0.9444510340690613})),
          FrequencyDerivative(x(start={1.151116967201233})),
          FrequencyDeviation(x(start={1.1279876232147217})),
          SimpleExciter(x(start={-0.14671242237091064})),
          VoltageDerivative(x(start={0.0058691417798399925})),
          VoltageDeviation(x(start={0.00586961954832077})))),
      N03(Gn=0),
      N21(dTloadOff=10),
      N52(dTloadOff=10),
      delta_G07_G01(start=-0.21962551772594452),
      delta_G13_G01(start=0.9002338647842407),
      delta_G23_G01(start=0.9554550647735596),
      delta_G24_G01(start=0.9906964898109436),
      delta_G33_G01(start=0.3973860442638397),
      delta_G36_G01(start=0.7514634132385254),
      delta_G44_G01(start=0.977094292640686),
      delta_G53_G01(start=0.21178215742111206),
      delta_G54_G01(start=0.48529040813446045));
  equation
    connect(T0937.out, node_9) annotation (Line(points={{300,-7},{280,-7},{
            280,2},{277,2},{277,21}}, color={28,108,200}));
    annotation (experiment(
        StopTime=65,
        __Dymola_NumberOfIntervals=10000,
        Tolerance=1e-06,
        __Dymola_Algorithm="Dassl"), __Dymola_Commands(editCall=
            Design.Experimentation.MonteCarloAnalysis(
            Design.Internal.Records.ModelUncertainSetup(
              Model="KKT_1_AVR_G53_opt",
              uncertainParameters={Design.Internal.Records.UncertainParameter(
                name="G01.G01_Regulator.K0w", Distributions=
                Design.Experimentation.RandomNumber.Functions.setFunctionData.randomUniform(
                -2, 2)),Design.Internal.Records.UncertainParameter(name=
                "G01.G01_Regulator.K1w", Distributions=
                Design.Experimentation.RandomNumber.Functions.setFunctionData.randomUniform(
                -2, 2)),Design.Internal.Records.UncertainParameter(name=
                "G01.G01_Regulator.K1u", Distributions=
                Design.Experimentation.RandomNumber.Functions.setFunctionData.randomUniform(
                -2, 2)),Design.Internal.Records.UncertainParameter(name=
                "G01.G01_Regulator.K1if", Distributions=
                Design.Experimentation.RandomNumber.Functions.setFunctionData.randomUniform(
                -1, 1))},
              observedVariables={Design.Internal.Records.ObservedVariable(name=
                "L0709_1.P1")},
              integrator=Design.Internal.Records.Integrator(
                startTime=0,
                stopTime=50,
                numberOfIntervals=5000,
                outputInterval=0,
                method="Dassl",
                tolerance=1e-06,
                fixedStepSize=0),
              outputToCSV=true),
            totalNumberOfSamples=10) "Sweep1",
        editCall=Design.Calibration.calibrate(
            Design.Internal.Records.ModelCalibrationSetup(
              Model="KKT_1_AVR_G53_init",
              tunerParameters={Design.Internal.Records.TunerParameter(
                name="G07.G07.Xd_p",
                active=false,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xq_p",
                active=false,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xs_p",
                active=false,
                Value=0.082,
                min=0.0574,
                max=0.1066),Design.Internal.Records.TunerParameter(
                name="G07.G07.X1d_p",
                active=false,
                Value=0.166,
                min=0.1162,
                max=0.2158),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2d_p",
                active=false,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2q_p",
                active=false,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.Rf_p",
                active=false,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1d_p",
                active=false,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1q_p",
                active=false,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G07.G07.Tj_p",
                active=true,
                Value=19.712,
                min=13.7984,
                max=25.6256),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemax",
                active=false,
                Value=2.5,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemin",
                active=false,
                Value=-0.6,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0u",
                Value=-25,
                min=-100,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1u",
                Value=-1,
                min=-10,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0w",
                Value=-2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1w",
                Value=2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1if",
                Value=0,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Udeforc",
                active=false,
                Value=0.95,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Tforcedelay",
                active=false,
                Value=0.1,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xd_p",
                active=false,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xq_p",
                active=false,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xs_p",
                active=false,
                Value=0.0036,
                min=0.00252,
                max=0.00468),Design.Internal.Records.TunerParameter(
                name="G01.G01.X1d_p",
                active=false,
                Value=0.0055,
                min=0.00385,
                max=0.00715),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2d_p",
                active=false,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2q_p",
                active=false,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.Rf_p",
                active=false,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1d_p",
                active=false,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1q_p",
                active=false,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G01.G01.Tj_p",
                Value=378.88,
                min=10,
                max=492.544),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemax",
                active=false,
                Value=2,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemin",
                active=false,
                Value=-0.6,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0u",
                Value=-25,
                min=-30,
                max=-20),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1u",
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0w",
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1w",
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1if",
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Udeforc",
                active=false,
                Value=0.9,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Tforcedelay",
                active=false,
                Value=0,
                min=0,
                max=0.2)},
              calibrationData=Design.Calibration.Internal.Dynamic_common(
                Design.Internal.Records.DynamicCommonCalibrationCases(
                  experimentNames={"E:/Dymola_new/Work_4/Data.csv"},
                  task={2},
                  startTime={39.9},
                  stopTime={43.9}),
                resultCouplings={
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.P1", data="P_L0709_1")}),
              integrator=Design.Internal.Records.CalibrationIntegrator(
                startTime=39.9,
                stopTime=43.9,
                method="Rkfix4"))) "Calibrate_with_init",
        editCall=Design.Calibration.calibrate(
            Design.Internal.Records.ModelCalibrationSetup(
              Model="KKT_1_AVR_G53_init",
              tunerParameters={Design.Internal.Records.TunerParameter(
                name="G07.G07.Xd_p",
                active=false,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xq_p",
                active=false,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xs_p",
                active=false,
                Value=0.082,
                min=0.0574,
                max=0.1066),Design.Internal.Records.TunerParameter(
                name="G07.G07.X1d_p",
                active=false,
                Value=0.166,
                min=0.1162,
                max=0.2158),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2d_p",
                active=false,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2q_p",
                active=false,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.Rf_p",
                active=false,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1d_p",
                active=false,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1q_p",
                active=false,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G07.G07.Tj_p",
                active=true,
                Value=19.712,
                min=13.7984,
                max=39),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemax",
                active=false,
                Value=2.5,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemin",
                active=false,
                Value=-1,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0u",
                active=true,
                Value=-23,
                min=-100,
                max=10),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1u",
                active=true,
                Value=-25,
                min=-30,
                max=-5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0w",
                active=true,
                Value=-15,
                min=-20,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1w",
                active=true,
                Value=5,
                min=-8,
                max=10),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1if",
                active=true,
                Value=-11,
                min=-15,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Udeforc",
                active=false,
                Value=0.95,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Tforcedelay",
                active=false,
                Value=0.1,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xd_p",
                active=false,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xq_p",
                active=false,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xs_p",
                active=false,
                Value=0.0036,
                min=0.00252,
                max=0.00468),Design.Internal.Records.TunerParameter(
                name="G01.G01.X1d_p",
                active=false,
                Value=0.0055,
                min=0.00385,
                max=0.00715),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2d_p",
                active=false,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2q_p",
                active=false,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.Rf_p",
                active=false,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1d_p",
                active=false,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1q_p",
                active=false,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G01.G01.Tj_p",
                active=false,
                Value=6.86798,
                min=0,
                max=20),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemax",
                active=false,
                Value=2,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemin",
                active=false,
                Value=-0.6,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0u",
                active=false,
                Value=-25,
                min=-30,
                max=-20),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1u",
                active=false,
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0w",
                active=false,
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1w",
                active=false,
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1if",
                active=false,
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Udeforc",
                active=false,
                Value=0.9,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Tforcedelay",
                active=false,
                Value=0,
                min=0,
                max=0.2)},
              calibrationData=Design.Calibration.Internal.Dynamic_common(
                Design.Internal.Records.DynamicCommonCalibrationCases(
                  experimentNames={"E:/Dymola_new/Work_4/Data.csv"},
                  task={1},
                  startTime={39.9},
                  stopTime={43.9}),
                resultCouplings={
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.P1", data="P_L0709_1")}),
              integrator=Design.Internal.Records.CalibrationIntegrator(
                startTime=39.9,
                stopTime=43.9,
                method="Rkfix4",
                tolerance=5e-3))) "Calibration_overregulation",
        editCall=Design.Calibration.checkCalibrationSensitivity(
            Design.Internal.Records.ModelCalibrationSetup(
              Model="KKT_1_AVR_G53_init",
              tunerParameters={Design.Internal.Records.TunerParameter(
                name="G07.G07.Xd_p",
                active=false,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xq_p",
                active=false,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xs_p",
                active=false,
                Value=0.082,
                min=0.0574,
                max=0.1066),Design.Internal.Records.TunerParameter(
                name="G07.G07.X1d_p",
                active=false,
                Value=0.166,
                min=0.1162,
                max=0.2158),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2d_p",
                active=false,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2q_p",
                active=false,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.Rf_p",
                active=false,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1d_p",
                active=false,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1q_p",
                active=false,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G07.G07.Tj_p",
                active=false,
                Value=19.712,
                min=13.7984,
                max=39),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemax",
                active=false,
                Value=2.5,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemin",
                active=false,
                Value=-1,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0u",
                active=true,
                Value=-23,
                min=-100,
                max=10),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1u",
                active=true,
                Value=-25,
                min=-30,
                max=-5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0w",
                active=false,
                Value=-15,
                min=-20,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1w",
                active=false,
                Value=5,
                min=-8,
                max=10),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1if",
                active=false,
                Value=-11,
                min=-15,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Udeforc",
                active=false,
                Value=0.95,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Tforcedelay",
                active=false,
                Value=0.1,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xd_p",
                active=false,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xq_p",
                active=false,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xs_p",
                active=false,
                Value=0.0036,
                min=0.00252,
                max=0.00468),Design.Internal.Records.TunerParameter(
                name="G01.G01.X1d_p",
                active=false,
                Value=0.0055,
                min=0.00385,
                max=0.00715),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2d_p",
                active=false,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2q_p",
                active=false,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.Rf_p",
                active=false,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1d_p",
                active=false,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1q_p",
                active=false,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G01.G01.Tj_p",
                active=false,
                Value=6.86798,
                min=0,
                max=20),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemax",
                active=false,
                Value=2,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemin",
                active=false,
                Value=-0.6,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0u",
                active=false,
                Value=-25,
                min=-30,
                max=-20),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1u",
                active=false,
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0w",
                active=false,
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1w",
                active=false,
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1if",
                active=false,
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Udeforc",
                active=false,
                Value=0.9,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Tforcedelay",
                active=false,
                Value=0,
                min=0,
                max=0.2)},
              calibrationData=Design.Calibration.Internal.Dynamic_common(
                Design.Internal.Records.DynamicCommonCalibrationCases(
                  experimentNames={"E:/Dymola_new/Work_4/Data.csv"},
                  task={1},
                  startTime={39.9},
                  stopTime={43.9}),
                resultCouplings={
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.P1", data="P_L0709_1")}),
              integrator=Design.Internal.Records.CalibrationIntegrator(
                startTime=39.9,
                stopTime=43.9,
                method="Rkfix4",
                tolerance=5e-3))) "Sensitivity_ananlysys",
        editCall=Design.Calibration.calibrate(
            Design.Internal.Records.ModelCalibrationSetup(
              Model="KKT_1_AVR_G53_init",
              tunerParameters={Design.Internal.Records.TunerParameter(
                name="G07.G07.Xd_p",
                active=false,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xq_p",
                active=false,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xs_p",
                active=false,
                Value=0.082,
                min=0.0574,
                max=0.1066),Design.Internal.Records.TunerParameter(
                name="G07.G07.X1d_p",
                active=false,
                Value=0.166,
                min=0.1162,
                max=0.2158),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2d_p",
                active=false,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2q_p",
                active=false,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.Rf_p",
                active=false,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1d_p",
                active=false,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1q_p",
                active=false,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G07.G07.Tj_p",
                active=false,
                Value=19.712,
                min=13.7984,
                max=25.6256),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemax",
                active=false,
                Value=2.5,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemin",
                active=false,
                Value=-0.6,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0u",
                active=false,
                Value=-25,
                min=-100,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1u",
                active=false,
                Value=-1,
                min=-10,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0w",
                active=false,
                Value=-2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1w",
                active=false,
                Value=2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1if",
                active=false,
                Value=0,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Udeforc",
                active=false,
                Value=0.95,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Tforcedelay",
                active=false,
                Value=0.1,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xd_p",
                active=false,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xq_p",
                active=false,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xs_p",
                active=false,
                Value=0.0036,
                min=0.00252,
                max=0.00468),Design.Internal.Records.TunerParameter(
                name="G01.G01.X1d_p",
                active=false,
                Value=0.0055,
                min=0.00385,
                max=0.00715),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2d_p",
                active=false,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2q_p",
                active=false,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.Rf_p",
                active=false,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1d_p",
                active=false,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1q_p",
                active=false,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G01.G01.Tj_p",
                active=false,
                Value=7,
                min=0,
                max=300),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemax",
                active=false,
                Value=2,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemin",
                active=false,
                Value=-0.6,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0u",
                active=false,
                Value=-25,
                min=-30,
                max=-20),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1u",
                active=false,
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0w",
                active=false,
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1w",
                active=false,
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1if",
                active=false,
                Value=0,
                min=-1,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Udeforc",
                active=false,
                Value=0.9,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Tforcedelay",
                active=false,
                Value=0,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Bn",
                active=true,
                Value=-18,
                min=-20,
                max=0),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Gn",
                active=true,
                Value=-5,
                min=-20,
                max=0)},
              calibrationData=Design.Calibration.Internal.Dynamic_common(
                Design.Internal.Records.DynamicCommonCalibrationCases(
                  experimentNames={"E:/Dymola_new/Work_4/Data.csv"},
                  task={2},
                  startTime={39.9},
                  stopTime={43.9}),
                resultCouplings={
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.P1", data="P_L0709_1")}),
              integrator=Design.Internal.Records.CalibrationIntegrator(
                startTime=39.9,
                stopTime=43.9,
                method="Rkfix4",
                tolerance=5e-3))) "Calibration_with_KZ",
        editCall=Design.Calibration.calibrate(
            Design.Internal.Records.ModelCalibrationSetup(
              Model="KKT_1_AVR_G53_init",
              tunerParameters={Design.Internal.Records.TunerParameter(
                name="G07.G07.Xd_p",
                active=false,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xq_p",
                active=false,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xs_p",
                active=false,
                Value=0.082,
                min=0.0574,
                max=0.1066),Design.Internal.Records.TunerParameter(
                name="G07.G07.X1d_p",
                active=false,
                Value=0.166,
                min=0.1162,
                max=0.2158),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2d_p",
                active=false,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2q_p",
                active=false,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.Rf_p",
                active=false,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1d_p",
                active=false,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1q_p",
                active=false,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G07.G07.Tj_p",
                active=false,
                Value=22.77,
                min=13.7984,
                max=25.6256),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemax",
                active=false,
                Value=2.5,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemin",
                active=false,
                Value=-0.6,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0u",
                active=false,
                Value=-25,
                min=-100,
                max=100),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1u",
                active=false,
                Value=-1,
                min=-10,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0w",
                active=false,
                Value=-2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1w",
                active=false,
                Value=2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1if",
                active=false,
                Value=0,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Udeforc",
                active=false,
                Value=0.95,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Tforcedelay",
                active=false,
                Value=0.1,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xd_p",
                active=false,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xq_p",
                active=false,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xs_p",
                active=false,
                Value=0.0036,
                min=0.00252,
                max=0.00468),Design.Internal.Records.TunerParameter(
                name="G01.G01.X1d_p",
                active=false,
                Value=0.0055,
                min=0.00385,
                max=0.00715),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2d_p",
                active=true,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2q_p",
                active=false,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.Rf_p",
                active=false,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1d_p",
                active=false,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1q_p",
                active=false,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G01.G01.Tj_p",
                active=false,
                Value=5.57,
                min=1,
                max=492.544),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemax",
                active=false,
                Value=2,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemin",
                active=false,
                Value=-0.6,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0u",
                active=false,
                Value=-10,
                min=-100,
                max=100),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1u",
                active=false,
                Value=0.78,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0w",
                active=false,
                Value=0,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1w",
                active=false,
                Value=0,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1if",
                active=false,
                Value=0,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Udeforc",
                active=false,
                Value=0.9,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Tforcedelay",
                active=false,
                Value=0,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Bn",
                active=false,
                Value=-11.6,
                min=-100,
                max=0),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Gn",
                active=false,
                Value=-5,
                min=-100,
                max=0)},
              calibrationData=Design.Calibration.Internal.Dynamic_common(
                Design.Internal.Records.DynamicCommonCalibrationCases(
                  experimentNames={"E:/Dymola_new/Work_4/Data.csv"},
                  task={1},
                  startTime={39.9},
                  stopTime={43.9}),
                resultCouplings={
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.P1", data="P_L0709_1")}),
              integrator=Design.Internal.Records.CalibrationIntegrator(
                startTime=39.9,
                stopTime=43.9,
                method="Rkfix4",
                tolerance=1e-3))) "Calibration_minimum",
        editCall=Design.Calibration.calibrate(
            Design.Internal.Records.ModelCalibrationSetup(
              Model="KKT_1_AVR_G53_init",
              tunerParameters={Design.Internal.Records.TunerParameter(
                name="G07.G07.Xd_p",
                active=true,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xq_p",
                active=true,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xs_p",
                active=true,
                Value=0.082,
                min=0.0574,
                max=0.1066),Design.Internal.Records.TunerParameter(
                name="G07.G07.X1d_p",
                active=true,
                Value=0.166,
                min=0.1162,
                max=0.2158),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2d_p",
                active=true,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2q_p",
                active=true,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.Rf_p",
                active=true,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1d_p",
                active=true,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1q_p",
                active=true,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G07.G07.Tj_p",
                active=true,
                Value=22.77,
                min=13.7984,
                max=25.6256),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemax",
                active=true,
                Value=2.5,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemin",
                active=true,
                Value=-0.6,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0u",
                active=true,
                Value=-25,
                min=-100,
                max=100),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1u",
                active=true,
                Value=-1,
                min=-10,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0w",
                active=true,
                Value=-2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1w",
                active=true,
                Value=2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1if",
                active=true,
                Value=0,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Udeforc",
                active=false,
                Value=0.95,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Tforcedelay",
                active=false,
                Value=0.1,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xd_p",
                active=true,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xq_p",
                active=true,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xs_p",
                active=true,
                Value=0.0036,
                min=0.00252,
                max=0.00468),Design.Internal.Records.TunerParameter(
                name="G01.G01.X1d_p",
                active=true,
                Value=0.0055,
                min=0.00385,
                max=0.00715),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2d_p",
                active=true,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2q_p",
                active=true,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.Rf_p",
                active=true,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1d_p",
                active=true,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1q_p",
                active=true,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G01.G01.Tj_p",
                active=true,
                Value=5.57,
                min=1,
                max=492.544),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemax",
                active=true,
                Value=2,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemin",
                active=true,
                Value=-0.6,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0u",
                active=true,
                Value=-10,
                min=-100,
                max=100),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1u",
                active=true,
                Value=0.78,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0w",
                active=true,
                Value=0,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1w",
                active=true,
                Value=0,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1if",
                active=true,
                Value=0,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Udeforc",
                active=false,
                Value=0.9,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Tforcedelay",
                active=false,
                Value=0,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Bn",
                active=true,
                Value=-11.6,
                min=-100,
                max=0),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Gn",
                active=true,
                Value=-5,
                min=-100,
                max=0)},
              calibrationData=Design.Calibration.Internal.Dynamic_common(
                Design.Internal.Records.DynamicCommonCalibrationCases(
                  experimentNames={"E:/Dymola_new/Work_4/Data.csv"},
                  task={1},
                  startTime={39.9},
                  stopTime={43.9}),
                resultCouplings={
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.P1", data="P_L0709_1")}),
              integrator=Design.Internal.Records.CalibrationIntegrator(
                startTime=39.9,
                stopTime=43.9,
                method="Rkfix4",
                tolerance=1e-3))) "Calibration_0.11",
        editCall=Design.Calibration.calibrate(
            Design.Internal.Records.ModelCalibrationSetup(
              Model="KKT_1_AVR_G53_init",
              tunerParameters={Design.Internal.Records.TunerParameter(
                name="G07.G07.Xd_p",
                active=false,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xq_p",
                active=false,
                Value=1.314,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xs_p",
                active=false,
                Value=0.082,
                min=0.0574,
                max=0.1066),Design.Internal.Records.TunerParameter(
                name="G07.G07.X1d_p",
                active=false,
                Value=0.166,
                min=0.1162,
                max=0.2158),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2d_p",
                active=false,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2q_p",
                active=false,
                Value=0.11,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.Rf_p",
                active=false,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1d_p",
                active=false,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1q_p",
                active=false,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G07.G07.Tj_p",
                active=false,
                Value=22.77,
                min=13.7984,
                max=25.6256),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemax",
                active=false,
                Value=2.5,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemin",
                active=false,
                Value=-0.6,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0u",
                active=false,
                Value=-25,
                min=-100,
                max=100),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1u",
                active=false,
                Value=-1,
                min=-10,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0w",
                active=false,
                Value=-2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1w",
                active=false,
                Value=2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1if",
                active=false,
                Value=0,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Udeforc",
                active=false,
                Value=0.95,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Tforcedelay",
                active=false,
                Value=0.1,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xd_p",
                active=false,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xq_p",
                active=false,
                Value=0.041,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xs_p",
                active=false,
                Value=0.0036,
                min=0.00252,
                max=0.00468),Design.Internal.Records.TunerParameter(
                name="G01.G01.X1d_p",
                active=false,
                Value=0.0055,
                min=0.00385,
                max=0.00715),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2d_p",
                active=false,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2q_p",
                active=false,
                Value=0.0039,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.Rf_p",
                active=false,
                Value=0.000601,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1d_p",
                active=false,
                Value=0.000226,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1q_p",
                active=false,
                Value=0.00024,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G01.G01.Tj_p",
                active=false,
                Value=5.57,
                min=1,
                max=492.544),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemax",
                active=false,
                Value=2,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemin",
                active=false,
                Value=-0.6,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0u",
                active=false,
                Value=-10,
                min=-100,
                max=100),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1u",
                active=false,
                Value=0.78,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0w",
                active=false,
                Value=0,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1w",
                active=false,
                Value=0,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1if",
                active=false,
                Value=0,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Udeforc",
                active=false,
                Value=0.9,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Tforcedelay",
                active=false,
                Value=0,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Bn",
                active=true,
                Value=-11.6,
                min=-100,
                max=0),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Gn",
                active=true,
                Value=-5,
                min=-100,
                max=0)},
              calibrationData=Design.Calibration.Internal.Dynamic_common(
                Design.Internal.Records.DynamicCommonCalibrationCases(
                  experimentNames={"E:/Dymola_new/Work_4/Data.csv"},
                  task={1},
                  startTime={39.9},
                  stopTime={43.9}),
                resultCouplings={
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.P1",
                  data="P_L0709_1",
                  active=false),
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.U1m", data="U1m_0709_1")}),
              integrator=Design.Internal.Records.CalibrationIntegrator(
                startTime=39.9,
                stopTime=43.9,
                method="Rkfix4",
                tolerance=1e-3))) "Calibration_U",
        editCall=Design.Calibration.calibrate(
            Design.Internal.Records.ModelCalibrationSetup(
              Model="KKT_1_AVR_G53_init",
              tunerParameters={Design.Internal.Records.TunerParameter(
                name="G07.G07.Xd_p",
                active=false,
                Value=1.3140011668,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xq_p",
                active=false,
                Value=1.3140049285,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xs_p",
                active=false,
                Value=0.081991846,
                min=0.0574,
                max=0.1066),Design.Internal.Records.TunerParameter(
                name="G07.G07.X1d_p",
                active=false,
                Value=0.1659842940,
                min=0.1162,
                max=0.2158),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2d_p",
                active=false,
                Value=0.1100200708,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2q_p",
                active=false,
                Value=0.110107339408,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.Rf_p",
                active=false,
                Value=0.00053404124,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1d_p",
                active=false,
                Value=0.0002938,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1q_p",
                active=false,
                Value=0.000168,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G07.G07.Tj_p",
                active=false,
                Value=22.770002386,
                min=13.7984,
                max=25.6256),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemax",
                active=false,
                Value=5,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemin",
                active=false,
                Value=0,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0u",
                active=false,
                Value=-100,
                min=-100,
                max=100),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1u",
                active=false,
                Value=-10,
                min=-10,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0w",
                active=false,
                Value=-2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1w",
                active=false,
                Value=2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1if",
                active=false,
                Value=0,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Udeforc",
                active=false,
                Value=0.95,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Tforcedelay",
                active=false,
                Value=0.2,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xd_p",
                active=false,
                Value=0.0402632322518,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xq_p",
                active=false,
                Value=0.04111729683,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xs_p",
                active=false,
                Value=0.0033967798051,
                min=0.00252,
                max=0.00468),Design.Internal.Records.TunerParameter(
                name="G01.G01.X1d_p",
                active=false,
                Value=0.00555652841,
                min=0.00385,
                max=0.00715),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2d_p",
                active=false,
                Value=0.00398991942,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2q_p",
                active=false,
                Value=0.003973000421,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.Rf_p",
                active=false,
                Value=0.0007813,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1d_p",
                active=false,
                Value=0.0001582,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1q_p",
                active=false,
                Value=0.000168,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G01.G01.Tj_p",
                active=false,
                Value=5.57000065822,
                min=1,
                max=492.544),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemax",
                active=false,
                Value=4,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemin",
                active=false,
                Value=0,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0u",
                active=false,
                Value=-10,
                min=-100,
                max=100),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1u",
                active=false,
                Value=0.78,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0w",
                active=false,
                Value=-0.00084,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1w",
                active=false,
                Value=0.0014493826,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1if",
                active=false,
                Value=-3.2069519618698025E-05,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Udeforc",
                active=false,
                Value=0.9,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Tforcedelay",
                active=false,
                Value=0.2,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Bn",
                active=true,
                Value=-11.6,
                min=-120,
                max=20),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Gn",
                active=true,
                Value=-5,
                min=-20,
                max=20)},
              calibrationData=Design.Calibration.Internal.Dynamic_common(
                Design.Internal.Records.DynamicCommonCalibrationCases(
                  experimentNames={"E:/Dymola_new/Work_4/Data.csv"},
                  task={1},
                  startTime={39.9},
                  stopTime={43.9}),
                resultCouplings={
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.P1",
                  data="P_L0709_1",
                  active=false),
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.U1m", data="U1m_0709_1")}),
              integrator=Design.Internal.Records.CalibrationIntegrator(
                startTime=39.9,
                stopTime=43.9,
                method="Rkfix4",
                tolerance=1e-3),
              optimizer=Design.Internal.Records.CalibrationOptimizer(tolerance=
                1E-3))) "Calibration_U_1",
        editCall=Design.Calibration.calibrate(
            Design.Internal.Records.ModelCalibrationSetup(
              Model="KKT_1_AVR_G53_init",
              tunerParameters={Design.Internal.Records.TunerParameter(
                name="G07.G07.Xd_p",
                active=false,
                Value=1.3140011668,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xq_p",
                active=false,
                Value=1.3140049285,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xs_p",
                active=false,
                Value=0.081991846,
                min=0.0574,
                max=0.1066),Design.Internal.Records.TunerParameter(
                name="G07.G07.X1d_p",
                active=false,
                Value=0.1659842940,
                min=0.1162,
                max=0.2158),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2d_p",
                active=false,
                Value=0.1100200708,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2q_p",
                active=false,
                Value=0.110107339408,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.Rf_p",
                active=false,
                Value=0.00053404124,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1d_p",
                active=false,
                Value=0.0002938,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1q_p",
                active=false,
                Value=0.000168,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G07.G07.Tj_p",
                active=false,
                Value=22.770002386,
                min=13.7984,
                max=25.6256),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemax",
                active=false,
                Value=5,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemin",
                active=false,
                Value=0,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0u",
                active=false,
                Value=-100,
                min=-100,
                max=100),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1u",
                active=false,
                Value=-10,
                min=-10,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0w",
                active=false,
                Value=-2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1w",
                active=false,
                Value=2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1if",
                active=false,
                Value=0,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Udeforc",
                active=false,
                Value=0.95,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Tforcedelay",
                active=false,
                Value=0.2,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xd_p",
                active=false,
                Value=0.0402632322518,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xq_p",
                active=false,
                Value=0.04111729683,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xs_p",
                active=false,
                Value=0.0033967798051,
                min=0.00252,
                max=0.00468),Design.Internal.Records.TunerParameter(
                name="G01.G01.X1d_p",
                active=false,
                Value=0.00555652841,
                min=0.00385,
                max=0.00715),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2d_p",
                active=false,
                Value=0.00398991942,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2q_p",
                active=false,
                Value=0.003973000421,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.Rf_p",
                active=false,
                Value=0.0007813,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1d_p",
                active=false,
                Value=0.0001582,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1q_p",
                active=false,
                Value=0.000168,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G01.G01.Tj_p",
                active=false,
                Value=5.57000065822,
                min=1,
                max=492.544),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemax",
                active=false,
                Value=4,
                min=1.5,
                max=3),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemin",
                active=false,
                Value=0,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0u",
                active=false,
                Value=-10,
                min=-100,
                max=100),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1u",
                active=false,
                Value=0.78,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0w",
                active=false,
                Value=-0.00084,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1w",
                active=false,
                Value=0.0014493826,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1if",
                active=false,
                Value=-3.2069519618698025E-05,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Udeforc",
                active=false,
                Value=0.9,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Tforcedelay",
                active=false,
                Value=0.2,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Bn",
                active=true,
                Value=-11.6,
                min=-120,
                max=20),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Gn",
                active=true,
                Value=-5,
                min=-20,
                max=20)},
              calibrationData=Design.Calibration.Internal.Dynamic_common(
                Design.Internal.Records.DynamicCommonCalibrationCases(
                  experimentNames={"E:/Dymola_new/Work_4/Data.csv"},
                  task={2},
                  startTime={39.9},
                  stopTime={43.9}),
                resultCouplings={
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.P1",
                  data="P_L0709_1",
                  active=false),
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.U1m", data="U1m_0709_1")}),
              integrator=Design.Internal.Records.CalibrationIntegrator(
                startTime=39.9,
                stopTime=43.9,
                method="Rkfix4",
                tolerance=1e-3),
              optimizer=Design.Internal.Records.CalibrationOptimizer(tolerance=
                1E-3))) "Calibration_U_1",
        editCall=Design.Calibration.calibrate(
            Design.Internal.Records.ModelCalibrationSetup(
              Model="KKT_1_AVR_G53_init",
              tunerParameters={Design.Internal.Records.TunerParameter(
                name="G07.G07.Xd_p",
                active=false,
                Value=1.3140011668,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xq_p",
                active=false,
                Value=1.3140049285,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xs_p",
                active=false,
                Value=0.081991846,
                min=0.0574,
                max=0.1066),Design.Internal.Records.TunerParameter(
                name="G07.G07.X1d_p",
                active=false,
                Value=0.1659842940,
                min=0.1162,
                max=0.2158),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2d_p",
                active=false,
                Value=0.1100200708,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2q_p",
                active=false,
                Value=0.110107339408,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.Rf_p",
                active=false,
                Value=0.00053404124,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1d_p",
                active=false,
                Value=0.0002938,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1q_p",
                active=false,
                Value=0.000168,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G07.G07.Tj_p",
                active=false,
                Value=22.770002386,
                min=13.7984,
                max=25.6256),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemax",
                active=false,
                Value=5,
                min=1.5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemin",
                active=false,
                Value=0,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0u",
                active=false,
                Value=-100,
                min=-200,
                max=100),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1u",
                active=false,
                Value=-10,
                min=-10,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0w",
                active=false,
                Value=-2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1w",
                active=false,
                Value=2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1if",
                active=false,
                Value=0,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Udeforc",
                active=false,
                Value=0.95,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Tforcedelay",
                active=false,
                Value=0.2,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xd_p",
                active=false,
                Value=0.0402632322518,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xq_p",
                active=false,
                Value=0.04111729683,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xs_p",
                active=false,
                Value=0.0033967798051,
                min=0.00252,
                max=0.00468),Design.Internal.Records.TunerParameter(
                name="G01.G01.X1d_p",
                active=false,
                Value=0.00555652841,
                min=0.00385,
                max=0.00715),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2d_p",
                active=false,
                Value=0.00398991942,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2q_p",
                active=false,
                Value=0.003973000421,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.Rf_p",
                active=false,
                Value=0.0007813,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1d_p",
                active=false,
                Value=0.0001582,
                min=0.0001582,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1q_p",
                active=false,
                Value=0.000168,
                min=0.000168,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G01.G01.Tj_p",
                active=false,
                Value=5.57000065822,
                min=1,
                max=492.544),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemax",
                active=false,
                Value=4,
                min=1.5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemin",
                active=false,
                Value=0,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0u",
                active=false,
                Value=-10,
                min=-100,
                max=100),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1u",
                active=false,
                Value=0.78,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0w",
                active=false,
                Value=-0.00084,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1w",
                active=false,
                Value=0.0014493826,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1if",
                active=false,
                Value=-3.2069519618698025E-05,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Uforc",
                active=false,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Udeforc",
                active=false,
                Value=0.9,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Tforcedelay",
                active=false,
                Value=0.2,
                min=0,
                max=0.2),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Bn",
                active=false,
                Value=-11.6,
                min=-120,
                max=20),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Gn",
                active=false,
                Value=-5,
                min=-20,
                max=20),Design.Internal.Records.TunerParameter(
                name="L0709_1.Bline1",
                active=false,
                Value=0.11695,
                min=0,
                max=0.11695),Design.Internal.Records.TunerParameter(
                name="L0709_1.Bline2",
                active=false,
                Value=0.11695,
                min=0,
                max=0.11695),Design.Internal.Records.TunerParameter(
                name="L0709_2.Bline1",
                Value=0.01435,
                min=0,
                max=0.11435),Design.Internal.Records.TunerParameter(
                name="L0709_2.Bline2",
                Value=0.01435,
                min=0,
                max=0.11435)},
              calibrationData=Design.Calibration.Internal.Dynamic_common(
                Design.Internal.Records.DynamicCommonCalibrationCases(
                  experimentNames={"E:/Dymola_new/Work_4/Data.csv"},
                  task={1},
                  startTime={39.9},
                  stopTime={43.9}),
                resultCouplings={
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.P1",
                  data="P_L0709_1",
                  active=false),
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.U1m", data="U1m_0709_1")}),
              integrator=Design.Internal.Records.CalibrationIntegrator(
                startTime=39.9,
                stopTime=43.9,
                method="Rkfix4",
                tolerance=1e-3),
              optimizer=Design.Internal.Records.CalibrationOptimizer(tolerance=
                1E-3))) "Calibration_U_2",
        editCall=Design.Calibration.calibrate(
            Design.Internal.Records.ModelCalibrationSetup(
              Model="KKT_1_AVR_G53_init",
              tunerParameters={Design.Internal.Records.TunerParameter(
                name="G07.G07.Xd_p",
                active=true,
                Value=1.3140011668,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xq_p",
                active=true,
                Value=1.3140049285,
                min=0.9198,
                max=1.7082),Design.Internal.Records.TunerParameter(
                name="G07.G07.Xs_p",
                active=true,
                Value=0.081991846,
                min=0.0574,
                max=0.1066),Design.Internal.Records.TunerParameter(
                name="G07.G07.X1d_p",
                active=true,
                Value=0.1659842940,
                min=0.1162,
                max=0.2158),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2d_p",
                active=true,
                Value=0.1100200708,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.X2q_p",
                active=true,
                Value=0.110107339408,
                min=0.077,
                max=0.143),Design.Internal.Records.TunerParameter(
                name="G07.G07.Rf_p",
                active=true,
                Value=0.00053404124,
                min=0.0004207,
                max=0.0007813),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1d_p",
                active=true,
                Value=0.0002938,
                min=0.0001582,
                max=0.00035),Design.Internal.Records.TunerParameter(
                name="G07.G07.R1q_p",
                active=true,
                Value=0.000168,
                min=0.0001,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G07.G07.Tj_p",
                active=true,
                Value=22.770002386,
                min=13.7984,
                max=25.6256),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemax",
                active=true,
                Value=5,
                min=1.5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07.Kemin",
                active=true,
                Value=0,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0u",
                active=true,
                Value=-100,
                min=-200,
                max=100),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1u",
                active=true,
                Value=-10,
                min=-15,
                max=0),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K0w",
                active=true,
                Value=-2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1w",
                active=true,
                Value=2,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.K1if",
                active=true,
                Value=0,
                min=-5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Uforc",
                active=true,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Udeforc",
                active=true,
                Value=0.95,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G07.G07_Regulator.Tforcedelay",
                active=true,
                Value=0.2,
                min=0,
                max=0.3),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xd_p",
                active=true,
                Value=0.04026323225,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xq_p",
                active=true,
                Value=0.04111729683,
                min=0.0287,
                max=0.0533),Design.Internal.Records.TunerParameter(
                name="G01.G01.Xs_p",
                active=true,
                Value=0.00339677981,
                min=0.00252,
                max=0.00468),Design.Internal.Records.TunerParameter(
                name="G01.G01.X1d_p",
                active=true,
                Value=0.00555652841,
                min=0.00385,
                max=0.00715),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2d_p",
                active=true,
                Value=0.00398991942,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.X2q_p",
                active=true,
                Value=0.00397300042,
                min=0.00273,
                max=0.00507),Design.Internal.Records.TunerParameter(
                name="G01.G01.Rf_p",
                active=true,
                Value=0.0007813,
                min=0.0004207,
                max=0.0009),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1d_p",
                active=true,
                Value=0.0001582,
                min=0.0001,
                max=0.0002938),Design.Internal.Records.TunerParameter(
                name="G01.G01.R1q_p",
                active=true,
                Value=0.000168,
                min=0.0001,
                max=0.000312),Design.Internal.Records.TunerParameter(
                name="G01.G01.Tj_p",
                active=true,
                Value=5.57000065822,
                min=1,
                max=492.544),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemax",
                active=true,
                Value=4,
                min=1.5,
                max=5),Design.Internal.Records.TunerParameter(
                name="G01.G01.Kemin",
                active=true,
                Value=0,
                min=-1,
                max=0),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0u",
                active=true,
                Value=-10,
                min=-100,
                max=100),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1u",
                active=true,
                Value=0.78,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K0w",
                active=true,
                Value=-0.00084,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1w",
                active=true,
                Value=0.0014493826,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.K1if",
                active=true,
                Value=0,
                min=-10,
                max=10),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Uforc",
                active=true,
                Value=0.85,
                min=0.75,
                max=0.9),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Udeforc",
                active=true,
                Value=0.9,
                min=0.9,
                max=1),Design.Internal.Records.TunerParameter(
                name="G01.G01_Regulator.Tforcedelay",
                active=true,
                Value=0.2,
                min=0,
                max=0.3),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Bn",
                active=false,
                Value=-11.6,
                min=-120,
                max=20),Design.Internal.Records.TunerParameter(
                name="shortCircuitShunt.Gn",
                active=false,
                Value=-5,
                min=-20,
                max=20),Design.Internal.Records.TunerParameter(
                name="L0709_1.Bline1",
                active=false,
                Value=0.11695,
                min=0,
                max=0.11695),Design.Internal.Records.TunerParameter(
                name="L0709_1.Bline2",
                active=false,
                Value=0.11695,
                min=0,
                max=0.11695),Design.Internal.Records.TunerParameter(
                name="L0709_2.Bline1",
                active=false,
                Value=0.01435,
                min=0,
                max=0.11435),Design.Internal.Records.TunerParameter(
                name="L0709_2.Bline2",
                active=false,
                Value=0.01435,
                min=0,
                max=0.11435)},
              calibrationData=Design.Calibration.Internal.Dynamic_common(
                Design.Internal.Records.DynamicCommonCalibrationCases(
                  experimentNames={"E:/Dymola_new/Work_4/Data.csv"},
                  task={2},
                  startTime={39.9},
                  stopTime={43.9}),
                resultCouplings={
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.P1",
                  data="P_L0709_1",
                  active=true,
                  weight=0.5),
                  Design.Internal.Records.DynamicCalibrationResultCoupling(
                  variable="L0709_1.U1m",
                  data="U1m_0709_1",
                  weight=0.5)}),
              integrator=Design.Internal.Records.CalibrationIntegrator(
                startTime=39.9,
                stopTime=43.9,
                method="Rkfix4",
                tolerance=1e-3),
              optimizer=Design.Internal.Records.CalibrationOptimizer(tolerance=
                1E-3))) "Calibration_all"),
      Documentation(info="<html>
<p>The equivalent energy system of Karelia and the Murmansk Region, including power plants, substations, and transmission lines with a voltage of 110 to 330 kV. </p>
<p>All power staions are presented as dynamic equivalents of the totality of their generators. </p>
<p>Infinite power buses are represented by the G1 generator, which equates the connection with the Leningrad power system. </p>
<p><b>0 s</b>: start;</p>
<p><b>40 s: </b>start of 2-phase short circuit in node_7, partial N10 load-off;</p>
<p><b>40.14 s: </b>end of short circuit, L0709_2 disconnection;</p>
<p><b>44 s</b>: automatic reclosing of L0709_2; start of the second short circuit in node_7;</p>
<p><b>44.14 s</b>: end of the second short circuit, L0709_2 second disconnection;</p>
<p><b>65 s</b>: end. </p>
</html>"));
  end KKT_1;

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
    LEPSE.Basic.Node node_12 annotation (Placement(transformation(extent={{-86,
              68},{-80,74}}), iconTransformation(extent={{-294,-20},{-274,0}})));
    LEPSE.Basic.Node node_10 annotation (Placement(transformation(extent={{-58,
              34},{-52,40}}), iconTransformation(extent={{-294,-66},{-274,-46}})));
    LEPSE.Basic.Node node_11 annotation (Placement(transformation(extent={{-58,
              -16},{-52,-10}}), iconTransformation(extent={{-294,-78},{-274,-58}})));
    LEPSE.Basic.Node node_7 annotation (Placement(transformation(extent={{8,68},
              {14,74}}), iconTransformation(extent={{-276,-54},{-256,-34}})));
    LEPSE.Basic.Node node_16 annotation (Placement(transformation(extent={{8,
              114},{14,120}}), iconTransformation(extent={{-284,-12},{-264,8}})));
    LEPSE.Basic.Node node_8 annotation (Placement(transformation(extent={{50,68},
              {56,74}}), iconTransformation(extent={{-290,-18},{-270,2}})));
    LEPSE.Basic.Node node_21 annotation (Placement(transformation(extent={{120,
              68},{126,74}}), iconTransformation(extent={{-278,-14},{-258,6}})));
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
    LEPSE.Basic.Node node_22 annotation (Placement(transformation(extent={{120,
              -56},{126,-50}}), iconTransformation(extent={{-294,-116},{-274,-96}})));
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
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
              rotation=0, extent={{-16,14},{-2,28}}), iconTransformation(extent
              ={{2,9},{22,29}})));
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
      LEPSE.Basic.Pin_v2 Stator_pin annotation (Placement(transformation(
              rotation=0, extent={{51,3},{57,9}}), iconTransformation(extent={{
                47,-7},{58,4}})));
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
      LEPSE.Basic.Excitation_Regulator excitation_Regulator(K0u=-20)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={38,36})));
      LEPSE.Basic.Pin_v2 pin_v2_2 annotation (Placement(transformation(extent={
                {80,36},{84,40}}), iconTransformation(extent={{100,44},{114,58}})));
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
    connect(G1.pin_v2_2, node_21) annotation (Line(points={{138.762,70.6625},{
            138,71},{123,71}},  color={28,108,200}));
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

  model Simple_model
    Real delta_G1_G2(start=0.5534006953239441);

    LEPSE.Basic.Gen_with_ARV_control G1(G(
        Pg=0.85,
        Qg=0.5,
        Ut=1.05), AVR(
        K0u=-20,
        ExcitationCurrent(x(start={-0.03201247379183769})),
        FrequencyBlockD(x(start={-0.2747640907764435})),
        FrequencyDerivative(x(start={-0.2747640907764435})),
        FrequencyDeviation(x(start={-0.27476415038108826})),
        SimpleExciter(x(start={-0.05362093076109886})),
        VoltageDerivative(x(start={0.0026810464914888144})),
        VoltageDeviation(x(start={0.0026810464914888144}))))
      annotation (Placement(transformation(extent={{-64,-2},{-28,32}})));
    LEPSE.Basic.HVline Line_1(TLineOff=30.1, dTLineOff=5)
      annotation (Placement(transformation(extent={{-14,2},{6,22}})));
    LEPSE.Basic.Gen_with_ARV_control G2(AVR(
        K0u=-30,
        K1u=-5,
        K0w=0,
        ExcitationCurrent(x(start={-1.6456316709518433})),
        FrequencyBlockD(x(start={-0.2747640907764435})),
        FrequencyDerivative(x(start={-0.2747640907764435})),
        FrequencyDeviation(x(start={-0.27476415038108826})),
        SimpleExciter(x(start={-0.14810684323310852})),
        VoltageDerivative(x(start={0.004936894867569208})),
        VoltageDeviation(x(start={0.004936894867569208}))), G(
        Pg=2,
        Qg=0.5,
        Ut=1,
        R1d_p=0.0037,
        R1q_p=0.0028,
        Rf_p=0.0009,
        Tj_p=50.0,
        X1d_p=0.015,
        X2d_p=0.012,
        X2q_p=0.012,
        Xd_p=0.1,
        Xq_p=0.1,
        Xs_p=0.01)) "infinite bus"        annotation (Placement(transformation(
          extent={{-18,-18},{18,18}},
          rotation=180,
          origin={40,18})));
    LEPSE.Basic.Constant_Conductivity_Load constant_Conductivity_Load(Gn=2.81,
        Bn=0.7) annotation (Placement(transformation(extent={{4,-18},{24,2}})));
    LEPSE.Basic.ShortCircuitShunt shortCircuitShunt(
      Bn=-100000,
      Gn=-100000,
      TkzOn=30,
      dTkzOn=0.1)
      annotation (Placement(transformation(extent={{-32,-16},{-12,4}})));
    LEPSE.Basic.Node node_1 annotation (Placement(transformation(extent={{-24,
              14},{-18,20}}), iconTransformation(extent={{-138,-48},{-118,-28}})));
    LEPSE.Basic.Node node_2 annotation (Placement(transformation(extent={{10,14},
              {16,20}}), iconTransformation(extent={{-136,-48},{-116,-28}})));
  equation

    der(delta_G1_G2) =G2.G.Wc*(G2.G.s - G1.G.s);

    G2.G.DeltaIJ = 0;
    G1.G.DeltaIJ = delta_G1_G2;

    G1.G.Ssys = G2.G.s;
    G2.G.Ssys =G2.G.s;

    connect(node_1,Line_1. inp)
      annotation (Line(points={{-21,17},{-11.6,17}}, color={28,108,200}));
    connect(Line_1.out, node_2) annotation (Line(points={{3.8,17.2},{3.8,17},
            {13,17}}, color={28,108,200}));
    connect(node_2,G2. inp) annotation (Line(points={{13,17},{13,16.92},{
            24.16,16.92}},
                     color={28,108,200}));
    connect(node_2, constant_Conductivity_Load.inp) annotation (Line(points={
            {13,17},{14,17},{14,0.6}}, color={28,108,200}));
    connect(node_1, G1.inp) annotation (Line(points={{-21,17},{-24,17},{-24,
            16.02},{-30.16,16.02}},
                             color={28,108,200}));
    connect(node_1, shortCircuitShunt.inp) annotation (Line(points={{-21,17},
            {-22,17},{-22,-1.2}}, color={28,108,200}));
    annotation (Documentation(info="<html>
<p>Calssical model of the simpliest power energy system, which is used to study the basics of transient processes. </p>
<p><b>0 s</b>: start;</p>
<p><b>30 s</b>: 3-phase short circuit in node_1;</p>
<p><b>30.1 s</b>: end of short circuit, disconnection one of the two circuits of the Line_1;</p>
<p><b>35.1 s</b>: automatic reclosing of the Line_1 circuit ;</p>
<p><b>50 s</b>: end. </p>
</html>"),
         experiment(
        StopTime=30,
        __Dymola_NumberOfIntervals=5000,
        Tolerance=1e-05,
        __Dymola_Algorithm="Dassl"),
      Icon(graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-74,-72},{78,74}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-22,56},{60,0},{-22,-52},{-22,56}})}),
      Diagram(graphics={Text(
            extent={{-30,34},{-16,24}},
            textColor={28,108,200},
            textString="1"), Text(
            extent={{6,34},{20,24}},
            textColor={28,108,200},
            textString="2")}));
  end Simple_model;

  annotation (Documentation(info="<html>
<p>This package contains several examples of power energy systems:</p>
<ul>
<li><b><span style=\"font-family: Arial;\"><a href=\"modelica://LEPSE.Examples.Simple_model\">Simple_model</a></span> -</b>the most commonly used concept in the study of dynamic stability, including synchronous machine, power transmission line and infinite power buses;</li>
<li><b><span style=\"font-family: Arial;\"><a href=\"modelica://LEPSE.Examples.three_maschine_scheme\">three_maschine_scheme</a></span></b> - model of a simple energy integration model used in bachelor&apos;s theses;</li>
<li><b><span style=\"font-family: Arial;\"><a href=\"modelica://LEPSE.Examples.KKT_1\">KKT</a></span></b> - The Kola-Karelian transit model, part of the Unified Energy System of North-West Russia, which extends the base class KKT_1.</li>
</ul>
</html>"),
         Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Polygon(
          origin={8,14},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end Examples;
