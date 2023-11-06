package com.study.springboot.jdbc;

import lombok.Data;

@Data
public class ChatRoomDTO {
	private int chat_room_seq;
	private int user_seq;
	private int product_seq;
	private String chat_room_at;
}
