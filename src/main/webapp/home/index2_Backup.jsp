<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WearWave</title>
<link rel="stylesheet" type="text/css" href="../css/items.css">
</head>
<body>
<jsp:include page="menu_header.jsp"/>

<table>
<tr>
	<td id="content">
			<c:choose>
				<c:when test="${ BODY != null }">
					<jsp:include page="${ BODY }"/>
				</c:when>
				<c:otherwise>
<jsp:include page="main_slider.jsp"/>	


<c:forEach items="${sessionScope.heartList }" var="heart">
image:${heart.imagename }<br/>
<div class="product">
	<a href="/item/itemDetail.html?item_id=${heart.i_item_code}">
   	<div class="image-container">
       <img src="../imgs/item/${heart.imagename }" alt="${heart.item_title }"/>
        <div class="heart-container">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon">
            	<path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
            </svg>
        </div>
	</div>	
    <div class="product-name">${heart.item_title }</div>
    <div class="product-description">${heart.content }</div>
    <div class="product-price">${heart.price }원</div>
	</a>
	<script type="text/javascript">
	if(${heart.status == 1}){
		const isFilled = this.classList.contains('filled');
		if(! isFilled) this.classList.toggle('filled');//하트 채운다.
	}
	</script>
</div>
</c:forEach>
			
                    <div class="product">
                        <a href="/item/itemDetail.html?item_id=1">
	                        <div class="image-container">
	                            <img src="../imgs/item/1.png" alt="포멜카멜레"/>
	                            <div class="heart-container">
		                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon">
		                            	<path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
		                            </svg>
						        </div>
							</div>	
                            <div class="product-name">포멜카멜레</div>
                            <div class="product-description">포멀 에스닉 퍼 울 Brown 5cm</div>
                            <div class="product-price">48,300원</div>
                        </a>
                    </div>
                    <div class="product">
                        <a href="/item/itemDetail.html?item_id=2">
                        	<div class="image-container">
                            	<img src="../imgs/item/2.png" alt="티뷰"/>
                            	<div class="heart-container">
		                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon">
		                            	<path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
		                            </svg>
						        </div>
							</div>	
                            <div class="product-name">티뷰</div>
                            <div class="product-description">레이어드랩셔츠원피스_V54-VOP003</div>
                            <div class="product-price">33,000원</div>
                        </a>
                    </div>
                    <div class="product">
                        <a href="/item/itemDetail.html?item_id=3">
                        	<div class="image-container">
                            	<img src="../imgs/item/3.png" alt="티뷰"/>
                            	<div class="heart-container">
		                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon">
		                            	<path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
		                            </svg>
						        </div>
							</div>	
                            <div class="product-name">티뷰</div>
                            <div class="product-description">와이드핀턱랩슬랙스_V4A-CPT026</div>
                            <div class="product-price">19,800원</div>
                        </a>
                    </div>
                    <div class="product">
                        <a href="/item/itemDetail.html?item_id=4">
                            <div class="image-container">
                            	<img src="../imgs/item/4.png" alt="프리즘웍스"/>
                            	<div class="heart-container">
		                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon">
		                            	<path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
		                            </svg>
						        </div>
							</div>	
                            <div class="product-name">프리즘웍스</div>
                            <div class="product-description">ALTAVIA DOWN PARKA_BLACK</div>
                            <div class="product-price">245,100원</div>
                        </a>
                    </div>
                    <!-- 추가 상품 예시 -->
                    <div class="product">
                        <a href="/item/itemDetail.html?item_id=5">
                            <div class="image-container">
                            	<img src="../imgs/item/1.png" alt="포멜카멜레"/>
                            	<div class="heart-container">
		                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon">
		                            	<path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
		                            </svg>
						        </div>
							</div>	
                            <div class="product-name">포멜카멜레</div>
                            <div class="product-description">포멀 에스닉 퍼 울 Brown 5cm</div>
                            <div class="product-price">48,300원</div>
                        </a>
                    </div>
                    <div class="product">
                        <a href="/item/itemDetail.html?item_id=6">
                            <div class="image-container">
                            	<img src="../imgs/item/2.png" alt="티뷰"/>
                            	<div class="heart-container">
		                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon">
		                            	<path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
		                            </svg>
						        </div>
							</div>	
                            <div class="product-name">티뷰</div>
                            <div class="product-description">레이어드랩셔츠원피스_V54-VOP003</div>
                            <div class="product-price">33,000원</div>
                        </a>
                    </div>
                    <div class="product">
                        <a href="/item/itemDetail.html?item_id=7">
                            <div class="image-container">
                            	<img src="../imgs/item/3.png" alt="티뷰"/>
                            	<div class="heart-container">
		                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon">
		                            	<path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
		                            </svg>
						        </div>
							</div>	
                            <div class="product-name">티뷰</div>
                            <div class="product-description">와이드핀턱랩슬랙스_V4A-CPT026</div>
                            <div class="product-price">19,800원</div>
                        </a>
                    </div>
                    <div class="product">
                        <a href="/item/itemDetail.html?item_id=8">
                            <div class="image-container">
                            	<img src="../imgs/item/4.png" alt="프리즘웍스"/>
                            	<div class="heart-container">
		                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon">
		                            	<path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
		                            </svg>
						        </div>
							</div>	
                            <div class="product-name">프리즘웍스</div>
                            <div class="product-description">ALTAVIA DOWN PARKA_BLACK</div>
                            <div class="product-price">245,100원</div>
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </td></tr>
</table>
<script src="https://kit.fontawesome.com/a076d05399.js"></script> <!-- Font Awesome for heart icon -->


