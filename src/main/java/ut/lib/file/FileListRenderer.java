package ut.lib.file;

import ut.lib.support.DataMap;


/**
 * 저장된 파일을 출력하는 Renderer class
 * @author  miru
 * @version 2005. 7. 02.
 */
public class FileListRenderer
{


    protected DataMap fileData;
	protected int maxUploadFileCnt;
    protected int attachFileCnt;
    protected String gubun = "";
    protected String htmlNameAttr = "";
    protected String changeFileCntScript;
    protected String fileFormCheckScript;
    protected String formCheckFuncName;
    protected String width;
    protected String checkStr = "";
    protected String strCh = "";

	protected String cssName;



    public FileListRenderer ()
	{
    }

    /**
     * 생성자
     * @param fileData - 파일 데이터
     * @param maxUploadFileCnt - 업로드된 파일수
     */
    public FileListRenderer (DataMap fileData, int maxUploadFileCnt)
	{
        super();
       	this.fileData = fileData;
        this.maxUploadFileCnt = maxUploadFileCnt;
        this.width = "330";

		fileData.setNullToInitialize(true);
        setAttachFileCnt(fileData);
    }

    /**
     * 생성자
     * @param fileData - 파일 데이터
     * @param gubun - 파일 구분
     * @param htmlNameAttr - HTML TAG의 name Attribute
     * @param formCheckFuncName - 파일폼 체크를 위한 스크립트 함수명
     */
    public FileListRenderer (DataMap fileData, int maxUploadFileCnt, String gubun, String htmlNameAttr, String formCheckFuncName)
	{
        super();
		this.fileData = fileData;
        this.maxUploadFileCnt = maxUploadFileCnt;
        this.gubun = gubun;
        this.htmlNameAttr = htmlNameAttr;
        this.formCheckFuncName = formCheckFuncName;
        this.width = "330";

		fileData.setNullToInitialize(true);
        setAttachFileCnt(fileData);
    }

    public FileListRenderer (DataMap fileData, int maxUploadFileCnt, String gubun, String htmlNameAttr, String formCheckFuncName, String ch, String ch1, String ch2)
	{
        super();
		this.fileData = fileData;
        this.maxUploadFileCnt = maxUploadFileCnt;
        this.gubun = gubun;
        this.htmlNameAttr = htmlNameAttr;
        this.formCheckFuncName = formCheckFuncName;
        this.width = "330";
        this.strCh = ch;

		fileData.setNullToInitialize(true);
        setAttachFileCnt(fileData);
    }



    /**
     * 생성자
     * @param fileData - 파일 데이터
     * @param maxUploadFileCnt - 업로드된 파일 수
     * @param gubun - 파일 구분
     * @param htmlNameAttr - HTML TAG의 name Attribute
     * @param formCheckFuncName - 파일폼 체크를 위한 스크립트 함수명
     * @param width
     */
    public FileListRenderer (DataMap fileData, int maxUploadFileCnt, String gubun, String htmlNameAttr, String formCheckFuncName, String width)
	{
        super();
		this.fileData = fileData;
        this.maxUploadFileCnt = maxUploadFileCnt;
        this.gubun = gubun;
        this.htmlNameAttr = htmlNameAttr;
        this.formCheckFuncName = formCheckFuncName;
        this.width = width;

		fileData.setNullToInitialize(true);
        setAttachFileCnt(fileData);
    }

    /**
     * 생성자
     * @param fileData - 파일 데이터
     * @param maxUploadFileCnt - 업로드된 파일 수
     * @param gubun - 파일 구분
     * @param htmlNameAttr - HTML TAG의 name Attribute
     * @param formCheckFuncName - 파일폼 체크를 위한 스크립트 함수명
     * @param width -파일필드의 너비
	 * @param cssName - css style 클래스명
     */
    public FileListRenderer (DataMap fileData, int maxUploadFileCnt, String gubun, String htmlNameAttr, String formCheckFuncName, String width, String cssName)
	{
        super();
		this.fileData = fileData;
        this.maxUploadFileCnt = maxUploadFileCnt;
        this.gubun = gubun;
        this.htmlNameAttr = htmlNameAttr;
        this.formCheckFuncName = formCheckFuncName;
        this.width = width;
		this.cssName = cssName;

		fileData.setNullToInitialize(true);
        setAttachFileCnt(fileData);
    }

