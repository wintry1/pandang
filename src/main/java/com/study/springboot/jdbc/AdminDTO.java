package com.study.springboot.jdbc;

import lombok.Data;

@Data
public class AdminDTO {
	private int admin_seq;
	private String admin_id;
	private String admin_nm;
	private String admin_pwd;
	private String admin_mobile_number;
	private String admin_at;
	private String admin_lst_cnn;
}
