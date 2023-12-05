package com.study.springboot.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.BookmarkDTO;

@Mapper
public interface BookmarkDAO {

	public BookmarkDTO selectDao(@Param("user_seq") int user_seq, @Param("product_seq") int product_seq);
	public int countDao(@Param("product_seq") int product_seq);
	public int insertDao(@Param("user_seq") int user_seq, @Param("product_seq") int product_seq);
    public int deleteDao(@Param("user_seq") int user_seq, @Param("product_seq") int product_seq);
}
