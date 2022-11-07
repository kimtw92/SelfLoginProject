// Decompiled by DJ v2.9.9.61 Copyright 2000 Atanas Neshkov  Date: 2003-07-05 ¿ÀÀü 10:34:50
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   ChartAppShell.java

package javachart.applet;

import java.awt.Component;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;

// Referenced classes of package javachart.applet:
//            ChartAppShell

class  extends MouseMotionAdapter
{

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

    ()
    {
    }
}