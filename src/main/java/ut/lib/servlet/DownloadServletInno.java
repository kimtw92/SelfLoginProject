package ut.lib.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import loti.common.service.CommonService;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Functions;
import ut.lib.util.SpringUtils;
import ut.lib.util.Util;
import ut.lib.util.WebUtils;

/**
 * Inno 컴퍼넌트로 올라온 파일의 다운로드.
 *
 * @author LYM
 *
 */
public class DownloadServletInno extends HttpServlet {
	protected void performTask( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws Exception {

		//TB_UPLOAD 테이블의 GroupFileNo
		int groupFileNo = Util.getIntValue((String)request.getParameter("groupfileNo"), -1);
		//TB_UPLOAD 테이블의 fileNo
		int fileNo = Util.getIntValue((String)request.getParameter("fileNo"), -1);
		
		//Service Instance
//		
//		String ATTR = FrameworkServlet.SERVLET_CONTEXT_PREFIX+"dispatcher";
//		
//		WebApplicationContext context =  WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext(),ATTR);
		
		CommonService service = SpringUtils.getBean(CommonService.class, request);
		service.updateUploadVisitCnt(groupFileNo, fileNo); //다운로드수 증가시킴.
		DataMap fileMap = service.selectUploadFileRow(groupFileNo, fileNo);
		
		if(fileMap == null)
			fileMap = new DataMap();
		fileMap.setNullToInitialize(true);
		// config 설정  // 폴더명이 lecturer이면 관리자만 받을수 있도록 처리
		if(fileMap.getString("filePath").indexOf("lecturer") != -1) {
			//관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
			if(!"Y".equals((String)request.getSession().getAttribute("filedownload_admin_yn"))) {
				return;
			}			
		}
		String filePathFull = SpringUtils.getRealPath(request) + Constants.UPLOAD + fileMap.get("filePath");	
		String filedownname = fileMap.getString("fileName"); //사용자가 올린 파일이름.

		try {
			File file = new File(filePathFull);
			
			int ifilesize = (int)file.length();
			String strClient = request.getHeader("User-Agent");
			String fileType;

			WebUtils.setFileHeader(request, response, filedownname, "UTF-8", "UTF-8");
			
			if (strClient.indexOf("MSIE 5.5") != -1) {
//				response.setHeader("Content-Disposition", "filename=" + new String(filedownname.getBytes("UTF-8"),"8859_1") + ";");
				fileType = "doesn/matter";
			} else {
//				response.setHeader("Content-Disposition", "attachment;filename=" + new String(filedownname.getBytes("UTF-8"),"8859_1") + ";");
				fileType = "application/octet-stream";
			}

			response.setContentType(fileType);
			response.setContentLength(ifilesize);

			byte b[] = new byte[2048];
			if (file.isFile()){
				BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
				int read = 0;
				try {
					while ((read = fin.read(b)) != -1)
						outs.write(b, 0, read);
					
					fin.close();
					outs.close();
					
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (fin != null) fin.close();
					if(outs != null) outs.close();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return;
	}


	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		doPost(req, resp);
	}

	/**
	 * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		try {
			performTask(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}


		
}
