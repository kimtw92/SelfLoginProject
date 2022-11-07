package ut.lib.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OMRReader {

	private OMRReader(){}
	
	private static final AnswerParser ANSWER_PARSER = new AnswerParser();
	
	public static AnswerParser parseAnswer(){
		return ANSWER_PARSER;
	}
	
	public static List<Map> read(InputStream is, Function<String, Object> parser) throws IOException{
		BufferedReader br = null;
		List list = null;
		try{
			br = new BufferedReader(new InputStreamReader(is));
	
			/*
			A,0092,2,4,2,1,8,8,8,2,1,1,8,4,8,8,1,1,4,8,4,8,8,4,1,2,2,1,1,2,4,4,1,2,1,8,2,2,8,4,2,1,2,4,8,2,1,2,4,4,4,8,2,8,8,1,2,8,4,8,8,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			0,0,0,0,0,0,0,0,0,0
			*/
			list = new ArrayList();
			String data1 = null;
			String data2 = null;
			while(true){
				data1 = br.readLine();
				data2 = br.readLine();
				if(data1 == null || data2 == null){
					break;
				}
				list.add(parser.apply(String.format("%s%n%s", data1, data2)));
			}
		}finally{
			if(br!=null) br.close();
		}
		
		return list;
	}
}

class AnswerParser implements Function<String, Object>{

	public int getPowers(int number, int indices){
		if(number == 0){
			return 0;
		}
		int i = 1;
		while((number = number/indices) > 0){
			i++;
		}
		return i;
	}
	
	@Override
	public Object apply(String t) {
		
		String[] strArr = t.split(String.format("%n"));
		
		List<String> list1 = Arrays.asList(strArr[0].split(","));
		List<String> list2 = Arrays.asList(strArr[1].split(","));
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String paperType = list1.get(0);
		String eduno = list1.get(1);
		
		// 1{:}2{:}4{:}2{:}4{:}4{:}3{:}1{:}1{:}3{:}4{:}4{:}1{:}4{:}4{:}3{:}1{:}4{:}2{:}1{:}2{:}3{:}3{:}2{:}4{:}4{:}3{:}1{:}4{:}3{:}4{:}4{:}2{:}4{:}3{:}2{:}4{:}3{:}4{:}4
		StringBuilder answers = new StringBuilder();
		
		for(int i=2; i<list1.size(); i++){
			if(i!=2){
				answers.append("{:}");
			}
			answers.append(getPowers(Integer.valueOf(list1.get(i)), 2));
		}
		for(String s : list2){
			if(answers.toString().length() > 0){
				answers.append("{:}");
			}
			answers.append(s);
		}
		
		map.put("paperType", paperType);
		map.put("eduno", eduno);
		map.put("answers", answers.toString());
		
		return map;
	}
	
}
