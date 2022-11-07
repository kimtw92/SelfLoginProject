package ut.lib.util;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 
 * @author 이승호
 *
 */
public class ListUtil {

	/**
	 * 특정 조건을 만족하는 객체 리스트를 리턴
	 * @param list : VO List
	 * @param func : 조건
	 * @return
	 */
	public static <V,R> List<V> select(List<V> list, Function<V, Boolean> func){
		
		List<V> res = new ArrayList<V>();
		
		for(V v : list){
			if(func.apply(v)){
				res.add(v);
			}
		}
		
		return res;
	}
	
	/**
	 * 객체의 특정 필드값 또는 맵의 특정키의 값을 리스트로 리턴
	 * @param list
	 * @param field
	 * @return
	 */
	public static <V,O> List<V> pluck(List<O> list, String field){
		List<V> res = null;
		try {
			res = new ArrayList<V>();
			Field f = null;
			Map m = null;
			V v = null;
			for(O o : list){
				if(o instanceof Map){
					m = (Map) o;
					v = (V)m.get(field);
				}else{
					f = o.getClass().getDeclaredField(field);
					if(!f.isAccessible()){
						f.setAccessible(true);
					}
					v = (V) f.get(o);
				}
				res.add(v);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return res;
	}
	
	/**
	 * VO 또는 Map List에서 특정 필드 값을 변환 또는 초기화를 위한 메소드
	 * @param list
	 * @param func
	 * @return
	 */
	public static <O> List<O> map(List<O> list, Function<O, O> func){
		List<O> res = new ArrayList<O>();
		if(list == null){
			return res;
		}
		for(O o : list){
			res.add(func.apply(o));
		}
		return res;
	}
	
	/**
	 * VO List에서 전체 값들이 어떤 조건을 만족하는지 결과를 리턴
	 * @param list
	 * @param func
	 * @return
	 */
	public static <V> boolean all(List<V> list, Function<V, Boolean> func){
		for(V v : list){
			if(!func.apply(v)){
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 중복 제거
	 * @param list
	 * @return
	 */
	public static <V> Set<V> uniq(List<V> list){
		Set<V> s = new LinkedHashSet<V>();
		for(V v : list){
			s.add(v);
		}
		return s;
	}
	
	/**
	 * 특정 구간에 일정 간격의 숫자 리스트를 리턴
	 * @param start
	 * @param end
	 * @param step
	 * @return
	 */
	public static List<Integer> range(int start, int end, int step){
		if(step == 0){
			return null;
		}
		List<Integer> res = new ArrayList<Integer>();
		if(step>0){
			for(int i=start; i<end; i+=step){
				res.add(i);
			}
		}else{
			for(int i=end; i>start; i-=step){
				res.add(i);
			}
		}
		return res;
	}
	
	/**
	 * List 들의 공통객체만 리턴
	 * @param lists
	 * @return
	 */
	public static <V> List<V> intersection(List<V>...lists){
		
		if(lists == null || lists.length == 0){
			return null;
		}else if(lists.length == 1){
			return lists[0];
		}
		
		List<V> res = new ArrayList<V>();
		
		boolean chk = true;
		for(V v : lists[0]){
			for(int i=1; i<lists.length; i++){
				if(!lists[i].contains(v)){
					chk = false;
					break;
				}
			}
			if(chk){
				res.add(v);
			}else{
				chk = true;
			}
		}
		return res;
	}
}
