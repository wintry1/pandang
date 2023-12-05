package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.NoticeDTO;

@Mapper
public interface NoticeDAO {

	public int noticeInsertChat(Map<String, String> map);
	public List<NoticeDTO> noticeviewDao(@Param("user_seq")int user_seq);
	public List<NoticeDTO> noticeviewDao1(@Param("user_seq")int user_seq);
	public List<NoticeDTO> noticeviewDao2(@Param("notice_seq")int notice_seq);
	public List<NoticeDTO> noticeviewDao3(@Param("product_seq")int product_seq);
	public int noticeupdateDao(@Param("user_seq")int user_seq, @Param("chat_room_seq")int chat_room_seq);
	public int noticeDelete(@Param("notice_seq")int notice_seq);
	public void noticeDeleteDao(@Param("product_seq")int product_seq);
	public void noticeInsert(Map<String, String> map2);
}
