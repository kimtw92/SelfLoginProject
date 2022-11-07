package ut.lib.util;

import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;


public class Crypto{
	/**
	 * 파일암호화에 쓰이는 버퍼 크기 지정
	 */
	public static final int kBufferSize = 8192;
	public static java.security.Key key = null;
	public static final String defaultkeyfileurl = "hana.key";

	public static Cipher c = null;

//	public static final String defaultkeyfileurl = "C:/개발-하나금융그룹/OilBank/WebRoot/WEB-INF/classes/hana.key";


	public static synchronized Cipher getObject() throws NoSuchAlgorithmException, NoSuchPaddingException {
	    if (c == null) {
	        c = Cipher.getInstance("DES/ECB/PKCS5Padding");
	    }
	    return c;
	}

	/**
	 * 비밀키 생성메소드
	 * @return  void
	 * @exception java.io.IOException,java.security.NoSuchAlgorithmException
	 */
	public static java.io.File makekey() throws java.io.IOException,java.security.NoSuchAlgorithmException{
		return makekey(defaultkeyfileurl);
	}


	public static java.io.File makekey(String filename) throws java.io.IOException,java.security.NoSuchAlgorithmException{
		java.io.File tempfile = new java.io.File(".",filename);
//		java.io.File tempfile = new java.io.File(filename);
		javax.crypto.KeyGenerator generator = javax.crypto.KeyGenerator.getInstance("DES");
		generator.init(new java.security.SecureRandom());
		java.security.Key key = generator.generateKey();
		java.io.ObjectOutputStream out = new java.io.ObjectOutputStream(new java.io.FileOutputStream(tempfile));
		out.writeObject(key);
		out.close();
		return tempfile;
	}

	/**
	 * 지정된 비밀키를 가지고 오는 메서드
	 * @return  Key 비밀키 클래스
	 * @exception Exception
	 */
	private static java.security.Key getKey() throws Exception{
		if(key != null){
			return key;
		}else{
			return getKey(defaultkeyfileurl);
		}
	}
	private static java.security.Key getKey(String fileurl) throws Exception{
		if(key == null){
			java.io.File file = new java.io.File(fileurl);
			if(!file.exists()){
				file = makekey();
			}
			if(file.exists()){
				java.io.ObjectInputStream in = new java.io.ObjectInputStream(new java.io.FileInputStream(fileurl));
				key = (java.security.Key)in.readObject();
				in.close();
			}else{
				throw new Exception("암호키객체를 생성할 수 없습니다.");
			}
		}
		return key;
	}

	/**
	 * 문자열 대칭 암호화
	 * @param   ID  비밀키 암호화를 희망하는 문자열
	 * @return  String  암호화된 ID
	 * @exception Exception
	 */
	public static String encrypt(String ID) throws Exception{
	    //long s1 = System.currentTimeMillis();
		if ( ID == null || ID.length() == 0 ) return "";
		//long s2 = System.currentTimeMillis();
		//Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
		Cipher cipher = getObject();
		//long e3 = System.currentTimeMillis();
		//long s4 = System.currentTimeMillis();
		cipher.init(Cipher.ENCRYPT_MODE,getKey());
		//long e1 = System.currentTimeMillis();
		String amalgam = ID;

		byte[] inputBytes1 = amalgam.getBytes("UTF8");
		byte[] outputBytes1 = cipher.doFinal(inputBytes1);
		sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
		String outputStr1 = encoder.encode(outputBytes1);
		//long e2 = System.currentTimeMillis();

		return outputStr1;
	}


	/**
	 * 문자열 대칭 복호화
	 * @param   codedID  비밀키 복호화를 희망하는 문자열
	 * @return  String  복호화된 ID
	 * @exception Exception
	 */
	public static String decrypt(String codedID) throws Exception{
	    //long s1 = System.currentTimeMillis();

		if ( codedID == null || codedID.length() == 0 ) return "";
		//Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
		Cipher cipher = getObject();
		cipher.init(Cipher.DECRYPT_MODE, getKey());
		sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();

		byte[] inputBytes1  = decoder.decodeBuffer(codedID);
		byte[] outputBytes2 = cipher.doFinal(inputBytes1);

		String strResult = new String(outputBytes2,"UTF8");
		//long e1 = System.currentTimeMillis();

		return strResult;
	}

	public static long PNO2Encrypt(String pno1, String pno2) {
		String pno = pno1 + pno2;
		return pno.hashCode();
	}
}

