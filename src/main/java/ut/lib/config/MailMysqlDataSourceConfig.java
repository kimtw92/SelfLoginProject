package ut.lib.config;

import java.io.IOException;

import javax.naming.NamingException;
import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.jndi.JndiObjectFactoryBean;
import org.springframework.jndi.JndiTemplate;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.mysql.jdbc.Driver;

import ut.lib.support.DataMap;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Configuration
@EnableTransactionManagement(proxyTargetClass=true)
@MapperScan(basePackages="loti", annotationClass=MailMapper.class, sqlSessionFactoryRef="mailMysqlSqlSessionFactoryBean")
public class MailMysqlDataSourceConfig {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private ApplicationContext applicationContext;
	
	
	@Bean
	public DataSource smsDataSource(){
		System.out.println("start smsDataSource");
		SimpleDriverDataSource ds = new SimpleDriverDataSource();
		
		ds.setDriverClass(Driver.class);		
		ds.setUrl("jdbc:mysql://211.253.98.142:53306/mono_customer");
		ds.setUsername("mono_customer");
		ds.setPassword("mono_customer1234qwer");		
		
		/*ds.setDriverClass(OracleDriver.class);
		ds.setUrl("jdbc:oracle:thin:@211.253.98.156:1521:IMOWEB"); 
		ds.setUsername("umsgw");
		ds.setPassword("umsgw123");*/
		System.out.println("end smsDataSource");
		return ds;
	}
	
	// 로컬 ----------------------------------------------------------------------------------------------
	@Bean
	public JndiObjectFactoryBean mailJndiObjectFactoryBean() throws NamingException {
		
		JndiObjectFactoryBean jndiObjectFactoryBean = new JndiObjectFactoryBean();
		
//		jndiObjectFactoryBean.setJndiName("sms");
		jndiObjectFactoryBean.setJndiName("java:comp/env/mail");
//		jndiObjectFactoryBean.setJndiTemplate(jndiTemplate);
		
		return jndiObjectFactoryBean;
	}
	
	@Bean(name="mailMysqlSqlSessionFactoryBean")
	public SqlSessionFactoryBean mailSqlSessionFactoryBean() throws IOException, NamingException{
		
		SqlSessionFactoryBean ssfb = new SqlSessionFactoryBean();
		
		ssfb.setDataSource(smsDataSource());
		ssfb.setMapperLocations(
				new PathMatchingResourcePatternResolver().getResources("classpath:/loti/**/*SmsMapper.xml"));
		ssfb.setTypeAliases(new Class[] {EgovMap.class, DataMap.class});
		ssfb.setConfigLocation(applicationContext.getResource("classpath:/configuration.xml"));
		return ssfb;
	}
	// 로컬 끝 ----------------------------------------------------------------------------------------------
	
	// 실서버 ----------------------------------------------------------------------------------------------
//	@Autowired
//	private JndiTemplate jndiTemplate;
//
//	@Bean
//	public JndiObjectFactoryBean mailMysqlJndiObjectFactoryBean() throws NamingException {
//
//		JndiObjectFactoryBean jndiObjectFactoryBean = new JndiObjectFactoryBean();
//	    
////		jndiObjectFactoryBean.setJndiName("mail");
//		jndiObjectFactoryBean.setJndiName("java:comp/env/mail");
//		jndiObjectFactoryBean.setJndiTemplate(jndiTemplate);
//		
//	    return jndiObjectFactoryBean;
//	}
//
//	@Bean(name="mailMysqlSqlSessionFactoryBean")
//	public SqlSessionFactoryBean mailSqlSessionFactoryBean() throws IOException, NamingException{
//		
//		SqlSessionFactoryBean ssfb = new SqlSessionFactoryBean();
//		
//		ssfb.setDataSource((DataSource)mailMysqlJndiObjectFactoryBean().getObject());
//		ssfb.setMapperLocations(
//				new PathMatchingResourcePatternResolver().getResources("classpath:/loti/**/*MailMapper.xml"));
//		ssfb.setTypeAliases(new Class[] {EgovMap.class, DataMap.class});
//		ssfb.setConfigLocation(applicationContext.getResource("classpath:/configuration.xml"));
//		return ssfb;
//	}
	// 실서버 끝 ----------------------------------------------------------------------------------------------
	
	
}
