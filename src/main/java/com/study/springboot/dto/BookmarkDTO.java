package com.study.springboot.dto;

import lombok.Data;

@Data
public class BookmarkDTO {
	private int bookmark_seq;
	private int user_seq;
	private int product_seq;
	private String bookmark_at;
	private String prd_title;
	private int prd_price;
	private String prd_image;
	private String prd_use;	
}
