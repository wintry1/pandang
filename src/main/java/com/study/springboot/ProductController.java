package com.study.springboot;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.dao.BookmarkDAO;
import com.study.springboot.dao.FilesDAO;
import com.study.springboot.dao.ProductDAO;
import com.study.springboot.dao.UserDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
public class ProductController {
	@Autowired
	ProductDAO pdao;
	@Autowired
	BookmarkDAO bdao;
	@Autowired
	FilesDAO fdao;
	@Autowired
	UserDAO udao;
	
	Random random = new Random();
	
	@RequestMapping("/write_view")
	public String write_view(HttpServletRequest request, Model model){
		HttpSession session = request.getSession();
		
		Integer userSeq = (Integer) request.getSession().getAttribute("user_seq");
		if (userSeq == null) {
	        return "loginhome"; // 로그인 페이지의 뷰 이름
	    }
		
		int user_seq = (int) session.getAttribute("user_seq");
		model.addAttribute("list", udao.getEmployee(user_seq));
		return "pop/write_view";
	}
	@RequestMapping("/write")
	public String write(HttpServletRequest request, Model model)
	{
		HttpSession session = request.getSession();
		String user_seq = (String) session.getAttribute("user_seq");
		String prd_title = request.getParameter("prd_title");
		String prd_ctnt = request.getParameter("prd_ctnt");
		String prd_price = request.getParameter("prd_price");
		Double latitude = (Double) session.getAttribute("latitude");
		Double longitude = (Double) session.getAttribute("longitude");
		String prd_address = (String) session.getAttribute("addressName");
		
		String prd_latitude = (latitude != null) ? latitude.toString() : null;
		String prd_longitude = (longitude != null) ? longitude.toString() : null;

		user_seq = "1";
		
		Map<String, String> mapp = new HashMap<String, String>();
		mapp.put("item1", user_seq);
		mapp.put("item2", prd_title);
		mapp.put("item3", prd_ctnt);
		mapp.put("item4", prd_price);
		mapp.put("item5", prd_latitude);
		mapp.put("item6", prd_longitude);
		mapp.put("item7", prd_address);
		
		int nResult = pdao.writeDao(mapp);
		System.out.println("Write : " + nResult);
		
		return "pop/write_view";
	}

	@PostMapping("/uploadOk")
	public ResponseEntity<Map<String, Object>> uploadOk(HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();

		try {
			String filePath = ResourceUtils
					.getFile("classpath:static/upload/").toPath().toString();
			System.out.println(filePath);
			
			// Retrieves <input type="file" name="files" multiple="true">
			List<Part> fileParts = request.getParts().stream()
								.filter(part -> "files".equals(part.getName()) && part.getSize() > 0)
								.collect(Collectors.toList());
			for (Part filePart : fileParts) {
				String fileName = Paths.get(filePart.getSubmittedFileName())
									.getFileName().toString();
				int bound = 10;
				String rnum = "num";
				for (int i = 0; i < 6; i++) {
				    rnum = rnum + String.valueOf(random.nextInt(bound));
				}
				String uuidfName = rnum + fileName;
				String dst = filePath + "\\" + uuidfName;
				
				try (BufferedInputStream fin = 
						new BufferedInputStream (filePart.getInputStream());
					BufferedOutputStream fout =
						new BufferedOutputStream(new FileOutputStream(dst)))
					{
						int data;
						while (true)
						{
							data = fin.read();
							if (data == -1)
								break;
							fout.write(data);
						}
					}
					 catch (IOException e) {
					    e.printStackTrace();
					}
				System.out.println("Uploaded Filename: " + dst + "<br>");
				HttpSession session = request.getSession();
	            session.setAttribute("uuidfName", uuidfName);
				response.put("success", true);
	            response.put("desc", "업로드 성공");
	            response.put("filePath", "/upload/" + uuidfName);
			}

		} catch (Exception e) {
			e.printStackTrace();
            response.put("success", false);
            response.put("desc", "업로드 실패");
		}
		
		return ResponseEntity.ok(response);
	}
}