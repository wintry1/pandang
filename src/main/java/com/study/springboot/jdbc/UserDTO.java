package com.study.springboot.jdbc;

import lombok.Data;

@Data
public class UserDTO {
	private int user_seq;
	private String user_id;
	private String user_name;
	private String user_role;
	private int user_warning_count;
	private int user_criminal_count;
	private String user_address;
	private double user_latitude;
	private double user_longitude;
	private String user_sns;
	private int user_grade;
}
