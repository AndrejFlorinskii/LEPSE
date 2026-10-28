within Basic;
model SysData
  parameter Real Sbaz = 1000 "Bazic power, MWA";
  parameter Real Ubaz = 20 "Basic voltage, kV";
  parameter Real Ubaz_HV = 330 "Basic voltage HV, kV";
  parameter Real fbaz = 50 "Basic frequency, Hz";

  annotation (
    Icon(
      coordinateSystem(extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-100,60},{100,-60}}, lineColor={0,0,255}, fillColor={220,220,255}, fillPattern=FillPattern.Solid),
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
