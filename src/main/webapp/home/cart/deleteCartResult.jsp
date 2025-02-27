<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 삭제 완료</title>
<style type="text/css">
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        background-color: #f5f5f5;
    }
    .container {
        width: 100%;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
    .addcart-Result {
        text-align: center;
    }
</style>
<!-- <script type="text/javascript">
    // 페이지가 로드된 후 3초 뒤에 자동으로 cart/cart.jsp로 리디렉션
    setTimeout(function() {
        window.location.href = "/cart/cart.html";  // 3초 후에 장바구니 페이지로 이동
    }, 3000);
</script> -->
</head>
<body>
<br/><br/><br/><br/><br/><br/><br/><br/><br/>
<div class="container">
    <div class="addcart-Result">
        <h2>장바구니 삭제가 완료되었습니다.</h2>
        <a href="/cart/cart.html">장바구니 목록으로</a>
    </div>
</div>
</body>
</html>
