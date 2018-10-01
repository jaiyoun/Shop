package com.shop.shop.Controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.aspectj.apache.bcel.classfile.ConstantObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties.Pageable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.shop.Shop;
import com.shop.shop.ShopRepository;
import com.shop.shop.Constant.ConstantClass;
//import com.shop.shop.Constant;

@CrossOrigin(origins = {"*"})
@Controller
public class ShopController {
	
	@Autowired
	ShopRepository shop_repository;
	
	//기본화면
	@RequestMapping("/index")
	public String showPage(){
		return "index";
	}
	
	//조회
	@RequestMapping("/shop")
	public String goList(Model m){
		return "list";
	}
	
	@RequestMapping("/shop/list")
	public ResponseEntity<Object> shop_list(){ 
		List<Shop> list = shop_repository.findByFlagsLike(ConstantClass.NOTDEL);	 
 		return new ResponseEntity<Object>(list, HttpStatus.OK);
	}
	
	//ShopList전달
	@CrossOrigin(origins = {"*"})
	@RequestMapping("/ShopList")
	@ResponseBody
	public ResponseEntity<Object> ShopList() {
		List<Shop> list = shop_repository.findByFlagsLike(ConstantClass.NOTDEL);
		String a ="";
		for(int i = 0 ; i < list.size(); i++) {
			a= a+list.get(i).getSid()+","+list.get(i).getName()+",";
		}
		return new ResponseEntity<Object>(a, HttpStatus.OK);
	}
	
	//추가됨 sid에 해당되는 이름 전달
	@CrossOrigin(origins = {"*"})
	@RequestMapping("/getShopName/{sid}")
	@ResponseBody
	public String ShopName(@PathVariable String sid) {
		//List<Shop> list = shop_repository.findByFlagsLike(ConstantClass.NOTDEL);
		String str = sid.replaceAll("^\"|\"$", "");
		String s_name = "";
	    System.out.println(str);
	    String[] idArr=str.split(",");
	    for(int i=0;i<idArr.length;i++){
	    	Shop shop = shop_repository.findBySid(Integer.parseInt(idArr[i]));
	    	if(shop==null){
	    		s_name="해당 메뉴를 판매하는 shop이 없습니다.";
	    		break;
	    	}
	    	s_name = s_name + shop.getName() +",";
	    }
	    
		return s_name;
	}
	
	//상세조회
	@RequestMapping("/detail/{id}")
	public String details(@PathVariable int id, Model m) {
		Shop shop = shop_repository.findBySid(id);
		if(shop == null ) 
			return "index";//지워진것이나 널인 것
		else if(shop.getFlags() == ConstantClass.DEL) return "index";
		else if(shop != null) 
			m.addAttribute("shop", shop);
		return "details";
	}
	
	//등록
	@RequestMapping(value = "/shop/reg")
	public String shop_insert(Model m) {
		int a = 1+ConstantClass.SID; 
		m.addAttribute("sid", a);
		return "insert";
	}
	
	@RequestMapping("/shop/register")
	@ResponseBody
	public void register(@RequestBody String params) {
		params = params.replaceAll("^\"|\"$", "");
		String[] info = params.split(",");
		Shop shop = new Shop(info[0]);
		shop_repository.save(shop);
	}
	
	//수정
	@RequestMapping("upd/{id}")
	public String update(@PathVariable int id, Model m) {
		Shop shop = shop_repository.findBySid(id);
		if(shop == null ) 
			return "index";//지워진것이나 널인 것
		else if(shop.getFlags() == ConstantClass.DEL) return "index";
		else if(shop != null ) m.addAttribute("shop", shop);
		return "update";
	}
	
	@RequestMapping("upd")
	@ResponseBody
	public void upd_data(@RequestBody String params) {
		params = params.replaceAll("^\"|\"$", "");
		System.out.println(params);
		String[] info = params.split(",");
		Shop s = shop_repository.findBySid(Integer.parseInt(info[1].substring(0,3)));
		s.setName(info[0]);
		String df = new SimpleDateFormat("yyyyMMdd").format(new Date());
		s.setUpdate_dt(df);
		shop_repository.save(s);
		return ;
	}
	//삭제
	@RequestMapping("del/{id}")
	public String delete(@PathVariable int id,Model m) {
		Shop shop = shop_repository.findBySid(id);
		if(shop == null ) 
			return "index";//지워진것이나 널인 것
		else if(shop.getFlags() == ConstantClass.DEL) return "index";
		shop.setFlags(ConstantClass.DEL);
		shop_repository.save(shop);
		m.addAttribute("sid",id);
		return "delete";
	}
	
	//판매
	@RequestMapping("/pos/{sid}")
	public String sales(@PathVariable int sid, Model m) {
		
		Shop shop = shop_repository.findBySid(sid);
		if(shop == null ) 
			return "index";//지워진것이나 널인 것
		else if(shop.getFlags() == ConstantClass.DEL) return "index";
		else if(shop != null ) m.addAttribute("shop", shop);
		return "sale";
	}
	
}
