package common;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 * 정규식 패턴 체크 유틸
 * 2011-10-17 게시판 콘텐츠 패턴용
 * @author user
 *
 */
public class RegExpUtil {
    // 숫자
    public final static String NUMBER_PATTERN              = "^[0-9]*$";
    // 영어
    public final static String ENGLISH_PATTERN             = "^[a-zA-Z]*$";
    // 영어 + 숫자
    public final static String ENGLISH_NUMBER_PATTERN      = "^[a-zA-Z0-9]*$";
    // 한국어
    public final static String KOREAN_PATTERN              = "^[ㄱ-ㅎ가-힣]*$";
    // 한국어 + 숫자
    public final static String KOREAN_NUMBER_PATTERN       = "^[ㄱ-ㅎ가-힣0-9]*$";
    // 이메일
    public final static String EMAIL_PATTERN               = "^[_0-9a-zA-Z-]+@[0-9a-zA-Z]+(.[_0-9a-zA-Z-]+)*$";
    // 전화번호
    public final static String TEL_PATTERN                 = "^\\d{2,3}-\\d{3,4}-\\d{4}$";
    // 핸드폰
    public final static String HP_PATTERN                  = "01[016789][-~.[:space:]][0-9]{3,4}[-~.[:space:]][0-9]{4}";
    // 주민번호
    public final static String JUMIN_PATTERN               = "([01][0-9]{5}[[:space:],~-]+[1-4][0-9]{6}|[2-9][0-9]{5}[[:space:],~-]+[1-2][0-9]{6})";
    // 여권번호
    public final static String PASSEPORT_PATTERN           = "[a-zA-Z]{2}[-~.[:space:]][0-9]{7}";
    // 면허번호
    public final static String DRIVERS_LICENSE_PATTERN     = "[0-9]{2}[-~.[:space:]][0-9]{6}[-~.[:space:]][0-9]{2}";
    // 신용카드
    public final static String CREDIT_CARD_PATTERN         = "[34569][0-9]{3}[-~.[:space:]][0-9]{4}[-~.[:space:]][0-9]{4}[-~.[:space:]][0-9]{4}";
    // 건강보험
    public final static String HEALTH_INSURANCE            = "[1257][-~.[:space:]][0-9]{10}";
    // 계좌번호
    public final static String ACCOUNT_NUMBER              = "([0-9]{2}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{6}|[0-9]{3}[-~.[:space:]]([0-9]{5,6}[-~.[:space:]][0-9]{3}|[0-9]{6}[-~.[:space:]][0-9]{5}|[0-9]{2,3}[-~.[:space:]][0-9]{6}|[0-9]{2}[-~.[:space:]][0-9]{7}|[0-9]{2}[-~.[:space:]][0-9]{4,6}[-~.[:space:]][0-9]|[0-9]{5}[-~.[:space:]][0-9]{3}[-~.[:space:]][0-9]{2}|[0-9]{2}[-~.[:space:]][0-9]{5}[-~.[:space:]][0-9]{3}|[0-9]{4}[-~.[:space:]][0-9]{4}[-~.[:space:]][0-9]{3}|[0-9]{6}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{3}|[0-9]{2}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{7})|[0-9]{4}[-~.[:space:]]([0-9]{3}[-~.[:space:]][0-9]{6}|[0-9]{2}[-~.[:space:]][0-9]{6}[-~.[:space:]][0-9])|[0-9]{5}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{6}|[0-9]{6}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{5,6})";
    // 아이피
    public final static String IP_PATTERN                  = "([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})";
     // HTML
    public final static String HTML_PATTERN                = "<(?:.|\\s)*?>";

    /**
     * 패턴 체크
     * @param p_regex
     * @param p_data
     * @return
     */
    public static boolean isCheckPattern(String p_regex, String p_data) {
        boolean l_loopCheck = false;
        Pattern l_pattern = Pattern.compile(p_regex, Pattern.CASE_INSENSITIVE);
        String[] l_dataTemp = p_data.split(" ");

        for(int i = 0; l_dataTemp.length > i ; i++) {
            Matcher l_matcher = l_pattern.matcher(l_dataTemp[i]);
            if(l_matcher.find()) {
                l_loopCheck = true;
                break;
            }
        }

        return l_loopCheck;
    }

