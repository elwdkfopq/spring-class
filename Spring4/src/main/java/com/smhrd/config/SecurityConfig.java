package com.smhrd.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		CharacterEncodingFilter enc = new CharacterEncodingFilter();
		enc.setEncoding("UTF-8");
		enc.setForceRequestEncoding(true);
		http.addFilterBefore(enc, CsrfFilter.class)
	}
	
	// 2단계 보안?
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptyPasswordEncoder();
	}
	

}