	/**
     * attachFileCnt 필드의 값을 전달받은 파라미터의 값으로 설정한다.
     * @param attachFileCnt - 첨부된 파일 수
     */
    public void setAttachFileCnt(int attachFileCnt)
	{
        this.attachFileCnt = attachFileCnt;
    }

	/**
     * attachFileCnt 필드의 값을 fileData의 keySize()로 설정한다.
     * @param fileData - 첨부된 파일 리스트를 가지고 있는 데이터
     */
    public void setAttachFileCnt(DataMap fileData)
	{
    	if(this.gubun.equals(""))
		{
    		setAttachFileCnt(fileData.keySize());
    	}
		else
		{
		   int size = 0;
    	   for(int i = 0 ; i < fileData.keySize() ; i++)
		   {
              if(fileData.getString("gubun", i).equals(this.gubun))
			  {
					size++;
              }
           }
		   setAttachFileCnt(size);
    	}
    }

	/**
	 * attachFileCnt 값을 리턴한다.
	 * @return attachFileCnt
	 **/
    public int getAttachFileCnt()
	{
        return attachFileCnt;
    }

	/**
     * 업로드할 파일수를 변경하는 Select Box html을 리턴하고, 관련된 자바스크립트를 생성한다.
     * @return 업로드할 파일수를 변경하는 Select Box html
     */
	public String attachFileCntRender()
	{
    	int currentCnt = 0;
		StringBuffer tagBuffer = new StringBuffer();
		//tagBuffer.append("<table cellspacing=0 cellpadding=0 border=0><tr><td>");
		tagBuffer.append("<select name=\"attachFileCnt\" style=\"width:66;\" onChange=\"setAttachFileCnt('"+htmlNameAttr+"_TR', this.value)\">\r\n");

		if (getAttachFileCnt()==0)
		{	 // 첨부된 파일 없을때
			currentCnt = 1;
		}
		else
		{
			currentCnt = getAttachFileCnt();
		}


		for (int i = currentCnt; i <= maxUploadFileCnt; i++)
		{
		    tagBuffer.append("<option value=\"").append(i).append("\"");
		    if (currentCnt==i)
			{
		        tagBuffer.append(" selected");
		    }
		    tagBuffer.append(">").append(i).append("</option>\r\n");
		}
		tagBuffer.append("</select>\r\n");

		//해당 스크립트 작성
		setChangeFileCntScript();

		return tagBuffer.toString();
    }

	/**
     * NChecker 문자열을 설정한 후, 업로드할 파일수를 변경하는 file 필드 html을 리턴하고, 관련된 자바스크립트를 생성한다.
	 * @param str - NChecker 문자열
     * @return 업로드할 파일수를 변경하는 file 필드 html
     */
	public String fileBoxRender(String str)
	{
		 this.checkStr = str;
		 return fileBoxRender();
	}

