package loti;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import ut.lib.support.DataMap;
import ut.lib.util.Functions;
import ut.lib.util.ListUtil;


public class CopyOftest {

	public static void main(String[] args) {
		
		DataMap dm = new DataMap();
		
		dm.put("a", "a");
		dm.set("b", "b");
		dm.setString("c", "c");
		dm.setInt("d", 1);
		
		Map a = new HashMap();
		
		a.put("11", 111);
		a.put("22", 222);
		a.put("33", 333);
		a.put("44", 444);
		
		dm.set("a", a);
		
		System.out.println(dm.get("a"));
		System.out.println(a);
	}
}
