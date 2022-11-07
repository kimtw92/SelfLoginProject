package loti;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import ut.lib.util.Functions;
import ut.lib.util.ListUtil;


public class test {

	public static void main(String[] args) {
		
		System.out.println('A' - ('A'-1));
		
		System.out.println((int)'①');
		System.out.println((char)('①'+1));
		System.out.println((char)('①'+2));
		System.out.println((char)('①'+3));
		System.out.println((char)('①'+4));
		System.out.println((char)('①'+5));
		
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("test1", "im test");
		map.put("test2", null);
		map.put("test3", 1);
		
		list.add(map);
		
		list = ListUtil.map(list, Functions.initMap());
		
		System.out.println(list);
		
		List<EgovMap> list2 = new ArrayList<EgovMap>();
		
		EgovMap em = new EgovMap();
		
		em.put("TEST_AAA", "im test");
		em.put("TEST_BBB", null);
		em.put("TEST_CCC", 1);
		
		list2.add(em);
		
		list2 = ListUtil.map(list2, Functions.initMap());
		
		System.out.println(list2.get(0).get("testAaa"));
		
		System.out.println(list2);
		
		
		String a = null;
		
		System.out.println( a+ "");
	}
}
