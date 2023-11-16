package com.study.springboot;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dao.FilesDAO;
import com.study.springboot.dao.ProductDAO;
import com.study.springboot.dto.FilesDTO;
import com.study.springboot.dto.ProductDTO;

@Controller
public class MyController {
	
	@Autowired
	ProductDAO productDao;
	@Autowired
	FilesDAO filesDao;
	
	@RequestMapping("/")
	public String root(Model model) throws Exception{

		return "redirect:list";
	}

	@RequestMapping("/chat_room")
	public String chat_room(Model model)
	{
		return "pop/chat_room";
	}
	
	@RequestMapping("/list")
	public String plist(Model model)
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
	public String psearch(@RequestParam(value = "title", required = false) String title, Model model) {
        List<ProductDTO> productList = productDao.searchDao(title);

        // 이미지 정보 추가
        for (ProductDTO product : productList) {
		    int productSeq = product.getProduct_seq();
		    FilesDTO filesDTO = filesDao.viewDao(productSeq);
		    String imageName = (filesDTO != null) ? filesDTO.getFilesName() : null;
		    product.setPrd_image(imageName);
		}

        model.addAttribute("list", productList);

        return "product_search";
    }
	
	@RequestMapping("/view")
    public String pview(@RequestParam("product_seq") int productSeq, Model model) {
		 
        // 특정 제품의 상세 정보 조회
        ProductDTO product = productDao.viewProduct(productSeq);

        // 해당 제품의 이미지 정보 조회
        FilesDTO filesDTO = filesDao.viewDao(productSeq);
        String imageName = (filesDTO != null) ? filesDTO.getFilesName() : null;
        product.setPrd_image(imageName);

        // 모델에 제품 정보 추가
        model.addAttribute("product", product);
        
        return "product_view";
    }
	
	@RequestMapping("/popup/popUp_login")
	public String popUp_login() {
		return "popup/popUp_login";
	}
	@RequestMapping("/popup/popUp_agree")
	public String login_agree() {
		return "popup/popUp_agree";
	}
	@RequestMapping("/popup/popUp_map")
	public String popUp_map() {
		return "popup/popUp_map";
	}
}