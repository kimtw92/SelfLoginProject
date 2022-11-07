package ut.lib.util;

/**
 * <B>UtilLang</B>
 */
public class UtilLang {

    /**
     * 캐릭터셋을 KSC5601로 변환하여 리턴한다.
     * @param 변환할 String
     * @param String
     */

	public static String ko(String str)
	{
		if(str == null)
			return null;
		try
		{
			return new String(str.getBytes("8859_1"), "KSC5601");
		}
		catch(Exception e)
		{
			return null;
		}
	}

	/**
     * 캐릭터셋을 8859_1 변환하여 리턴한다.
     * @param 변환할 String
     * @param String
     */
	public static String en(String str)
	{
		if(str == null)
			return null;
		try
		{
			return new String(str.getBytes("KSC5601"), "8859_1");
		}
		catch(Exception e)
		{
			return null;
		}
	}

	public static String utf(String str){
		
		if(str == null)
			return null;
		try
		{
			return new String(str.getBytes("8859_1"), "UTF-8");
		}
		catch(Exception e)
		{
			return null;
		}
	} 

    /**
     * 캐릭터셋을 KSC5601로 변환하여 리턴한다.
     * @param 변환할 String
     * @param String
     */

	public static String jp(String str)
	{
		if(str == null)
			return null;
		try
		{
			return new String(str.getBytes("8859_1"), "JISAutoDetect");
		}
		catch(Exception e)
		{
			return null;
		}
	}

    /**
     * 캐릭터셋을 KSC5601로 변환하여 리턴한다.
     * @param 변환할 String
     * @param String
     */

	public static String jpToEn(String str)
	{
		if(str == null)
			return null;
		try
		{
			return new String(str.getBytes("JISAutoDetect"), "8859_1");
		}
		catch(Exception e)
		{
			return null;
		}
	}

}
