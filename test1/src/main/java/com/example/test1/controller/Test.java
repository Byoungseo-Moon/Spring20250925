package com.example.test1.controller;

import java.util.Random;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Random ran = new Random();
		
		String rNum = "";
		for(int i=0; i<6; i++) {
			rNum += ran.nextInt(10);
		}
		
		System.out.println(rNum);
	}
}
