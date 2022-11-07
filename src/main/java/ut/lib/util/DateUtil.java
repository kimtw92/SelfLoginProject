package ut.lib.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * DateTime Class 사용예
 *
 *
 * <table>
 * <tr><td>올해는</td><td>DateTime.getYear()</td></tr>
 * <tr><td>이번달은		:DateTime.getMonth()</td></tr>
 * <tr><td>오늘은			:DateTime.getDay()</td></tr>
 * <tr><td>요일은			:DateTime.getDayOfWeek()</td></tr>
 * <tr><td>현재시간		:DateTime.getHour()</td></tr>
 * <tr><td>현재분			:DateTime.getMinute()</td></tr>
 * <tr><td>현재 초			:DateTime.getSecond()</td></tr>
 * <tr><td>현재 날짜		:DateTime.getDateString()</td></tr>
 * <tr><td>현재 날짜		:DateTime.getDateString(".")</td></tr>
 * <tr><td>현재 날짜		:DateTime.getDateString("/")</td></tr>
 * <tr><td>시간스트링		:DateTime.getTimeString()</td></tr>
 * <tr><td>TimeStamp		:DateTime.getTimeStampString()</td></tr>
 * <tr><td>DateTimeMin 	:DateTime.getDateTimeMin()</td></tr>
 * <tr><td>DateTimeString 	:DateTime.getDateTimeString()</td></tr>
 * <tr><td>윤년판단		:DateTime.checkEmbolism(2002)</td></tr>
 * <tr><td>일수 구하기		:DateTime.getMonthDate("2002","2")</td></tr>
 * </table>
 */

public class DateUtil {

	public static String dateSep = "-";
	public static String timeSep = ":";
	public static String dateSep_1 = ".";

	private static final String[] day = {"일", "월", "화", "수", "목", "금", "토" };

	public DateUtil() {}

	/**
	 *
	 * For example, String time = DateTime.getFormatString("yyyy-MM-dd HH:mm:ss");
	 *
	 * @param java.lang.String pattern  "yyyy, MM, dd, HH, mm, ss and more"
	 * @return formatted string representation of current day and time with  your pattern.
	 */
	public static int getNumberByPattern(String pattern) {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat (pattern, java.util.Locale.KOREA);
		String dateString = formatter.format(new java.util.Date());
		//Date date1 = new Date();
		return Integer.parseInt(dateString);
		
	}

	/**
	* 현재날짜의 년도를 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static int getYear() { return getNumberByPattern("yyyy"); }

	/**
	* 현재날짜의 월을 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static int getMonth() { return getNumberByPattern("MM"); }

	/**
	* 현재날짜의 일자를 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static int getDay() { return getNumberByPattern("dd"); }

	/**
	* 주중 요일을 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static String getDayOfWeek() {
		Calendar c = Calendar.getInstance();
		return day[c.get(java.util.Calendar.DAY_OF_WEEK)-1];
	}

	/**
	* 헤당 년,월의 시작 요일에 수를 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static int getDayOfWeekNumber(int year, int month) {
		Calendar c = Calendar.getInstance();
		c.set(Calendar.YEAR, year);
		c.set(Calendar.MONTH, month-1);
		c.set(Calendar.DATE, 1);
		return c.get(Calendar.DAY_OF_WEEK);
	}
	
	/**
	* 현재 시각의 시간를 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static int getHour() {
		Calendar c = Calendar.getInstance();
		return c.get(Calendar.HOUR_OF_DAY);
	}

	/**
	* 현재 시각의 분을 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static int getMinute() {
		Calendar c = Calendar.getInstance();
		return c.get(Calendar.MINUTE);
	}

	/**
	* 현재시각의 초을 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static int getSecond() {
		Calendar c = Calendar.getInstance();
		return c.get(Calendar.SECOND);
	}

	/**
	* YYY-MM-DD 형태의 스트링을 구하는 Method
	* @param pattern String
	* @exception
	* @author
	*/
	public static String getDateString() {
			return getYear() + "-" + getMonth() + "-" + getDay();
	}
	/**
	* YYY-MM-DD 형태의 스트링을 구하는 Method
	* @param pattern String
	* @exception
	* @author
	*/
	public static String getToDateString() {
		String month = getMonth() + "";
		String day = getDay() + "";

		if(month.length() == 1) {
			month = "0" + month;
		}
		if(day.length() == 1) {
			day = "0" + day;
		}
			return getYear() + "-" + month + "-" + day;
	}
	
	/**
	* YYY-MM 형태의 스트링을 구하는 Method
	* @param pattern String
	* @exception
	* @author
	*/
	public static String getYearMonth() {
		String month = getMonth() + "";

		if(month.length() == 1) {
			month = "0" + month;
		}
		return getYear() + "-" + month;
	}
	/**
	* YYY-MM-DD 형태의 스트링을 Pattern에 의해 구하는 Method
	* Pattern 값에 따른 결과 반영
	* @param pattern String
	* @exception
	* @author
	*/
	public static String getDateString(String pattern) {
			return getYear() + pattern + getMonth() + pattern + getDay();
	}

