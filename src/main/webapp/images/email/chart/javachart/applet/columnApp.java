// Decompiled by DJ v2.9.9.61 Copyright 2000 Atanas Neshkov  Date: 2003-07-05 ¿ÀÀü 10:34:13
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   columnApp.java

package javachart.applet;

import java.applet.Applet;
import javachart.chart.*;

// Referenced classes of package javachart.applet:
//            ChartAppShell

public class columnApp extends ChartAppShell
{

    public void getMyOptions()
    {
        BarChart barchart = (BarChart)super.chart;
        String s = getParameter("barLabelsOn");
        if(s != null && s.indexOf("true") != -1)
            barchart.getBar().setLabelsOn(true);
        s = getParameter("barBaseline");
        if(s != null)
            barchart.getBar().setBaseline(Double.valueOf(s).doubleValue());
        s = getParameter("barClusterWidth");
        if(s != null)
            barchart.getBar().setClusterWidth(Double.valueOf(s).doubleValue());
        s = getParameter("barLabelAngle");
        if(s != null)
            barchart.getBar().setLabelAngle(Integer.parseInt(s));
    }

    public void init()
    {
        initLocale();
        super.chart = new BarChart("My Chart");
        getOptions();
    }

    public columnApp()
    {
    }
}