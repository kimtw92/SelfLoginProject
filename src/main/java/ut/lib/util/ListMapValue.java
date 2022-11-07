package ut.lib.util;

import java.util.List;
import java.util.Map;

public class ListMapValue {
	
	List<Map<String,Object>> list;
	
	public ListMapValue(List<Map<String,Object>> list) {
		this.list = list;
	}
	
	public Object get(String key, int i){
		return Util.nvl(list.get(i).get(key));
	}
	
	public int size(){
		return list.size();
	}
}