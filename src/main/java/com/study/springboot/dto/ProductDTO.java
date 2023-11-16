package com.study.springboot.dto;

import lombok.Data;

@Data
public class ProductDTO {
	private int product_seq;
	private int user_seq;
	private String prd_title;
	private String prd_ctnt;
	private String prd_at;
	private int prd_hit;
	private String prd_use;
	private int prd_price;
	private double prd_latitude;
	private double prd_longitude;
	private String prd_address;
	private String prd_use_yn;
	private String prd_image;
	private String files_name;
	private int bookmark_seq;
	private String rev_name;
	private String rev_content;
	private String rev_date;
	private String rev_addr;
}
