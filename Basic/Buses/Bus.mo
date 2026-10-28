within ;
model Bus
  parameter Integer busNumber = 1;
  parameter Real Unom=330 "Nominal bus voltage, kV";
  Real Um(start = 1.0, fixed = false) "Full bus voltage, kV";
  parameter Boolean displayVoltage=true "Display bus voltage";
  LEPSE.Interfaces.Pin_v2 bus_pin annotation (Placement(transformation(extent={
            {-12,-12},{10,10}}), iconTransformation(extent={{-12,-12},{10,10}})));
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
