package com.model2.mvc.web.util;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.util.UtilService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/util/*")
public class UtilRestController {
	
	///Field
	@Autowired
	@Qualifier("utilService")
	private UtilService utilService;
	//setter Method 구현 않음
		
	public UtilRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/validationCheck", method=RequestMethod.POST )
	public boolean validationCheck( @RequestBody Map<String,String> map) throws Exception{
		
		System.out.println("json/validationCheck : POST");
		
		System.out.println(map);
		
		//Business Logic
		return utilService.validationCheck(map);
	}

	@RequestMapping( value="json/getData", method=RequestMethod.POST )
	public List<String> getData(@RequestBody Map<String,String> map) throws Exception{
		
		System.out.println("json/getData : POST");
		
		System.out.println("tableName : " + map.get("tableName"));
		System.out.println("colum : " + map.get("colum"));
		System.out.println("value : " + map.get("value"));
		
		//Business Logic
		return utilService.getData(map);
	}
	
	@RequestMapping( value="json/updateData", method=RequestMethod.POST )
	public boolean updateData(@RequestBody Map<String,String> map) throws Exception{
		
		System.out.println("json/updateData : POST");
		
		//Business Logic
		return utilService.updateData(map);
	}
	
	@ExceptionHandler(value = Exception.class)
	public String nfeHandler(Exception e) {
		e.printStackTrace();
		return e.getMessage();
	}
}