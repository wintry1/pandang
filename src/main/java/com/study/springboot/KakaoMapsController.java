package com.study.springboot;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
public class KakaoMapsController {
	
	@RequestMapping("/kakaosearch")
	public ResponseEntity<String> kakaosearch(@RequestParam("latitude") Double latitude, @RequestParam("longitude") Double longitude, HttpServletRequest request) {
		Integer user_seq = (Integer) request.getSession().getAttribute("user_seq");
		HttpSession session = request.getSession();
		
		String url = "https://dapi.kakao.com/v2/local/geo/coord2address.json?";
	    String key = "0e5fcd82ed464324c0e57a10607243a6";
	    RestTemplate restTemplate = new RestTemplate();
	    
	    HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.set("Authorization", "KakaoAK " + key);

        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("x", longitude)
        		.queryParam("y", latitude);
   
        String requestUrl = builder.build().toUriString();

        ResponseEntity<String> response = restTemplate.exchange(requestUrl, HttpMethod.GET, new HttpEntity<>(httpHeaders), String.class);

        String responseBody = response.getBody();
        
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            JsonNode jsonNode = objectMapper.readTree(responseBody);
            JsonNode documents = jsonNode.get("documents");
            JsonNode firstDocument = documents.get(0);
            JsonNode address = firstDocument.get("address");
            
            String addressName = null;
            
            if (user_seq == null) {
            	String region_1 = address.get("region_1depth_name").asText() + " ";
                String region_2 = address.get("region_2depth_name").asText() + " ";
                String region_3 = address.get("region_3depth_name").asText();
                addressName = region_1 + region_2 + region_3;
    	    } else { addressName = address.get("address_name").asText(); }

            System.out.println(addressName);
            
            session.setAttribute("latitude", latitude);
            session.setAttribute("longitude", longitude);
            session.setAttribute("addressName", addressName);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return response;
    }
	
	@RequestMapping("calcul")
	class DistanceCalculator {
		static double calculateDistanceInMeters(double lat1, double lon1, double lat2, double lon2) {
		    double earthRadius = 6371.0;
	
		    // 라디안으로 변환
		    double radiansLat1 = Math.toRadians(lat1);
	        double radiansLon1 = Math.toRadians(lon1);
	        double radiansLat2 = Math.toRadians(lat2);
	        double radiansLon2 = Math.toRadians(lon2);
	
		    // 위도와 경도의 차이를 계산
		    double dLat = radiansLat2 - radiansLat1;
		    double dLon = radiansLon2 - radiansLon1;
	
		    // 거리 계산 (킬로미터 단위)
		    double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
	                Math.cos(radiansLat1) * Math.cos(radiansLat2) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
		    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		    double distanceInKilometers = earthRadius * c;
	
		    // 거리를 미터로 변환
		    double distanceInMeters = distanceInKilometers * 1000.0;
	
		    return distanceInMeters;
	  	}
	}
}

