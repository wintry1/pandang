package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.ProductDTO;

@Mapper
public interface ProductDAO {

	public int writeDao(Map<String, String> map);
	public List<ProductDTO> selectDao();
	public String selectDao1(@Param("product_seq")String product_seq);
	public String selectDao2(@Param("user_seq")String user_seq);
	public List<ProductDTO> searchDao(@Param("title")String title);
    public ProductDTO viewProduct(@Param("productSeq")int productSeq);
}

