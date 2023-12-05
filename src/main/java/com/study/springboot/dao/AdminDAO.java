package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.ProductDTO;
import com.study.springboot.dto.UserDTO;

@Mapper
public interface AdminDAO {

	public List<UserDTO> admin_user_list();
	public UserDTO admin_user_view(int user_seq);
	public int admin_user_delete(int user_seq);
	public int admin_user_grade(int user_seq);
	public int admin_user_punish(int user_warning_count, int user_criminal_count, int user_grade, int user_seq);
	public List<UserDTO> admin_user_id_search(@Param("searchText") String searchText);
	public List<UserDTO> admin_user_name_search(@Param("searchText") String searchText);
	
	public List<ProductDTO> admin_prd_list();
	public int admin_prd_hide(String prd_use_yn, int product_seq);
	public List<ProductDTO> admin_prd_title_search(@Param("searchText") String searchText);
	public List<ProductDTO> admin_prd_ctnt_search(@Param("searchText") String searchText);
}
