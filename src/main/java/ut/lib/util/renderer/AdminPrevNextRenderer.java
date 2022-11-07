package ut.lib.util.renderer;

import ut.lib.support.DataMap;

/**
 * Class <b> AdminPrevNextRenderer </b><br>.
 * 관리자 이전/다음글.
 * @author  진영민 (jymin@pentabreed.com)
 * @version	2005. 7. 19.
 */
public class AdminPrevNextRenderer {

	private String prevNextBox;

	public AdminPrevNextRenderer(DataMap prevNextData){
		doRender(prevNextData);
	}

	public String getPrevNextBox(){
		return prevNextBox;
	}

    public void doRender(DataMap prevNextData) {

		String prev = "";
		String next = "";

		for (int i=0; i<prevNextData.keySize(); i++){
			if(prevNextData.getString("sep",i).equals("PREV")){
				prev = "<a href=\"javascript:goDetail('" + prevNextData.getString("nstseq",i) + "')\">" + prevNextData.getString("mtitle",i) + "</a>";
			}else{
				next = "<a href=\"javascript:goDetail('" + prevNextData.getString("nstseq",i) + "')\">" + prevNextData.getString("mtitle",i) + "</a>";
			}
		}

        StringBuffer buf = new StringBuffer();

        buf.append("<table cellpadding='0' cellspacing='0' width='723'>");
        buf.append("<tr><td height='20'></td></tr>");
        buf.append("<tr>");
        buf.append("    <td class='b_title'></td>");
        buf.append("</tr>");
        buf.append("</table>");
        buf.append("<table cellpadding='0' cellspacing='0'><tr><td height='15'></td></tr></table> ");
        buf.append("<table cellpadding='0' cellspacing='1' width='723' bgcolor='#9DA6B7'>");
        buf.append("<tr>");
        buf.append("    <td width='140' align='center' class='table_btxt_02'>이전글</td>");
        buf.append("    <td width='583' class='table_txt_01' height=30 colspan='2'>");
        	if(prev==""){
        		buf.append(" 이전글이 없습니다.");
        	}else{
        		buf.append(prev);
        	}
	    buf.append("    </td>");
	    buf.append("</tr>");
	    buf.append("<tr>");
	    buf.append("    <td width='140' align='center' class='table_btxt_02'>다음글</td>");
	    buf.append("    <td width='583' class='table_txt_01' height='30' colspan='2'>");
	    	if(next==""){
	    		buf.append(" 다음글이 없습니다.");
	    	}else{
	    		buf.append(next);
	    	}
	    buf.append("   </td>");
	    buf.append("</tr>    ");
	    buf.append("</table>    ");


        prevNextBox = buf.toString();
    }
}


