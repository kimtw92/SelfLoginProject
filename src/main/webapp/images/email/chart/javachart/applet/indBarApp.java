package javachart.applet;

import javachart.chart.IndBarChart;


public class indBarApp extends ChartAppShell {

			  
	public void getMyOptions() {
		String 		str;
		IndBarChart	b;
		b = (IndBarChart) chart;

	 	str = getParameter("barLabelsOn");
	 	if(str != null)
	 		if(str.indexOf("true") != -1)
	 			b.getBar().setLabelsOn(true);
	 	str = getParameter("barBaseline");
	 	if(str != null)
	 		b.getBar().setBaseline((Double.valueOf(str)).doubleValue());
	 	str = getParameter("barClusterWidth");
	 	if(str != null)
	 		b.getBar().setClusterWidth((Double.valueOf(str)).doubleValue());
		str = getParameter("barLabelAngle");
	 	if(str != null)
		 	b.getBar().setLabelAngle(Integer.parseInt(str));
	}
	public void init () {			  
		initLocale();
		chart = new IndBarChart("My Chart");
		getOptions();
	}
}