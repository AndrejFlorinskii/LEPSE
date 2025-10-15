within LEPSE;
package Interfaces
  connector Pin_v2
    Real Vd "Potential Vd";
    Real Vq "Potential Vq";
    flow Real Id "Current Id";
    flow Real Iq "Current Iq";

  end Pin_v2;

  connector Single_Pin
    Real Signal "Connector's signal";

  end Single_Pin;

  connector Node
    Real Vd "Potential Vd";
    Real Vq "Potential Vq";
    flow Real Id "Current Id";
    flow Real Iq "Current Iq";

  end Node;
end Interfaces;