	/**
	* HH:MI:SS 형태의 스트링을 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static String getTimeString() {
		String hour = getHour() + "";
		String min = getMinute() + "";
		String sec = getSecond() + "";

		if(hour.length() == 1) {
		  hour = "0" + hour;
		}
		if(min.length() == 1) {
		  min = "0" + min;
		}
		if(sec.length() == 1) {
		  sec = "0" + sec;
		}

		return hour + timeSep + min + timeSep + sec;


	}

	/**
	* YYYY-MM-DD HH:MI:SS 형태의 스트링을 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static String getTimeStampString() {
		return getDateString("-") + " " + getTimeString();
	}

	/**
	* YYYYMMDDHHMISS 형태의 스트링를 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static String getDateTimeMinSec() {
		String month = getMonth() + "";
		String day = getDay() + "";
		String hour = getHour() + "";
		String min = getMinute() + "";
		String sec = getSecond() + "";

		if(month.length() == 1) {
		  month = "0" + month;
		}
		if(day.length() == 1) {
		  day = "0" + day;
		}
		if(hour.length() == 1) {
		  hour = "0" + hour;
		}
		if(min.length() == 1) {
		  min = "0" + min;
		}
		if(sec.length() == 1) {
			sec = "0" + sec;
		}		
		return getYear()+""+month+""+day+""+hour+""+min+""+sec;
	}

	/**
	* YYYYMMDDHHMISS 형태의 스트링를 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static String getDateTimeMin() {
		String month = getMonth() + "";
		String day = getDay() + "";
		String hour = getHour() + "";
		String min = getMinute() + "";

		if(month.length() == 1) {
		  month = "0" + month;
		}
		if(day.length() == 1) {
		  day = "0" + day;
		}
		if(hour.length() == 1) {
		  hour = "0" + hour;
		}
		if(min.length() == 1) {
		  min = "0" + min;
		}
		return getYear()+""+month+""+day+""+hour+""+min;
	}
	
	/**
	* YYYYMMDD 형태의 스트링를 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static String getDateTime() {
		String month = getMonth() + "";
		String day = getDay() + "";
		if(month.length() == 1) {
		  month = "0" + month;
		}
		if(day.length() == 1) {
		  day = "0" + day;
		}
		
		return getYear()+""+month+""+day;
	}	
	/**
	* YYYYMM 형태의 스트링를 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static String getDateYyyyMm() {
		String month = getMonth() + "";
		String day = getDay() + "";
		if(month.length() == 1) {
		  month = "0" + month;
		}
		if(day.length() == 1) {
		  day = "0" + day;
		}
		
		return getYear()+""+month;
	}	

	/**
	* 년/월/일/시/분/초 스트링를 구하는 Method
	*
	* @param
	* @exception
	* @author
	*/
	public static String getDateTimeString() {
		String month = getMonth() + "";
		String day = getDay() + "";
		String hour = getHour() + "";
		String min = getMinute() + "";
		String sec = getSecond() + "";

		if(month.length() == 1) {
		  month = "0" + month;
		}
		if(day.length() == 1) {
		  day = "0" + day;
		}
		if(hour.length() == 1) {
		  hour = "0" + hour;
		}
		if(min.length() == 1) {
		  min = "0" + min;
		}
		if(sec.length() == 1) {
		  sec = "0" + sec;
		}
		return getYear()+""+month+""+day+""+hour+""+min + sec;
	}

	public static String getParseDateString(String dateTime, String pattern){
		if ( dateTime != null ){
			String year = dateTime.substring(0, 4);
			String month = dateTime.substring(5, 7);
			String day = dateTime.substring(8, 10);		
		
			return year + pattern + month + pattern + day;				
		} else {
			return "";	
		}	
	}

	public static String getDisplayDateString(String dateTime, String pattern){
		if ( dateTime != null ){
			int len = dateTime.length();
			String year ="";
			String month = "";
			String day = "";
			if(len == 6) {
				year = dateTime.substring(0, 2);
				month = dateTime.substring(2, 4);
				day = dateTime.substring(4, 6);
			}else if(len >= 8){
				year = dateTime.substring(0, 4);
				month = dateTime.substring(4, 6);
				day = dateTime.substring(6, 8);
			}
			return year + pattern + month + pattern + day;				
		} else {
			return "";	
		}	
	}
	
