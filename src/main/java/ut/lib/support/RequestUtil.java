package ut.lib.support;


import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;



import org.apache.log4j.Logger;

import ut.lib.file.FileUtil;
import ut.lib.util.Constants;
import ut.lib.util.DateUtil;
import ut.lib.util.MD5;
import ut.lib.util.SpringUtils;



/**
 * <B>NRequestUtil</B><br>
 * - HttpServletRequest를 파싱하여 DataMap로 변환하는 메서드를 포함하고 있다.<br>
 * - enctype이 multipart일 경우 파일을 업로드한다.<br>
 * @author  miru
 * @version 2005. 7. 02.
 */

public class RequestUtil
{

	private static Logger log = Logger.getLogger(RequestUtil.class);
	
	private RequestUtil()
	{
	}

    /**
     * FORM의 INPUT Data를 파싱하여 DataMap 객체에 담아 return한다.
     * @return DataMap
     */
	public static DataMap getAttributeBox(HttpServletRequest httpservletrequest){
		DataMap box = new DataMap("REQUEST_DATA");
		String s;
		for(Enumeration enumeration = httpservletrequest.getAttributeNames(); enumeration.hasMoreElements(); box.put(s, httpservletrequest.getAttribute(s))) {
			s = (String)enumeration.nextElement();
		}

		return box;
	}

