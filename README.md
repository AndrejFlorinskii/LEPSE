GENERAL INFORMATION

Library of electric power system elements 
LEPSE is a libary for power enerygy system, developed and maintained by the staff of the Higher School of Electrical Power Systems (https://ie.spbstu.ru/department/vysshaya_shkola_elektroenergeticheskih_sistem/) of the Peter the Great St. Petersburg Polytechnic University (https://www.spbstu.ru/), led by Belyaev Andrey Nikolaevich (https://belyaev.spb.ru/). 
Ths library allows to create dynamic calculation model of power energy system and to investigate electromechanical transient processes. 
All equations are written for the 0qd coordinate system. All parameters and variables, except for time variables, are given in relative units
Basic componentsm which are used to create new model, are located in package Basic . 
Several examples of different power energy systems are located in package Examples. 
The authors can be contacted by email: andrej.florinskiy@gmail.com.

This Modelica package is free software and the use is completely at your own risk; it can be redistributed and/or modified under the terms of the BSD 3-Clause License. For license conditions read LICENSE.txt.
<img width="1304" height="597" alt="KKT_1" src="https://github.com/user-attachments/assets/3c4c5e1d-bad6-4e01-b7e6-1448b72920b4" />

HOW TO WORK WITH LEPSE

I To start working with LEPSE, firstly you need to determine the values of model element's parameters. All variables are presented in basic per-units (p.u.b.) of measurement - so you need to choose 2 basic values: basic power  and basic voltage , for example: 1000 MVA and 340 kV. 
The next stage is to calculate values of parameters in p.u.b. with the use of well known formulas. An examples for parameter's conversion from per-units or named units (Om, MVA, MW etc) to basic per-units calculations are presented in .xlsx file "Conversion". 

It should be noted that in most cases there is a necessity to equivalent power system grid to simplify dynamic model. In these case several power transmission lines, transformers, generators and loads can be equivalented into one. It is taken into account in "Conversion" file. 

II Every scheme needs infinite bus - "big" equivalent generator. It's parameters can be easily calculated using the same method as for a conventional generator. The defining initial parameter for this calculation is the total short-circuit power , which defines the total power of external system and is determined by the following formula:
Ssc = sqrt(3)*Isc*Uline 
where Isc - nominal short-circuit cut-off current; Uline - nominal phase-to-phase voltage of the line. If there are several lines of communication with the external power system, the short-circuit power is determined by summing the calculated Ssc value for each line. 
Then the infinite bus is equivalent to the number of generators required to provide the total short-circuit power. It is normal, for example, if infinite bus is equivalent to 50 generators of 500 MVA nominal power. 
To get quasi-steady-state condition, you need to manually set a dummy load at the infinite power bus connection point so that the power system maintains a balance between generation and consumption. This balance can be easily monitored by the slip value s of the equivalent generator of the external power system - ideally, it must be near zero. 

III To investigate transient processes, certain emergency events are needed. Simple switching off (on) is specified by three parameters - time of the element's shutdown (TLineOff, TtOff etc), duration of shutdown (dTLineOff, dTtOff etc) and the degree of its shutdown (Koff) . The latter means either the shutdown of a part of the generation/load, or the shutdown of one circuit or one transformer of the equivalent power line and equivalent transformer, respectively. In real power energy systems the main reason of emergency shutdown is short circuit, which is simulated by ShortCircuitShunt switching on. There are 4 main parameters of ShortCircuitShunt: reactive, active conductivity of short sircuit, time of its start and duration. The fifth parameter, total conductvity of short circuit, is useful, when you need to save the same degree of voltage drop duiring short circuit, varying the ratio between its active and reactive components. To simulate repeated short circuit, you need another ShortCircuitShunt model. The second power transmission line shutdown after its automatic reclosing can be simulated with the help of TLineOff_1, dTLineOff_1 and Koff_1 parameters. 

IV LEPSE allows to investigate different means of increasing dynamic stability. The first of them is the changement of Automatic Voltage Regulator (AVR) control coefficients in Excitation_Regulator model as well as setpoints of field forcing, which is realised by logical_switch implementation in AVR model. The second one is series or parallel electrical breaking, Electrical_Braking and Electrical_Braking_Parallel accordingly, which efficiency depends on their active resistanse value. The third mean is fast turbine valving control or turbine fast valving (defined by T_regOff, T_regOn, Aimp, Timp, dTimp values) as well as automatic speed controller (ASC) parameters changement (Sigma and TauCup). The fourth mean is automatic reclosing, which was mentioned before. Finally, the fifth way to increase dynamic stability is generation or load reduction or disabling. 