	public static String getDisplayDateStringTwo(String dateTime, String pattern){
		if ( dateTime != null ){
			int len = dateTime.length();
			String year ="";
			String month = "";
			String day = "";
			String returnValue= dateTime;
			if(len == 6) {
				year = dateTime.substring(0, 4);
				month = dateTime.substring(4, 6);
				returnValue = year + pattern + month;
			}else if(len >= 8){
				year = dateTime.substring(0, 4);
				month = dateTime.substring(4, 6);
				day = dateTime.substring(6, 8);
				returnValue = year + pattern + month + pattern + day;
			}
			return returnValue;				
		} else {
			return "";	
		}	
	}
	
	
	public static String getDisplayDateTimeString(String dateTime){
		if ( dateTime != null ){
			int len = dateTime.length();
			String year ="";
			String month = "";
			String day = "";
			String time = "";
			String min = "";
			if(len == 14) {
				year = dateTime.substring(2, 4);
				month = dateTime.substring(4, 6);
				day = dateTime.substring(6, 8);
				time = dateTime.substring(8, 10);
				min = dateTime.substring(10, 12);
			}
			return year + "." + month + "." + day+ "  " + time+ ":" + min;				
		} else {
			return "";	
		}	
	}
	/**
	* yyyy-MM-dd 형태의 자료를 yyyyMMdd로 변환
	* 단 8자리가 오면 그대로 리턴 
	*
	* @param String yyyy-MM-dd
	* @return String yyyyMMdd
	* @exception
	* @author
	*/
	public static String getDBDateStringPatternRemove(String dateTime){
		if ( dateTime != null ){
			int len = dateTime.length();
			String year ="";
			String month = "";
			String day = "";
			if(len == 10) {
				year = dateTime.substring(0, 4);
				month = dateTime.substring(5, 7);
				day = dateTime.substring(8, 10);
				return year  + month  + day;	
			}
			return dateTime;				
		} else {
			return "";	
		}	
	}

	/**
	* 주어진 년도가 윤년인지를 구하는 Method
	*
	* @param int year
	* @exception
	* @author
	*/
	public static boolean checkEmbolism(int year) {
		int remain = 0;
		int remain_1 = 0;
		int remain_2 = 0;

		remain = year % 4;
		remain_1 = year % 100;
		remain_2 = year % 400;

		// the ramain is 0 when year is divided by 4;
		if (remain == 0) {
			
			// the ramain is 0 when year is divided by 100;
			if (remain_1 == 0) {
				
				// the remain is 0 when year is divided by 400;
				if (remain_2 == 0) return true;
				else return false;
				
			} else  return true;
		}
		return false;
	}
	/**
	* 주어진 년,월의 일수를 구하는 Method
	*
	* @param    String year, String month
	* @exception
	* @author
	*/
	public static int getMonthDate(String year, String month) {
		
		int [] dateMonth = new int[12];
	
		dateMonth[0] = 31;
		dateMonth[1] = 28;
		dateMonth[2] = 31;
		dateMonth[3] = 30;
		dateMonth[4] = 31;
		dateMonth[5] = 30;
		dateMonth[6] = 31;
		dateMonth[7] = 31;
		dateMonth[8] = 30;
		dateMonth[9] = 31;
		dateMonth[10] = 30;
		dateMonth[11] = 31;
	
		if (checkEmbolism(Integer.parseInt(year))) { dateMonth[1] = 29; }
	
		int day = dateMonth[Integer.parseInt(month) - 1];
	
		return day;
	}
	
	/**
	 * 주어진 날짜의 요일을 한글로 구하는 Method
	 * @param dateStr
	 * @return
	 * @throws ParseException
	 */	  
	public static String getDayOfWeek(String dateStr) throws ParseException {
		DateFormat df = null;
		Calendar cld = null;
		Date myDate = null;
		String DOW = "";

		try {
			if(dateStr.length() == 8) {
			
				df = new SimpleDateFormat("yyyyMMdd"); 
				myDate = df.parse(dateStr); 
				cld = Calendar.getInstance(); 
				cld.setTime(myDate);
				
				if(cld.get(Calendar.DAY_OF_WEEK) == 1) {
					DOW = "일";
				}else if(cld.get(Calendar.DAY_OF_WEEK) == 2) {
					DOW = "월";
				}else if(cld.get(Calendar.DAY_OF_WEEK) == 3) {
					DOW = "화";
				}else if(cld.get(Calendar.DAY_OF_WEEK) == 4) {
					DOW = "수";
				}else if(cld.get(Calendar.DAY_OF_WEEK) == 5) {
					DOW = "목";
				}else if(cld.get(Calendar.DAY_OF_WEEK) == 6) {
					DOW = "금";
				}else if(cld.get(Calendar.DAY_OF_WEEK) == 7) {
					DOW = "토";
				}			
			}				
		} catch (ParseException e) {
				e.printStackTrace();
		} 
		
		return DOW;
	}	  
	
	/**
	 * 주어진 날짜의 요일을 숫자형식으로 구하는 Method
	 * @param dateStr
	 * @return
	 * @throws ParseException
	 */
	public static String getDayOfWeekNum(String dateStr) throws ParseException {
		DateFormat df = null;
		Calendar cld = null;
		Date myDate = null;
		String DOW = "";

		try {
				if(dateStr.length() == 8) {
				
					df = new SimpleDateFormat("yyyyMMdd"); 
					myDate = df.parse(dateStr); 
					cld = Calendar.getInstance(); 
					cld.setTime(myDate);
					
					if(cld.get(Calendar.DAY_OF_WEEK) == 1) {
						DOW = "1";
					}else if(cld.get(Calendar.DAY_OF_WEEK) == 2) {
						DOW = "2";
					}else if(cld.get(Calendar.DAY_OF_WEEK) == 3) {
						DOW = "3";
					}else if(cld.get(Calendar.DAY_OF_WEEK) == 4) {
						DOW = "4";
					}else if(cld.get(Calendar.DAY_OF_WEEK) == 5) {
						DOW = "5";
					}else if(cld.get(Calendar.DAY_OF_WEEK) == 6) {
						DOW = "6";
					}else if(cld.get(Calendar.DAY_OF_WEEK) == 7) {
						DOW = "7";
					}			
				}				
		} catch (ParseException e) {
				e.printStackTrace();
		} 
		
		return DOW;
	}
	
	
	
