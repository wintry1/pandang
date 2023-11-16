$(document).ready(function(){
	"use strict";
    
/*=========== TABLE OF CONTENTS ===========
1. Scroll To Top 
2. feather icon
3. Read more
======================================*/

    // 1. Scroll To Top 
		$(window).on('scroll',function () {
			if ($(this).scrollTop() > 600) {
				$('.return-to-top').fadeIn();
			} else {
				$('.return-to-top').fadeOut();
			}
		});
		$('.return-to-top').on('click',function(){
				$('html, body').animate({
				scrollTop: 0
			}, 1500);
			return false;
		});
	
	// 2. feather icon

		feather.replace();
		
	// 3. Read more
	
		$(function(){
    		$(".product-use").slice(0, 6).show(); // 초기갯수
    		$("#load").click(function(e){ // 클릭시 more
        		e.preventDefault();
        		if ($(".product-use:hidden").length > 0) { // 컨텐츠 남아있는지 확인
        			$(".product-use:hidden").slice(0, 6).show();
        		} else {
					alert("더이상 존재하지 않습니다."); // 컨텐츠 없을시 alert 창 띄우기 
				}
    		});
    		
    		
		});
		
		
});