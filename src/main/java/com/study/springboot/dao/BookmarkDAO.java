package com.study.springboot.dao;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.BookmarkDTO;

@Mapper
public interface BookmarkDAO {

	public BookmarkDTO selectDao(int userSeq, int productSeq);
}
