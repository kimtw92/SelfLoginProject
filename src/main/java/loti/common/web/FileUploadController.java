package loti.common.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import ut.lib.util.Constants;
import ut.lib.util.SpringUtils;
import ut.lib.util.Util;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.BaseController;

@Controller
public class FileUploadController extends BaseController {

	private ServletContext servletContext;

	String _ROOT_DIR;
	String _TEMP_DIR;
	
	@Autowired
	public FileUploadController(ServletContext servletContext) {
		this.servletContext = servletContext;
		_ROOT_DIR = SpringUtils.getRealPath(servletContext) + Constants.UPLOAD; // 실제 저장위치
		_TEMP_DIR = SpringUtils.getRealPath(servletContext) + Constants.TEMP; // 임시 저장위치	
	}

	boolean _OVERWRITE = false; // 덮어쓰기 여부

	// 전역변수 선언 (선언부는 꼭 필요한 경우를 제외하고 수정하지 마십시오)
	String _SUB_DIR;
	String _action;
	String _filename;
	String _folder;
	String _filesize;
	String _newname;
	// 2008-05-28 저장 위치 및 실제 파일 저장 이름을 위하여 추가.
	String _saveDir;

	// 한번에 읽어들일 MultiPartRequest의 크기를 지정합니다.
	// 이 크기는 "한번에 업로드될 파일 크기 + 1MB" 의 크기로
	// 지정하시기 바랍니다.
	int nSizeLimit = 3 * 1024 * 1024;
	int BUFFER_SIZE = 51200; // 파일을 읽어들일때 속도 향상을 위해 할당하는 버퍼의 크기

	// 파일별 업로드 완료 사용자 콜백 함수
	private void setSaveInfo(String folder, String filename,
			String orig_filename) {

		/*
		 * folder : 파일이 저장된 위치, _ROOT_DIR 이하의 상대경로 filename : getSaveInfo 함수에서
		 * 필요에따라 변경하여 리턴된 실제 저장 파일명 orig_filename : 원본 파일명
		 */

		// 선점용 임시파일 삭제
		File z5 = new File(_ROOT_DIR + folder + filename + "._ds_");
		if (z5.exists())
			z5.delete();

		/*
		 * CREATE TABLE content_file ( content_file_id integer not null,
		 * content_id integer not null, folder varchar(4000) null,
		 * filename_original varchar(128) not null, filename_saved varchar(128)
		 * not null, filesize integer not null, created_ip varchar(16) not null,
		 * created_at timestamp not null )
		 * 
		 * 이 곳에 위와 유사한 구조의 테이블에 자료를 입력하는 스크립트를 작성하면 됩니다. 파일에 대한 Foreign Key 등은
		 * InnoDSInit 가 삽입된 페이지에 AppendPostData를 통해서 전달 받을 수 있습니다.
		 */

		// 업로드 표시 삭제
		// z5 = new File(_ROOT_DIR + _SUB_DIR + File.separator +
		// "uploading._ds_");
		z5 = new File(_ROOT_DIR + _saveDir + File.separator + "uploading._ds_");
		if (z5.exists())
			z5.delete();
	}

	// 파일명 정의 사용자 콜백 함수
	// z[0] 에 저장할 폴더를 지정하시면 되고 z[1] 에 저장할 파일명을 지정하시고 리턴해 주시면 됩니다.
	private String[] getSaveInfo(String folder, String filename) {

		String[] z = new String[2];

		// 덮어쓰기에서는 기존 파일 삭제
		if (_OVERWRITE) {
			File z5 = new File(_ROOT_DIR + folder + filename);
			if (z5.exists())
				z5.delete();

			z5 = new File(_ROOT_DIR + folder + filename + "._ds_");
			if (z5.exists())
				z5.delete();
		}

		// 넘버링 형태로 유니크 파일명 추출 (test.txt -> text(1).txt -> text(2).txt ->
		// text(3).txt ... text(100).txt)
		z[1] = getUniqueNumbering(folder, filename);
		// z[1] = DateUtil.getDateTimeMinSec();

		// 파일명 선점 처리
		File z5 = new File(_ROOT_DIR + folder + z[1] + "._ds_");
		try {
			z5.createNewFile();
		} catch (IOException e) {
			//
		}

		// 디렉터리에 업로드중 표시
		// z5 = new File(_ROOT_DIR + _SUB_DIR + File.separator +
		// "uploading._ds_");
		z5 = new File(_ROOT_DIR + _saveDir + File.separator + "uploading._ds_");

		try {
			z5.createNewFile();
		} catch (IOException e) {
			//
		}

		z[0] = folder;

		return z;
	}

