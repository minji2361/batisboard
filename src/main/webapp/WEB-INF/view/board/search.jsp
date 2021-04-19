<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BBOARD</title>
</head>
<body>

<h1>검색 결과</h1>

<h3>item 테이블</h3>
<table>
	<tr>
		<td>게시판</td>
		<td>작성자</td>
		<td>제목</td>
	</tr>
	<c:forEach var="samList" items="${samList}">
	<c:if test="${samList.type eq 'item'}" >
		<tr>
			<td>${samList.type}</td>
			<td>${samList.writer}</td>
			<td><a href="info?id=${samList.bnum}">${samList.title}</a></td>
		</tr>
	</c:if>
	</c:forEach>
</table>

<h3>food 테이블</h3>
<table>
	<tr>
		<td>게시판</td>
		<td>작성자</td>
		<td>제목</td>
	</tr>
	<c:forEach var="samList" items="${samList}">
	<c:if test="${samList.type eq 'food'}" >
		<tr>
			<td>${samList.type}</td>
			<td>${samList.writer}</td>
			<td><a href="info?id=${samList.bnum}">${samList.title}</a></td>
		</tr>
	</c:if>
	</c:forEach>
</table>

<h3>hospital 테이블</h3>
<table>
	<tr>
		<td>게시판</td>
		<td>작성자</td>
		<td>제목</td>
	</tr>
	<c:forEach var="samList" items="${samList}">
	<c:if test="${samList.type eq 'hospital'}" >
		<tr>
			<td>${samList.type}</td>
			<td>${samList.writer}</td>
			<td><a href="info?id=${samList.bnum}">${samList.title}</a></td>
		</tr>
	</c:if>
	</c:forEach>
</table>

</body>
</html>