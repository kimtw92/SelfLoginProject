package ut.lib.mail;

import javax.activation.*;
import java.io.*;

class ByteArrayDataSource implements DataSource {
	byte[] bytes;
	String contentType;
	String name;

	ByteArrayDataSource(byte[] bytes, String contentType, String name) {
		this.bytes = bytes;
		if(contentType == null)
			this.contentType = "application/octet-stream";
		else
			this.contentType = contentType;
		this.name = name;
	}

	public String getContentType() {
		return contentType;
	}

	public InputStream getInputStream() {
		// remove the final CR/LF
		return new ByteArrayInputStream(bytes,0,bytes.length - 2);
	}

	public String getName() {
		return name;
	}

	public OutputStream getOutputStream() throws IOException {
		throw new FileNotFoundException();
	}
}