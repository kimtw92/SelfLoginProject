package ut.lib.config;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import java.io.IOException;
import java.util.Properties;
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
import org.springframework.jndi.JndiObjectFactoryBean;
import org.springframework.jndi.JndiTemplate;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.jta.JtaTransactionManager;
import ut.lib.support.DataMap;

@Configuration
@EnableTransactionManagement(proxyTargetClass=true)
@MapperScan(basePackages={"loti"}, annotationClass=Mapper.class, sqlSessionFactoryRef="sqlSessionFactoryBean")
public class DataSourceConfig
{
  Logger logger = LoggerFactory.getLogger(getClass());
  @Autowired
  private ApplicationContext applicationContext;
  
  @Bean
  public JndiObjectFactoryBean jndiObjectFactoryBean()
    throws NamingException
  {
    JndiObjectFactoryBean jndiObjectFactoryBean = new JndiObjectFactoryBean();
    
    jndiObjectFactoryBean.setJndiName("java:comp/env/lotiTbr");
    //jndiObjectFactoryBean.setJndiTemplate(jndiTemplate());
    
    return jndiObjectFactoryBean;
  }
  
  @Bean(name={"sqlSessionFactoryBean"})
  public SqlSessionFactoryBean sqlSessionFactoryBean()
    throws IOException, NamingException
  {
    SqlSessionFactoryBean ssfb = new SqlSessionFactoryBean();
    
    ssfb.setDataSource((DataSource)jndiObjectFactoryBean().getObject());
    ssfb.setMapperLocations(
      new PathMatchingResourcePatternResolver().getResources("classpath:/loti/**/*.xml"));
    ssfb.setTypeAliases(new Class[] { EgovMap.class, DataMap.class });
    ssfb.setConfigLocation(this.applicationContext.getResource("classpath:/configuration.xml"));
    
    
    
    
    return ssfb;
  }
  
  
 /* @Bean
  public JndiTemplate jndiTemplate()
  {
    Properties environment = new Properties();
    
    environment.setProperty("java.naming.factory.initial", "jeus.jndi.JNSContextFactory");
    environment.setProperty("java.naming.provider.url", "127.0.0.1:19736");
    
    JndiTemplate jndiTemplate = new JndiTemplate();
    
    jndiTemplate.setEnvironment(environment);
    
    return jndiTemplate;
  }
  
  @Bean
  public JtaTransactionManager jtaTransactionManager()
  {
    String transactionmanagerName = "java:/TransactionManager";
    
    JtaTransactionManager jtaTransactionManager = new JtaTransactionManager();
    
    jtaTransactionManager.setTransactionManagerName(transactionmanagerName);
    jtaTransactionManager.setJndiTemplate(jndiTemplate());
    
    return jtaTransactionManager;
  }*/
  
  
}
