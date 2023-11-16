package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.UserDTO;

@Mapper
public interface UserDAO {

	public UserDTO getEmployee(int user_seq);
	public List<UserDTO> userList();
	public UserDTO userView(String user_id);
	public int userInsert(Map<String, String> map);
	//public int userInsert(String user_id, String user_name, String user_role, String user_created_at, int user_warning_count, int user_criminal_count, String user_address, double user_latitude, double user_longitude, String user_sns);
	public int userUpdate(String user_name);
	public int userDelete(String user_id);
	public int userSelect(UserDTO userDto);
	public int joinUser(Map<String, String> map);
	public int updateUser(String user_name, int user_seq);
	public int deleteUser(int user_seq);
	public UserDTO viewUser(int user_seq);
}