    /**
     * html 삭제
     * @param p_htmlStr
     * @return
     */
    public static String replacePattern(String p_htmlStr, String p_regex) {
        Pattern l_pattern = Pattern.compile(p_regex, Pattern.CASE_INSENSITIVE);
        Matcher l_matcher = l_pattern.matcher(p_htmlStr);

        return l_matcher.replaceAll("");
    }

    /**
     * 널체크 메소드
     * @param p_data
     * @param p_returnValue
     * @return
     */
    public static String checkNULL(String p_data, String p_returnValue) {
        if(!"".equals(p_data)) {
            return p_data;
        }

        return p_returnValue;
    }

    /**
     * 체크
     * @param p_data
     * @param deleteHtmlYn
     * @return
     */
    public static boolean isValid(String p_regex, String p_data, boolean p_isDeleteHtml) {
        boolean l_ischeck = false;

        p_data = checkNULL(p_data, "");                     // 널체크

        if("".equals(p_data)) {                             // 널일경우
            return l_ischeck;
        }

        if(p_isDeleteHtml) {                                // html 제거
            p_data = replacePattern(p_data, HTML_PATTERN);  // 설정한 패턴 리플래스
        }

        return isCheckPattern(p_regex, p_data);             // 정규식 체크
    }


    /**
     * 숫자
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidNumber(String p_data, boolean p_isDeleteHtml) {

        return isValid(NUMBER_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * 영어
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidEngLish(String p_data, boolean p_isDeleteHtml) {

        return isValid(ENGLISH_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * 숫자 + 영어
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidEngLishAndNumber(String p_data, boolean p_isDeleteHtml) {

        return isValid(ENGLISH_NUMBER_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * 한국어 + 숫자
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidKoreanAndNumber(String p_data, boolean p_isDeleteHtml) {

        return isValid(KOREAN_NUMBER_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * 한국어
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidKorean(String p_data, boolean p_isDeleteHtml) {

        return isValid(KOREAN_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * 이메일 체크
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidEmail(String p_data, boolean p_isDeleteHtml) {

        return isValid(EMAIL_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * 전화번호
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidTel(String p_data, boolean p_isDeleteHtml) {

        return isValid(TEL_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * 핸드폰
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidHp(String p_data, boolean p_isDeleteHtml) {

        return isValid(HP_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * 주민번호
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidJuMin(String p_data, boolean p_isDeleteHtml) {

        return isValid(JUMIN_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * 여권번호
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidPassEport(String p_data, boolean p_isDeleteHtml) {

        return isValid(PASSEPORT_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * 면허증
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidDriversLicense(String p_data, boolean p_isDeleteHtml) {

        return isValid(DRIVERS_LICENSE_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * 신용카드
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidCreditCard(String p_data, boolean p_isDeleteHtml) {

        return isValid(CREDIT_CARD_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * 건강보험
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidHealthInsurance(String p_data, boolean p_isDeleteHtml) {

        return isValid(HEALTH_INSURANCE, p_data, p_isDeleteHtml);
    }

    /**
     * 계좌번호
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidAccountNumber(String p_data, boolean p_isDeleteHtml) {

        return isValid(ACCOUNT_NUMBER, p_data, p_isDeleteHtml);
    }

    /**
     * 아이피 주소
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidIp(String p_data, boolean p_isDeleteHtml) {

        return isValid(IP_PATTERN, p_data, p_isDeleteHtml);
    }

    /**
     * html
     * @param p_data
     * @param p_isDeleteHtml
     * @return
     */
    public static boolean isValidHtml(String p_data, boolean p_isDeleteHtml) {

        return isValid(HTML_PATTERN, p_data, p_isDeleteHtml);
    }
}