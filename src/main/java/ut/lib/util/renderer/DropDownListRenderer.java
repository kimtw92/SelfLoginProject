package ut.lib.util.renderer;


import ut.lib.support.DataMap;

public class DropDownListRenderer {
	public static String DropDownListRendering(DataMap source, String valueColumn, String textColumn) {
		String rtn = "";
		for (int i = 0; i < source.keySize(valueColumn); i++) {
			rtn += "<option value=\"" + source.getString(valueColumn, i) + "\">" + source.getString(textColumn, i) + "</option>";
		}

		return rtn;

	}

	public static String DropDownListRendering(DataMap source, String valueColumn, String textColumn, String defalutValue) {
		String rtn = "";

		for (int i = 0; i < source.keySize(valueColumn); i++) {
			rtn += "<option value=\"" + source.getString(valueColumn, i) + "\"";

			if (source.getString(valueColumn, i).equals(defalutValue)) {
				rtn+= " selected";
			}

			rtn += ">" + source.getString(textColumn, i) + "</option>";
		}
		return rtn;
	}
}
