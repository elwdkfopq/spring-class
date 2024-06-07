package com.smhrd.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@MapperScan(basePackages = {"com.smhrd.mapper"})
public class RootConfig {

	@Bean
	public DataSource myDataSource() {
		HikariConfig hikariConfig = new HikariConfig();
		hikariConfig.setDriverClassName("com.mysql.jdbc.Driver");
	      hikariConfig.setJdbcUrl("jdbc:mysql://localhost:3306/com");
	      hikariConfig.setUsername("com");
	      hikariConfig.setPassword("com01");
	      
	      HikariDataSource ds = new HikariDataSource(hikariConfig);
	      return ds;
	}
	
	@Bean
	public SqlSessionFactory sessionFactory() throws Exception{
		SqlSessionFactoryBean sf = new SqlSessionFactoryBean();
		sf.setDataSource(myDataSource());
		return (SqlSessionFactory) sf.getObject();
	}
}