	/**
	 * 일년 간 달력의 월별 날짜수 배열을 구한다.
	 * 
	 * @param yr
	 *            년도
	 * @return
	 */
	public static int[] getMonthDaysArray(int yr) {
		int[] a1 = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
		int[] a2 = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

		if (yr <= 1582) {
			if ((yr % 4) == 0) {
				if (yr == 4) {
					return a1;
				}
				return a2;
			}
		} else {
			if (((yr % 4) == 0) && ((yr % 100) != 0)) {
				return a2;
			} else if ((yr % 400) == 0) {
				return a2;
			}
		}

		return a1;
	}

	/**
	 * 지정된 년도와 달에 따른 요일 편차를 구한다.
	 * 
	 * @param y
	 *            년도
	 * @param m
	 *            월
	 * @return
	 */
	public static int addWeekDays(int y, int m) {
		int[] b1 = { 3, 0, 3, 2, 3, 2, 3, 3, 2, 3, 2, 3 };
		int[] b2 = { 3, 1, 3, 2, 3, 2, 3, 3, 2, 3, 2, 3 };
		int i = 0;
		int rval = 0;

		if (y <= 1582) {
			if ((y % 4) == 0) {
				if (y == 4) {
					for (i = 0; i < m - 1; i++)
						rval += b1[i];
				} else {
					for (i = 0; i < m - 1; i++)
						rval += b2[i];
				}
			} else {
				for (i = 0; i < m - 1; i++)
					rval += b1[i];
			}
		} else {
			if (((y % 4) == 0) && ((y % 100) != 0)) {
				for (i = 0; i < m - 1; i++)
					rval += b2[i];
			} else if ((y % 400) == 0) {
				for (i = 0; i < m - 1; i++)
					rval += b2[i];
			} else {
				for (i = 0; i < m - 1; i++)
					rval += b1[i];
			}
		}

		return rval;
	}

	/**
	 * 지정한 년도의 총 날짜 수를 구한다.
	 * 
	 * @param y
	 *            년도
	 * @return
	 */
	public static int getDaysInYear(int y) {
		if (y > 1582) {
			if (y % 400 == 0)
				return 366;
			else if (y % 100 == 0)
				return 365;
			else if (y % 4 == 0)
				return 366;
			else
				return 365;
		} else if (y == 1582)
			return 355;
		else if (y > 4) {
			if (y % 4 == 0)
				return 366;
			else
				return 365;
		} else if (y > 0)
			return 365;
		else
			return 0;
	}

	/**
	 * 지정한 년도, 지정한 월의 총 날짜 수를 구한다.
	 * 
	 * @param m
	 *            월
	 * @param y
	 *            년도
	 * @return
	 */
	public static int getDaysInMonth(int m, int y) {
		if (m < 1 || m > 12)
			throw new RuntimeException("Invalid month: " + m);

		int[] b = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
		if (m != 2 && m >= 1 && m <= 12 && y != 1582)
			return b[m - 1];
		if (m != 2 && m >= 1 && m <= 12 && y == 1582)
			if (m != 10)
				return b[m - 1];
			else
				return b[m - 1] - 10;

		if (m != 2)
			return 0;

		// m == 2 (즉 2월)
		if (y > 1582) {
			if (y % 400 == 0)
				return 29;
			else if (y % 100 == 0)
				return 28;
			else if (y % 4 == 0)
				return 29;
			else
				return 28;
		} else if (y == 1582)
			return 28;
		else if (y > 4) {
			if (y % 4 == 0)
				return 29;
			else
				return 28;
		} else if (y > 0)
			return 28;
		else
			throw new RuntimeException("Invalid year: " + y);
	}

	/**
	 * 지정한 년도의 지정한 월의 첫날 부터 지정한 날 까지의 날짜 수를 구한다.
	 * 
	 * @param d
	 *            일
	 * @param m
	 *            월
	 * @param y
	 *            년
	 * @return
	 */
	public static int getDaysFromMonthFirst(int d, int m, int y) {
		if (m < 1 || m > 12)
			throw new RuntimeException("Invalid month " + m + " in " + d + "/"
					+ m + "/" + y);

		int max = getDaysInMonth(m, y);
		if (d >= 1 && d <= max)
			return d;
		else
			throw new RuntimeException("Invalid date " + d + " in " + d + "/"
					+ m + "/" + y);
	}

