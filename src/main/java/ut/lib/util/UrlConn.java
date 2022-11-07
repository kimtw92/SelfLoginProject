package ut.lib.util;

import java.net.URL;
import java.net.MalformedURLException;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.IOException;

/**
 *
 * URL을 넘기면 해당 웹페이지를 가져온다.
 *
 * @author  정해영(hyjung@pentabreed.com)
 * @version 2005. 4. 8.
 */
public class UrlConn {


    public String getPage(String URL) throws Exception {
        URL url;//URL 주소 객체
        InputStream is;//URL접속에서 내용을 읽기위한 Stream
        BufferedReader br;

        //내용을 읽어서 리턴한다.
        String retBuf = "";
        try{
            //URL객체를 생성하고 해당 URL로 접속한다..
            url = new URL(URL);
            is=url.openStream();
            br=new BufferedReader(new InputStreamReader(is, "EUC-KR"));

            String buf = null;
            while(true){
                buf = br.readLine();
                if(buf == null) {
                	break;
                }
                retBuf += buf;
            }
        } catch(MalformedURLException mue){			// 잘못된 URL인 경우
        	System.out.println("MalformedURLException : "+mue.getMessage());
        	throw new Exception("common.util.UrlConn.getPage.ms1");
        } catch(IOException ioe){
        	System.out.println("Warning : IOException >> "+ioe.getMessage());
        	throw new Exception("common.util.UrlConn.getPage.ms2");
        }
        return retBuf;
    }

    public String getPageByLine(String URL) throws Exception {
        URL url;//URL 주소 객체
        InputStream is;//URL접속에서 내용을 읽기위한 Stream
        BufferedReader br;

        //내용을 읽어서 리턴한다.
        String retBuf = "";
        try{
            //URL객체를 생성하고 해당 URL로 접속한다..
            url = new URL(URL);
            is=url.openStream();
            br=new BufferedReader(new InputStreamReader(is, "EUC-KR"));

            String buf = null;
            while(true){
                buf = br.readLine();
                if(buf == null) {
                	break;
                }
                retBuf += buf + "\n";
            }
        } catch(MalformedURLException mue){			// 잘못된 URL인 경우
        	System.out.println("MalformedURLException : "+mue.getMessage());
        	throw new Exception("common.util.UrlConn.getPage.ms1");
        } catch(IOException ioe){
        	System.out.println("Warning : IOException >> "+ioe.getMessage());
        	throw new Exception("common.util.UrlConn.getPage.ms2");
        }
        return retBuf;
    }
}
