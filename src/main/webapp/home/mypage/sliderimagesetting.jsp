<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>슬라이더 이미지 관리</title>
<link rel="stylesheet" type="text/css" href="../css/slidersetting.css">
</head>
<body>
 <div id="slider-table-container">
 	<div id="header-container">
  	 <h3>슬라이더 이미지 목록</h3>
    <!-- 이미지 추가 버튼 -->
    <div id="add-button-container">
        <form action="/slider/addImagePage.html" method="get">
            <button type="submit" id="add-image-btn">이미지 추가</button>
        </form>
    </div>
	</div>
        <table id="slider-table" class="table">
            <thead>
                <tr>
                    <th>순서</th>
                    <th>이미지</th>
                    <th>이름</th>
                    <th>삭제</th>
                    <th>순서 변경</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="slider" items="${sliderImg}">
                    <tr>
                        <td>${slider.display_order}</td>
                        <td><img src="${slider.image_url}" class="slider-image" /></td>
                        <td>${slider.title}</td>
                        <td>
                            <form action="/slider/deleteImage.html" method="post" class="delete-form"  onsubmit="return deleteimage(event, this)">
							    <input type="hidden" name="order" value="${slider.display_order}" />
							    <input type="submit" class="delete-btn" value="삭제"/>
							</form>
                        </td>
                        <td><form action="/slider/updateOrder.html" method="post" class="order-form">
						    <input type="hidden" name="num" value="${slider.num}" />
						    <input type="hidden" name="old_order" value="${slider.display_order}" />
						    <label for="new_order${slider.num}" class="order-label">순서:</label>
						    <select name="new_order" id="new_order${slider.num}" class="order-select">   
						        <c:forEach var="order" begin="1" end="${sliderImg.size()}" varStatus="status">
						            <option value="${status.index}" 
						                <c:if test="${status.index  == slider.display_order}">selected</c:if>>
						                ${status.index}
						            </option>
						        </c:forEach>
						    </select>
						    <input type="submit" class="order-btn" value="순서 변경" />
						</form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        const forms = document.querySelectorAll(".order-form");

        forms.forEach(form => {
            form.addEventListener("submit", function(event) {
                const oldOrder = form.querySelector("input[name='old_order']").value;
                const newOrder = form.querySelector("select[name='new_order']").value;
                
                if (oldOrder === newOrder) {
                    alert("현재 순서와 동일한 값으로 변경할 수 없습니다.");
                    event.preventDefault();
                }
            });
        });
    });
        function deleteimage(order) { 
	        if (confirm("정말 삭제하시겠습니까?")) {
	            alert("삭제가 완료되었습니다"); 
	            form.submit();
	        }
	        return false;
	    }
    </script>
</body>
</html>