package common;
//import jxl.*;
//import jxl.read.biff.File;

import java.io.InputStream;
import java.lang.Exception;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import org.apache.struts.action.Action;
//import org.apache.struts.action.ActionForm;
//import org.apache.struts.action.ActionMapping;
//import org.apache.struts.action.DynaActionForm;
//import org.apache.struts.upload.FormFile;

import ut.lib.support.DataMap;
import ut.lib.support.RequestUtil;
import java.io.*;

// 사용 안하는것으로 보임...
public class XcelUpload extends Exception{
//	public void xcelUpload(
//			final ActionMapping mapping,
//			final ActionForm form,
//			final HttpServletRequest request,
//			final HttpServletResponse response){
//		Workbook workbook = null;
//		Sheet sheet = null;
//		Cell cell = null;
//
//		try
//		{
//			
//			 //요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
//			DataMap requestMap = RequestUtil.getRequest(request);
//			//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
//			requestMap.setNullToInitialize(true);
//			String savePath= "";
//			String sizeLimit = "";
//			
//			DynaActionForm codeForm = (DynaActionForm) form;
//			Hashtable uploadFiles = codeForm.getMultipartRequestHandler().getFileElements();
//			FormFile formFile = (FormFile)uploadFiles.get("fileName");
//			
//			//엑셀파일을 인식 
//			workbook = Workbook.getWorkbook( new java.io.File(requestMap.getString("fileName")));
//			
//			Cell[] cells = null;
//			
//		    //엑셀파일에 포함된 sheet의 배열을 리턴한다.
//		    //workbook.getSheets();
//		
//		    if( workbook != null)
//		    {
//		        //엑셀파일에서 첫번째 Sheet를 인식
//		        sheet = workbook.getSheet(0);
//		
//		        if( sheet != null)
//		        {
//					int sheetRowCnt = sheet.getRows();
//
//					for(int i = 2; i < sheetRowCnt; i++ ) {
//						cells = sheet.getRow(i);
//						requestMap.addString("jik", cells[0].getContents());
//						requestMap.addString("jiknm", cells[8].getContents());
//						requestMap.addString("jikj", cells[2].getContents());
//						requestMap.addString("jikr", cells[5].getContents());
//						requestMap.addString("dogs", cells[7].getContents());
//					}
//		        }
//		        
//		        else
//		        {
//		            System.out.println( "Sheet is null!!" );
//		        }
//		    }
//		}
//		catch( Exception e)
//		{
//		    e.printStackTrace();
//		}
//		finally
//		{
//		    if( workbook != null)
//		    {
//		        workbook.close();
//		    }
//		}
//	}
}
