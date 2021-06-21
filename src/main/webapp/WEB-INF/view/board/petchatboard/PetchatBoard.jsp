<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사랑하냥? 사랑하개!</title>
</head>
<body>
<!-- header -->
<jsp:include page="${path}/view/include/header.jsp" />
<!-- //header -->

<!-- container -->
	<div>
		<h2>집사들의 수다</h2>
		<nav class="array">
			<input type="button" value="추천순" onClick="javascript: form.action='likeCount';">
			&nbsp;&nbsp;
			<input type="button" value="최신순" onClick="javascript: form.action='recent';">
			&nbsp;&nbsp;
			<input type="button" value="오래된순" onClick="javascript: form.action='past';">
			&nbsp;&nbsp;
			<input type="button" value="조회수" onClick="javascript: form.action='readCount';">
		</nav>
		<input type="submit" value="글쓰기" onClick="javascript: form.action='writePage';">
	</div>
	<table>
		<tr>
			<td>글 번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>조회수</td>
			<td>작성 시간</td>
			<td>추천수</td>
		</tr>
	</table>
	<div class="pagingNum"></div>
<!-- //container -->

<!-- footer -->
<!-- //footer -->
</body>
</html>
