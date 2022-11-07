package ut.lib.util;

import java.math.BigDecimal;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class Functions {

	private static Function<Map, Map> mapInitializer = new Function<Map, Map>(){

		@Override
		public Map apply(Map m) {
			
			if(m == null){
				return null;
			}
			
//			System.out.println(m.getClass());
			Map res;
			try {
				res = m.getClass().newInstance();
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			Object value = null;
			for(Object key : m.keySet()){
				value = m.get(key);
				if(value == null){
					res.put(key, "");
				}else{
					
					if(value instanceof BigDecimal){
						res.put(key, value.toString());
					}else{
						res.put(key, value);
					}
				}
			}
			return res;
		}
	};
	
	/**
	 * Map 에서 value가 null일경우 ""를 대입
	 * @return
	 */
	public static Function initMap(){
		return mapInitializer;
	}

	private static Function<HSSFWorkbook, List<Map<String,Object>>> xlsAnsToListFunction = null;
	
	public static Function<HSSFWorkbook, List<Map<String,Object>>> xlsAnsToList(){
		
		if(xlsAnsToListFunction != null){
			return xlsAnsToListFunction;
		}
		
		return new Function<HSSFWorkbook, List<Map<String,Object>>>(){

			@Override
			public List<Map<String, Object>> apply(HSSFWorkbook t) {
				// TODO Auto-generated method stub
				return null;
			}
			
		};
	}
}
