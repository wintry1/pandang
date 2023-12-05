<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작은 상점</title>
<script src="http://code.jquery.com/jquery.js"></script>
<link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />
<link rel="stylesheet" type="text/css" href="./public/style.css" />
<script src="https://js.tosspayments.com/v1/payment-widget"></script>
</head>
<%
	String user_name = (String) request.getSession().getAttribute("user_name");
%>
<body>
    <!-- 주문서 영역 -->
    <div class="wrapper">
      <div class="box_section"
      style="padding: 40px 30px 50px 30px; margin-top:30px; margin-bottom:50px">
        <!-- 결제 UI -->
        <div id="payment-method"></div>
        <!-- 이용약관 UI -->
        <div id="agreement"></div>
        <!-- 결제하기 버튼 -->
        <div class="result wrapper">
          <button class="button" id="payment-button"
          style="margin-top:30px; ">결제하기</button>
        </div>
      </div>
    </div>
  </body>

  <script>
    const button = document.getElementById("payment-button");
    const coupon = document.getElementById("coupon-box");
    const generateRandomString = () => window.btoa(Math.random()).slice(0, 20);
    let currentURL = window.location.protocol + "//" + window.location.host + "/" + window.location.pathname.split('/')[1];
    var amount = ${list.prd_price};

    const clientKey = "test_ck_kYG57Eba3G67q2LddLpw8pWDOxmA"; 
    const customerKey = generateRandomString();                 
    const paymentWidget = PaymentWidget(clientKey, customerKey);

    paymentMethodWidget = paymentWidget.renderPaymentMethods(
      "#payment-method",
      { value: amount },
      { variantKey: "DEFAULT" }
    );
    // ------  이용약관 UI 렌더링 ------
    // @docs https://docs.tosspayments.com/reference/widget-sdk#renderagreement선택자-옵션
    paymentWidget.renderAgreement(
      "#agreement",
      { variantKey: "AGREEMENT" }
    );

    button.addEventListener("click", function () {
      paymentWidget.requestPayment({
        orderId: generateRandomString(),
        orderName: '${list.prd_title}',
        successUrl: 'http://localhost:8081/success',
        failUrl: 'http://localhost:8081/fail',
        customerName: '<%= user_name %>',
      });
    });
    
  </script>
</body>
</html>