	/**
     * 업로드할 파일수를 변경하는 file 필드 html을 리턴하고, 관련된 자바스크립트를 생성한다.
     * @return 업로드할 파일수를 변경하는 file 필드 html
     */
	public String fileBoxRender()
	{
		boolean flag = false;
		if(this.gubun.equals(""))
		{
			flag = true;
		}
        StringBuffer tagBuffer = new StringBuffer();

		//gubun이 없을 경우에는 모든 파일을 rendering 한다.
        int k = 0;

        for (int i = 0 ; i < fileData.keySize() ; i++)
		{
            if ( (flag ? true : fileData.getString("gubun", i).equals(this.gubun)) )
			{

            	tagBuffer.append("<tr id=\"").append(htmlNameAttr).append("_TR\">\r\n");
				tagBuffer.append("<td height=60></td>\r\n");
				tagBuffer.append("<td colspan=2>\r\n");
	            tagBuffer.append("&nbsp;<a href=\"Javascript:goFileDown('").append(fileData.getString("orgName", i));
	            tagBuffer.append("','").append(fileData.getString("orgName", i));
	            tagBuffer.append("','").append(fileData.getString("path", i));
	            tagBuffer.append("');\">").append(fileData.getString("orgName", i));
	            tagBuffer.append("</a>&nbsp;(").append(fileData.getString("fileSize", i)).append("바이트)<br>");
	            tagBuffer.append("<input type=\"checkbox\" name=\"del");
	            tagBuffer.append(gubun).append("Check");
	            tagBuffer.append("\" value=\"Y\"  enable_fields=\"").append(htmlNameAttr);

	            if (maxUploadFileCnt > 1)
				{
		            tagBuffer.append("\" onClick=\"changeFileStateArray('"+htmlNameAttr+"', ");
	    	                tagBuffer.append(k);
		            tagBuffer.append(")\" ");
	            }
				else
				{
		            tagBuffer.append("\" onClick=\"changeFileState('"+htmlNameAttr+"')\" ");
	            }
	            tagBuffer.append(" class=\"checkbox\">");
	            tagBuffer.append("<span class=\"gray_01 s_txt\">기존에 등록하신 파일을 삭제하시려면 체크하신후 수정하시면 됩니다.</span><br>\r\n");
	            tagBuffer.append("<input type=\"file\"");
				if(!strCh.equals("")){
					tagBuffer.append(" OnChange='javascript:"+strCh+";' " );	//uploadImageCheck1(this,300)
				}
	            tagBuffer.append("name=\"").append(htmlNameAttr);

				tagBuffer.append("\" style=\"width:" + this.width + ";\" class=\"" + this.cssName + "\" disabled "+ checkStr +" ><br>\r\n");
	            tagBuffer.append("<input type=\"hidden\" name=\"old").append((htmlNameAttr.substring(0,1)).toUpperCase()).append(htmlNameAttr.substring(1)).append("Seq");

				tagBuffer.append("\" value=\"").append(fileData.getInt("seq", i)).append("\">\r\n");
				tagBuffer.append("</td></tr>");
				k++;
			}

        }

		StringBuffer tagBuffer1 = new StringBuffer();
		String dispOption = "";

		if (maxUploadFileCnt > 1)
		{
			for(int i = getAttachFileCnt() ; i < maxUploadFileCnt ; i++)
			{
				tagBuffer1.append("<tr id=\"" + htmlNameAttr + "_TR\" style=\"");
				if (i != 0)
				{
				    dispOption = "display:none;";
				}
				tagBuffer1.append(dispOption).append("\">");
				tagBuffer1.append("<td height=30></td>");
				tagBuffer1.append("<td colspan=2>");
				tagBuffer1.append("<input type=\"file\"" );
//				if(ch){
//					tagBuffer1.append("OnChange='javascript:document.all.pic.src=this.value;'" );
//				}
				if(!strCh.equals("")){
					tagBuffer1.append(" OnChange='javascript:"+strCh+";' " );	//uploadImageCheck1(this,300)
				}
				tagBuffer1.append("name=\"").append(htmlNameAttr).append("\" class=\"" + this.cssName + "\" style=\"width:" + this.width + ";\" " );

				tagBuffer1.append(checkStr +"  >\r\n");
				tagBuffer.append("</td></tr>");
			}
		}
		else
		{
		    if (getAttachFileCnt() < maxUploadFileCnt)
			{
		    	tagBuffer1.append("<tr id=\"" + htmlNameAttr + "_TR\">\r\n");
				tagBuffer1.append("<td height=30></td>");
				tagBuffer1.append("<td colspan=2>");
		        tagBuffer1.append("<input type=\"file\"");
//				if(ch){
//					tagBuffer1.append("OnChange='javascript:document.all.pic.src=this.value;'" );
//				}
				if(!strCh.equals("")){
					tagBuffer1.append(" OnChange='javascript:"+strCh+";' " );	//uploadImageCheck1(this,300)
				}
		        tagBuffer1.append("name=\"").append(htmlNameAttr).append("\"  class=\"" + this.cssName + "\" style=\"width:" + this.width + ";\"  "+ checkStr +" >\r\n");
		        tagBuffer.append("</td></tr>");
			}
		}

		setFileFormCheckScript();

		return tagBuffer.toString() + tagBuffer1.toString();
    }

