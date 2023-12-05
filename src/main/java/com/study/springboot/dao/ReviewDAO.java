package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.ReviewDTO;

@Mapper
public interface ReviewDAO {
	public ReviewDTO userList(int user_seq);	
	public int reviewInsert(Map<String, Object> map);
	public ReviewDTO productReview(int user_seq, int product_seq);	
}
