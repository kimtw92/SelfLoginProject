package ut.lib.log;

import org.apache.log4j.Logger;
/**
 * <B>NLog</B>
 * Log4j를 wrapping한 클래스
 * @author  miru
 * @version 2005. 6. 16.
 */
public class Log {

	private static Logger log = null;

	public static void info(String className, Object message){
		log = Logger.getLogger(className);
		log.info(message);
	}

	public static void info(Class className, Object message){
		log = Logger.getLogger(className);
		log.info(message);
	}

	public static void dbwrap(String className, Object message){
		info(className, message);

		System.out.println(message);
	}

	public static void dbwrap(Class className, Object message){
		info(className, message);

		System.out.println(message);
	}

	public static void error(String className, Object message){
		log = Logger.getLogger(className);
		log.error(message);
	}

	public static void error(Class className, Object message){
		log = Logger.getLogger(className);
		log.error(message);
	}

}
