package com.study.springboot.jdbc;

import lombok.Data;

@Data
public class PrisonDTO {
	private int prison_seq;
	private int user_seq;
	private String prison_release_date;
	private String prison_criminal_reson;
	private String prison_is_imprisoned;
	private String prison_created_at;
	private String prison_updated_at;
}
