package ut.lib.page;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

import ut.lib.log.Log;

/**
 * <B>NPageFactory</B><br>
 * board_config.xml 파일에 정의된 PageNavigation instance를 리턴하기 위한 Factory
 * @author  miru
 * @version 2005. 6. 16.
 */

public class PageFactory {

    /**
     * XML 파일에 설정된 PageNavigation instance를 리턴한다.
     * @param pageClassName
     * @param pageInfo
     * @return NPageNavigation
     */
    public static PageNavigation getInstance(String pageClassName, PageInfo pageInfo) {
        PageNavigation pageNavi = null;

        Class cl;
        try {
            cl = Class.forName(pageClassName);

            Class arrCons[] = { PageInfo.class };

            Constructor constructor = cl.getConstructor(arrCons);

            Object paramObj[] = { pageInfo };

            Object obj = constructor.newInstance(paramObj);

            pageNavi = (PageNavigation)obj;
        } catch (ClassNotFoundException e) {
            Log.info(PageFactory.class, "PageFactory.getService() >> " + e.getMessage());
            e.printStackTrace();
        } catch (SecurityException e) {
            Log.info(PageFactory.class, "PageFactory.getService() >> " + e.getMessage());
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            Log.info(PageFactory.class, "PageFactory.getService() >> " + e.getMessage());
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            Log.info(PageFactory.class, "PageFactory.getService() >> " + e.getMessage());
            e.printStackTrace();
        } catch (InstantiationException e) {
            Log.info(PageFactory.class, "PageFactory.getService() >> " + e.getMessage());
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            Log.info(PageFactory.class, "PageFactory.getService() >> " + e.getMessage());
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            Log.info(PageFactory.class, "PageFactory.getService() >> " + e.getMessage());
            e.printStackTrace();
        }
        return pageNavi;
    }
}
