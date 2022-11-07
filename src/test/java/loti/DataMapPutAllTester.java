package loti;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import ut.lib.support.DataMap;

public class DataMapPutAllTester {

	public static void main(String[] args) {
		
		List<DataMap> list = new ArrayList();
		
		DataMap map1 = new DataMap();
		DataMap map2 = new DataMap();
		DataMap map3 = new DataMap();
		DataMap map4 = new DataMap();
		
		map1.put("AAA_TEST", "map1111");
		map1.put("BBB_TEST", "map1222");
		map1.put("CCC_TEST", "map1333");
		map1.put("DDD_TEST", "map1444");
		
		map2.put("AAA_TEST", "map2111");
		map2.put("BBB_TEST", "map2222");
		map2.put("CCC_TEST", "map2333");
		map2.put("DDD_TEST", "map2444");
		
		map3.put("AAA_TEST", "map3111");
		map3.put("BBB_TEST", "map3222");
		map3.put("CCC_TEST", "map3333");
		map3.put("DDD_TEST", "map3444");
		
		map4.put("AAA_TEST", "map4111");
		map4.put("BBB_TEST", "map4222");
		map4.put("CCC_TEST", "map4333");
		map4.put("DDD_TEST", "map4444");
		
		list.add(map1);
		list.add(map2);
		list.add(map3);
		list.add(map4);
		
		System.out.println(list);
		
		DataMap dm = new DataMap().putAll(list);
		
		System.out.println(dm);
		
		dm.put("aaa", 111);
		
		System.out.println(dm);
		
		System.out.println(dm.get("aaa"));
		
		System.out.println("asdfasdf".indexOf("_"));
		
		EgovMap em = new EgovMap();
		
		em.put("testTest", 111);
		em.put("TESTTEST", 222);
		
		System.out.println(em);
	}
}
