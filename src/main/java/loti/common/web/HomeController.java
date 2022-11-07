package loti.common.web;

import loti.common.mapper.TestMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.controller.BaseController;

@Controller
public class HomeController extends BaseController{

//	private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);
	private static final org.apache.log4j.Logger LOGGER3 = org.apache.log4j.Logger.getLogger(HomeController.class);
	
//	private static final java.util.logging.Logger LOGGER2 = java.util.logging.Logger.getLogger("HomeController111");

	
	
	@Autowired
	private TestMapper test;
	
	@RequestMapping("/test.do")
	@ResponseBody
	public String test() {
		System.out.println("sysout");
//		LOGGER.error("test");
//		LOGGER.info("test333333");
		LOGGER3.info("test333333111111111111111111111");
//		LOGGER2.info("test2");
		log.info(test.test());
		System.out.println(test.test());
		return "Hello Wolrd!";
	}
}
