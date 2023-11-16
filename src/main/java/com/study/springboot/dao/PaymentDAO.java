package com.study.springboot.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentDAO {

	public int paymentDao(Map<String, String> map);
}