	/**
	 * 지정한 년도의 첫날 부터 지정한 월의 지정한 날 까지의 날짜 수를 구한다.
	 * 
	 * @param d 일
	 * @param m 월
	 * @param y 년도
	 * @return
	 */
	public static int getDaysFromYearFirst(int d, int m, int y) {
		if (m < 1 || m > 12)
			throw new RuntimeException("Invalid month " + m + " in " + d + "/"
					+ m + "/" + y);

		int max = getDaysInMonth(m, y);
		if (d >= 1 && d <= max) {
			int sum = d;
			for (int j = 1; j < m; j++)
				sum += getDaysInMonth(j, y);
			return sum;
		} else
			throw new RuntimeException("Invalid date " + d + " in " + d + "/"
					+ m + "/" + y);
	}

	/**
	 * 2000년 1월 1일 부터 지정한 년, 월, 일 까지의 날짜 수를 구한다. 2000년 1월 1일 이전의 경우에는 음수를 리턴한다.
	 * 
	 * @param d 일
	 * @param m 월
	 * @param y 년도
	 * @return
	 */
	public static int getDaysFrom21Century(int d, int m, int y) {
		if (y >= 2000) {
			int sum = getDaysFromYearFirst(d, m, y);
			for (int j = y - 1; j >= 2000; j--)
				sum += getDaysInYear(j);
			return sum - 1;
		} else if (y > 0 && y < 2000) {
			int sum = getDaysFromYearFirst(d, m, y);
			for (int j = 1999; j >= y; j--)
				sum -= getDaysInYear(y);
			return sum - 1;
		} else
			throw new RuntimeException("Invalid year " + y + " in " + d + "/"
					+ m + "/" + y);
	}

	/**
	 * 지정한 년도의 지정한 월의 첫날 부터 지정한 날 까지의 날짜 수를 구한다.
	 * 
	 * @param s  날짜
	 * @return
	 */
	public static int getDaysFromMonthFirst(String s) {
		int d, m, y;
		if (s.length() == 8) {
			y = Integer.parseInt(s.substring(0, 4));
			m = Integer.parseInt(s.substring(4, 6));
			d = Integer.parseInt(s.substring(6));
			return getDaysFromMonthFirst(d, m, y);
		} else if (s.length() == 10) {
			y = Integer.parseInt(s.substring(0, 4));
			m = Integer.parseInt(s.substring(5, 7));
			d = Integer.parseInt(s.substring(8));
			return getDaysFromMonthFirst(d, m, y);
		} else if (s.length() == 11) {
			d = Integer.parseInt(s.substring(0, 2));
			String strM = s.substring(3, 6).toUpperCase();
			String[] monthNames = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
					"JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };
			m = 0;
			for (int j = 1; j <= 12; j++) {
				if (strM.equals(monthNames[j - 1])) {
					m = j;
					break;
				}
			}
			if (m < 1 || m > 12)
				throw new RuntimeException("Invalid month name: " + strM
						+ " in " + s);
			y = Integer.parseInt(s.substring(7));
			return getDaysFromMonthFirst(d, m, y);
		} else
			throw new RuntimeException("Invalid date format: " + s);
	}

	/**
	 * 지정한 년도의 첫날 부터 지정한 월의 지정한 날 까지의 날짜 수를 구한다.
	 * 
	 * @param s
	 *            날짜
	 * @return
	 */
	public static int getDaysFromYearFirst(String s) {
		int d, m, y;
		if (s.length() == 8) {
			y = Integer.parseInt(s.substring(0, 4));
			m = Integer.parseInt(s.substring(4, 6));
			d = Integer.parseInt(s.substring(6));
			return getDaysFromYearFirst(d, m, y);
		} else if (s.length() == 10) {
			y = Integer.parseInt(s.substring(0, 4));
			m = Integer.parseInt(s.substring(5, 7));
			d = Integer.parseInt(s.substring(8));
			return getDaysFromYearFirst(d, m, y);
		} else if (s.length() == 11) {
			d = Integer.parseInt(s.substring(0, 2));
			String strM = s.substring(3, 6).toUpperCase();
			String[] monthNames = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
					"JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };
			m = 0;
			for (int j = 1; j <= 12; j++) {
				if (strM.equals(monthNames[j - 1])) {
					m = j;
					break;
				}
			}
			if (m < 1 || m > 12)
				throw new RuntimeException("Invalid month name: " + strM
						+ " in " + s);
			y = Integer.parseInt(s.substring(7));
			return getDaysFromYearFirst(d, m, y);
		} else
			throw new RuntimeException("Invalid date format: " + s);
	}

	/**
	 * 2000년 1월 1일 부터 지정한 년, 월, 일 까지의 날짜 수를 구한다. 2000년 1월 1일 이전의 경우에는 음수를 리턴한다.
	 * 
	 * @param s 날짜
	 * @return
	 */
	public static int getDaysFrom21Century(String s) {
		int d, m, y;
		if (s.length() == 8) {
			y = Integer.parseInt(s.substring(0, 4));
			m = Integer.parseInt(s.substring(4, 6));
			d = Integer.parseInt(s.substring(6));
			return getDaysFrom21Century(d, m, y);
		} else if (s.length() == 10) {
			y = Integer.parseInt(s.substring(0, 4));
			m = Integer.parseInt(s.substring(5, 7));
			d = Integer.parseInt(s.substring(8));
			return getDaysFrom21Century(d, m, y);
		} else if (s.length() == 11) {
			d = Integer.parseInt(s.substring(0, 2));
			String strM = s.substring(3, 6).toUpperCase();
			String[] monthNames = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
					"JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };
			m = 0;
			for (int j = 1; j <= 12; j++) {
				if (strM.equals(monthNames[j - 1])) {
					m = j;
					break;
				}
			}
			if (m < 1 || m > 12)
				throw new RuntimeException("Invalid month name: " + strM
						+ " in " + s);
			y = Integer.parseInt(s.substring(7));
			return getDaysFrom21Century(d, m, y);
		} else
			throw new RuntimeException("Invalid date format: " + s);
	}

