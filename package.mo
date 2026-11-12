within ;
package OMLET

  annotation (Coordsys(
      extent=[0, 0; 791, 630],
      grid=[2, 2],
      component=[20, 20]), Window(
      x=0.11,
      y=0.01,
      width=0.42,
      height=0.64,
      library=1,
      autolayout=1),
    uses(Modelica(version="4.0.0")),
    Icon(coordinateSystem(extent={{-660,-640},{791,630}}),
         graphics={Bitmap(extent={{-562,-440},{644,386}}, fileName=
              "modelica://OMLET/Images/f_27-10-2025-05-58-30.1761544711.jpg")}),
    Documentation(info="<html>
<p><b><span style=\"font-family: Arial Black; font-size: 10pt;\">Open Modelica Library for Electrovechanical Transients</span></b></p>
<p>OMLET is a libary for power enerygy system, developed and maintained by<span style=\"font-family: YS 58; background-color: #ffffff;\"> </span>the staff of the <a href=\"https://ie.spbstu.ru/department/vysshaya_shkola_elektroenergeticheskih_sistem/\">Higher School of Electrical Power Systems</a> of the<span style=\"font-family: YS 58; background-color: #ffffff;\"> </span><a href=\"https://www.spbstu.ru/\">Peter the Great St. Petersburg Polytechnic University</a>, led by <a href=\"http://belyaev.spb.ru/\">Belyaev Andrey Nikolaevich</a>. </p>
<p>Ths library allows to create dynamic calculation model of power energy system and to investigate electromechanical transient processes. </p>
<p>All equations are written for the 0qd coordinate system. Parameters and variables, are given both in relative and numerical units. </p>
<p>A brief guide to using the library is located in the UsersGuide. folder. </p>
<p>The main connectors, which are used to link model elements, are located in the Interfaces folder.</p>
<p>Basic components which are used to create new model, are located in package <span style=\"font-family: Arial;\"><a href=\"modelica://LEPSE.Basic\">Basic</a></span> . </p>
<p>Several examples of different power energy systems are located in package <span style=\"font-family: Arial;\"><a href=\"modelica://LEPSE.Examples\">Examples</a></span>. </p>
<p>The authors can be contacted by email: andrej.florinskiy@gmail.com.</p>
<p><br><span style=\"font-family: Arial; font-size: 10pt;\">Licensed by &lt;A. A. Florinskii&gt; under the<span style=\"background-color: #ffff00;\"> Modelica License&nbsp;2</span></p>
<p><span style=\"font-family: Arial; font-size: 10pt;\">Copyright &copy; &lt;2002&gt;-&lt;2027&gt;, &lt;A. N. Belyaev&gt;.</span></p>
<p><i><span style=\"font-family: Arial; font-size: 10pt; background-color: #ffff00;\">This Modelica package is&nbsp;<u>free</u>&nbsp;software and the use is completely at&nbsp;<u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License&nbsp;2. For license conditions (including the disclaimer of warranty) see&nbsp;<a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a>&nbsp;or visit&nbsp;<a href=\"http://www.modelica.org/licenses/ModelicaLicense2\">http://www.modelica.org/licenses/ModelicaLicense2</a>.</span></i></p>
<p><br><b><span style=\"font-family: Arial Black; font-size: 10pt;\">Библиотека элекментов электроэнергетической системы</span></b></p>
<p>OMLET - это библиотека элементов электроэнергетической системы, разработанная и поддерживаемая сотрудниками Высшей школы электроэнергетических систем (ВШЭС) ФГАОУ ВО &quot;СПбПУ Петра Великого&quot;, под руководством <a href=\"https://belyaev.spb.ru/\">Андрея Николаевич Беляева</a>. </p>
<p>Библиотека позволяет создавать динамические расчетные модели энергосистемы и проводить исследования электромеханических переходных процессов. </p>
<p>Все уравнения рассчитываются в 0qd-системе координат. Параметры и переменные представлены как в относительных, так и в именоанных единицах. </p>
<p>Краткое руководство по использованию библиотеки находится в папке UsersGuide. </p>
<p>Основные коннекторы, с помощью которых осуществляется связь элементов модели, находятся в папке Interfaces. </p>
<p>Базовые модели, позвляющие создавать новые модели, представлены в папке Basic. </p>
<p>Несколько примеров различных энергосистем расположены в папке Examples. </p>
<p>Связаться с авторами можно по почте: <a href=\"mailto:andrej.florinskiy@gmail.com\">andrej.florinskiy@gmail.com</a></p>
<p>Лицензировано &lt;А. А. Флоринским&gt; по лицензии <span style=\"background-color: #ffff00;\">BSD 3-Clause.</span></p>
<p>Авторское право &copy; &lt;2002&gt;-&lt;2027&gt;, &lt;Беляев А.Н.&gt;.</p>
<p>Эта библиотека на языке Моделика является бесплатным и свободно распространяемым ПО. Использование библиотеки в коммерческих целях запрещено в соответствии с лицензией. </p>
</html>"),
    Diagram(coordinateSystem(extent={{-660,-640},{791,630}})));
end OMLET;
