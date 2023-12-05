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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nimbusds.jose.shaded.gson.Gson;
import com.study.springboot.dao.BookmarkDAO;
import com.study.springboot.dao.FilesDAO;
import com.study.springboot.dao.ProductDAO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.BookmarkDTO;
import com.study.springboot.dto.FilesDTO;
import com.study.springboot.dto.ProductDTO;
import com.study.springboot.dto.UserDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
public class ProductController {
	@Autowired
	ProductDAO productDao;
	@Autowired
	BookmarkDAO bookmarkDao;
	@Autowired
	FilesDAO filesDao;
	@Autowired
	UserDAO userDao;
	
	Random random = new Random();
	
	@RequestMapping("/list")
	public String plist(HttpServletRequest request, Model model)
	{
		List<ProductDTO> productList = productDao.selectDao();
		
		for (ProductDTO product : productList) {
		    int productSeq = product.getProduct_seq();
		    FilesDTO filesDTO = filesDao.viewDao(productSeq);
		    String imageName = (filesDTO != null) ? filesDTO.getFilesName() : null;
		    product.setPrd_image(imageName);
		}

		model.addAttribute("list", productList);
		
		return "mainhome";
	}
	
	@RequestMapping("/search")
	public String psearch(HttpServletRequest request, Model model) {
		String search_words = request.getParameter("search_words");		

		String[] searchWords = search_words.split(" ");
		for (int i = 0; i < searchWords.length; i++) {
			System.out.println("searchWords[" + i + "]: " + searchWords[i]);
		}
		int len = searchWords.length;
		System.out.println("searchWords.length = " + len);

		if (searchWords.length == 0) {
			return "product_search";
		}
		else if (searchWords.length == 1) {
			List<ProductDTO> productList = productDao.searchPrd1(searchWords[0]);
			for (ProductDTO product : productList) {
			    int productSeq = product.getProduct_seq();
			    FilesDTO filesDTO = filesDao.viewDao(productSeq);
			    String imageName = (filesDTO != null) ? filesDTO.getFilesName() : null;
			    product.setPrd_image(imageName);
			}

	        model.addAttribute("list", productList);
		}
		else if (searchWords.length == 2) {
			List<ProductDTO> productList = productDao.searchPrd2(searchWords[0], searchWords[1]);
			for (ProductDTO product : productList) {
			    int productSeq = product.getProduct_seq();
			    FilesDTO filesDTO = filesDao.viewDao(productSeq);
			    String imageName = (filesDTO != null) ? filesDTO.getFilesName() : null;
			    product.setPrd_image(imageName);
			}

	        model.addAttribute("list", productList);
		}
		else {
			List<ProductDTO> productList = productDao.searchPrd3(searchWords[0], searchWords[1], searchWords[2]);
			for (ProductDTO product : productList) {
			    int productSeq = product.getProduct_seq();
			    FilesDTO filesDTO = filesDao.viewDao(productSeq);
			    String imageName = (filesDTO != null) ? filesDTO.getFilesName() : null;
			    product.setPrd_image(imageName);
			}

	        model.addAttribute("list", productList);
		}
		
        return "product_search";
    }
	
	@RequestMapping("/view")
    public String pview(HttpServletRequest request, @RequestParam("product_seq") int product_seq, Model model) {
		HttpSession session = request.getSession();
		Integer user_seq = (Integer) session.getAttribute("user_seq");

		if (user_seq != null) {
	        BookmarkDTO bookmarkDto = bookmarkDao.selectDao(user_seq, product_seq);
	        
	        model.addAttribute("bookmark", bookmarkDto);
		}
		
		ProductDTO productlist = productDao.viewProduct(product_seq);
		if (user_seq == null || user_seq != productlist.getUser_seq()) {
			productDao.updatePrd1(product_seq);
		}
		
        // 해당 제품의 이미지 정보 조회
        FilesDTO filesDto = filesDao.viewDao(product_seq);
        String imageName = (filesDto != null) ? filesDto.getFilesName() : null;
        productlist.setPrd_image(imageName);
        
        int bookmarkcount = bookmarkDao.countDao(product_seq);
        UserDTO userlist = userDao.viewUser(productlist.getUser_seq());
        
        model.addAttribute("bookmarkcount", bookmarkcount);
        model.addAttribute("product_user", userlist);
        model.addAttribute("product", productlist);
        
		return "product_view";
    }
	@RequestMapping("/write_view")
	public String write_view(HttpServletRequest request, Model model){
		HttpSession session = request.getSession();
		Integer user_seq = (Integer) request.getSession().getAttribute("user_seq");
		if (user_seq == null) {
	        return "redirect:list";
	    }

		model.addAttribute("list", userDao.viewUser(user_seq));
		return "write_view";
	}
	
	@SuppressWarnings("null")
	@RequestMapping("/write")
	public String write(HttpServletRequest request, @RequestBody Map<String, Object> data)
	{
		HttpSession session = request.getSession();
		int user_seq = (int) session.getAttribute("user_seq");
		String prd_title = (String) data.get("prd_title");
		String prd_ctnt = (String) data.get("prd_ctnt");
		String prd_price = (String) data.get("prd_price");
		Double latitude = (Double) session.getAttribute("latitude");
		Double longitude = (Double) session.getAttribute("longitude");
		String address = (String) session.getAttribute("addressName");
		String files_name = (String) data.get("files_name");
		
		UserDTO userDto = userDao.viewUser(user_seq);
		
		String prd_latitude = (latitude != null) ? latitude.toString() : String.valueOf(userDto.getUser_latitude());
		String prd_longitude = (longitude != null) ? longitude.toString() :  String.valueOf(userDto.getUser_longitude());
		String prd_address = (address != null) ? address.toString() :  userDto.getUser_address();
		prd_title = (prd_title != null) ? prd_title.toString() : "제목이 없습니다.";
		prd_ctnt = (prd_ctnt != null) ? prd_ctnt.toString() : "내용이 없습니다.";
		prd_price = (prd_price != null) ? prd_price.toString() : "0";
		prd_price = prd_price.replace(",", "");
		files_name = files_name.replaceAll("\\s", "");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("item1", String.valueOf(user_seq));
		map.put("item2", prd_title);
		map.put("item3", prd_ctnt);
		map.put("item4", prd_price);
		map.put("item5", prd_latitude);
		map.put("item6", prd_longitude);
		map.put("item7", prd_address);
		
		productDao.writeDao(map);
		String product_seq = productDao.selectDao2(user_seq);
		
		System.out.println(files_name);
		
		if (files_name != null && !files_name.trim().isEmpty()) {
			Map<String, String> files = new HashMap<String, String>();
			files.put("item1", product_seq);
			files.put("item2", files_name);
	
			filesDao.filesDao(files);
		}
		
		return "redirect:list";
	}

	@PostMapping("/uploadOk")
	@ResponseBody
	public String uploadOk(HttpServletRequest request) {
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
				response.put("success", true);
	            response.put("imagePath", "/upload/" + uuidfName);
			}
		} catch (Exception e) {
			e.printStackTrace();
            response.put("success", false);
            response.put("desc", "업로드 실패");
		}
		
		return new Gson().toJson(response);
	}
}