    /**
     * 업로드할 파일수를 변경하는데 필요한 자바스크립트 함수를 설정한다.
     */
    public void setChangeFileCntScript()
	{
        StringBuffer tagBuffer = new StringBuffer();
		tagBuffer.append("function setAttachFileCnt(name, val) {\r\n");
		tagBuffer.append("	var oTrs = document.getElementsByName( name );\r\n");
		tagBuffer.append("	for (var i = 0; i < parseInt(val); i++) {\r\n");
		tagBuffer.append("		oTrs[i].style.display = \"\";\r\n");
        tagBuffer.append("	}\n");
        tagBuffer.append("	for (var j = parseInt(val); j < "+maxUploadFileCnt+"; j++) {\r\n");
        tagBuffer.append("      document.f.").append(htmlNameAttr).append("[j].select();");
        tagBuffer.append("      document.selection.clear();");
        tagBuffer.append("		oTrs[j].style.display = \"none\";\r\n");
        tagBuffer.append("	}");
        tagBuffer.append("}");

		this.changeFileCntScript = tagBuffer.toString();
    }

	/**
     * 업로드할 파일수를 변경하는데 필요한 자바스크립트 함수를 리턴한다.
     * @return 업로드 파일수 변경을 위한 javascript function
     */
    public String getChangeFileCntScript()
	{
        return changeFileCntScript;
    }

	/**
     * 파일폼을 체크하기 위한 자바스크립트 함수를 설정한다.
     */
	public void setFileFormCheckScript()
	{
        StringBuffer tagBuffer1 = new StringBuffer();
        tagBuffer1.append("function ").append(formCheckFuncName).append(" {\r\n");
        if (maxUploadFileCnt > 1)
		{
	        tagBuffer1.append("	for (i = 0 ; i < ").append(getAttachFileCnt()).append("; i++ ) {\r\n");
			tagBuffer1.append("		if ((i==0) && (document.f[\"del" + gubun +"Check\"]) && (document.f[\"del" + gubun +"Check\"].checked)) {\r\n");
			tagBuffer1.append("			document.f.oldAttachFileSeq.value = document.f.oldAttachFileSeq.value + document.f[\"old").append((htmlNameAttr.substring(0,1)).toUpperCase()).append(htmlNameAttr.substring(1)).append("Seq").append("\"].value + \",\";\r\n");
			tagBuffer1.append("		} \r\n");

			String strDel = "";
			String strOld = "";
			if(getAttachFileCnt() == 1){
				strDel = "document.f[\"del" + gubun + "Check\"]";
				strOld = "document.f[\"old" + htmlNameAttr.substring(0,1).toUpperCase() + htmlNameAttr.substring(1) + "Seq\"]";
			}else{
				strDel = "document.f[\"del" + gubun + "Check\"][i]";
				strOld = "document.f[\"old" + htmlNameAttr.substring(0,1).toUpperCase() + htmlNameAttr.substring(1) + "Seq\"][i]";
			}

			tagBuffer1.append("		if ((" + strDel + ")&&(" + strDel + ".checked)) {\r\n");
			tagBuffer1.append("			document.f.oldAttachFileSeq.value = document.f.oldAttachFileSeq.value + " + strOld + ".value + \",\";\r\n");

			//tagBuffer1.append("			document.f.oldAttachFile.value = document.f.oldAttachFile.value + document.f[\"old").append((htmlNameAttr.substring(0,1)).toUpperCase()).append(htmlNameAttr.substring(1)).append("\"+i].value + \",\";\r\n");
			tagBuffer1.append("		} else {\r\n");

			tagBuffer1.append("			if (document.f[\"").append(htmlNameAttr).append("\"][i].value!=\"\") {\r\n");
			tagBuffer1.append("				alert(\"첨부파일을 수정하시려면 체크박스를 체크하셔야 합니다.\");\r\n");
			tagBuffer1.append(strDel).append(".focus();\r\n");
			tagBuffer1.append("				return false;\r\n");
	    	tagBuffer1.append("			}\r\n");
			tagBuffer1.append("		}\r\n");
	    	tagBuffer1.append("}\r\n");

        }
		else
		{
            tagBuffer1.append("if (document.f.del").append(gubun).append("Check != null) {");
			tagBuffer1.append("		if (document.f.del").append(gubun).append("Check.checked) {\r\n");
			tagBuffer1.append("			document.f.oldAttachFileSeq.value = document.f.oldAttachFileSeq.value + document.f.old").append((htmlNameAttr.substring(0,1)).toUpperCase()).append(htmlNameAttr.substring(1)).append("Seq").append(".value + \",\";\r\n");
			//tagBuffer1.append("			document.f.oldAttachFile.value = document.f.oldAttachFile.value + document.f[\"old").append((htmlNameAttr.substring(0,1)).toUpperCase()).append(htmlNameAttr.substring(1)).append("\"+i].value + \",\";\r\n");
			tagBuffer1.append("		} else {\r\n");
			tagBuffer1.append("			if (document.f.").append(htmlNameAttr).append(".value!=\"\") {\r\n");
			tagBuffer1.append("				alert(\"첨부파일을 수정하시려면 체크박스를 체크하셔야 합니다.\");\r\n");
			tagBuffer1.append("				document.f.").append("del").append(gubun).append("Check.focus();\r\n");
			tagBuffer1.append("				return false;\r\n");
	    	tagBuffer1.append("			}\r\n");
			tagBuffer1.append("		}\r\n");
			tagBuffer1.append("	}\r\n");
        }
		tagBuffer1.append("return true;\r\n");
    	tagBuffer1.append("}\r\n");
    	fileFormCheckScript = tagBuffer1.toString();

    }