	// 파일명 얻기
	private String getUniqueNumbering(String folder, String filename) {

		String file_name, file_ext, newfilename;
		int pos;

		pos = filename.lastIndexOf(".");

		if (pos == -1) {
			file_name = filename;
			file_ext = "";
		} else {
			file_name = filename.substring(0, pos);
			file_ext = filename.substring(pos);
		}

		newfilename = file_name + file_ext;

		if ((new File(_ROOT_DIR + folder + newfilename)).exists()
				|| (new File(_ROOT_DIR + folder + newfilename + "._ds_"))
						.exists()) {

			for (int i = 0; i < 100; i++) {
				newfilename = file_name + "(" + i + ")" + file_ext;

				if ((new File(_ROOT_DIR + folder + newfilename)).exists() == false
						&& (new File(_ROOT_DIR + folder + newfilename + "._ds_"))
								.exists() == false) {
					break;
				}
			}
		}

		return newfilename;
	}

	// 폴더 생성
	private void newFolder(String _path) {

		File z5;

		if (_path != null) {
			z5 = new File(_ROOT_DIR + _path);
			if (z5.exists() == false)
				z5.mkdirs();
		}
	}
	
//	@RequestMapping("/commonInc/fileUpload.do")
	public void fileUpload(
				HttpServletRequest request
			){
		
		// 파일 경로 없을 경우 생성.
		File uploadDir = new File(_ROOT_DIR);
		if (!uploadDir.exists())
			uploadDir.mkdir();
		File temp = new File(_TEMP_DIR);
		if (!temp.exists())
			temp.mkdir();
		
		//파일업로드
        MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)request;
        
        Iterator fileIter = mptRequest.getFileNames();
        
