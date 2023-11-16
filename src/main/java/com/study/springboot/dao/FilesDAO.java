package com.study.springboot.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.FilesDTO;

@Mapper
public interface FilesDAO {

	public int filesDao(Map<String, String> map);
	public FilesDTO viewDao(int productSeq);
	public int deleteDao(@Param("_id")String id);
}
