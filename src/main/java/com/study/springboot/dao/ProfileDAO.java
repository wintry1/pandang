package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.BookmarkDTO;
import com.study.springboot.dto.ProductDTO;
import com.study.springboot.dto.ReviewDTO;

@Mapper
public interface ProfileDAO {
	public List<ProductDTO> listSproduct(int user_seq);	
	public ReviewDTO showReview(int product_seq);
	public List<BookmarkDTO> listBookmark(int user_seq);	
	public List<ProductDTO> listMyproduct(int user_seq);
	public String getReviewerName(int user_seq);
	public String getReviewerAddr(int user_seq);
	public ProductDTO listBMproduct(int product_seq);
}
