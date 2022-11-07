package loti;

import java.io.File;
import java.io.IOException;

import loti.homeFront.web.IndexController;
import ut.lib.util.SpringUtils;

public class RealPathTester {

	public static void main(String[] args) throws IOException {
		String path = SpringUtils.getApplicationRealPath();
		System.out.println(path);
		
		File file = new File(IndexController.class.getProtectionDomain().getCodeSource().getLocation().getPath());
		System.out.println(file.getAbsolutePath());
	}
}
