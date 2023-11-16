package com.study.springboot.dto;

import lombok.Data;

@Data
public class FilesDTO {
	private int files_seq;
	private int product_seq;
	private String files_name;
	private String files_at;
	public String getFilesName() {
		return files_name;
	}
}
