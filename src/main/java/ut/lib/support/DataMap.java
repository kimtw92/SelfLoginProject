package ut.lib.support;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import ut.lib.log.Log;
import ut.lib.util.Constants;

public class DataMap extends DataProtocol {

    public DataMap(String s) {
        name = s;
    }

    public DataMap(int i, float f) {
        super(i, f);
    }

    public DataMap(int i) {
        super(i);
    }

    public DataMap() {

    }

    public DataMap(Map map) {
        super(map);
    }

    public DataMap(int i, float f, boolean flag) {
        super(i, f, flag);
    }

    public void set(Object obj, Object obj1)
    {
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(obj1);
        super.put(obj, arraylist);
    }

    public void setString(Object obj, String s)
    {
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(s);
        super.put(obj, arraylist);
    }

    public void putString(Object obj, String s)
    {
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(s);
        super.put(obj, arraylist);
    }

    public void setInt(Object obj, int i)
    {
        Integer integer = new Integer(i);
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(integer);
        super.put(obj, arraylist);
    }

    public void putInt(Object obj, int i)
    {
        Integer integer = new Integer(i);
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(integer);
        super.put(obj, arraylist);
    }

    public void setDouble(Object obj, double d)
    {
        Double double1 = new Double(d);
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(double1);
        super.put(obj, arraylist);
    }

    public void putDouble(Object obj, double d)
    {
        Double double1 = new Double(d);
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(double1);
        super.put(obj, arraylist);
    }

    public void setFloat(Object obj, float f)
    {
        Float float1 = new Float(f);
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(float1);
        super.put(obj, arraylist);
    }

    public void putFloat(Object obj, float f)
    {
        Float float1 = new Float(f);
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(float1);
        super.put(obj, arraylist);
    }

    public void setLong(Object obj, long l)
    {
        Long long1 = new Long(l);
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(long1);
        super.put(obj, arraylist);
    }

    public void putLong(Object obj, long l)
    {
        Long long1 = new Long(l);
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(long1);
        super.put(obj, arraylist);
    }

    public void setShort(Object obj, short word0)
    {
        Short short1 = new Short(word0);
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(short1);
        super.put(obj, arraylist);
    }

    public void putShort(Object obj, short word0)
    {
        Short short1 = new Short(word0);
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(short1);
        super.put(obj, arraylist);
    }

    public void setBoolean(Object obj, boolean flag)
    {
        Boolean boolean1 = new Boolean(flag);
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(boolean1);
        super.put(obj, arraylist);
    }

    public void putBoolean(Object obj, boolean flag)
    {
        Boolean boolean1 = new Boolean(flag);
        ArrayList arraylist = new ArrayList(1);
        arraylist.add(boolean1);
        super.put(obj, arraylist);
    }


    public void add(Object obj, Object obj1)
    {
        if(!super.containsKey(obj))
        {
            ArrayList arraylist = new ArrayList();
            arraylist.add(obj1);
            super.put(obj, arraylist);
        } else
        {
            ArrayList arraylist1 = (ArrayList)super.get(obj);
            arraylist1.add(obj1);
        }
    }

    public void addString(Object obj, String s)
    {
        if(!super.containsKey(obj))
        {
            ArrayList arraylist = new ArrayList();
            arraylist.add(s);
            super.put(obj, arraylist);
        } else
        {
            ArrayList arraylist1 = (ArrayList)super.get(obj);
            arraylist1.add(s);
        }
    }

    public void addInt(Object obj, int i)
    {
        Integer integer = new Integer(i);
        if(!super.containsKey(obj))
        {
            ArrayList arraylist = new ArrayList();
            arraylist.add(integer);
            super.put(obj, arraylist);
        } else
        {
            ArrayList arraylist1 = (ArrayList)super.get(obj);
            arraylist1.add(integer);
        }
    }

