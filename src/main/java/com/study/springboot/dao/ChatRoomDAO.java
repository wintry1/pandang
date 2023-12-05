package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.ChatRoomDTO;

@Mapper
public interface ChatRoomDAO {

	public int cRinsertDao(Map<String, String> map);
	public ChatRoomDTO selectDao(@Param("buy_seq")int buy_seq, @Param("sell_seq")int sell_seq, @Param("product_seq")int product_seq);
	public String selectDao1(@Param("chat_room_seq")int chat_room_seq);
	public ChatRoomDTO buyDao(@Param("user_seq")int user_seq);
	public ChatRoomDTO sellDao(@Param("user_seq")int user_seq);
	public List<ChatRoomDTO> getBuyer(@Param("product_seq")int product_seq);
	public int selectDao2(@Param("chat_room_seq")int chat_room_seq);
	public ChatRoomDTO selectDao3(@Param("chat_room_seq")int chat_room_seq);
}
