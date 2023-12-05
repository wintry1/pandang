package com.study.springboot.dto;

import lombok.Data;

@Data
public class ChatRoomDTO {
	private int chat_room_seq;
	private int buy_seq;
	private int sell_seq;
	private int product_seq;
	private String chat_room_at;
	public int getchat_room_seq() {
		return chat_room_seq;
	}
	private String buyer_name;
}
