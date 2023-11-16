package com.study.springboot;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
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

import com.study.springboot.dao.PaymentDAO;
import com.study.springboot.dao.ProductDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class TosspayController {
	
	@Autowired
	PaymentDAO paymentDao;
	@Autowired
	ProductDAO productDao;
	
	@RequestMapping("/checkout")
	public String checkout(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String product_seq = (String) session.getAttribute("product_seq");
        String prd_price = productDao.selectDao1(product_seq);
        
        model.addAttribute("prd_price", prd_price);
        
		return "checkout";
    }
	@RequestMapping("/success")
	public String success(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String secretKey = "test_sk_KNbdOvk5rkm9kPGnmg9q3n07xlzm:";

        Encoder encoder = Base64.getEncoder();
        byte[] encodedBytes = encoder.encode(secretKey.getBytes());
        String authorizations = "Basic " + new String(encodedBytes);
        
        String orderId = (String) session.getAttribute("orderId");
        String paymentKey = (String) session.getAttribute("paymentKey");
        String amount = (String) session.getAttribute("amount");
        String buy_seq = (String) session.getAttribute("buy_seq");
        String sell_seq = (String) session.getAttribute("sell_seq");
        String product_seq = (String) session.getAttribute("product_seq");
        
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
            
            if (isSuccess) {
            	String prd_price = productDao.selectDao1(product_seq);
                Map<String, String> map = new HashMap<>();
                map.put("item1", buy_seq);
                map.put("item2", sell_seq);
                map.put("item3", product_seq);
                map.put("item4", prd_price);
                paymentDao.paymentDao(map);
            } else {
				
			}
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // TODO: 성공 페이지로 리다이렉트 또는 모델에 필요한 데이터를 추가하여 반환
        return "success"; // 성공 페이지의 뷰 이름을 반환
    }
}

