package ut.lib.page;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class AdminPageNavigation extends PageNavigation {

    public AdminPageNavigation() {
    }

    public AdminPageNavigation(PageInfo pageInfo_) {
        super(pageInfo_);
    }

    public String showPage() {
        int start = pageInfo.getFirstPageOfRow();
        int end = pageInfo.getLastPageOfRow();

        StringBuffer buf = new StringBuffer();

        for (int i = start; i <= end; i++) {
            //if (i > start && i <= end) {
            //    buf.append("&nbsp;|&nbsp;");
            //}

            if (i == pageInfo.getCurrPage()) {
                buf.append("<span style='color:#3366CC'>[").append(i).append("]</span>");
            } else {
                buf.append("<a href='javascript:goPage(").append(i).append(")'><span style='color:#666666'>[").append(i).append("]</span></a>");
            }
        }

        return buf.toString();
    }

    public String showNext() {
        StringBuffer buf = new StringBuffer();
        int nextPage = pageInfo.getLastPageOfRow()+1;

        if (pageInfo.getLastPageOfRow() < pageInfo.getTotalPage()) {
            buf.append("&nbsp;&nbsp;<a href='javascript:goPage(").append(nextPage).append(")'>").append("<img src='/images/common/next.gif' align=absbottom>").append("</a>");
        }

        return buf.toString();
    }

    public String showPrev() {
        StringBuffer buf = new StringBuffer();
        int prevPage = pageInfo.getFirstPageOfRow() - 1;

        if (prevPage > 0) {
            buf.append("<a href='javascript:goPage(").append(prevPage).append(")'>").append("<img src='/images/common/prev.gif' align=absmiddle>").append("</a>");
        }

        return buf.toString();
    }

    public String showLast() {
        StringBuffer buf = new StringBuffer();

        if (pageInfo.getCurrPage() < pageInfo.getTotalPage()) {
            buf.append("<a href='javascript:goPage(").append(pageInfo.getTotalPage()).append(")'>").append("<img src='/images/common/next_2.gif' align=absmiddle>").append("</a>");
        }
        return buf.toString();
    }

    public String showFirst() {
        StringBuffer buf = new StringBuffer();

        if (pageInfo.getCurrPage() > 1) {
            buf.append("<a href='javascript:goPage(").append("1").append(")'>").append("<img src='/images/common/prev_2.gif' align=absmiddle>").append("</a>");
        }
        return buf.toString();
    }
}


