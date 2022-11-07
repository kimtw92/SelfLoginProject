package ut.lib.file;

import java.io.File;
import java.sql.SQLException;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import loti.common.mapper.CommonMapper;
import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Functions;
import ut.lib.util.ListUtil;
import ut.lib.util.Message;
import ut.lib.util.SpringUtils;


/**
 * File Utility Class
 */
public class FileUtil {

    public static final Pattern dosSeperator = Pattern.compile("\\\\");
    public static final Pattern lastSeperator = Pattern.compile("/$");

    /**
     * 패스정보를 제외한 파일명을 리턴한다.
     * @return 패스정보를 삭제한 파일명
     */
    public static String getFileNameChop(String s) {
        if(s == null)
            return null;
        s = dosSeperator.matcher(s).replaceAll("/");
        int i = s.lastIndexOf("/");
        if(i > -1)
            return s.substring(i + 1);
        else
            return s;
    }
    /**
     * 패스정보를 제외한 게시판에 등록할 파일명명을 리턴한다.
     * @return 패스정보를 삭제한 파일명
     */
    public static File getFileNameTemp(String dir) {


    	File file = null;
    	File returnFile = null;

        if(dir == null)
            return file;

        if (dir.equals("board")){

        	file = new File(getFilePath(dir) + "/" + "board_file_temp");
        	returnFile = getConvertFile(file); // 파일 중복 체크.

        }else if ( dir.equals("member") ){

        	file = new File(getFilePath(dir) +  "/" + "member_file_temp");
        	returnFile = getConvertFile(file); // 파일 중복 체크.

        }else{

        	file = new File(getFilePath(dir) + "/" + dir +"_file_temp");
        	returnFile = getConvertFile(file); // 파일 중복 체크.

        }

        if (returnFile != null) System.out.print("\n ## getFileNameTemp. file.getName() = " + returnFile.getName());
        return returnFile;

    }

    /**
     * 파일 경로를 가져오는 메소드
     * @param gubun
     * @param dir
     * @return
     */
    public static String getFilePath(String dir) {

        if(dir == null)
            return null;

    	return Constants.UPLOAD + "/" + dir;

    }

    /**
     * 주어진 파일의 path의 마지막에 /가 있는지 검사하고 없는 경우 /를 추가하여 리턴한다.
     * @return /를 붙인 full path
     */
    public static String getCompleteLeadingSeperator(String s) {
        if(s == null)
            return null;
        s = dosSeperator.matcher(s).replaceAll("/");
        if(!s.endsWith(File.separator))
            s = s + "/";
        return s;
    }

    /**
     * 파일명 중복시 파일명[index].확장자 형태로 파일명을 변경해서 리턴한다.
     * @return 변경된 파일명
     */
    public static File getConvertFile(File file) {
        if(!file.exists()) {
            return file;
        }

        String s = file.getName();
        int i = s.lastIndexOf('.');
        String s1 = i != -1 ? s.substring(i) : "";
        String s2 = i != -1 ? s.substring(0, i) : s;

        int j = 0;
        do {
            
            file = new File(getCompleteLeadingSeperator(file.getParent()) + s2 + "[" + j + "]" + s1);
           
        	
            j++;
        } while(file.exists());

        return file;
    }
    
    
    /**
     * 저장 디렉토리에 특정 파일 삭제.
     * @param path
     * @param delFileName
     * @return
     */
    public static boolean deleteFile(String path, String delFileName) throws BizException{

    	boolean returnValue = false;

		File fileDir = new File(path); //저장 디렉토리.
		if(fileDir.exists() && fileDir.isDirectory()){
			File[] datafile= fileDir.listFiles();
			for(int n=0;n<datafile.length;n++){
				if (datafile[n].getName().equals(delFileName)){
					datafile[n].delete();
					break;
				}
			}
			returnValue = true;
		}else{
			returnValue = true;
		}

    	return returnValue;
    }

 
    
    
    
    /**
     * 실제 저장된 파일 삭제.
     * 
     * @param fileInfo : 파일의 경로 + 이름까지 함께 넘겨와야 한다. (TB_UPLOAD.FILE_PATH)
     * @throws Exception
     */
    public static void deleteFile(String fileInfo) throws Exception {

    	if(fileInfo == null || fileInfo.equals(""))
    		return;
    	
    	File delFile = new File(SpringUtils.getRealPath() + Constants.UPLOAD + fileInfo);

    	if(delFile.exists() && delFile.isFile())
    		delFile.delete();
    	
    	System.out.println("\n 파일 삭제 시킴 : " + fileInfo);
    	
    }
    
    /**
     * DB 및 실제 파일을 삭제 한다.
     * @param groupfileNo
     * @throws Exception
     */
    public static void commonDeleteGroupfile(int groupfileNo) throws Exception {

    	
    	try{
    		
    		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
    		
    		String attr = FrameworkServlet.SERVLET_CONTEXT_PREFIX+"dispatcher";
    		WebApplicationContext context =  WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext(),attr);
    		CommonMapper commonMapper = context.getBean(CommonMapper.class);
    		
	        //파일정보
	        DataMap fileMap = commonMapper.selectUploadFileList(groupfileNo);
	        if(fileMap == null) return;
	        fileMap.setNullToInitialize(true);
	        
			if(fileMap.keySize("groupfileNo") > 0){
				
				//DB의 기존 파일의 모든 정보
				for(int i=0; i < fileMap.keySize("groupfileNo"); i++){
					//파일 삭제.
					deleteFile(fileMap.getString("filePath", i));
				}
				
				//기존 groupFile 삭제.
				commonMapper.deleteUploadGroupFileNo(groupfileNo);  
				
			}
			
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } catch (Exception e) {
            throw new BizException(e);
        } finally {
        }
        

    }
    
    
    
}

