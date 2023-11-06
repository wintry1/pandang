package com.study.springboot.jdbc;

import lombok.Data;

@Data
public class NoticeDTO {
	private int bookmark_seq;
	private int user_seq;
	private int chat_room_seq;
	private int review_seq;
	private String notice_at;
}