	/**
     * Cookie를 DataMap 객체에 담아 return한다.
     * @return DataMap
     */
	public static DataMap getDataFromCookie(HttpServletRequest request) {
		
		DataMap box = new DataMap("COOKIE_DATA");
		Cookie acookie[] = request.getCookies();
		
		if(acookie == null)
			return box;
		
		for(int i = 0; i < acookie.length; i++) {
			String s = acookie[i].getName();
			String s1 = acookie[i].getValue();
			if(s1 == null)
				s1 = "";
			String s2 = s1;
			box.set(s, s2);
		}

		return box;
	}

	
	
	
	/**
	 * Inno 컴퍼넌트 사용을 위한 getRequest
	 * @param request
	 * @return
	 * @throws IOException
	 */
	public static DataMap getRequest(HttpServletRequest request) throws IOException{
		DataMap map = new DataMap("REQUEST_DATA");
		String s;
		boolean isMultipart = FileUpload.isMultipartContent(request);

		log.debug("\n ## file is  = " + isMultipart + " \n" );
		
		if (isMultipart) {
			//System.out.print("\n ## file is  = true \n" );
			
			//파일 Map
			DataMap fileBox = new DataMap("UPLOAD_FILE");
			
			// temp 폴더 없을경우 생성.
			if ( !new File(SpringUtils.getRealPath(request) + Constants.TEMP).exists() ) 
				new File(SpringUtils.getRealPath(request) + Constants.TEMP).mkdir();

			DiskFileUpload upload = new DiskFileUpload();
			upload.setRepositoryPath(SpringUtils.getRealPath(request) + Constants.TEMP);
			upload.setSizeMax(100*1024*1024);
			upload.setSizeThreshold(1024*50);
			upload.setHeaderEncoding("UTF-8");
			
			String dir = ""; //파일 저장 위치.
			String renameYn = "Y";

			// 강사사진관련
			String resno = "";
			
			try {

				List items = upload.parseRequest(request);
				Iterator iter = items.iterator();

				for (int i = 0; i < items.size(); i++) {
					FileItem item = (FileItem) items.get(i);
					if (item.isFormField()){
						if (item.getFieldName().equals("UPLOAD_DIR"))
							dir = item.getString();
						if (item.getFieldName().equals("INNO_SAVE_DIR"))
							dir = item.getString();
						if (item.getFieldName().equals("RENAME_YN"))
							renameYn = item.getString();
						
						// 강사사진관련
						if (item.getFieldName().equals("resno")){
							resno = item.getString();
						}
					}
					
				}

				log.debug("\n ## System Upload Dir = " + SpringUtils.getRealPath(request) + Constants.UPLOAD + dir + " \n" );

				
				// PDS 폴더 없을경우 생성.
				if ( !new File(SpringUtils.getRealPath(request) + Constants.UPLOAD).exists() ) 
					new File(SpringUtils.getRealPath(request) + Constants.UPLOAD).mkdir();
				
				// 저장 폴더 없을 경우 생성.
				if ( !new File(SpringUtils.getRealPath(request) + Constants.UPLOAD + dir).exists() ) 
					new File(SpringUtils.getRealPath(request) + Constants.UPLOAD + dir).mkdir();
				
				int tmpCnt = 0;
				while (iter.hasNext()) {
					
					FileItem item = (FileItem) iter.next();

					if (item.isFormField()) { //파일이 아님경우

						String name = item.getFieldName();
						//String value = UtilLang.ko(item.getString());
						String value = item.getString("UTF-8");
						
						if(name.equals("_innods_filename")) //Inno 컴퍼넌트로 넘어온 파일
							fileBox.add("fileSysName", value);
						else if(name.equals("_innods_folder")) //Inno 컴퍼넌트로 넘어온 파일의 폴더
							fileBox.add("fileFolder", value);
						else if(name.equals("_innods_filesize")) //Inno 컴퍼넌트로 넘어온 파일의 크기.
							fileBox.add("fileSize", value);
						else if(name.equals("_innods_exist_file")){ //Inno 컴퍼넌트로 넘어온 기존 파일 정보.
							
							fileBox.add("existFile", value);
							//System.out.println("\n ########## exist_file_value = " + value);
							
						}else if(name.equals("_innods_deleted_file")){ //Inno 컴퍼넌트로 삭제된 기존 파일 정보.
							
							if(value.indexOf("#") > -1){
								fileBox.add("deleteFile", value);
								//System.out.println("\n ########## deleteFile_value = " + value);
							}
							
						}else if(name.equals("existFile")){
							fileBox.add("existFile", value);
						}
						//System.out.println("\n $$$ ["+name+"] =  " + value);
						//map.add(name, value);
						map.add(name, value);

						
					} else { //파일 일경우.

						log.debug("\n $$$ " + item.getName() + "");
						if (item.getName().length() != 0) {

							String orgFileName = FileUtil.getFileNameChop(item.getName()); //사용자가 올린  파일 이름.
							String sysFileName = ""; //실제 저장되는 파일 이름.
							
							File uploadFile = null;
							
							if(renameYn.equals("tutor")){
								// 강사관리에서 강사사진전용
								ut.lib.util.MD5 md5 = new MD5(resno);
								sysFileName = md5.asHex();								
								
								FileUtil.deleteFile(SpringUtils.getRealPath(request) + Constants.UPLOAD + dir, sysFileName);
								
							}else{
								
								// 파일 리네임이 N이 아니면 리네임
								if( !renameYn.equals("N") ){
									sysFileName =  DateUtil.getDateTimeMinSec() + tmpCnt;
								}else{
									sysFileName = orgFileName;
								}
																
							}
							
							// 시스템에 저장되는 파일.
							uploadFile = FileUtil.getConvertFile(new File( SpringUtils.getRealPath(request) + Constants.UPLOAD + dir + sysFileName));
						
							

							//; //파일 중복 검사.
							item.write(uploadFile); //파일 저장.

							fileBox.addString(item.getFieldName() + "_filePath", dir ); //저장 위치. /inno/common/
							fileBox.addString(item.getFieldName() + "_fileOrgName", orgFileName); //사용자 파일명.
							fileBox.addString(item.getFieldName() + "_fileName", uploadFile.getName()); //실제 저장되는 파일 이름.
							fileBox.addLong(item.getFieldName() + "_fileSize", uploadFile.length());
							fileBox.addString("fileUploadOk", "1");
							
							
							log.debug("\n #################################################### ");
							log.debug("\n " + item.getFieldName() + "_filePath = " + dir);
							log.debug("\n " + item.getFieldName() + "_fileOrgName = " + orgFileName);
							log.debug("\n " + item.getFieldName() + "_fileName = " + uploadFile.getName());
							log.debug("\n " + item.getFieldName() + "_fileSize = " + uploadFile.length());
							log.debug("\n fileUploadOk = 1");

						}
					}
					
					tmpCnt++;
				}
				
				
				map.add("UPLOAD_FILE", fileBox);
				
				
			} catch (Exception ex) {
				ex.printStackTrace();
				//System.out.println("Exception="+ex.getMessage());
			} finally {
				// 종료 시에 반드시 자원을 해제해야 한다.
				// 그렇지 않으면 임시 파일이 삭제되지 않고 남을 수 있다.
				try{
				}catch (Exception ex) {}
			}
				
				

		} else {
			log.debug("[ENDER DEBUG] : 1");
			//System.out.print("\n ## file is  = false\n" );
			
			//boolean isGet = request.getMethod().toUpperCase().equals("GET");	// JEUS에서 한글 처리를 위해 삽입 2005.09.08
			//boolean isGet = false;
			Enumeration enumeration = request.getParameterNames();

			while(enumeration.hasMoreElements()) {
				s = (String)enumeration.nextElement();
				String as[] = request.getParameterValues(s);

				for(int i = 0; i < as.length; i++) {
					map.add(s, as[i]);
					//if (isGet) {
					//	map.add(s, UtilLang.ko(as[i]));
					//} else {
						//map.add(s, UtilLang.ko(as[i]));
					//	map.add(s, as[i]);
					//	box.add(s, as[i]);
					//}
				}
			}
		}

		map.setString("ip", request.getRemoteAddr());
		
		request.setAttribute("REQUEST_DATA", map);

		return map;
	}
	
	
	

