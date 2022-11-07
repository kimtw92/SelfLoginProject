package ut.lib.util.renderer;

import ut.lib.support.DataMap;
import ut.lib.util.Util;

/**
 * Class <b> FrontPrevNextRenderer </b><br>.
 * Front 이전/다음글.
 * @author  진영민 (jymin@pentabreed.com)
 * @version	2005. 7. 19.
 */
public class FrontEventPrevNextRenderer {

	private String prevNextBox;

	public FrontEventPrevNextRenderer(DataMap prevNextData){
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
				prev = "<a href=\"javascript:goDetail('" + prevNextData.getString("nstseq",i) + "','" + prevNextData.getString("ngroup", i) + "','" + prevNextData.getString("norder", i) + "')\" class='list_cmt'>" + Util.cutString(prevNextData.getString("mtitle",i),50) + "</a>";
			}else{
				next = "<a href=\"javascript:goDetail('" + prevNextData.getString("nstseq",i) + "','" + prevNextData.getString("ngroup", i) + "','" + prevNextData.getString("norder", i) + "')\" class='list_cmt'>" + Util.cutString(prevNextData.getString("mtitle",i),50) + "</a>";
			}
		}

        StringBuffer buf = new StringBuffer();

        buf.append("<table cellpadding='0' cellspacing='0' border='0' width='627'>	");
        buf.append("	<tr>");
        buf.append("		<td width='6'><img src='/asset/images/community/brd02_bx08.gif'></td>");
        buf.append("	</tr>					");
        buf.append("	<tr>");
        buf.append("		<td background='/asset/images/community/brd02_bx05.gif' align='center'>");


		        buf.append("<table cellpadding='0' cellspacing='0' border='0' width='601'>");
		        buf.append("	<tr>");
		        buf.append("		<td width='51' height='30'><img src='/asset/images/community/txt_prev01.gif'></td>");
		        buf.append("		<td width='550' class='list_cmt'>");

		                	if(prev==""){
		                		buf.append(" 이전글이 없습니다.");
		                	}else{
		                		buf.append(prev);
		                	}

		        buf.append("		</td>");
		        buf.append("	</tr>");
		        buf.append("	<tr><td colspan='2' bgcolor='#E5E5E5'></td></tr>");
		        buf.append("	<tr>");
		        buf.append("		<td height='30'><img src='/asset/images/community/txt_next01.gif'></td>");
		        buf.append("		<td class='list_cmt'>");


		        	    	if(next==""){
		        	    		buf.append(" 다음글이 없습니다.");
		        	    	}else{
		        	    		buf.append(next);
		        	    	}

		        buf.append("		</td>");
		        buf.append("	</tr>");
		        buf.append("</table>");


        buf.append("		</td>");
        buf.append("	</tr>		");
        buf.append("	<tr>");
        buf.append("		<td><img src='/asset/images/community/brd02_bx02.gif'></td>");
        buf.append("	</tr>");
		// 수정 2005.08.19
        buf.append("	<tr><td height='15'></td></tr>");
        buf.append("</table>");


        prevNextBox = buf.toString();
    }
}


