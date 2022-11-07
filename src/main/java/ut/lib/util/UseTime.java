package ut.lib.util;

/**
 * <B>UseTime</B>
 * - 소요시간 측정을 위한 Util 클래스
 */
public class UseTime {
    long startTime;

    public UseTime() {
    	reset();
    }

    /**
     * 시작 시간을 초기화 한다.
     */
    public void reset() {
    	startTime = System.currentTimeMillis();
    }

    /**
     * 소요시간을 리턴한다.
     * @return 소요시간
     */
    public long getTime() {
    	long endTime = System.currentTimeMillis();

    	return endTime - startTime;
    }
}
