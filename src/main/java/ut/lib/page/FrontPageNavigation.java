package ut.lib.page;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class FrontPageNavigation extends PageNavigation {

    public FrontPageNavigation() {
    }

    public FrontPageNavigation(PageInfo pageInfo_) {
        super(pageInfo_);
    }

    public String showPage() {
        int start = pageInfo.getFirstPageOfRow();
        int end = pageInfo.getLastPageOfRow();

        StringBuffer buf = new StringBuffer();

        for (int i = start; i <= end; i++) {

            if (i == pageInfo.getCurrPage()) {
            	if (i < pageInfo.getLastPageOfRow()) {
            		buf.append("<font color='#4356a2' style='font-weight:bold'>").append(i).append("</font>&nbsp;\n");
            	} else {
            		buf.append("<font color='#4356a2' style='font-weight:bold'>").append(i).append("</font>&nbsp;\n");
            	}
            } else {
            	if (i < pageInfo.getLastPageOfRow()) {
            		buf.append("<a href='javascript:go_page(").append(i).append(")'>").append(i).append("</a>&nbsp;\n");
            	} else {
            		buf.append("<a href='javascript:go_page(").append(i).append(")'>").append(i).append("</a>&nbsp;\n");
            	}
            }
        }

        return buf.toString();
    }

    public String showNext() {
        StringBuffer buf = new StringBuffer();
        int nextPage = pageInfo.getLastPageOfRow()+1;

        if (pageInfo.getLastPageOfRow() < pageInfo.getTotalPage()) {
        	buf.append("&nbsp;<a href='javascript:go_page(").append(nextPage).append(")'>").append("<img src='/images/pg_next01.gif' width='14' height='11' border='0' alt='뒤로'>").append("</a>");
        } else {
            buf.append("&nbsp;<img src='/images/pg_next01.gif' width='14' height='11' border='0' alt='뒤로'>");
        }

        return buf.toString();
    }


    public String showPrev() {
        StringBuffer buf = new StringBuffer();
        int prevPage = pageInfo.getFirstPageOfRow() - 1;

        if (prevPage > 0) {
        	buf.append("<a href='javascript:go_page(").append(prevPage).append(")'>").append(" <img src='/images/pg_back01.gif' width='14' height='11' border='0' alt='앞으로'>").append("</a> &nbsp; ");
        } else {
        	buf.append("<img src='/images/pg_back01.gif' width='14' height='11' border='0' alt='앞으로'> &nbsp; ");
        }

        return buf.toString();
    }

    public String showLast() {
        StringBuffer buf = new StringBuffer();

        if (pageInfo.getCurrPage() < pageInfo.getTotalPage()) { //LAST
        	buf.append("<a href='javascript:go_page(").append(pageInfo.getTotalPage()).append(")'>").append("<img src='/images/pg_next02.gif' width='15' height='11' border='0' alt='맨뒤로'>").append("</a>");
        } else {
        	buf.append("<img src='/images/pg_next02.gif' width='15' height='11' border='0' alt='맨뒤로'>");
        }
        return buf.toString();
    }

    public String showFirst() {
        StringBuffer buf = new StringBuffer();

        if (pageInfo.getCurrPage() > 1) { //FIRST
        	buf.append("<a href='javascript:go_page(").append("1").append(")'>").append("<img src='/images/pg_back02.gif' width='15' height='11' border='0' alt='맨앞으로'>").append("</a>");
        } else {
        	buf.append("<img src='/images/pg_back02.gif' width='15' height='11' border='0' alt='맨앞으로'>");
        }
        return buf.toString();
    }
    
    
    
    
    
    
    public String FrontPageStr(){
    	String pageStr = "";
    
    	pageStr = FrontshowFirst();
		pageStr += FrontshowPrev();
		pageStr += FrontshowPage();
		pageStr += FrontshowNext();
		pageStr += FrontshowLast();
    	
    	return pageStr;
    }
    
    public String FrontshowPage() {
        int start = pageInfo.getFirstPageOfRow();
        int end = pageInfo.getLastPageOfRow();

        StringBuffer buf = new StringBuffer();

        buf.append("<ol start=\"1\">");
        
        for (int i = start; i <= end; i++) {
        	
        	
            
            if (i == pageInfo.getCurrPage()) {
            	//if (i < pageInfo.getLastPageOfRow()) {
            	//	buf.append("<li class=\"fir\">").append(i).append("</li>");
            	//} else {
            		buf.append("<li class=\"fir\">").append(i).append("</li>");
            	//}
            } else {
            	//if (i < pageInfo.getLastPageOfRow()) {
            		buf.append("<li><a href='javascript:go_page(").append(i).append(")'>").append(i).append("</a></li>");
            	//} else {
            		//buf.append("<li><a href='javascript:go_page(").append(i).append(")'>").append(i).append("</a></li>");
            	//}
            }
            
        }
        
        buf.append("</ol>");

        return buf.toString();
    }
    
    public String FrontshowNext() {
        StringBuffer buf = new StringBuffer();
        int nextPage = pageInfo.getLastPageOfRow()+1;

        if (pageInfo.getLastPageOfRow() < pageInfo.getTotalPage()) {
        	buf.append("<a href='javascript:go_page(").append(nextPage).append(")'>").append("<img src='/images/skin1/icon/pg_next01.gif' alt='뒤로'>").append("</a>");
        } else {
            buf.append("<a href='javascript:'><img src='/images/skin1/icon/pg_next01.gif' alt='뒤로'></a>");
        }

        return buf.toString();
    }


    public String FrontshowPrev() {
        StringBuffer buf = new StringBuffer();
        int prevPage = pageInfo.getFirstPageOfRow() - 1;

        if (prevPage > 0) {
        	buf.append("<a href='javascript:go_page(").append(prevPage).append(")'>").append(" <img src='/images/skin1/icon/pg_back01.gif' alt='앞으로'>").append("</a>");
        } else {
        	buf.append("<a href='javascript:'><img src='/images/skin1/icon/pg_back01.gif' alt='앞으로'></a>");
        }

        return buf.toString();
    }

    public String FrontshowLast() {
        StringBuffer buf = new StringBuffer();

        if (pageInfo.getCurrPage() < pageInfo.getTotalPage()) { //LAST
        	buf.append("<a href='javascript:go_page(").append(pageInfo.getTotalPage()).append(")'>").append("<img src='/images/skin1/icon/pg_next02.gif' alt='맨뒤로'>").append("</a>");
        } else {
        	buf.append("<a href='javascript:'><img src='/images/skin1/icon/pg_next02.gif' alt='맨뒤로'></a>");
        }
        return buf.toString();
    }

    public String FrontshowFirst() {
        StringBuffer buf = new StringBuffer();

        if (pageInfo.getCurrPage() > 1) { //FIRST
        	buf.append("<a href='javascript:go_page(").append("1").append(")'>").append("<img src='/images/skin1/icon/pg_back02.gif' alt='맨앞으로'>").append("</a>");
        } else {
        	buf.append("<a href='javascript:'><img src='/images/skin1/icon/pg_back02.gif' alt='맨앞으로'></a>");
        }
        return buf.toString();
    }
    
    
    
    
}


