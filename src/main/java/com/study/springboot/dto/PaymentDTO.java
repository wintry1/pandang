package com.study.springboot.dto;

import lombok.Data;

@Data
public class PaymentDTO {
	private int payment_seq;
	private int buy_seq;
	private int sell_seq;
	private int product_seq;
	private int payment_use;
	private String payment_at;
}