package com.study.springboot.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AuthDAO {

	public int writeAuth(String auth_id, String auth_num, String auth_time);
	public String viewAuthNum(String auth_id);	
	public String viewAuthTime(String auth_id);
	public int deleteAuth(String auth_id);
}
