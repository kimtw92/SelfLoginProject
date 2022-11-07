package ut.lib.page;

/**
 * Class <b> FrontEventPageNavigation </b><br>.
 * 클래스 상세설명.
 * @author  김화정  (kims@pentabreed.com)
 * @version	2005. 8. 18.
 */
public class FrontEventPageNavigation extends FrontPageNavigation {

    public FrontEventPageNavigation() {
    }

    public FrontEventPageNavigation(PageInfo pageInfo_) {
        super(pageInfo_);
    }

    public String showNext() {
        StringBuffer buf = new StringBuffer();
        int nextPage = pageInfo.getLastPageOfRow()+1;

        if (pageInfo.getLastPageOfRow() < pageInfo.getTotalPage()) {
            buf.append("<a href='javascript:goPage(").append(nextPage).append(")'>").append("<img src='/asset/images/event/btn_next01.gif'>").append("</a>");
        }else {
            buf.append("<img src='/asset/images/event/btn_next01.gif'>");
        }

        return buf.toString();
    }

    public String showPrev() {
        StringBuffer buf = new StringBuffer();
        int prevPage = pageInfo.getFirstPageOfRow() - 1;

        if (prevPage > 0) {
            buf.append("<a href='javascript:goPage(").append(prevPage).append(")'>").append("<img src='/asset/images/event/btn_prev01.gif'>").append("</a>");
        }else {
            buf.append("<img src='/asset/images/event/btn_prev01.gif'>");
        }

        return buf.toString();
    }
}


