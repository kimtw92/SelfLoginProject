package ut.lib.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import ut.lib.support.DataMap;

public class WebUtils {

	private WebUtils() {
	}

	public static String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.contains("MSIE")) {
			return "MSIE";
		} else if (header.contains("Chrome")) {
			return "Chrome";
		} else if (header.contains("Opera")) {
			return "Opera";
		}
		return "Firefox";
	}
	
	public static String encodeFileName(String browser, String fileName, String charsetFrom, String charsetTo) throws UnsupportedEncodingException{
		if (browser.contains("MSIE")) {
			return URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
		} else if (browser.contains("Firefox")) {
			return new String(fileName.getBytes(charsetFrom), charsetTo);
		} else if (browser.contains("Opera")) {
			return new String(fileName.getBytes(charsetFrom), charsetTo);
		} else if (browser.contains("Chrome")) {
			return new String(fileName.getBytes(charsetFrom), charsetTo);
		}
		return null;
	}
	
	public static String encodeFileName(String browser, String fileName) throws UnsupportedEncodingException{
		return encodeFileName(browser, fileName, "UTF-8", "EUC-KR");
	}
	
	public static void setFileHeader(HttpServletRequest request, HttpServletResponse response, String fileName, String charsetFrom, String charsetTo) throws UnsupportedEncodingException{
		String browser = getBrowser(request);
		String encodedfileName = encodeFileName(browser, fileName, charsetFrom, charsetTo);
		if (browser.contains("MSIE")) {
			response.setHeader("Content-Disposition", "attachment;filename=" + encodedfileName + ";");
		} else if (browser.contains("Firefox")) {
			response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedfileName + "\"");
		} else if (browser.contains("Opera")) {
			response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedfileName + "\"");
		} else if (browser.contains("Chrome")) {
			response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedfileName + "\"");
		}
	}
	public static void setFileHeader(HttpServletRequest request, HttpServletResponse response, String fileName) throws UnsupportedEncodingException{
		setFileHeader(request, response, fileName, "UTF-8", "EUC-KR");
	}
	
    public static HttpServletRequest getCurrentRequest(){
        return((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
    }
	
   public static String getClientIp(){
                 return getClientIp(getCurrentRequest());
   }
  
   public static String getClientIp(HttpServletRequest request){
                 String ip =request.getHeader("X-Forwarded-For");
                 if (ip == null || ip.length()== 0 || "unknown".equalsIgnoreCase(ip)){
                     ip = request.getHeader("Proxy-Client-IP");
                 }
                 if (ip == null || ip.length()== 0 || "unknown".equalsIgnoreCase(ip)){
                     ip = request.getHeader("WL-Proxy-Client-IP");
                 }
                 if (ip == null || ip.length()== 0 || "unknown".equalsIgnoreCase(ip)){
                     ip = request.getHeader("HTTP_CLIENT_IP");
                 }
                 if (ip == null || ip.length()== 0 || "unknown".equalsIgnoreCase(ip)){
                     ip = request.getHeader("HTTP_X_FORWARDED_FOR");
                 }
                 if (ip == null || ip.length()== 0 || "unknown".equalsIgnoreCase(ip)){
                     ip = request.getRemoteAddr();
                 }
                 return ip;
   }
   
   public static DataMap getRequestMap(MultipartHttpServletRequest request){
	   
	   DataMap requestMap = new DataMap("REQUEST_MAP");
	   
	   Map<String, String[]> paramMap = request.getParameterMap();
	   
	   for(Entry<String, String[]> entry : paramMap.entrySet()){
		   for(String value : entry.getValue()){
			   requestMap.addString(entry.getKey(), value);
		   }
	   }
	   
	   return requestMap;
   }
   
   public static void setExcelHeader(String excelName, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{

	   setFileHeader(request, response, excelName+".xls", "UTF-8", "UTF-8");
	   response.setHeader("Content-Description", "JSP Generated Data");
	   response.setContentType("application/vnd.ms-excel");
	   request.setCharacterEncoding("UTF-8");
   }
}
