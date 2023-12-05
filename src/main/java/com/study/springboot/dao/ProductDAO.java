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
	public ProductDTO selectDao1(@Param("product_seq")int product_seq);
	public String selectDao2(@Param("user_seq")int user_seq);
	public List<ProductDTO> selectDao3(@Param("user_seq")int user_seq);
	public List<ProductDTO> searchPrd1(String search_word1);
	public List<ProductDTO> searchPrd2(String search_word1, String search_word2);
	public List<ProductDTO> searchPrd3(String search_word1, String search_word2, String search_word3);
	public ProductDTO viewProduct(@Param("product_seq")int product_seq);
	public int updatePrd(String prd_use, int productSeq);
	public int updatePrd1(@Param("product_seq")int product_seq);
}

