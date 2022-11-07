package ut.lib.page;

/**
 * <B>NPageNavigation</B><br>
 * 페이징 출력과 관련된 메서드를 포함하고 있다.<br>
 * 출력 디자인이 바뀌는 경우 이 클래스를 상속받아 해당 메서드를 구현한다.
 * @author  miru
 * @version 2005. 6. 16.
 */

public class PageNavigation {

    public PageInfo pageInfo = null;

    public PageNavigation() {
    }

    public PageNavigation(PageInfo pageInfo_) {
        pageInfo = pageInfo_;
    }

    public int getTotalCnt() {
        return pageInfo.getTotalCnt();
    }

    public int getCurrPage(){
    	return pageInfo.getCurrPage();
    }

    public int getTotalPage(){
    	return pageInfo.getTotalPage();
    }



    /**
     * 페이지 사이즈 만큼 페이지를 출력한다.
     * @return 페이지 블록
     */
    public String showPage() {
        int start = pageInfo.getFirstPageOfRow();
        int end = pageInfo.getLastPageOfRow();

        StringBuffer buf = new StringBuffer();

        for (int i = start; i <= end; i++) {
            if (i > start && i <= end) {
                buf.append("&nbsp;|&nbsp;");
            }

            if (i == pageInfo.getCurrPage()) {
                buf.append("<font color='red'>").append(i).append("</font>");
            } else {
                buf.append("<a href='javascript:goPage(").append(i).append(")'>").append(i).append("</a>");
            }
        }

        return buf.toString();
    }

    /**
     * 다음 페이지 블록이 있는 경우 다음 블록의 첫 페이지가 링크된 [NEXT] 문자열을 출력한다.
     * @return 링크된 [NEXT] 문자열
     */
    public String showNext() {
        StringBuffer buf = new StringBuffer();
        int nextPage = pageInfo.getLastPageOfRow()+1;

        if (pageInfo.getLastPageOfRow() < pageInfo.getTotalPage()) {
            buf.append("&nbsp;&nbsp;<a href='javascript:goPage(").append(nextPage).append(")'>").append("[NEXT]").append("</a>");
        }

        return buf.toString();
    }

    /**
     * 이전 페이지 블록이 있는 경우 이전 블록의 마지막 페이지가 링크된 [PREV] 문자열을 출력한다.
     * @return 링크된 [PREV] 문자열
     */
    public String showPrev() {
        StringBuffer buf = new StringBuffer();
        int prevPage = pageInfo.getFirstPageOfRow() - 1;

        if (prevPage > 0) {
            buf.append("<a href='javascript:goPage(").append(prevPage).append(")'>").append("[PREV]").append("</a>&nbsp;&nbsp;");
        }

        return buf.toString();
    }

    /**
     * 현재 페이지가 마지막 페이지가 아닌 경우 마지막 페이지가 링크된 [LAST] 문자열을 출력한다.
     * @return 마지막 페이지가 링크된 [LAST] 문자열
     */
    public String showLast() {
        StringBuffer buf = new StringBuffer();

        if (pageInfo.getCurrPage() < pageInfo.getTotalPage()) {
            buf.append("<a href='javascript:goPage(").append(pageInfo.getTotalPage()).append(")'>").append("[LAST]").append("</a>&nbsp;&nbsp;");
        }
        return buf.toString();
    }

    /**
     * 현재 페이지가 첫 페이지가 아닌 경우 첫 페이지가 링크된 [FIRST] 문자열을 출력한다.
     * @return 첫페이지가 링크된 [FIRST] 문자열
     */
    public String showFirst() {
        StringBuffer buf = new StringBuffer();

        if (pageInfo.getCurrPage() > 1) {
            buf.append("<a href='javascript:goPage(").append("1").append(")'>").append("[FIRST]").append("</a>&nbsp;&nbsp;");
        }
        return buf.toString();
    }
}
