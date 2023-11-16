package com.study.springboot.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.UserDTO;

@Mapper
public interface AdminDAO {

	ArrayList<UserDTO> getEmployee();
}