	/**
	 * (양 끝 제외) 날짜 차이 구하기
	 * 
	 * @param s1 날짜
	 * @param s2 날짜
	 * @return
	 */
	public static int getDaysBetween(String s1, String s2) {
		int y1 = getDaysFrom21Century(s1);
		int y2 = getDaysFrom21Century(s2);
		return y1 - y2 - 1;
	}

	/**
	 * 날짜 차이 구하기
	 * 
	 * @param s1 날짜
	 * @param s2 날짜
	 * @return
	 */
	public static int getDaysDiff(String s1, String s2) {
		int y1 = getDaysFrom21Century(s1);
		int y2 = getDaysFrom21Century(s2);
		return y1 - y2;
	}

	/**
	 * (양 끝 포함) 날짜 차이 구하기
	 * 
	 * @param s1
	 *            날짜
	 * @param s2
	 *            날짜
	 * @return
	 */
	public static int getDaysFromTo(String s1, String s2) {
		int y1 = getDaysFrom21Century(s1);
		int y2 = getDaysFrom21Century(s2);
		return y1 - y2 + 1;
	}

	/**
	 * 지정한 년도, 지정한 월에 지정한 요일이 들어 있는 회수를 구한다.
	 * 
	 * @param weekDay
	 *            요일
	 * @param m
	 *            월
	 * @param y
	 *            년도
	 * @return
	 */
	public static int getWeekdaysInMonth(int weekDay, int m, int y) {
		int week = ((weekDay - 1) % 7);
		int days = getDaysInMonth(m, y);
		int sum = 6; // 2000년 1월 1일은 토요일
		if (y >= 2000) {
			for (int i = 2000; i < y; i++)
				sum += getDaysInYear(i);
		} else {
			for (int i = y; i < 2000; i++)
				sum -= getDaysInYear(i);
		}
		for (int i = 1; i < m; i++)
			sum += getDaysInMonth(i, y);

		// if (sum < 0)
		// sum += 350*3000;

		int firstWeekDay = sum % 7;
		if (firstWeekDay < 0) {
			firstWeekDay += 7;
		}

		// firstWeekDay += 1;
		int n = firstWeekDay + days;
		int counter = (n / 7) + (((n % 7) > week) ? 1 : 0);
		if (firstWeekDay > week)
			counter--;

		return counter;
	}

	/**
	 * 2000년 1월 1일 기준을 n일 경과한 날짜 구하기
	 * 
	 * @param elapsed
	 * @return yyyy-mm-dd 양식의 String 타입
	 */
	public static String getDateStringFrom21Century(int elapsed) {
		int y = 2000;
		int m = 1;
		int d = 1;

		int n = elapsed + 1;
		int j = 2000;
		if (n > 0) {
			while (n > getDaysInYear(j)) {
				n -= getDaysInYear(j);
				j++;
			}
			y = j;

			int i = 1;
			while (n > getDaysInMonth(i, y)) {
				n -= getDaysInMonth(i, y);
				i++;
			}
			m = i;
			d = n;
		} else if (n < 0) {
			while (n < 0) {
				n += getDaysInYear(j - 1);
				j--;
			}
			y = j;

			int i = 1;
			while (n > getDaysInMonth(i, y)) {
				n -= getDaysInMonth(i, y);
				i++;
			}
			m = i;
			d = n;
		}

		String strY = "" + y;
		String strM = "";
		String strD = "";

		if (m < 10)
			strM = "0" + m;
		else
			strM = "" + m;

		if (d < 10)
			strD = "0" + d;
		else
			strD = "" + d;

		return strY + "/" + strM + "/" + strD;

	}

	/**
	 * 2000년 1월 1일 기준을 n일 경과한 날짜 구하기
	 * 
	 * @param elapsed
	 * @return yyyy-mm-dd 양식의 String 타입
	 */
	public static String getDateStringFrom21CenturyNo(int elapsed) {
		int y = 2000;
		int m = 1;
		int d = 1;

		int n = elapsed + 1;
		int j = 2000;
		if (n > 0) {
			while (n > getDaysInYear(j)) {
				n -= getDaysInYear(j);
				j++;
			}
			y = j;

			int i = 1;
			while (n > getDaysInMonth(i, y)) {
				n -= getDaysInMonth(i, y);
				i++;
			}
			m = i;
			d = n;
		} else if (n < 0) {
			while (n < 0) {
				n += getDaysInYear(j - 1);
				j--;
			}
			y = j;

			int i = 1;
			while (n > getDaysInMonth(i, y)) {
				n -= getDaysInMonth(i, y);
				i++;
			}
			m = i;
			d = n;
		}

		String strY = "" + y;
		String strM = "";
		String strD = "";

		if (m < 10)
			strM = "0" + m;
		else
			strM = "" + m;

		if (d < 10)
			strD = "0" + d;
		else
			strD = "" + d;

		return strY + strM + strD;

	}

