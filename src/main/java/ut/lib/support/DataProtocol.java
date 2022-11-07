package ut.lib.support;

import java.util.LinkedHashMap;
import java.util.Map;

public class DataProtocol extends LinkedHashMap
{

    public DataProtocol(int i, float f)
    {
        super(i, f);
        name = null;
        nullToInitialize = false;
    }

    public DataProtocol(int i)
    {
        super(i);
        name = null;
        nullToInitialize = false;
    }

    public DataProtocol()
    {
        name = null;
        nullToInitialize = false;
    }

    public DataProtocol(Map map)
    {
        super(map);
        name = null;
        nullToInitialize = false;
    }

    public DataProtocol(int i, float f, boolean flag)
    {
        super(i, f, flag);
        name = null;
        nullToInitialize = false;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String s)
    {
        name = s;
    }

    public boolean isNullToInitialize()
    {
        return nullToInitialize;
    }

    public void setNullToInitialize(boolean flag)
    {
        nullToInitialize = flag;
    }

    protected String name;
    protected boolean nullToInitialize;
}