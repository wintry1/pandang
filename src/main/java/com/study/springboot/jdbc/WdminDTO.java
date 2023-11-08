package com.study.springboot.jdbc;

import lombok.Data;

@Data
public class WdminDTO {
	private int warning_seq;
	private int user_seq;
	private String warning_release_date;
	private String warning_criminal_reson;
	private String warning_created_at;
	private String warning_updated_at;
}
