package com.study.springboot.jdbc;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ProductDAO {

	public List<ProductDTO> listDao();
	public ProductDTO viewDao(String id);
	public int writeDao(Map<String, String> map);
	public int deleteDao(@Param("_id")String id);
	public int articleCount();
}
