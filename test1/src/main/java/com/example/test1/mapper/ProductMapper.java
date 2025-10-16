package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Mapper
public interface ProductMapper {

	//제품목록	
	List<Product> selectProductList(HashMap<String, Object> map);
	
	//메뉴목록	
	List<Menu> selectMenuList(HashMap<String, Object> map);	
	
	//메뉴 등록
	int insertProduct(HashMap<String, Object> map);
	
	//첨부파일(이미지) 업로드
	int insertProductImg(HashMap<String, Object> map);
	
	
	//제품상세보기	
	Product selectProduct(HashMap<String, Object> map);
	
	//복수첨부파일(이미지) 업로드
	List<Product> selectImgList (HashMap<String, Object> map);
	
	//제품 결제 이력 삽입
	int paymentHistory(HashMap<String, Object> map);
			
		
	
}
