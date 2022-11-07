// Decompiled by DJ v2.9.9.61 Copyright 2000 Atanas Neshkov  Date: 2003-07-05 ¿ÀÀü 10:34:42
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   ChartAppShell.java

package javachart.applet;

import java.applet.Applet;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.net.*;
import java.text.Format;
import java.text.NumberFormat;
import java.util.StringTokenizer;
import java.util.Vector;
import javachart.chart.*;

// Referenced classes of package javachart.applet:
//            MessageFrame, ParameterParser, GetParam

public abstract class ChartAppShell extends Applet
    implements Runnable, GetParam
{

    public ChartAppShell()
    {
        home = true;
        networkInterval = -1;
        useDwellLabel = true;
        dwellLabelFormat = null;
        dwellUseXValue = true;
        dwellUseYValue = true;
        dwellUseString = false;
        secondsSoFar = 0;
        displayList = new Vector();
        showDataPopup = false;
        dwellLabelVisible = false;
        popupX = 0;
        popupY = 0;
    }

    public boolean closeURL(InputStream inputstream)
    {
        try
        {
            inputstream.close();
        }
        catch(IOException ioexception)
        {
            System.out.println("can't close URL");
            return false;
        }
        return true;
    }

    public void destroy()
    {
        stop();
        chart.setImage(null);
        chart = null;
        if(messageFrame != null)
            messageFrame.dispose();
    }

    protected void displayInfo(Vector vector)
    {
        for(int i = 0; i < vector.size(); i++)
        {
            Object obj = vector.elementAt(i);
            if(obj instanceof Datum)
            {
                dwellLabelXString = getDwellLabelXString((Datum)obj);
                dwellLabelYString = getDwellLabelYString((Datum)obj);
                dwellLabelLabelString = getDwellLabelLabelString((Datum)obj);
                showDataPopup = true;
                repaint();
                return;
            }
        }

    }

    protected void doDwellLabel()
    {
        if(dwellLabelVisible || !useDwellLabel)
            return;
        Point point = new Point(popupX, popupY);
        displayList.removeAllElements();
        if(chart.getDisplayList().contains(point, displayList))
            displayInfo(displayList);
    }

    void doVEMessage()
    {
        if(messageFrame == null)
        {
            messageFrame = new MessageFrame();
            messageFrame.setAppletContext(getAppletContext());
        }
        messageFrame.setVisible(true);
    }

    protected void drawDataPopup(Graphics g)
    {
        FontMetrics fontmetrics = g.getFontMetrics();
        int i = 0;
        StringTokenizer stringtokenizer = null;
        int j = 0;
        if(dwellLabelLabelString != null && dwellUseString)
            if(dwellLabelLabelString.indexOf("|") == -1)
            {
                i = fontmetrics.stringWidth(dwellLabelLabelString) + 6;
                j = 1;
            } else
            {
                int k = 0;
                boolean flag = false;
                for(stringtokenizer = new StringTokenizer(dwellLabelLabelString, "|"); stringtokenizer.hasMoreTokens();)
                {
                    int i1 = fontmetrics.stringWidth(stringtokenizer.nextToken());
                    if(i1 > k)
                        k = i1;
                    j++;
                }

                i = k + 6;
            }
        int l;
        if(dwellUseXValue)
            l = fontmetrics.stringWidth(dwellLabelXString) + 6;
        else
            l = 0;
        int j1;
        if(dwellUseYValue)
            j1 = fontmetrics.stringWidth(dwellLabelYString) + 6;
        else
            j1 = 0;
        int k1;
        if(i > l)
            k1 = i;
        else
            k1 = l;
        if(j1 > k1)
            k1 = j1;
        int l1 = fontmetrics.getHeight() + 4;
        int i2 = 4;
        if(dwellUseXValue)
            i2 += l1;
        if(dwellUseYValue)
            i2 += l1;
        if(dwellUseString)
            i2 += j * l1;
        if(popupX + k1 > getSize().width)
            popupX = getSize().width - k1 - 10;
        popupY = popupY - i2;
        if(popupY < 0)
            popupY = 0;
        g.setColor(Color.white);
        g.fillRect(popupX, popupY, k1, i2);
        g.setColor(Color.black);
        g.drawRect(popupX, popupY, k1, i2);
        g.drawLine(popupX + 1, popupY + i2 + 1, popupX + 1 + k1, popupY + 1 + i2);
        g.drawLine(popupX + k1 + 1, popupY + 1, popupX + 1 + k1, popupY + 1 + i2);
        int j2 = l1;
        if(dwellUseString && dwellLabelLabelString != null)
            if(stringtokenizer == null)
            {
                g.drawString(dwellLabelLabelString, popupX + 3, popupY + j2);
                j2 += l1;
            } else
            {
                for(StringTokenizer stringtokenizer1 = new StringTokenizer(dwellLabelLabelString, "|"); stringtokenizer1.hasMoreTokens();)
                {
                    g.drawString(stringtokenizer1.nextToken(), popupX + 3, popupY + j2);
                    j2 += l1;
                }

            }
        if(dwellUseXValue)
        {
            g.drawString(dwellLabelXString, popupX + 3, popupY + j2);
            j2 += l1;
        }
        if(dwellUseYValue)
            g.drawString(dwellLabelYString, popupX + 3, popupY + j2);
        popupY = popupY + i2;
    }

    public void drawMyStuff(Graphics g)
    {
        if(home)
        {
            return;
        } else
        {
            g.setColor(Color.blue);
            g.fillRect(getSize().width - 20, getSize().height - 20, 5, 5);
            return;
        }
    }

    protected String getDwellLabelLabelString(Datum datum)
    {
        String s = datum.getLabel();
        return s;
    }

    protected String getDwellLabelXString(Datum datum)
    {
        String s;
        if(dwellLabelFormat instanceof NumberFormat)
            s = dwellLabelFormat.format(datum.getX());
        else
            return dwellLabelFormat.format(new Double(datum.getX()));
        int i = dwellXString.indexOf("#");
        return dwellXString.substring(0, i) + s + dwellXString.substring(i + 1);
    }

    protected String getDwellLabelYString(Datum datum)
    {
        String s;
        if(dwellLabelFormat instanceof NumberFormat)
            s = dwellLabelFormat.format(datum.getY());
        else
            return dwellLabelFormat.format(new Double(datum.getY()));
        int i = dwellYString.indexOf("#");
        return dwellYString.substring(0, i) + s + dwellYString.substring(i + 1);
    }

    public void getMyDatasets(String s)
    {
    }

    public void getMyOptions()
    {
    }

    protected void getOptions()
    {
        installMouseAdapter();
        if(parser == null)
            parser = new ParameterParser(chart, this);
        if(getCodeBase().getHost().equals("www.ve.com"))
        {
            home = true;
        } else
        {
            String s = getParameter("CopyrightNotification");
            if(s != null)
                if(s.equals("KavaChart is a copyrighted work, and subject to full legal protection"))
                    home = true;
                else
                if(s.equals("JavaChart is a copyrighted work, and subject to full legal protection"))
                    home = true;
        }
        String s1 = getParameter("networkInterval");
        if(s1 != null)
            networkInterval = Integer.parseInt(s1);
        s1 = getParameter("dwellLabelsOn");
        if(s1 != null && s1.equalsIgnoreCase("false"))
            useDwellLabel = false;
        s1 = getParameter("dwellUseLabelString");
        if(s1 != null && s1.equalsIgnoreCase("true"))
            dwellUseString = true;
        s1 = getParameter("dwellUseXValue");
        if(s1 != null && s1.equalsIgnoreCase("false"))
            dwellUseXValue = false;
        s1 = getParameter("dwellUseYValue");
        if(s1 != null && s1.equalsIgnoreCase("false"))
            dwellUseYValue = false;
        s1 = getParameter("dwellXString");
        if(s1 != null)
            dwellXString = s1;
        else
            dwellXString = "X: #";
        s1 = getParameter("dwellYString");
        if(s1 != null)
            dwellYString = s1;
        else
            dwellYString = "Y: #";
        parser.getOptions();
        getMyOptions();
        if(dwellLabelFormat == null)
            dwellLabelFormat = NumberFormat.getInstance();
        s1 = getParameter("dwellLabelPrecision");
        if(s1 != null)
            dwellLabelFormat.setMaximumFractionDigits(Integer.parseInt(s1));
    }

    protected void initLocale()
    {
        String s = getParameter("defaultFont");
        if(s != null)
            Gc.defaultFont = ParameterParser.getFont(s);
        ParameterParser.setLocale(getParameter("locale"));
    }

    protected void installMouseAdapter()
    {
        addMouseListener(new MouseAdapter() {

            public void mousePressed(MouseEvent mouseevent)
            {
                if(!home)
                    doVEMessage();
            }

        });
        addMouseMotionListener(new MouseMotionAdapter() {

            public void mouseMoved(MouseEvent mouseevent)
            {
                if(showDataPopup && (Math.abs(mouseevent.getX() - popupX) > 3 || Math.abs(mouseevent.getY() - popupY) > 3))
                {
                    showDataPopup = false;
                    repaint();
                }
                popupX = mouseevent.getX();
                popupY = mouseevent.getY();
            }

        });
    }

    public Image makeURLImage(String s)
    {
        Image image = getImage(getCodeBase(), s);
        if(!gotImages)
        {
            imageTracker = new MediaTracker(this);
            gotImages = true;
        }
        imageTracker.addImage(image, 0);
        return image;
    }

    public InputStream openURL(String s)
    {
        URL url;
        try
        {
            url = new URL(s);
        }
        catch(MalformedURLException malformedurlexception)
        {
            try
            {
                String s1 = getDocumentBase().toExternalForm();
                String s2 = s1.substring(0, s1.lastIndexOf("/") + 1);
                url = new URL(s2 + s);
            }
            catch(MalformedURLException malformedurlexception1)
            {
                System.out.println("couldn't open " + s);
                return null;
            }
        }
        InputStream inputstream;
        try
        {
            URLConnection urlconnection = url.openConnection();
            urlconnection.setUseCaches(false);
            inputstream = urlconnection.getInputStream();
        }
        catch(IOException ioexception)
        {
            System.out.println("can't open stream " + s);
            return null;
        }
        return inputstream;
    }

    public void paint(Graphics g)
    {
        if(gotImages)
            try
            {
                imageTracker.waitForID(0);
            }
            catch(InterruptedException interruptedexception)
            {
                return;
            }
        try
        {
            chart.paint(this, g);
        }
        catch(OutOfMemoryError outofmemoryerror)
        {
            System.out.println("out of memory, no label rotation or double-buffering");
            showStatus("low memory");
            chart.setStringRotator(null);
            chart.setImage(null);
            chart.drawGraph(g);
        }
        drawMyStuff(g);
        if(showDataPopup)
        {
            drawDataPopup(g);
            dwellLabelVisible = true;
        } else
        {
            dwellLabelVisible = false;
        }
    }

    protected void reReadURLDatasets()
    {
        parser.reReadURLDatasets();
    }

    public void run()
    {
        while(true) 
            try
            {
                Thread.sleep(1000L);
                if(networkInterval != -1 && secondsSoFar > networkInterval)
                {
                    secondsSoFar = 0;
                    reReadURLDatasets();
                    showDataPopup = false;
                    repaint();
                } else
                {
                    doDwellLabel();
                    secondsSoFar++;
                }
            }
            catch(InterruptedException interruptedexception) { }
    }

    public void start()
    {
        if(useDwellLabel)
            chart.setUseDisplayList(true);
        else
            chart.setUseDisplayList(false);
        if(getThread == null)
        {
            getThread = new Thread(this);
            getThread.start();
        }
    }

    public void stop()
    {
        if(getThread != null)
        {
            getThread.stop();
            getThread = null;
        }
    }

    public void update(Graphics g)
    {
        paint(g);
    }

    protected boolean home;
    public ChartInterface chart;
    protected ParameterParser parser;
    protected Thread getThread;
    protected int networkInterval;
    protected MediaTracker imageTracker;
    protected boolean gotImages;
    static MessageFrame messageFrame;
    protected boolean useDwellLabel;
    protected NumberFormat dwellLabelFormat;
    protected boolean dwellUseXValue;
    protected boolean dwellUseYValue;
    protected boolean dwellUseString;
    protected String dwellXString;
    protected String dwellYString;
    private int secondsSoFar;
    protected Vector displayList;
    protected boolean showDataPopup;
    protected boolean dwellLabelVisible;
    protected int popupX;
    protected int popupY;
    protected String dwellLabelXString;
    protected String dwellLabelYString;
    protected String dwellLabelLabelString;
}