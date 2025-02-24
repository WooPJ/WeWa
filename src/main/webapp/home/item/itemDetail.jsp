<%@ page language="java" contentType="text/html; charset=UTF-8"
<<<<<<< HEAD
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 상세 정보</title>
    <style>
        body {
            display: flex;
            justify-content: center; /* 수평 중앙 정렬 */
            align-items: center; /* 수직 중앙 정렬 */
            height: 100vh; /* 화면 높이 전체 사용 */
            margin: 0; /* 기본 여백 제거 */
        }
        .product-details {
            text-align: center; /* 텍스트 중앙 정렬 */
        }
    </style>
</head>
<body>
    <div class="product-details">
        <h1>상품 상세 정보</h1>

        <c:set var="item_id" value="${param.item_id}" />
        
        <img src="../imgs/item/${item_id}.png" width="250" height="300" alt="${productName}"/>
        <div class="product-name">${productName}</div>
        <div class="product-description">${productDescription}</div>
        <div class="product-price">${productPrice}</div>
    </div>
</body>
</html>
=======
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 정보</title>
<link rel="stylesheet" type="text/css" href="../css/itemDetail.css">
</head>
<body>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	
	
	<div class="container">
	    						<!-- 첫 번째 상품 정보 -->
		<div class="product-wrapper first">
			<div class="product-details">
				<h1>상품 상세 정보</h1>
				<c:set var="item_code" value="${param.item_code}" />
				<img class="product-image" src="${item.imagename}"
					width="400" height="450"/>
				<div class="product-name">${item.item_title}</div>
				<div class="product-description">${item.content}</div>
				<div class="product-price">
					<fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" />원
				</div>
				<!-- 좋아요 버튼 -->
				<form:form action="/item/like.html" method="post">
					<button type="submit" style="background: none; border: none; padding: 0; cursor: pointer;">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512"
							class="heart-icon">
		                    <path
								d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z" />
		                </svg>
					</button>
				</form:form>
				<div class="product-review">
					<a href="/item/review.html?item_code=${item.item_code}">리뷰 보러가기</a>
				</div>
			</div>
		</div>


										<!-- 구매 옵션 div -->

		<div class="product-wrapper second">
			<div class="product-details">
				<h1>구매 옵션</h1>
				<c:set var="item_code" value="${param.item_code}" />
				<input type="hidden" readonly="readonly" value="${item.item_code}">
				<input type="hidden" readonly="readonly" value="${sessionScope.loginUser.id}">
				<div class="product-name">${item.item_title}</div>
				<div class="product-description">${item.content}</div>
				<div class="product-price">
					<fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" />원
				</div>
				<!-- 사이즈 선택 -->
				<div class="size-select">
				    <label for="size">Size:</label>
				    <select id="size-select" name="size">
				     <option value="" selected>-- 사이즈 선택 --</option> <!-- 첫 번째 옵션 공백 -->
				        <c:forEach var="size" items="${sizeList}">
				            <option value="${size}">${size}</option>
				        </c:forEach>
				    </select>
				    <input type="hidden" name="size" id="selectedSize" value="" />
				</div>
				<!-- 색상 선택 -->
				<div class="color-select">
					<label for="color">Color:</label> <select id="color-select" name="color">
					 <option value="" selected>--- 색상 선택 ---</option> <!-- 첫 번째 옵션 공백 -->
						<c:forEach var="color" items="${colorList}">
							<option value="${color}">${color}</option>
						</c:forEach>
					</select>
					 <input type="hidden" name="selected_color" id="selectedColor" value="" />
				</div>

				<br />
				<div class="purchase">
					<!-- 수량 선택 -->
					<div class="quantity-select">
						<button type="button" onclick="increment()"
							style="background-color: #4CAF50; color: white; border: none; padding: 10px; cursor: pointer; border-radius: 5px; font-size: 20px; width: 30px; height: 30px; margin-left: 5px;">
							+</button>
						<button type="button" onclick="decrement()"
							style="background-color: #f44336; color: white; border: none; padding: 10px; cursor: pointer; border-radius: 5px; font-size: 20px; width: 30px; height: 30px; margin-left: 5px;">
							-</button>
						<input type="number" id="quantity" name="quantity" value="0" min="0" max="10" readonly>
						<input type="hidden" name="selected_quantity" id="selectedQuantity" value="1" />
					</div>
					<!-- 총 가격 -->
					<div class="total-price">
						<span id="total-price"><fmt:formatNumber
								value="${item.price}" type="number" groupingUsed="true" />원</span>
					</div>

					<!-- 장바구니 담기 버튼 -->
					<c:choose>
						<c:when test="${sessionScope.loginUser == null}">
							<button type="button" class="purchase-button" onclick="redirectToLogin('cart')">
								<img alt="Cart" src="../imgs/icon/cart.png" width="30" height="30">장바구니 담기
							</button>
						</c:when>
						<c:when
							test="${sessionScope.loginUser != null && sessionScope.loginUser.grade != 0}">
							<!-- 장바구니 담기 버튼 -->
							<form action="../item/cart.html" method="post" onsubmit="return validateForm()">
							    <input type="hidden" name="item_code" value="${item.item_code}" />
							    <input type="hidden" name="selectedSize" id="selectedSizePost"  />
							    <input type="hidden" name="selectedColor" id="selectedColorPost" />
							    <input type="hidden" name="selectedQuantity" id="selectedQuantityPost" />
							    <input type="hidden" name="inputPrice" id="inputPricePost" />
							    <input type="hidden" name="user_id" value="${sessionScop.loginUser.id}">
								<button type="submit" class="purchase-button">
									<img alt="Cart" src="../imgs/icon/cart.png" width="30"height="30">
									장바구니 담으러 가기
								</button>
							</form>
						</c:when>
					</c:choose>


				</div>
			</div>
		</div>
	</div>
	<script>
		function validateForm() {
	        var selectedSize = document.getElementById('selectedSize').value;
	        var selectedColor = document.getElementById('selectedColor').value;
	        var quantity = document.getElementById('quantity').value;
	
	        if (!selectedSize || !selectedColor || quantity < 1) {
	            alert("사이즈, 색상, 수량을 선택해주세요!");
	            return false;
	        }
	        return true;
	    }	
	
		document.getElementById('size-select').addEventListener('change', function() {
		    document.getElementById('selectedSize').value = this.value;
		    document.getElementById('selectedSizePost').value = this.value;//input form에도 value를 넣어준다.
		    //console.log("🟢 선택된 사이즈:", this.value);
		});
	
		document.getElementById('color-select').addEventListener('change', function() {
		    document.getElementById('selectedColor').value = this.value;
		    document.getElementById('selectedColorPost').value = this.value;//input form에도 value를 넣어준다.
		    //console.log("🟢 선택된 색상:", this.value);
		});
		function updateTotalPrice() {
		    var price = parseInt("${item.price}" || "0");
		    var quantity = parseInt(document.getElementById('quantity').value);
		    var totalPrice = price * quantity;
		    document.getElementById('total-price').innerText = totalPrice.toLocaleString() + "원";
		    document.getElementById('inputPricePost').value = price; // hidden 필드에 총 가격 저장
		    console.log("총 가격 업데이트:", totalPrice);  
		}
	
		function updateQuantity() {
		    var quantityInput = document.getElementById('quantity');
		    var selectedQuantity = document.getElementById('selectedQuantity');
		    var selectedQuantityPost = document.getElementById('selectedQuantityPost');

		    selectedQuantity.value = quantityInput.value;
		    selectedQuantityPost.value = quantityInput.value;
		    console.log("🟢 선택된 수량:", quantityInput.value);
		}

		// 수량 증가 버튼
		function increment() {
		    var quantityInput = document.getElementById('quantity');
		    var currentValue = parseInt(quantityInput.value);

		    if (currentValue < 10) {
		        quantityInput.value = currentValue + 1;
		        updateQuantity();  // 값 변경 시 업데이트 실행
		        updateTotalPrice();
		    }
		}

		// 수량 감소 버튼
		function decrement() {
		    var quantityInput = document.getElementById('quantity');
		    var currentValue = parseInt(quantityInput.value);

		    if (currentValue > 1) {
		        quantityInput.value = currentValue - 1;
		        updateQuantity();  // 값 변경 시 업데이트 실행
		        updateTotalPrice();
		    }
		}
	    function redirectToLogin(page) { 
	        if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
	            window.location.href = "/login/login.html"; // 로그인 페이지로 이동
	        }
	    }
        // 하트 아이콘 클릭 시 /item/like.html로 이동
        document.querySelectorAll('.heart-icon').forEach(heartIcon => {
            heartIcon.addEventListener('click', function(event) {
                event.preventDefault();
                this.classList.toggle('filled');
                this.closest('form').submit();
            });
        });
    </script>
</body>
</html>
>>>>>>> origin/master
