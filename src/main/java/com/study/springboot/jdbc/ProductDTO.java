package com.study.springboot.jdbc;

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
	private String prd_maptext;
	private String prd_use_yn;
}