<script>

	function redirectToLogin() {
    	alert("로그인 후 찜기능을 사용할 수 있습니다.");
    	window.location.href = "/login/login.html"; // 로그인 페이지로 이동
	}

    // 하트 아이콘 클릭 시 채워지거나 비어지게 하는 기능
     const heartIcons = document.querySelectorAll('.heart-icon');
	
    // 각 아이콘에 클릭 이벤트
    heartIcons.forEach(heart => {
	    heart.addEventListener('click', function (event) {
	        event.preventDefault(); // a 태그 링크 동작 방지
	        
	        if(${sessionScope.loginUser == null }) {
		        redirectToLogin(); // 로그인 유무 확인
	        } else {
		        const variable = this.closest('a').getAttribute('href').split('item_id=')[1]; // URL에서 item_id 추출
		        
		        // 하트채우기 UI반영
		        this.classList.toggle('filled');
	
				// 현재 상태 확인 (채울때 true, 비울때 false를 보냄)
            	const isFilled = this.classList.contains('filled');
           
				const inData = {
						itemId : variable,
						status : isFilled
				}
		        
                
                // fetch 요청 URL 구성
                const url = `/heart/toggle.html?itemId=${inData.itemId}&status=${inData.isFilled}`;
                console.log("요청 URL:", url);
				
		       	console.log("아이템 코드 : " + inData.itemId)
		       	console.log("상태 : " + inData.status)
		       	
		       	let param = new URLSearchParams(inData).toString();
		       	fetch("/heart/toggle.html?" + param);
		       	
// 		        fetch(url, {
//  	        	    method: 'GET',
//         	    	headers: {
//                        'Content-Type': 'application/json'
//                    }
//  	    	    })
//  	    	    .then(response => {
// 	                if (!response.ok) {
// 	                    throw new Error('Network response was not ok');
// 	                }
// 	                return response.json();
// 	            })
// 	            .then(data => {
// 	                // 서버 응답이 성공적일 때만 UI 업데이트
// 	                this.classList.toggle('filled');
// 	                console.log("서버 응답:", data);
// 	            })
// 	            .catch(error => {
// 	                console.error('Error:', error);
// 	                alert('처리 중 오류가 발생했습니다.');
// 	            });
		       	//window.location.href = "/heart/toggle.html?itemId="+inData.itemId+"&status="+inData.status;
		       	//window.location.href = "/heart/toggle.html?itemId="+itemId+"&status="+isFilled;
		       	
		       	
	        } //if문
	     	// @GetMapping으로 GET 요청
// 	        fetch(`/heart/toggle.html?itemId=${itemId}&status=${isFilled}`, {
// 	            method: 'GET'
// 	        });
// 	        .then(response => {
// 	            if (!response.ok) {
// 	                throw new Error('네트워크 응답이 올바르지 않습니다.');
// 	            }
// 	            return response.json();
// 	        })
// 	        .then(data => {
// 	            console.log('서버 응답:', data);
// 	        })
// 	        .catch(error => {
// 	            console.error('요청 중 오류 발생:', error);
// 	        });
	    });
    });
</script>

</body>
</html>