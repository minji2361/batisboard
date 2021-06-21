<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사랑하냥? 사랑하개!</title>
</head>
<body>
<!-- header -->
<jsp:include page="/WEB-INF/view/include/header.jsp" />
<!-- //header -->
<form>
<div class ="container">
	<div>
		<h2>구해줘 펫즈</h2>
			<nav class="array">
		<center>
			<a href="likeCount"><button type="button" class="btn btn-outline-secondary">추천순</button></a>
			&nbsp;&nbsp;
			<a href="recent"><button type="button" class="btn btn-outline-secondary">최신순</button></a>
			&nbsp;&nbsp;
			<a href="past"><button type="button" class="btn btn-outline-secondary">오래된순</button></a>
			&nbsp;&nbsp;
			<a href="readCount"><button type="button" class="btn btn-outline-secondary">조회순</button></a>
		</nav>
		  </center>
	</div>
	<div style='width:80px;float: right;'>
		<a href="../lostpetWrite"><button type="submit" class="btn btn-outline-secondary">글쓰기</button></a>
	</div>
</form>
	<table>		
		<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">글번호</th>
      <th scope="col">제목</th>
      <th scope="col">닉네임</th>
      <th scope="col">조회수</th>
      <th scope="col">작성시간</th>
      <th scope="col">추천수</th>
	    <!-- 공지글 -->
		<c:forEach var="notice" items="${lostpetNotice}">
				<tr>
					<td>${notice.boardNumber}</td>
					<td><a href="<c:url value="/lostpetContent/${notice.boardNumber}" />"id="notice" class="notice">
					${notice.subtitle}${notice.title}<%-- (${notice.replyCount}) --%></a></td>
					<td>${notice.nickName}</td>
					<td>${notice.readCount}</td>
					<td>${notice.writeDate}</td>
					<td>${notice.likeCount}</td>
				</tr>
		</c:forEach>
		<!-- 일반게시판 글 (검색x) -->
		<c:if test="${searchKey == null}">
			<c:if test="${arrayList == null}"> <!-- 최신순 정렬 default -->
			<c:forEach var="lostpet" items="${lostpetList}">
				<tr>
					<td>${lostpet.boardNumber}</td>
					<td><a href="<c:url value="/lostpetContent/${lostpet.boardNumber}" />">
					[${lostpet.subtitle}]${lostpet.title}(${replyCount})</a></td>
					<td>${lostpet.nickName}</td>
					<td>${lostpet.readCount}</td>
					<td>${lostpet.writeDate}</td>
					<td>${lostpet.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'likeCount'}"> <!-- 추천순 정렬  -->
			<c:forEach var="lostpet" items="${lostpetList}">
				<tr>
					<td>${lostpet.boardNumber}</td>
					<td><a href="<c:url value="/lostpetContent/${lostpet.boardNumber}" />">
					[${board.subtitle}]${board.title}(${replyCount})</a></td>
					<td>${lostpet.nickName}</td>
					<td>${lostpet.readCount}</td>
					<td>${lostpet.writeDate}</td>
					<td>${lostpet.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'old'}"> <!-- 오래된순 정렬  -->
			<c:forEach var="lostpet" items="${lostpetList}">
				<tr>
					<td>${lostpet.boardNumber}</td>
					<td><a href="<c:url value="/lostpetContent/${lostpet.boardNumber}" />">
					[${lostpet.subtitle}]${lostpet.title}(${replyCount})</a></td>
					<td>${lostpet.nickName}</td>
					<td>${lostpet.readCount}</td>
					<td>${lostpet.writeDate}</td>
					<td>${lostpet.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'readCount'}"> <!-- 조회순 정렬  -->
			<c:forEach var="lostpet" items="${lostpetList}">
				<tr>
					<td>${lostpet.boardNumber}</td>
					<td><a href="<c:url value="/lostpetContent/${lostpet.boardNumber}" />">
					[${lostpet.subtitle}]${lostpet.title}(${replyCount})</a></td>
					<td>${lostpet.nickName}</td>
					<td>${lostpet.readCount}</td>
					<td>${lostpet.writeDate}</td>
					<td>${lostpet.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
		</c:if>
		<!-- 검색 글 -->
		<c:if test="${searchKey == 'keyword'}">
			<c:if test="${arrayList == null}"> <!-- 최신순 정렬 default -->
			<c:forEach var="lostpet" items="${lostpetList}">
				<tr>
					<td>${lostpet.boardNumber}</td>
					<td><a href="<c:url value="/lostpetContent/${lostpet.boardNumber}" />">
					[${lostpet.subtitle}]${lostpet.title}(${replyCount})</a></td>
					<td>${lostpet.nickName}</td>
					<td>${lostpet.readCount}</td>
					<td>${lostpet.writeDate}</td>
					<td>${lostpet.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'likeCount'}"> <!-- 추천순 정렬  -->
			<c:forEach var="lostpet" items="${lostpetList}">
				<tr>
					<td>${lostpet.boardNumber}</td>
					<td><a href="<c:url value="/lostpetContent/${lostpet.boardNumber}" />">
					[${lostpet.subtitle}]${lostpet.title}(${replyCount})</a></td>
					<td>${lostpet.nickName}</td>
					<td>${lostpet.readCount}</td>
					<td>${lostpet.writeDate}</td>
					<td>${lostpet.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'old'}"> <!-- 오래된순 정렬  -->
			<c:forEach var="lostpet" items="${lostpetList}">
				<tr>
					<td>${lostpet.boardNumber}</td>
					<td><a href="<c:url value="/lostpetContent/${lostpet.boardNumber}" />">
					[${lostpet.subtitle}]${lostpet.title}(${replyCount})</a></td>
					<td>${lostpet.nickName}</td>
					<td>${lostpet.readCount}</td>
					<td>${lostpet.writeDate}</td>
					<td>${lostpet.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'readCount'}"> <!-- 조회순 정렬  -->
			<c:forEach var="lostpet" items="${lostpetList}">
				<tr>
					<td>${lostpet.boardNumber}</td>
					<td><a href="<c:url value="/lostpetContent/${lostpet.boardNumber}" />">
					[${lostpet.subtitle}]${lostpet.title}(${replyCount})</a></td>
					<td>${lostpet.nickName}</td>
					<td>${lostpet.readCount}</td>
					<td>${lostpet.writeDate}</td>
					<td>${lostpet.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
		 </c:if> 
	</table>
	</div>
	
<!-- footer -->
<jsp:include page="/WEB-INF/view/include/footer.jsp" />
<!-- //footer -->	
</body>
</html>