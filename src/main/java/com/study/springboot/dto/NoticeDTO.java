package com.study.springboot.dto;

import lombok.Data;

@Data
public class NoticeDTO {
	private int notice_seq;
	private int user_seq;
	private int chat_room_seq;
	private int product_seq;
	private String notice_use_yn;
	private String notice_read_or_not;
	private String notice_at;
	private String notice_name;
	private String notice_title;
}
