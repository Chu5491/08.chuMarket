package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Market;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.market.MarketService;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 Controller
@Controller
@RequestMapping("/product/**")
public class ProductController 
{
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("marketServiceImpl")
	private MarketService marketService;
	//setter Method 구현 않음
		
	public ProductController()
	{
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	//@Value("#{commonProperties['pageUnit']}")
	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	//@Value("#{commonProperties['pageSize']}")
	@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping("getProduct")
	public ModelAndView getProduct(@RequestParam("prodNo") int prodNo,
								   @RequestParam("menu") String menu, 
								   HttpServletResponse response,
								   HttpServletRequest request) throws Exception 
	{
		System.out.println("/product/getProduct");
		
		Product prod = productService.getProduct(prodNo);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("prod", prod);
		modelAndView.addObject("menu", menu);
		if(menu.equals("manage"))
		{
			modelAndView.setViewName("forward:/product/updateProductView.jsp");
		}else
		{
			Cookie[] cookies 	= request.getCookies();
			String history 		= "";
			if(cookies != null)
			{
				for(Cookie cookie : cookies)
				{
					if(cookie.getName().equals("history"))
					{
						// 쿠키 있으면 추가
						history 	= cookie.getValue();
						history += ":" + prodNo;
						cookie 	= new Cookie("history", history);
						response.addCookie(cookie);
						break;
					}else
					{
						// 쿠키가 없으면 새로 생성
						cookie = new Cookie("history", Integer.toString(prodNo));
						response.addCookie(cookie);
					}
				}
			}else
			{
				// 쿠키가 없으면 새로 생성
				Cookie cookie = new Cookie("history", Integer.toString(prodNo));
				response.addCookie(cookie);
			}
			
			modelAndView.setViewName("forward:/product/getProductView.jsp");
		}
		
		return modelAndView;
	}
	
	@RequestMapping("addProduct")
	public ModelAndView addProduct(@ModelAttribute("prod") Product prod, @SessionAttribute("user") User user) throws Exception 
	{
		System.out.println("/product/addProduct");
		System.out.println(prod);
		prod.setManuDate(prod.getManuDate().replace("-",""));
		Market market = marketService.getMarket(user.getUserId());
		System.out.println(market);
		prod.setMarket(market);
		System.out.println(prod);
		prod = productService.addProduct(prod);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("menu", "search");
		
		modelAndView.setViewName("forward:/product/getProductView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping("updateProduct")
	public ModelAndView updateProduct(@ModelAttribute("prod") Product prod) throws Exception 
	{
		System.out.println("/product/updateProduct");
		
		productService.updateProduct(prod);
		
		prod = productService.getProduct(prod.getProdNo());
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("prod", prod);
		modelAndView.addObject("menu", "search");
		
		modelAndView.setViewName("forward:/product/getProductView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping("listProduct")
	public ModelAndView listProduct(@ModelAttribute("search") Search search, @RequestParam("menu") String menu, @SessionAttribute("user") User user) throws Exception 
	{
		System.out.println("/product/listProduct");
		
		if(search.getCurrentPage() == 0 )
		{
			search.setCurrentPage(1);
		}
		System.out.println("검색어 : " + search.getSearchCondition() );
		
		search.setPageSize(pageSize);
		Map<String , Object> map;
		// Business logic 수행
		if(menu.equals("bsns"))
		{
			Market market = marketService.getMarket(user.getUserId());
			map = productService.getMarketProductList(search,market.getMarketNo());
		}else
		{
			map = productService.getProductList(search);
		}
		
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		int totalCount  = productService.getProductTotal(search);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.addObject("menu", menu);
		
		modelAndView.setViewName("forward:/product/listProductView.jsp");
		
		return modelAndView;
	}
	
}