        while(fileIter.hasNext()){
        	List<MultipartFile> mFile = mptRequest.getFiles((String)fileIter.next());
        }
	}

	// Inno 컴퍼넌트 파일 업로드 실행.
	@RequestMapping("/commonInc/fileUpload.do")
	public void fileUpload(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// 파일 경로 없을 경우 생성.
		File uploadDir = new File(_ROOT_DIR);
		if (!uploadDir.exists())
			uploadDir.mkdir();
		File temp = new File(_TEMP_DIR);
		if (!temp.exists())
			temp.mkdir();

		// 파일 업로드 MultipartRequest
		MultipartRequest multi = new MultipartRequest(request, _TEMP_DIR,
				nSizeLimit, "EUC-KR", new DefaultFileRenamePolicy());

		// System.out.println("===== action_file.jsp ====");

		// 파라메타
		_SUB_DIR = multi.getParameter("_SUB_DIR");
		_action = multi.getParameter("_action");
		_filename = multi.getParameter("_filename");
		_folder = multi.getParameter("_folder");
		_filesize = multi.getParameter("_filesize");
		_newname = multi.getParameter("_newname");

		// System.out.println("\n ### realDir = " + _saveDir);
		_saveDir = multi.getParameter("SAVE_DIR");
		if (_saveDir != null) { // 신규 추가.

			if (_folder == null || _folder.length() == 0)
				_folder = _saveDir;
			else
				_folder = _saveDir + "\\\\" + _folder;

		} else if (_SUB_DIR != null) {
			if (_folder == null || _folder.length() == 0)
				_folder = _SUB_DIR;
			else
				_folder = _SUB_DIR + "\\\\" + _folder;

		}

		if (_folder == null)
			_folder = "";

		if (_action != null && _action.equals("getFileInfo")) {

			String ret[];
			String newfilename = "";
			String fullpath = "";
			long filesize = 0;

			// 폴더 생성
			if (_folder != null) {
				_folder = _folder.replaceAll("[\\\\]+", File.separator
						+ File.separator);
				newFolder(_folder);
				_folder += File.separator;
			}

			// 이어올리기 처리
			if (_newname != null) {

				newfilename = _newname;
				fullpath = _ROOT_DIR + _folder + newfilename;

				File z5 = new File(fullpath);
				if (z5.exists())
					filesize = z5.length();

			} else {

				ret = getSaveInfo(_folder, _filename);
				_folder = ret[0];
				_filename = ret[1];

				if (_folder == null)
					_folder = "";

				newfilename = _filename;
				fullpath = _ROOT_DIR + _folder + newfilename;
			}

			Util.out(response, "FileSize=" + filesize + ";");
			Util.out(response, "FileName=" + newfilename + ";");
			Util.out(response, "FilePath=" + fullpath + ";");

		} else if (_action != null && _action.equals("attachFile")) {

			String fullpath;
			long current_size, exists_size, saved_size;
			boolean bAppend = false;
			File z6 = multi.getFile("_file");

			current_size = z6.length();
			String orig_filename = multi.getOriginalFileName("_file");

			if (_folder != null) {
				_folder = _folder.replaceAll("[\\\\]+", File.separator
						+ File.separator);
				_folder += File.separator;
			}

			fullpath = _ROOT_DIR + _folder + _filename;

			File filetoken = new File(fullpath); // 지정된 경로의 파일객체 생성

			if (filetoken.exists()) {
				exists_size = filetoken.length();
				saved_size = current_size + exists_size;
				bAppend = true;
			} else {
				saved_size = current_size;
			}

			FileOutputStream fout = new FileOutputStream(filetoken, bAppend); // FileOutputStream
																				// 객체에
																				// 생성할
																				// 파일을
																				// APPEND모드로
																				// 할당
			byte buffer[] = new byte[BUFFER_SIZE]; // 버퍼할당

			try {

				FileInputStream fin = new FileInputStream(z6);
				for (int length; (length = fin.read(buffer, 0, BUFFER_SIZE)) != -1;) {
					// 파일을 읽어들여 지정된 파일에 붙인다.
					fout.write(buffer, 0, length);
				}

				fin.close();
				fout.close();

				z6.delete();

			} catch (IOException e) {
				//
			}

			System.out.println("_folder = " + _folder + "|| _filename = "
					+ _filename + "|| orig_filename = " + orig_filename);
			// 사용자 콜백
			if (saved_size >= Integer.parseInt(_filesize))
				setSaveInfo(_folder, _filename, orig_filename);

		}

	}

	// 이미지 검증 배열변수
	private final String[] allow_file = { "jpg", "png", "bmp", "gif" };
	
	@RequestMapping("/commonInc/SE/ImageUpload.do")
	public void seImageUpload(HttpServletRequest request,
			HttpServletResponse response) throws IOException,
			FileUploadException {
		String return1 = "";
		String return2 = "";
		String return3 = "";
		// 변경 title 태그에는 원본 파일명을 넣어주어야 하므로
		String name = "";
		if (ServletFileUpload.isMultipartContent(request)) {
			ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
			uploadHandler.setHeaderEncoding("UTF-8");
			List<FileItem> items = uploadHandler.parseRequest(request);
			for (FileItem item : items) {
				if (item.getFieldName().equals("callback")) {
					return1 = item.getString("UTF-8");
				} else if (item.getFieldName().equals("callback_func")) {
					return2 = "?callback_func=" + item.getString("UTF-8");
				} else if (item.getFieldName().equals("Filedata")) {
					if (item.getSize() > 0) {
						// String name =
						// item.getName().substring(item.getName().lastIndexOf(File.separator)+1);
						// 기존 상단 코드를 막고 하단코드를 이용
						name = item.getName().substring(
								item.getName().lastIndexOf(File.separator) + 1);
						String filename_ext = name.substring(name
								.lastIndexOf(".") + 1);
						filename_ext = filename_ext.toLowerCase();
						int cnt = 0;
						for (int i = 0; i < allow_file.length; i++) {
							if (filename_ext.equals(allow_file[i])) {
								cnt++;
							}
						}
						if (cnt == 0) {
							return3 = "&errstr=" + name;
						} else {

							// 파일 기본경로
							String dftFilePath = servletContext.getRealPath("/");
							// 파일 기본경로 _ 상세경로
							String filePath = dftFilePath + "editor" + File.separator + "upload" + File.separator;

							File file = null;
							file = new File(filePath);
							if (!file.exists()) {
								file.mkdirs();
							}

							String realFileNm = "";
							SimpleDateFormat formatter = new SimpleDateFormat(
									"yyyyMMddHHmmss");
							String today = formatter
									.format(new java.util.Date());
							realFileNm = today + UUID.randomUUID().toString()
									+ name.substring(name.lastIndexOf("."));

							String rlFileNm = filePath + realFileNm;
							// /////////////// 서버에 파일쓰기 /////////////////
							InputStream is = item.getInputStream();
							OutputStream os = new FileOutputStream(rlFileNm);
							int numRead;
							byte b[] = new byte[(int) item.getSize()];
							while ((numRead = is.read(b, 0, b.length)) != -1) {
								os.write(b, 0, numRead);
							}
							if (is != null) {
								is.close();
							}
							os.flush();
							os.close();
							// /////////////// 서버에 파일쓰기 /////////////////

							return3 += "&bNewLine=true";
							// img 태그의 title 옵션에 들어갈 원본파일명
							return3 += "&sFileName=" + name;
							return3 += "&sFileURL=/editor/upload/" + realFileNm;
						}
					} else {
						return3 += "&errstr=error";
					}
				}
			}
		}
		response.sendRedirect(return1 + return2 + return3);

	}

	@RequestMapping("/commonInc/SE/MultipleImageUpload.do")
	public String seMultipleImageUpload(HttpServletRequest request,
			HttpServletResponse response) throws IOException,
			FileUploadException {
		
		String fileInfo;
		
		// 파일정보
		String sFileInfo = "";
		// 파일명을 받는다 - 일반 원본파일명
		String filename = request.getHeader("file-name");
		// 파일 확장자
		String filename_ext = filename.substring(filename.lastIndexOf(".") + 1);
		// 확장자를소문자로 변경
		filename_ext = filename_ext.toLowerCase();

		// 돌리면서 확장자가 이미지인지
		int cnt = 0;
		for (int i = 0; i < allow_file.length; i++) {
			if (filename_ext.equals(allow_file[i])) {
				cnt++;
			}
		}

		// 이미지가 아님
		if (cnt == 0) {
			fileInfo = "NOTALLOW_" + filename;
		} else {
			// 이미지이므로 신규 파일로 디렉토리 설정 및 업로드
			// 파일 기본경로
			String dftFilePath = servletContext.getRealPath("/");
			// 파일 기본경로 _ 상세경로
			String filePath = dftFilePath + "editor" + File.separator
					+ "multiupload" + File.separator;
			File file = new File(filePath);
			if (!file.exists()) {
				file.mkdirs();
			}
			String realFileNm = "";
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
			String today = formatter.format(new java.util.Date());
			realFileNm = today + UUID.randomUUID().toString()
					+ filename.substring(filename.lastIndexOf("."));
			String rlFileNm = filePath + realFileNm;
			// /////////////// 서버에 파일쓰기 /////////////////
			InputStream is = request.getInputStream();
			OutputStream os = new FileOutputStream(rlFileNm);
			int numRead;
			byte b[] = new byte[Integer
					.parseInt(request.getHeader("file-size"))];
			while ((numRead = is.read(b, 0, b.length)) != -1) {
				os.write(b, 0, numRead);
			}
			if (is != null) {
				is.close();
			}
			os.flush();
			os.close();
			// /////////////// 서버에 파일쓰기 /////////////////

			// 정보 출력
			sFileInfo += "&bNewLine=true";
			// sFileInfo += "&sFileName="+ realFileNm;;
			// img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
			sFileInfo += "&sFileName=" + filename;
			;
			sFileInfo += "&sFileURL=" + "/editor/multiupload/" + realFileNm;
			fileInfo = sFileInfo;
		}
		
		request.setAttribute("fileInfo", fileInfo);
		
		return "/se2/multipleImageUpload";
	}
}
