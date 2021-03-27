<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BBOARD</title>
<style type="text/css">
			li {list-style: none; float: left; padding: 6px;}
</style>
</head>
<body>
	<h1>게시판</h1>
	<form method="get" action="write">
	<table border="1">
		<tr>
			<td>글쓴이</td>
			<td>제목</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
	<c:if test="${search == null}" >
	<c:forEach var="board" items="${content}">
		<tr>
			<td>${board.writer}</td>
			<td><a href="info?id=${board.id}">${board.title}</a></td>
			<td>${board.writedate}</td>
			<td>${board.readCount}</td>
		</tr>
	</c:forEach>
	</c:if>
	
	<c:if test="${search != null}" >
	<c:forEach var="board" items="${searchWrs}">
		<tr>
			<td>${board.writer}</td>
			<td><a href="info?id=${board.id}">${board.title}</a></td>
			<td>${board.writedate}</td>
			<td>${board.readCount}</td>
		</tr>
	</c:forEach>
	</c:if>
		<tr>
			<td colspan="3">
			<input type="text" name="searchWr" />
			<input type="submit" value="검색" onClick="javascript: form.action='search';">
			</td>
			<td>
			<input type="submit" value="글쓰기">
			</td>
		</tr>
	</table>
	<!-- <div>
	  <ul>
	    <c:if test="${pageMaker.prev}">
	    	<li><a href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
	    </c:if> 
	
	    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
	    	<li><a href="list${pageMaker.makeQuery(idx)}">${idx}</a></li>
	    </c:forEach>
	
	    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
	    	<li><a href="list${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
	    </c:if> 
	  </ul>
	</div>  -->
	</form>
</body>
</html>