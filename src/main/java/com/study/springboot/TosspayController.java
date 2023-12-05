package com.study.springboot;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dao.ChatRoomDAO;
import com.study.springboot.dao.PaymentDAO;
import com.study.springboot.dao.ProductDAO;
import com.study.springboot.dto.ChatRoomDTO;
import com.study.springboot.dto.ProductDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class TosspayController {
	
	@Autowired
	PaymentDAO paymentDao;
	@Autowired
	ProductDAO productDao;
	@Autowired
	ChatRoomDAO chatRoomDao;
	
	@RequestMapping("/checkout")
	public String checkout(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		
		String product_seq = request.getParameter("product_seq");
		
		session.setAttribute("product_seq", product_seq);
        model.addAttribute("list", productDao.viewProduct(Integer.parseInt(product_seq)));
        
		return "checkout";
    }
	
	@RequestMapping("/success")
	public String success(HttpServletRequest request, 
			@RequestParam("orderId") String orderId,
            @RequestParam("paymentKey") String paymentKey,
            @RequestParam("amount") int amount,
            Model model) 
	{
		Map<String, String> response = new HashMap<>();
		HttpSession session = request.getSession();
		String secretKey = "test_sk_KNbdOvk5rkm9kPGnmg9q3n07xlzm:";
		
        Encoder encoder = Base64.getEncoder();
        byte[] encodedBytes = encoder.encode(secretKey.getBytes());
        String authorizations = "Basic " + new String(encodedBytes);

        
        int buy_seq = (int) session.getAttribute("user_seq");

        try {
            paymentKey = URLEncoder.encode(paymentKey, "UTF-8");
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        
        URL url = null;
        try {
            url = new URL("https://api.tosspayments.com/v1/payments/confirm");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestProperty("Authorization", authorizations);
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            
            JSONObject obj = new JSONObject();
            obj.put("paymentKey", paymentKey);
            obj.put("orderId", orderId);
            obj.put("amount", amount);
            
            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(obj.toString().getBytes("UTF-8"));
            int code = connection.getResponseCode();
            
            boolean isSuccess = code == 200;

            InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
            
            try (Reader reader = new InputStreamReader(responseStream, "UTF-8")) {
                JSONParser parser = new JSONParser();
                JSONObject jsonObject = (JSONObject) parser.parse(reader);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            
            responseStream.close();
            
            String productSeqStr = (String) session.getAttribute("product_seq");
            int product_seq = Integer.parseInt(productSeqStr);
            if (isSuccess) {
            	
            	ProductDTO productDto = productDao.selectDao1(product_seq);
            	String prd_price = String.valueOf(productDto.getPrd_price());
            	String sell_seq = String.valueOf(productDto.getUser_seq());
            	
                Map<String, String> map = new HashMap<>();
                map.put("item1", String.valueOf(buy_seq));
                map.put("item2", sell_seq);
                map.put("item3", String.valueOf(product_seq));
                map.put("item4", prd_price);
                
                paymentDao.paymentinsert(map);
                ChatRoomDTO chatRoomlist = chatRoomDao.selectDao(buy_seq, Integer.parseInt(sell_seq), product_seq);
                System.out.println(chatRoomlist);
                model.addAttribute("user_name", (String) session.getAttribute("user_name"));
                model.addAttribute("list", chatRoomlist);  
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "success";
    }
}

