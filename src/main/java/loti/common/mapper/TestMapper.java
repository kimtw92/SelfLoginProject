package loti.common.mapper;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface TestMapper {

	Map<String,Object> test(); 
}
