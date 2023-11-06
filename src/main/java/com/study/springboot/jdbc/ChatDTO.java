package com.study.springboot.jdbc;

import lombok.Data;

@Data
public class ChatDTO {
	private int chat_seq;
	private int chat_room_seq;
	private int user_seq;
	private String chat_message;
	private String chat_read_or_not;
	private String chat_at;
}