	/**
     * FORM의 INPUT Data를 파싱하여 DataMap 객체에 담아 return한다.
     * enctype이 multipart인 경우 파일을 저장한다.
     * @return DataMap
     */
	public static DataMap getRequestBackup(HttpServletRequest request)
	{
		DataMap map = new DataMap("REQUEST_DATA");
		String s;
		boolean isMultipart = FileUpload.isMultipartContent(request);

		if (isMultipart) {
			String dir = ""; //파일 저장 위치.

			DataMap fileBox = new DataMap("UPLOAD_FILE");

			DiskFileUpload upload = new DiskFileUpload();
			upload.setRepositoryPath(Constants.TEMP);
			upload.setSizeMax(100*1024*1024);
			upload.setSizeThreshold(1024*50);

			try {

				List items = upload.parseRequest(request);
				Iterator iter = items.iterator();

				for (int i = 0; i < items.size(); i++) {
					FileItem item = (FileItem) items.get(i);

					if (item.isFormField()) {
						if (item.getFieldName().equals("upload_path")) {
							dir = item.getString();
							break;
						}
					}
				}

				log.debug("\n $dir = " + dir + " \n" );

				while (iter.hasNext()) {

					FileItem item = (FileItem) iter.next();

					if (item.isFormField()) { //파일이 아님경우

						String name = item.getFieldName();
						String value = item.getString();
						map.add(name, value);

					} else { //파일 일경우.

						if (item.getName().length() != 0) {

							File file = new File(Constants.UPLOAD + "/" + dir);

							if ( !new File(Constants.UPLOAD).exists() ) //upload 폴더 없을경우 생성.
								new File(Constants.UPLOAD).mkdir();
							if(!file.exists()) //저장 폴더.
								file.mkdir();


							File uploadFile = FileUtil.getFileNameTemp(dir);
							item.write(uploadFile);

							fileBox.addString("filePath", "/"+dir); //저장 위치. /board, /app.. , /myinfo
							fileBox.addString("fileName", FileUtil.getFileNameChop(item.getName())); //사용자 파일명.
							fileBox.addString("fileSysName", uploadFile.getName()); //실제 저장 파일.

							fileBox.addString("fieldName", item.getFieldName());
							fileBox.addString("clientFileName", FileUtil.getFileNameChop(item.getName()));
							fileBox.addLong("fileSize", uploadFile.length());
							fileBox.addString("fileUploadOk", "1");

						}
					}
				}

				map.add("UPLOAD_FILE", fileBox);


			} catch (FileUploadException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			log.debug("[ENDER DEBUG] : 2");
			//System.out.print("\n ## file is  = false\n" );
			
			//boolean isGet = request.getMethod().toUpperCase().equals("GET");	// JEUS에서 한글 처리를 위해 삽입 2005.09.08
			//boolean isGet = false;
			Enumeration enumeration = request.getParameterNames();

			while(enumeration.hasMoreElements()) {
				s = (String)enumeration.nextElement();
				String as[] = request.getParameterValues(s);

				for(int i = 0; i < as.length; i++) {
					map.add(s, as[i]);
					//if (isGet) {
					//	map.add(s, UtilLang.ko(as[i]));
					//} else {
						//map.add(s, UtilLang.ko(as[i]));
					//	map.add(s, as[i]);
					//	box.add(s, as[i]);
					//}
				}
			}
		}
		
		//System.out.println("\n #Connection Ip = " + request.getRemoteAddr());
		map.setString("ip", request.getRemoteAddr());

		return map;
	}

}