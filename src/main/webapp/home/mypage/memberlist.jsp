<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="stylesheet" type="text/css" href="../css/memberList.css">
</head>
<body>
<div id="member-container">
    <h2 class="title">회원 목록</h2>
    
    <form id="grade-search-form" action="/member/gradeSearch.html">
        <label for="grade">회원 등급:</label>
        <select id="grade-select" name="grade">
            <option value="1">손님</option>
            <option value="2">사업자</option>
        </select>
        <input class="btn-search" type="submit" value="조회"/>
    </form>
    
    <br/>
    
    <table id="member-table">
        <thead>
            <tr>
                <th>계정</th>
                <th>이름</th>
                <th>주소</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>등급</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="member" items="${memberList}">
                <tr class="member-row">
                    <td>${member.user_id}</td>
                    <td>${member.name}</td>
                    <td>${member.addr}</td>
                    <td>${member.phone}</td>
                    <td>${member.email}</td>
                    <td class="member-grade">
                        <c:choose>
                            <c:when test="${member.grade == 0}">어드민</c:when>
                            <c:when test="${member.grade == 1}">손님</c:when>
                            <c:when test="${member.grade == 2}">사업자</c:when>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>    
        </tbody>
    </table>
</div>
</body>
</html>
