package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.UserDTO;

@Mapper
public interface UserDAO {

	public UserDTO viewUser(@Param("user_seq") int user_seq);
	public List<UserDTO> userList();
	public UserDTO userView(String user_id);
	public int userInsert(Map<String, String> map);
	public int userDelete(String user_id);
	public int userSelect(UserDTO userDto);
	public UserDTO userSelect1(@Param("user_name") String user_name);
	public int userUpdate(String user_name);
	public int updateUser(String user_name, int user_seq);
	public int deleteUser(@Param("user_seq") int user_seq);
	public String username(@Param("user_seq") int user_seq);
	public int locationUpdate(Map<String, String> map);
	public int updateUserScore(@Param("score") int score, @Param("user_seq") int user_seq);
}
