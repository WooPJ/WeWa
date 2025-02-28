<%@ page language="java" contentType="text/html; charset=UTF-8" 
		pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 정보</title>
<link rel="stylesheet" type="text/css" href="../css/itemDetail.css">
</head>
<body>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	
	
	<div class="container" id="item-detail-container">
	    <!-- 첫 번째 상품 정보 -->
		<div class="product-wrapper first">
			<div class="product-details">
				<h1>상품 상세 정보</h1>
				<c:set var="item_code" value="${param.item_code}" />
				    <c:set var="imageList" value="${fn:split(item.imagename, ',')}" />
				    <div class="slideshow-container">
				        <c:forEach var="image" items="${imageList}" varStatus="status">
				            <div class="mySlides fade" style="display: ${status.index == 0 ? 'block' : 'none'};">
				                <img src="${image}" class="myItem-image" width="320" height="350"/>
				            </div>
				        </c:forEach>
				
				        <!-- 이전 버튼 -->
				        <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
				        <!-- 다음 버튼 -->
				        <a class="next" onclick="plusSlides(1)">&#10095;</a>
				    </div>	
				<div class="product-name">${item.item_title}</div>
				<div class="product-descriptions">${item.content}</div>
				<div class="product-price">
					<fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" />원
				</div>
				<!-- 찜하트 -->
				<div class="heart-container">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon"
                         data-item-code="${item.item_code}">
                        <path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4
                                c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4
                                268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8
                                c0 41.5 17.2 81.2 47.6 109.5z"/>
                    </svg>
                </div>
				<div class="product-review">
					<button class="goReview" onclick="goToReview('${item.item_code}')">리뷰 보러가기</button>
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
									장바구니 담기
								</button>
							</form>
						</c:when>
					</c:choose>
				</div>
			</div>
			<div class="product-details">
			     <c:choose>
			        <c:when test="${sessionScope.loginUser == null}">
			     		  <button type="submit" class="inquire-button" onclick="redirectToLoginPage('qnawrite')">
			            	문의하기
			        	</button>
			        </c:when>
			        <c:otherwise>
			        <form action="/qna/qnaWrite.html" method="get">
				        <input type="hidden" name="item_code" value="${item.item_code}"/>
				        <button type="submit" class="inquire-button">
				            문의하기
				        </button>
				    </form>
			        </c:otherwise>
			    </c:choose>
			</div>
		</div>
	</div>
	<script>
		//찜하트기능 ----------
		const heartIcon = document.querySelector('.heart-icon');
        const itemId = heartIcon.getAttribute("data-item-code");
        
        heartIcon.addEventListener('click', function (event) {
            //event.preventDefault();
            if (${sessionScope.loginUser == null}) {
               redirectToLogin();
               
            } else {
                let test = this.classList.toggle('filled'); //빈칸일때 누르면 true
                console.log(test);
                if(test) {
                	this.classList.add('filled'); 
                	console.log("하트채움");
                } else {
                	this.classList.remove('filled');
                	console.log("하트비움");
                }
                const isFilled = this.classList.contains('filled');
                console.log("isFilled? = " + isFilled);
                const inData = { itemCode: itemId, status: isFilled };
                let param = new URLSearchParams(inData).toString();
                fetch("/heart/toggle.html?" + param);
            }
        }); //찜하트기능 끝 ----------
		
		//리뷰 작성 및 보러가는 버튼 기능 함수
		function goToReview(itemCode) {
		    window.location.href = `/item/review.html?item_code=${item_code}`;
		}	
		//사이즈, 색상, 수량 미선택 시, 띄우는 메시지 함수
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
	    //이미지 관련 스크립트
	     var slideIndex = 0;

    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    function showSlides(n) {
        var slides = document.getElementsByClassName("mySlides");
        if (n >= slides.length) {slideIndex = 0}
        if (n < 0) {slideIndex = slides.length - 1}

        // 모든 슬라이드를 숨기고, 현재 인덱스의 슬라이드만 보이게 설정
        for (var i = 0; i < slides.length; i++) {
            slides[i].style.display = "none"; 
        }
        slides[slideIndex].style.display = "block";
    }

    // 첫 번째 슬라이드 자동으로 보여줌
    showSlides(slideIndex);
    
    //문의하기
    function goToInquire(itemCode) {
        window.location.href = `/qna/qnaWrite.html?item_code=${itemCode}`;
    }
    function redirectToLoginPage(page) { 
        if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
            window.location.href = "/login/login.html"; // 로그인 페이지로 이동
        }
    }
    </script>
</body>
</html>