    public void addDouble(Object obj, double d)
    {
        Double double1 = new Double(d);
        if(!super.containsKey(obj))
        {
            ArrayList arraylist = new ArrayList();
            arraylist.add(double1);
            super.put(obj, arraylist);
        } else
        {
            ArrayList arraylist1 = (ArrayList)super.get(obj);
            arraylist1.add(double1);
        }
    }

    public void addFloat(Object obj, float f)
    {
        Float float1 = new Float(f);
        if(!super.containsKey(obj))
        {
            ArrayList arraylist = new ArrayList();
            arraylist.add(float1);
            super.put(obj, arraylist);
        } else
        {
            ArrayList arraylist1 = (ArrayList)super.get(obj);
            arraylist1.add(float1);
        }
    }

    public void addLong(Object obj, long l)
    {
        Long long1 = new Long(l);
        if(!super.containsKey(obj))
        {
            ArrayList arraylist = new ArrayList();
            arraylist.add(long1);
            super.put(obj, arraylist);
        } else
        {
            ArrayList arraylist1 = (ArrayList)super.get(obj);
            arraylist1.add(long1);
        }
    }

    public void addShort(Object obj, short word0)
    {
        Short short1 = new Short(word0);
        if(!super.containsKey(obj))
        {
            ArrayList arraylist = new ArrayList();
            arraylist.add(short1);
            super.put(obj, arraylist);
        } else
        {
            ArrayList arraylist1 = (ArrayList)super.get(obj);
            arraylist1.add(short1);
        }
    }

    public void addBoolean(Object obj, boolean flag)
    {
        Boolean boolean1 = new Boolean(flag);
        if(!super.containsKey(obj))
        {
            ArrayList arraylist = new ArrayList();
            arraylist.add(boolean1);
            super.put(obj, arraylist);
        } else
        {
            ArrayList arraylist1 = (ArrayList)super.get(obj);
            arraylist1.add(boolean1);
        }
    }


    public Object get(Object obj)
    {
        if (Constants.DATAMAP_DEBUG) {
            if (!super.containsKey(obj)) {
                System.out.println("- Warning!!! >> ??? ???= : " + obj.toString());
            }
        }

        Object item = super.get(obj);
        
        ArrayList arr = null;
        
        if(item instanceof ArrayList){
        	arr = (ArrayList)super.get(obj);
        }else{
        	if(item == null)
            {
                if(nullToInitialize)
                    return "";
                else
                    return null;
            } else
            {
                return item;
            }
        }
        

        if(arr == null)
        {
            if(nullToInitialize)
                return "";
            else
                return null;
        } else
        {
//            return arr.get(0);
        	Object o = arr.get(0);
            if(o == null){
                return "";
            }
            else
                return o;
        }
    }

