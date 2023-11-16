package com.study.springboot.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.ChatRoomDTO;

@Mapper
public interface ChatRoomDAO {

	public int cRinsertDao(Map<String, String> map);
	public ChatRoomDTO buyDao(@Param("buy_seq")int buy_seq, @Param("sell_seq")int sell_seq, @Param("product_seq")int product_seq);
	public ChatRoomDTO cRviewDao(int chat_room_seq);
}
