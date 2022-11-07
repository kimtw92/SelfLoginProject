package ut.lib.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ut.lib.util.Constants;
import ut.lib.util.SpringUtils;
import ut.lib.util.Util;
import ut.lib.util.WebUtils;



/**
 * 첨부 화일을 다운로드 받는 클래스
 * @author
 */
public class DownloadServlet extends HttpServlet {

	protected void performTask(
		javax.servlet.http.HttpServletRequest request,
		javax.servlet.http.HttpServletResponse response)
		throws Exception {


		//String no = request.getParameter("no");
		//String seq = request.getParameter("seq");
		
		System.out.println("DownloadServlet====");
			
		String fileName = Util.getValue(request.getParameter("downFileName"));
		String filePathLoad = Util.getValue(request.getParameter("downPath"));
		String isPds = Util.getValue(request.getParameter("isPds"));
		String downname = Util.getValue(request.getParameter("downname"));
		
		System.out.println("fileName="+fileName);
		System.out.println("filePathLoad="+filePathLoad);
		System.out.println("isPds="+isPds);
				
		String filedownname = fileName;
		
		String upHomePath = "";
		
		if(isPds.equals("")){
			upHomePath = SpringUtils.getRealPath(request) + Constants.UPLOAD;
		}else{
			upHomePath = SpringUtils.getRealPath(request);
		}
		
		
		
		String savepath = upHomePath  + filePathLoad ;
        System.out.println(savepath);
	  try {
			File file = null;

			//file = new File(savepath, filerealname);
			file = Util.getFileRename2(savepath, filedownname);

			int ifilesize = (int) file.length();
			//byte bfilebyte[] = new byte[ifilesize];
			String strClient = request.getHeader("User-Agent");
			String fileType;

			if (downname != null && !downname.equals("")) {
				WebUtils.setFileHeader(request, response, downname, "UTF-8", "UTF-8");
			} else {
				WebUtils.setFileHeader(request, response, filedownname, "UTF-8", "UTF-8");
			}
			
		   if (strClient.indexOf("MSIE 5.5") != -1) {
				fileType = "doesn/matter";
		   } else {
				fileType = "application/octet-stream";
		   }

		   response.setContentType(fileType);
		   response.setContentLength(ifilesize);

		   byte b[] = new byte[1024];
		   if (file.isFile()) {
				BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
				int read = 0;
				try {
					 while ((read = fin.read(b)) != -1) {
					  	outs.write(b, 0, read);
					 }
					 fin.close();
					 outs.close();
				} catch (Exception e) {
				   	e.printStackTrace();
				} finally {
					 if (fin != null)
					  	fin.close();
				}
		   }


	  } catch (Exception e) {
		 e.printStackTrace();
	  }



		return;
	}

	private void dumpFile(File realFile, OutputStream outputstream) {
		byte readByte[] = new byte[4096];
		try {
			BufferedInputStream bufferedinputstream =
				new BufferedInputStream(new FileInputStream(realFile));
			int i;
			while ((i = bufferedinputstream.read(readByte, 0, 4096)) != -1)
				outputstream.write(readByte, 0, i);
			bufferedinputstream.close();
		} catch (Exception _ex) {
		}
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
			throw new ServletException(e.getMessage());
		}
	}

}