    public int getInt(Object obj) {
        if (Constants.DATAMAP_DEBUG) {
            if (!super.containsKey(obj)) {
                System.out.println("- Warning!!! >> ??? ???= : " + obj.toString());
            }
        }

        ArrayList arr = (ArrayList)super.get(obj);

        if(arr == null) {
            if(nullToInitialize)
            {
                return 0;
            } else
            {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                throw new RuntimeException("[Exception in DataMap] Value Type(int) does not match : It's type is not int.");
            }

   		} else  {
            Object obj1 = arr.get(0);
            if (obj1 == null) {
                if(nullToInitialize)
                {
                    return 0;
                } else
                {
                    Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                    throw new RuntimeException("[Exception in DataMap] Value Type(int) does not match : It's type is not int.");
                }
            } else {
		        Class class1 = obj1.getClass();
		        if(class1 == java.lang.Integer.class)
		            return ((Integer)arr.get(0)).intValue();
		        if(class1 == java.lang.Short.class)
		            return ((Short)arr.get(0)).shortValue();
		        if(class1 == Double.class)
		        	return ((Double)arr.get(0)).intValue();
		        if(class1 == BigDecimal.class)
		        	return ((BigDecimal)arr.get(0)).intValue();
		        if(class1 == java.lang.String.class)
		        {
		            try
		            {
		                return Integer.parseInt(arr.get(0).toString());
		            }
		            catch(Exception exception)
		            {
		                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ")" + " Type(int) does not match : It's type is not int.");
		                throw new RuntimeException("[Exception in DataMap] Value Type(int) does not match : It's type is not int.");
		            }
		        } else
		        {
		            Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ")" + " Type(int) does not match : It's type is not int.");
	                throw new RuntimeException("[Exception in DataMap] Value Type(int) does not match : It's type is not int.");
		        }
            }
        }
    }

    public double getDouble(Object obj)
    {
        if (Constants.DATAMAP_DEBUG) {
            if (!super.containsKey(obj)) {
                System.out.println("- Warning!!! >> ??? ???= : " + obj.toString());
            }
        }
        ArrayList arr = (ArrayList)super.get(obj);

        if (arr != null) {
            Object obj1 = arr.get(0);
            if(obj1 == null)
                if(nullToInitialize)
                {
                    return 0.0D;
                } else
                {
                    Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                    throw new RuntimeException("[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                }
            Class class1 = obj1.getClass();
            if(class1 == java.lang.Double.class)
                return ((Double)obj1).doubleValue();
            if(class1 == java.lang.Float.class)
                return (double)((Float)obj1).floatValue();
            if(class1 == BigDecimal.class)
            	return ((BigDecimal)obj1).doubleValue();
            if(class1 == java.lang.String.class) {
                try
                {
                    return Double.parseDouble(obj1.toString());
                }
                catch(Exception exception)
                {
                    Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ")" + " Type(double) does not match : It's type is not double.");
                }
                throw new RuntimeException("[Exception in DataMap] Value Type(double) does not match : It's type is not double.");
            } else {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ")" + " Type(double) does not match : It's type is not double.");
                throw new RuntimeException("[Exception in DataMap] Value Type(double) does not match : It's type is not double.");
            }
        } else {
            if(nullToInitialize)
            {
                return 0.0D;
            } else
            {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                throw new RuntimeException("[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
            }
        }
    }

    public float getFloat(Object obj)
    {
        if (Constants.DATAMAP_DEBUG) {
            if (!super.containsKey(obj)) {
                System.out.println("- Warning!!! >> ??? ???= : " + obj.toString());
            }
        }

        ArrayList arr = (ArrayList)super.get(obj);

        if (arr != null) {
            Object obj1 = arr.get(0);
            if(obj1 == null)
                if(nullToInitialize)
                {
                    return 0.0F;
                } else
                {
                    Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                    throw new RuntimeException("[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                }
            Class class1 = obj1.getClass();
            if(class1 == java.lang.Float.class)
                return ((Float)obj1).floatValue();
            if(class1 == BigDecimal.class)
            	return ((BigDecimal)obj1).floatValue();
            if(class1 == java.lang.String.class)
            {
                try
                {
                    return Float.parseFloat(obj1.toString());
                }
                catch(Exception exception)
                {
                    Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ")" + " Type(float) does not match : It's type is not float.");
                }
                throw new RuntimeException("[Exception in DataMap] Value Type(float) does not match : It's type is not float.");
            } else
            {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ")" + " Type(float) does not match : It's type is not float.");
                throw new RuntimeException("[Exception in DataMap] Value Type(float) does not match : It's type is not float.");
            }
        } else {
            if(nullToInitialize)
            {
                return 0.0F;
            } else
            {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                throw new RuntimeException("[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
            }
        }
    }

    public long getLong(Object obj)
    {
        if (Constants.DATAMAP_DEBUG) {
            if (!super.containsKey(obj)) {
                System.out.println("- Warning!!! >> ??? ???= : " + obj.toString());
            }
        }

        ArrayList arr = (ArrayList)super.get(obj);

        if (arr != null) {
            Object obj1 = arr.get(0);
            if(obj1 == null)
                if(nullToInitialize)
                {
                    return 0L;
                } else
                {
                    Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                    throw new RuntimeException("[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                }
            Class class1 = obj1.getClass();
            if(class1 == java.lang.Long.class)
                return ((Long)obj1).longValue();
            if(class1 == java.lang.Integer.class)
                return (long)((Integer)obj1).intValue();
            if(class1 == java.lang.Short.class)
                return (long)((Short)obj1).shortValue();
            if(class1 == BigDecimal.class)
            	return ((BigDecimal)obj1).longValue();
            if(class1 == java.lang.String.class)
            {
                try
                {
                    return Long.parseLong(obj1.toString());
                }
                catch(Exception exception)
                {
                    Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ")" + " Type(long) does not match : It's type is not long.");
                }
                throw new RuntimeException("[Exception in DataMap] Value Type(long) does not match : It's type is not long.");
            } else
            {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ")" + " Type(long) does not match : It's type is not long.");
                throw new RuntimeException("[Exception in DataMap] Value Type(long) does not match : It's type is not long.");
            }
        } else {
            if(nullToInitialize)
            {
                return 0L;
            } else
            {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                throw new RuntimeException("[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
            }
        }

    }

    public short getShort(Object obj)
    {
        if (Constants.DATAMAP_DEBUG) {
            if (!super.containsKey(obj)) {
                System.out.println("- Warning!!! >> ??? ???= : " + obj.toString());
            }
        }
        ArrayList arr = (ArrayList)super.get(obj);


        if (arr != null) {
            Object obj1 = arr.get(0);

            if(obj1 == null) {
                if (nullToInitialize) {
                    return 0;
                } else {
                    Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                    throw new RuntimeException("[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                }
            }
            Class class1 = obj1.getClass();
            if(class1 == java.lang.Short.class)
                return ((Short)obj1).shortValue();
            if(class1 == BigDecimal.class)
            	return ((BigDecimal)obj1).shortValue();
            if(class1 == java.lang.String.class)
            {
                try
                {
                    return Short.parseShort(obj1.toString());
                }
                catch(Exception exception)
                {
                    Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ")" + " Type(short) does not match : It's type is not short.");
                }
                throw new RuntimeException("[Exception in DataMap] Value Type(short) does not match : It's type is not short.");
            } else
            {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ")" + " Type(short) does not match : It's type is not short.");
                throw new RuntimeException("[Exception in DataMap] Value Type(short) does not match : It's type is not short.");
            }
        } else {
            if (nullToInitialize) {
                return 0;
            } else {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                throw new RuntimeException("[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
            }
        }
    }

    public boolean getBoolean(Object obj)
    {
        if (Constants.DATAMAP_DEBUG) {
            if (!super.containsKey(obj)) {
                System.out.println("- Warning!!! >> ??? ???= : " + obj.toString());
            }
        }

        ArrayList arr = (ArrayList)super.get(obj);

        if (arr != null) {
            Object obj1 = arr.get(0);
            if(obj1 == null) {
                if(nullToInitialize) {
                    return false;
                } else {
                    Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                    throw new RuntimeException("[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                }
            } else {
                if(obj1.getClass().isInstance(new Boolean(true)))
                    return ((Boolean)obj1).booleanValue();
                if(obj1.getClass().isInstance(new String()))
                {
                    try
                    {
                        return Boolean.getBoolean(obj1.toString());
                    }
                    catch(Exception exception)
                    {
                        Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ")" + " Type(boolean) does not match : It's type is not boolean.");
                    }
                    throw new RuntimeException("[Exception in DataMap] Value Type(boolean) does not match : It's type is not boolean.");
                } else
                {
                    Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ")" + " Type(boolean) does not match : It's type is not boolean.");
                    throw new RuntimeException("[Exception in DataMap] Value Type(boolean) does not match : It's type is not boolean.");
                }
            }
        } else {
            if(nullToInitialize) {
                return false;
            } else {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
                throw new RuntimeException("[Exception in DataMap] Key(" + obj + ") does not exist in " + name + " DataMap or Key(" + obj + ")'s value is null.");
            }
        }
    }

    public String getString(Object obj)
    {
        if (Constants.DATAMAP_DEBUG) {
            if (!super.containsKey(obj)) {
                System.out.println("- Warning!!! >> ??? ???= : " + obj.toString());
            }
        }
        ArrayList arr = (ArrayList)super.get(obj);

        if (arr != null) {
            Object obj1 = arr.get(0);

            if (obj1 != null) {
                return obj1.toString();
            } else {
                if(nullToInitialize)
                    return "";
                else
                    return null;
            }
        } else {
            if(nullToInitialize)
                return "";
            else
                return null;
        }
    }


    private Object getObj(Object obj, int i)
    {
        if (Constants.DATAMAP_DEBUG) {
            if (!super.containsKey(obj)) {
                System.out.println("- Warning!!! >> ??? ???= : " + obj.toString());
            }
        }

        Object obj1 = null;
        ArrayList arraylist = (ArrayList)super.get(obj);
        if(arraylist == null) {
            if(nullToInitialize) {
                return null;
            } else {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in DataMap(" + name + ") ");
            }
        }

        try {
            obj1 = arraylist.get(i);
        } catch(IndexOutOfBoundsException indexoutofboundsexception) {
            Log.error(this.getClass(), "[IndexOutOfBoundsException in DataMap] Index(" + i + ") in DataMap(" + name + ") is out of Bounds.");
        }
        return obj1;
    }

    public Object get(Object obj, int i)
    {
        return getObj(obj, i);
    }

    public int getInt(Object obj, int i)
    {
        Object obj1 = getObj(obj, i);
        if(obj1 == null)
            return 0;
        Class class1 = obj1.getClass();
        if(class1 == java.lang.Integer.class)
            return ((Integer)obj1).intValue();
        if(class1 == java.lang.Short.class)
            return ((Short)obj1).shortValue();
        if(class1 == BigDecimal.class)
        	return ((BigDecimal)obj1).intValue();
        if(class1 == java.lang.String.class)
        {
            try
            {
                return Integer.parseInt(obj1.toString());
            }
            catch(Exception exception)
            {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in DataMap(" + name + ") ");
            }
            throw new RuntimeException("[Exception in DataMap] Value of the Key(" + obj + ") Type(int) does not match : It's type is not int");
        } else
        {
            Log.error(this.getClass(), "[Exception in DataMap] Value of the Key(" + obj + ") Type(int) does not match : It's type is not int");
            throw new RuntimeException("[Exception in DataMap] Value of the Key(" + obj + ") Type(int) does not match : It's type is not int");
        }
    }

    public double getDouble(Object obj, int i)
    {
        Object obj1 = getObj(obj, i);
        if(obj1 == null)
            return 0.0D;
        Class class1 = obj1.getClass();
        if(class1 == java.lang.Double.class)
            return ((Double)obj1).doubleValue();
        if(class1 == java.lang.Float.class)
            return (double)((Float)obj1).floatValue();
        if(class1 == BigDecimal.class)
        	return ((BigDecimal)obj1).doubleValue();
        if(class1 == java.lang.String.class)
        {
            try
            {
                return Double.parseDouble(obj1.toString());
            }
            catch(Exception exception)
            {
                Log.error(this.getClass(), "[Exception in DataMap] Value of the Key(" + obj + ") Type(double) does not match : It's type is not double");
            }
            throw new RuntimeException("[Exception in DataMap] Value of the Key(" + obj + ") Type(double) does not match : It's type is not double");
        } else
        {
            Log.error(this.getClass(), "[Exception in DataMap] Value of the Key(" + obj + ")  Type(double) does not match : It's type is not double");
            throw new RuntimeException("[Exception in DataMap] Value of the Key(" + obj + ")  Type(double) does not match : It's type is not double");
        }
    }

    public float getFloat(Object obj, int i)
    {
        Object obj1 = getObj(obj, i);
        if(obj1 == null)
            return 0.0F;
        Class class1 = obj1.getClass();
        if(class1 == java.lang.Float.class)
            return ((Float)obj1).floatValue();
        if(class1 == BigDecimal.class)
        	return ((BigDecimal)obj1).floatValue();
        if(class1 == java.lang.String.class)
        {
            try
            {
                return Float.parseFloat(obj1.toString());
            }
            catch(Exception exception)
            {
                Log.error(this.getClass(), "[Exception in DataMap] Value of the Key(" + obj + ") Type(float) does not match : It's type is not float");
                System.out.print(this.getClass() + "[Exception in DataMap] Value of the Key(" + obj + ") Type(float) does not match : It's type is not float");
            }
            throw new RuntimeException("[Exception in DataMap] Value of the Key(" + obj + ") Type(float) does not match : It's type is not float");
        } else {
            Log.error(this.getClass(), "[Exception in DataMap] Value of the Key(" + obj + ") Type(float) does not match : It's type is not float");
            System.out.print(this.getClass() + "[Exception in DataMap] Value of the Key(" + obj + ") Type(float) does not match : It's type is not float");
            throw new RuntimeException("[Exception in DataMap] Value of the Key(" + obj + ") Type(float) does not match : It's type is not float");
        }
        
    }

    public long getLong(Object obj, int i)
    {
        Object obj1 = getObj(obj, i);
        if(obj1 == null)
            return 0L;
        Class class1 = obj1.getClass();
        if(class1 == java.lang.Long.class)
            return ((Long)obj1).longValue();
        if(class1 == java.lang.Integer.class)
            return (long)((Integer)obj1).intValue();
        if(class1 == java.lang.Short.class)
            return (long)((Short)obj1).shortValue();
        if(class1 == BigDecimal.class)
        	return ((BigDecimal)obj1).longValue();
        if(class1 == java.lang.String.class)
        {
            try
            {
                return Long.parseLong(obj1.toString());
            }
            catch(Exception exception)
            {
                Log.error(this.getClass(), "[Exception in DataMap] Value of the Key(" + obj + ") Type(long) does not match : It's type is not long");
            }
            throw new RuntimeException("[Exception in DataMap] Value of the Key(" + obj + ") Type(long) does not match : It's type is not long");
        } else
        {
            Log.error(this.getClass(), "[Exception in DataMap] Value of the Key(" + obj + ") Type(long) does not match : It's type is not long");
            throw new RuntimeException("[Exception in DataMap] Value of the Key(" + obj + ") Type(long) does not match : It's type is not long");
        }
    }

    public short getShort(Object obj, int i)
    {
        Object obj1 = getObj(obj, i);
        if(obj1 == null)
            return 0;
        Class class1 = obj1.getClass();
        if(class1 == java.lang.Short.class)
            return ((Short)obj1).shortValue();
        if(class1 == BigDecimal.class)
        	return ((BigDecimal)obj1).shortValue();
        if(class1 == java.lang.String.class)
        {
            try
            {
                return Short.parseShort(obj1.toString());
            }
            catch(Exception exception)
            {
                Log.error(this.getClass(), "Key(" + obj + ")" + " Type(short) does not match : It's type is not short");
                return 0;
            }

        } else
        {
            Log.error(this.getClass(), "Key(" + obj + ")" + " Type(short) does not match : It's type is not short");
            return 0;

        }
    }

    public boolean getBoolean(Object obj, int i)
    {
        Object obj1 = getObj(obj, i);
        if(obj1 == null)
            return false;
        Class class1 = obj1.getClass();

        if(class1 == java.lang.Boolean.class) {
            return ((Boolean)obj1).booleanValue();
        }

        if(class1 == java.lang.String.class)
        {
            try
            {
                return Boolean.getBoolean(obj1.toString());
            }
            catch(Exception exception)
            {
                Log.error(this.getClass(), "[Exception in DataMap] Value of the Key(" + obj + ") Type(short) does not match : It's type is not short");
                return false;
            }
        } else
        {
            Log.error(this.getClass(), "[Exception in DataMap] Value of the Key(" + obj + ") Type(short) does not match : It's type is not short");
            return false;
        }
    }

    public String getString(Object obj, int i)
    {
        Object obj1 = null;
        try {
            obj1 = getObj(obj, i);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(obj1 == null)
        {
            if(isNullToInitialize())
                return "";
            else
                return null;
        } else
        {
            return obj1.toString();
        }
    }

    public Object[] toArray(Object obj) {
        if (Constants.DATAMAP_DEBUG) {
            if (!super.containsKey(obj)) {
                System.out.println("- Warning!!! >> ??? ???= : " + obj.toString());
            }
        }

        Object[] obj1 = null;
        ArrayList arraylist = (ArrayList)super.get(obj);
        if(arraylist == null) {
            if(nullToInitialize) {
                return null;
            } else {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in DataMap(" + name + ") ");
            }
        }
        obj1 = arraylist.toArray();
        return obj1;
    }

    public Object[] toArray(Object obj, Object[] obj1) {
        if (Constants.DATAMAP_DEBUG) {
            if (!super.containsKey(obj)) {
                System.out.println("- Warning!!! >> ??? ???= : " + obj.toString());
            }
        }

        Object[] obj2 = null;
        ArrayList arraylist = (ArrayList)super.get(obj);
        if(arraylist == null) {
            if(nullToInitialize) {
                return null;
            } else {
                Log.error(this.getClass(), "[Exception in DataMap] Key(" + obj + ") does not exist in DataMap(" + name + ") ");
            }
        }
        obj2 = arraylist.toArray(obj1);
        return obj2;
    }

    public Object remove(Object obj, int i)
    {
        if(super.containsKey(obj))
            return ((ArrayList)super.get(obj)).remove(i);
        else
            return null;
    }

    public int keySize(Object obj)
    {
        if(super.containsKey(obj))
            return ((ArrayList)super.get(obj)).size();
        else
            return 0;
    }

    public int keySize()
    {
        Set set = super.keySet();
        Iterator iterator = set.iterator();
        if(iterator.hasNext())
        {
            String s = iterator.next().toString();
            return ((ArrayList)super.get(s)).size();
        } else
        {
            return 0;
        }
    }

    public synchronized String toString()
    {
        int i = super.size() - 1;
        StringBuffer stringbuffer = new StringBuffer();
        Set set = super.entrySet();
        Iterator iterator = set.iterator();
        stringbuffer.append("{");
        for(int j = 0; j <= i; j++)
        {
            Object obj = iterator.next();
            if(obj == null)
                stringbuffer.append("");
            else
                stringbuffer.append(obj.toString());
            if(j < i)
                stringbuffer.append(", ");
        }

        stringbuffer.append("}");
        return "DataMap[" + getName() + "]=" + stringbuffer.toString();
    }
    
    public DataMap putAll(List<? extends Map> arg0) {
    	
    	if(arg0 == null || arg0.size() == 0){
    		return this;
    	}
    	
    	for(Map m : arg0){
    		for(Object key : m.keySet()){
    			Object value = m.get(key);
    			add(key, value);
    		}
    	}
    	
    	return this;
    }
    
    @Override
    public Object put(Object paramK, Object paramV) {
    	
//    	if(paramK.toString().indexOf("_") != -1){
    		return super.put(RsConverter.getAttributeName(paramK.toString().toLowerCase()), paramV);
//    	}else{
//    		return super.put(paramK, paramV);
//    	}
    	
    }

}