	/**
	 * 지정한 날짜를 offset일 경과한 날짜 구하기
	 * 
	 * @param offset
	 * @param d
	 *            일
	 * @param m
	 *            월
	 * @param y
	 *            년도
	 * @return yyyy-mm-dd 양식의 String 타입
	 */
	public static String addDate(int offset, int d, int m, int y) {
		int z = getDaysFrom21Century(d, m, y);
		int n = z + offset;
		return getDateStringFrom21Century(n);
	}

	/**
	 * 지정한 날짜를 offset일 경과한 날짜 구하기
	 * 
	 * @param offset
	 * @param date
	 *            날짜
	 * @return yyyy-mm-dd 양식의 String 타입
	 */
	public static String addDate(int offset, String date) {
		int z = getDaysFrom21Century(date);
		int n = z + offset;
		return getDateStringFrom21Century(n);
	}

	/**
	 * 지정한 날짜를 offset일 경과한 날짜 구하기
	 * 
	 * @param offset
	 * @param date
	 *            날짜
	 * @return yyyy-mm-dd 양식의 String 타입
	 */
	public static String addDateNo(int offset, String date) {
		int z = getDaysFrom21Century(date);
		int n = z + offset;
		return getDateStringFrom21CenturyNo(n);
	}
	
	
	
