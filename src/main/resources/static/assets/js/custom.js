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
    		const hiddenContent = $(".product-use:hidden");
    
    		if (hiddenContent.length === 0) {
        		$("#load").hide(); // 초기에 숨겨진 콘텐츠가 없으면 버튼을 숨깁니다.
        	}
        	
    		$("#load").click(function(e){ // 클릭시 more
        		e.preventDefault();
        		
        		if ($(".product-use:hidden").length > 0) { // 컨텐츠 남아있는지 확인
        			$(".product-use:hidden").slice(0, 6).show();
        			if ($(".product-use").filter(':hidden').length === 0) {
          	     		$("#load").hide(); // 더 이상 숨겨진 콘텐츠가 없으면 버튼을 숨깁니다.
          		  	}
				}
    		});
		});
		
});