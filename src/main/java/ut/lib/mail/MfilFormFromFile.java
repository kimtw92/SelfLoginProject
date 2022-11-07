package ut.lib.mail;


import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import ut.lib.log.Log;
import ut.lib.util.Constants;

public class MfilFormFromFile implements MailForm {
	String formHtml = null;

	public String getMailForm(String fileName) throws Exception {
		String filePath = "";						//파일 경로
		FileReader reader = null;
		formHtml = "";
		try {

	//        filePath = Constants.MAIL_FORM + fileName;

			//파일리더 객체
			reader = new FileReader(filePath);

			//파일 읽기

			int tmpStr = 0;

			while (true) {
				tmpStr = reader.read();

				if (tmpStr == -1) break;
				formHtml += (char)tmpStr;
			}

		    formHtml.replaceAll("@@URL@@", Constants.URL);
		} catch(FileNotFoundException e) {
		    Log.error(this.getClass(), "[Exception in " + this.getClass().getName() + "]" + e.getMessage());
			throw e;
		} catch(IOException e) {
		    Log.error(this.getClass(), "[Exception in " + this.getClass().getName() + "]" + e.getMessage());
			throw e;
	    } finally {
			try {
				reader.close();
			} catch(IOException e) {
			    Log.error(this.getClass(), "[Exception in " + this.getClass().getName() + "]" + e.getMessage());
				throw e;
			}
		}

		return formHtml;
	}

}