    /**
	 * NChecker 문자열을 설정한 후, 렌더에 의해 작성된 Select Box 와 file 필드의 HTML 태그를 전부 리턴한다.
	 * @param NcheckStr - NChecker 문자열
     * @return 완성된 Select Box 와 file 필드의 HTML 태그
     */
    public String toHtml(String NCheckStr)
	{
    	setCheckStr(NCheckStr);

        return toHtml();
    }

    /**
     * 렌더에 의해 작성된 Select Box 와 file 필드의 HTML 태그를 전부 리턴한다.
     * @return 완성된 Select Box 와 file 필드의 HTML 태그
     */
    public String toHtml()
	{
        String html = "";
        if (maxUploadFileCnt > 1)
		{
            html = "<table cellspacing=0 cellpadding=0 border=0><tr><td colspan=3>" + attachFileCntRender() + "</td></tr>" + fileBoxRender() + "</table>";
        }
		else
		{
            html = "<table cellspacing=0 cellpadding=0 border=0>" + fileBoxRender() + "</table>";
        }

        return html;
    }

	/**
     * 파일폼을 체크하기 위한 자바스크립트 함수를 리턴한다.
     * @return 파일폼 체크를 위한 javascript function
     */
    public String getFileFormCheckScript()
	{
        return fileFormCheckScript;
    }

    /**
     * 파일 삭제, 수정에 필요한 스크립트를 리턴한다.
     * @return Script
     */
    public String toScript()
	{
    	StringBuffer tagBuffer = new StringBuffer();

		tagBuffer.append("	    function changeFileStateArray(tag, num)\r\n");
		tagBuffer.append("	    {\r\n");
		tagBuffer.append("			fm = document.f[tag][num];\r\n");
		tagBuffer.append("	    	fm.disabled = !fm.disabled;\r\n");
		tagBuffer.append("	    }\r\n");
		tagBuffer.append("	    function changeFileState(tag)\r\n");
		tagBuffer.append("	    {\r\n");
		tagBuffer.append("	    	document.f[tag].disabled = !document.f[tag].disabled;\r\n");
		tagBuffer.append("	    }\r\n");
		return tagBuffer.toString();
    }

	/**
     * 벨리데이션 체크를 위한 문자열을 저장한다.
     */
    public void setCheckStr(String str)
	{
    	this.checkStr = str;
    }
    public void setWidth(String width) {
    	this.width = width;
    }
}
