package ut.lib.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class ExcelExcutor {

	public static <R> R excute(File xlsFile, Function<HSSFWorkbook, R> func)
			throws IOException {

		FileInputStream fis = null;
		HSSFWorkbook workbook = null;
		R r = null;

		try {
			fis = new FileInputStream(xlsFile);
			workbook = new HSSFWorkbook(fis);
			r = func.apply(workbook);
		} finally {
			if(workbook != null) workbook.close();
			if(fis != null) fis.close();
		}

		return r;
	}
	
	public static <R> R excute(InputStream is, Function<HSSFWorkbook, R> func)
			throws IOException {

		HSSFWorkbook workbook = null;
		R r = null;

		try {
			workbook = new HSSFWorkbook(is);
			r = func.apply(workbook);
		} finally {
			if(workbook != null) workbook.close();
			if(is != null) is.close();
		}

		return r;
	}
}
