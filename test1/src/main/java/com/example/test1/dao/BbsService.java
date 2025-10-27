package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BbsMapper;
import com.example.test1.model.Bbs;


@Service
public class BbsService {
   
	
	@Autowired             
	BbsMapper bbsMapper;
	
	@Autowired
	HttpSession session;	
	
	@Autowired
	PasswordEncoder passwordEncoder;
    
	
	//List
	public HashMap<String, Object> getBbsList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Bbs> bbs = bbsMapper.bbsList(map);
			int cnt = bbsMapper.selectBbsListCnt(map);
			
			resultMap.put("cnt", cnt);
			resultMap.put("list", bbs);			
			resultMap.put("result", "success");
		} catch(Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}
	
	
	
		
		//bbs add
		public HashMap<String, Object> addBbs(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
			try {
				int cnt = bbsMapper.insertBbs(map);			// int cnt생략가능
				resultMap.put("bbsNum",map.get("bbsNum"));					
				resultMap.put("result", "success");
				
			} catch(Exception e) {
				resultMap.put("result","fail");
				System.out.println(e.getMessage());
			}
				
			return resultMap;
		}
		
		
		//bbs delete
		public HashMap<String, Object> removeBbs(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
			try {
				int cnt = bbsMapper.deleteBbs(map);			// int cnt생략가능									
				resultMap.put("result", "success");
				
			} catch(Exception e) {
				resultMap.put("result","fail");
				System.out.println(e.getMessage());
			}
				
			return resultMap;
		}
	
		//bbs 상세보기
		public HashMap<String, Object> getBbs(HashMap<String, Object> map){
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			try {
				Bbs info = bbsMapper.selectBbs(map);
				resultMap.put("info", info);
				resultMap.put("result", "success");
			} catch (Exception e) {
				// TODO: handle exception
				resultMap.put("result", "fail");
				System.out.println(e.getMessage());
			}			
			
			return resultMap;		
		}
		
		
		public HashMap<String, Object> editBbs(HashMap<String, Object> map){
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			try {
				bbsMapper.updateBbs(map);
				resultMap.put("result", "success");
			} catch (Exception e) {
				// TODO: handle exception
				resultMap.put("result", "fail");
				System.out.println(e.getMessage());
			}			
			
			return resultMap;		
		}	
		
		
		

}
