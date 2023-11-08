package com.study.springboot;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class KakaoMapsController {
	
	class DistanceCalculator {
		static double calculateDistanceInMeters(double lat1, double lon1, double lat2, double lon2) {
		    double earthRadius = 6371.0; // 지구 반지름 (킬로미터 단위)
	
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

