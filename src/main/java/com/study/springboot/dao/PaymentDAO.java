package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.PaymentDTO;

@Mapper
public interface PaymentDAO {

	public int paymentinsert(Map<String, String> map);
	public List<PaymentDTO> paymentselect(@Param("product_seq")String product_seq, @Param("buy_seq")String buy_seq, @Param("sell_seq")String sell_seq);
}
