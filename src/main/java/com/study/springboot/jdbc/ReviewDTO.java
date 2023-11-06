package com.study.springboot.jdbc;

import lombok.Data;

@Data
public class ReviewDTO {
	private int review_seq;
	private int product_seq;
	private int user_seq;
	private String review_ctnt;
	private String review_at;
}
