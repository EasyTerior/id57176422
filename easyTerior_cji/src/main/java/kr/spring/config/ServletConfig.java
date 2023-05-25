package kr.spring.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@EnableWebMvc // MVC 패턴 가능여부 명시
@Configuration // 설정파일이라고 명시
@ComponentScan(basePackages = {"kr.spring.controller"}) // POJO 인 kr.spring.controller 에서만 찾아서 Controller라고 명시. 배열이므로 , 하고 추가 가능.
public class ServletConfig implements WebMvcConfigurer {
	// MVC에서 구현되는 내용들 구현하기
	
	// resource 구현
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// registry 라는 설정파일에 설정 등록
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
		// WebMvcConfigurer.super.addResourceHandlers(registry);
	}

	// view resolvers에서 prefix, suffix 구현
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		InternalResourceViewResolver bean = new InternalResourceViewResolver();
		bean.setPrefix("/WEB-INF/views/");
		bean.setSuffix(".jsp");
		// 설정 후 registry 에 등록 필수
		registry.viewResolver(bean);
		// WebMvcConfigurer.super.configureViewResolvers(registry);
	}
	

	
}
