package ut.lib.util;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;

public class  List<E> extends ArrayList<E>{

	/**
	 * 특정 조건을 만족하는 객체 리스트를 리턴
	 * @param func : 조건
	 * @return
	 */
	public List<E> select(Function<E, Boolean> func){
		
		List<E> res = new List<E>();
		
		for(E e : this){
			if(func.apply(e)){
				res.add(e);
			}
		}
		
		return res;
	}
	
	/**
	 * 객체의 특정 필드값 또는 맵의 특정키의 값을 리스트로 리턴
	 * @param field
	 * @return
	 */
	public List<E> pluck(String field){
		List<E> res = null;
		try {
			res = new List<E>();
			Field f = null;
			Map m = null;
			E v = null;
			for(E o : this){
				if(o instanceof Map){
					m = (Map) o;
					v = (E)m.get(field);
				}else{
					f = o.getClass().getDeclaredField(field);
					if(!f.isAccessible()){
						f.setAccessible(true);
					}
					v = (E) f.get(o);
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
	 * @param func
	 * @return
	 */
	public List<E> map(Function<E, E> func){
		List<E> res = new List<E>();
		for(E o : this){
			res.add(func.apply(o));
		}
		return res;
	}
	
	/**
	 * VO List에서 전체 값들이 어떤 조건을 만족하는지 결과를 리턴
	 * @param func
	 * @return
	 */
	public boolean all(Function<E, Boolean> func){
		for(E v : this){
			if(!func.apply(v)){
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 중복 제거
	 * @return
	 */
	public List<E> uniq(){
		Set<E> s = new LinkedHashSet<E>();
		s.addAll(this);
		List<E> list = new List<E>();
		list.addAll(s);
		return list;
	}
}
