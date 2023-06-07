package kr.spring.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@MapperScan(basePackages = {"kr.spring.mapper"}) // mapper 설정 // mapper 파일을 어디에 넣을지 -> // mybatis가 찾아가도록
@PropertySource({"classpath:persistence-mysql_local.properties"}) // 같은 경로임
public class RootConfig {
	// db 연동 정보 -> 외부파일(속성파일, property file)로 만들어 빼내서 불러오기
	// src/main/resources에 property file 만들어서 넣기 -> persistence-mysql.properties

	// 실질 connect 객체 hikariconfig
	// persistence-mysql.properties 읽어오는 객체
	@Autowired
	private Environment env; // Interface로서 org.springframework.core.env.Environment 읽어와야 함.
	
	@Bean 
	// Spring Container로 올리겠다고 명시
	public DataSource myDataSource() { // import javax.sql.DataSource;
		HikariConfig hikariConfig = new HikariConfig();
		hikariConfig.setDriverClassName(env.getProperty("jdbc.driver"));
		hikariConfig.setJdbcUrl(env.getProperty("jdbc.url"));
		hikariConfig.setUsername(env.getProperty("jdbc.user"));
		hikariConfig.setPassword(env.getProperty("jdbc.password"));
		// src/main/resource/persistence-mysql.properties 에 정보 있음.
		
		HikariDataSource myDataSource = new HikariDataSource(hikariConfig);
		return myDataSource;
	} 
	// mapper interface 구현 클래스로서 위에 만든 것이 myDataSource() 인 셈.
	
	// SQL 실행하는 API
	@Bean
	public SqlSessionFactory sessionFactory() throws Exception { // 예외처리 생길 수 있으니 throws 처리
		SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
		sessionFactory.setDataSource(myDataSource());
		return (SqlSessionFactory) sessionFactory.getObject();
	}
	
	
}