    /**
     * yyyyMMddhh24miss 를 yyyy-MM-dd hh24:mi:ss 로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */	        
    public static String convertDate1(String date) {
        if (date.length() == 14) {
            return date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8) + " " + date.substring(8, 10) + ":" + date.substring(10, 12) + ":" + date.substring(12);  
        } else if (date.length() == 8) {
            return date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8);
        } else {
            return "";
        }
    }

    /**
     * yyyyMMddhh24miss 를 yyyy년 MM월dd일로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */	        
    public static String convertDate2(String date) {
        if (date.length() == 14) {
            return date.substring(0, 4) + "년 " + Integer.parseInt(date.substring(4, 6)) + "월" + Integer.parseInt(date.substring(6, 8)) + "일" ;  
        } else if (date.length() == 8) {
            return date.substring(0, 4) + "년 " + Integer.parseInt(date.substring(4, 6)) + "월 " + Integer.parseInt(date.substring(6, 8)) + "일";
        } else {
            return "";
        }
    }

    /**
     * yyyyMMddhh24miss 를 yyyy년 MM월dd일로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */	
    public static String convertDate4(String date) {
        if (date.length() == 14) {
            return Integer.parseInt(date.substring(4, 6)) + "월" + Integer.parseInt(date.substring(6, 8)) + "일" ;  
        } else if (date.length() == 8) {
            return Integer.parseInt(date.substring(4, 6)) + "월 " + Integer.parseInt(date.substring(6, 8)) + "일";
        } else {
            return "";
        }
    }

    /**
     * yyyyMMddhh24 를 yyyy년 MM월dd일 오후 2시로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */	
    public static String convertDate5(String date) {

         String divideDate = date.replaceAll("-","");

        if (date.length() == 10) {
            divideDate = date.substring(0, 4) + "년 " + Integer.parseInt(date.substring(4, 6)) + "월" + Integer.parseInt(date.substring(6, 8)) + "일" ;

            if ( Integer.parseInt(date.substring(8, 10)) < 12 )
            {
                divideDate = divideDate + " 오전 "+Integer.parseInt(date.substring(8, 10))+ "시";
            } else if ( Integer.parseInt(date.substring(8, 10)) >= 12 )
            {
                divideDate = divideDate + " 오후 "+ (Integer.parseInt(date.substring(8, 10))-12 ) +  "시";
            }
        } else {
            return "";
        }

        return divideDate;
    }
    
    
    /**
     * yyyyMMddhh24miss 를 yyyy.MM.dd 로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */	
    public static String convertDate6(String date) {
        if (date.length() == 14) {
            return Integer.parseInt(date.substring(0, 4)) + "." + Util.plusZero(Integer.parseInt(date.substring(4, 6))) + "." + Util.plusZero(Integer.parseInt(date.substring(6, 8))) + "" ;  
        } else if (date.length() == 8) {
            return Integer.parseInt(date.substring(0, 4)) + "." + Util.plusZero(Integer.parseInt(date.substring(4, 6))) + "." + Util.plusZero(Integer.parseInt(date.substring(6, 8))) + "";
        } else {
            return "";
        }
    }
    
    
    
	/**
	 * 데이트 문자열을 지정된 패턴으로 포맷하는 메소드
	 * @param dateSource 데이트 문자열(yyyyMMdd 형태)
	 * @return yyyy-MM-dd HH:mm:ss형태로 포맷된 데이트 문자열(dateSource의 길이에 따라 유동적)
	 * @throws Exception
	 */
	public static String getDateFormat(String dateSource) throws Exception {
		return getDateFormat(dateSource, null, null);
	}

	/**
	 * 데이트 문자열을 주어진 패턴에 의해 포맷하는 메소드
	 * @param dateSource 데이트 문자열(yyyyMMdd 형태)
	 * @param dstPattern 결과 값의 패턴
	 * @return dstPattern에 따라 포맷된 데이트 문자열
	 * @throws Exception
	 */
	public static String getDateFormat(String dateSource, String dstPattern) throws Exception {
		return getDateFormat(dateSource, null, dstPattern);
	}

	/**
	 * 데이트 문자열을 주어진 패턴에 의해 포맷하는 메소드
	 * @param dateSource 데이트 문자열
	 * @param srcPattern dateSource의 패턴
	 * @param dstPattern 결과 값의 패턴
	 * @return dstPattern에 따라 포맷된 데이트 문자열
	 * @throws Exception
	 */
	public static String getDateFormat(String dateSource, String srcPattern, String dstPattern) throws Exception {

		final String day_src_fmt = "yyyyMMdd";
		final String hour_src_fmt = "yyyyMMddHH";
		final String min_src_fmt = "yyyyMMddHHmm";
		final String sec_src_fmt = "yyyyMMddHHmmss";

		final String day_dst_fmt = "yyyy-MM-dd";
		final String hour_dst_fmt = "yyyy-MM-dd HH";
		final String min_dst_fmt = "yyyy-MM-dd HH:mm";
		final String sec_dst_fmt = "yyyy-MM-dd HH:mm:ss";

		SimpleDateFormat sdf = new SimpleDateFormat();
		Date date = null;
		String dateString = "";

		if (srcPattern == null || srcPattern.equals("")) {
			switch (dateSource.length()) {
			case 10:
				srcPattern = hour_src_fmt;
				break;
			case 12:
				srcPattern = min_src_fmt;
				break;
			case 14:
				srcPattern = sec_src_fmt;
				break;
			default:
				srcPattern = day_src_fmt;
				break;
			}
		}else if (dateSource.length() > srcPattern.length()) {
			dateSource = dateSource.substring(0, srcPattern.length());
		}

		if (dstPattern == null || dstPattern.equals("")) {
			switch (dateSource.length()) {
			case 10:
				dstPattern = hour_dst_fmt;
				break;
			case 12:
				dstPattern = min_dst_fmt;
				break;
			case 14:
				dstPattern = sec_dst_fmt;
				break;
			default:
				dstPattern = day_dst_fmt;
				break;
			}
		}

		try {
			sdf.applyPattern(srcPattern);
			date = sdf.parse(dateSource);
			sdf.applyPattern(dstPattern);
			dateString = sdf.format(date);
		} catch (ParseException e) {
			dateString = "";
		} catch (Exception e) {
			throw e;
		}

		return dateString;
	}
	
    /**
     * 해당월의 마지막날짜를 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */	        
    public static int monthEndDay(int Year, int Month) {

    	int year = Year;//Integer.parseInt(Year);
    	int month = Month;//Integer.parseInt(Month);
    	
    	int END_DAY = 0;
    	
    	Calendar eDay = Calendar.getInstance();
    	eDay.set(year, month, 1);
    	eDay.add(Calendar.DAY_OF_MONTH, -1);
    	
    	END_DAY = eDay.get(Calendar.DAY_OF_MONTH);
    	
    	
    	return END_DAY;
    }   
	
    
    
    /**
     * 해당날짜를 요일정보[1,2,3,4,5,6,7]로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */	        
    public static int startDayOfWeek(int Year, int Month) {

    	int year = Year; //Integer.parseInt(Year);
    	int month = Month; //Integer.parseInt(Month);
    	
    	int START_DAY_OF_WEEK = 0;
    	
    	Calendar sDay = Calendar.getInstance();
    	sDay.set(year, month-1, 1);
    	
    	START_DAY_OF_WEEK = sDay.get(Calendar.DAY_OF_WEEK);
    	
            Calendar now   = Calendar.getInstance();
            
            now.set(Calendar.YEAR,Calendar.MONTH,Calendar.DATE);



            return START_DAY_OF_WEEK;
    }    
    
    
    /**
     * yyyyMMddhh24miss 를 yyyy-MM-dd hh24:mi:ss 로 변경하여 리턴한다.
     * @param 문자열
     * @return 변경된 문자열
     */	        
    public static String convertDate4(String date, String sep) {
        if (date.length() > 7) {
            return date.substring(0, 4) + sep + date.substring(4, 6) + sep + date.substring(6, 8) ;  
        } else {
            return "";
        }
    }    

    
    public static String getNextWeek() {
        Calendar now = Calendar.getInstance();
        now.add(Calendar.DATE, 7);
        Date date = now.getTime();
        
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
        return formatter.format(date);        
    }

    
    
}

