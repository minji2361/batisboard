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

<!-- container -->
<div class ="container">
	<div>
		<center>
		<h2>멍냥 여행사</h2>
		<nav class="array">
			<a href="likeCount"><button type="button" class="btn btn-outline-secondary">추천순</button></a>
			&nbsp;&nbsp;
			<a href="petchat"><button type="button" class="btn btn-outline-secondary">최신순</button></a>
			&nbsp;&nbsp;
			<a href="past"><button type="button" class="btn btn-outline-secondary">오래된순</button></a>
			&nbsp;&nbsp;
			<a href="readCount"><button type="button" class="btn btn-outline-secondary">조회순</button></a>
		</nav>
		</center>
	</div>
	<div style='width:80px;float: right;'>
		<a href="petplaceWritePage"><button type="submit" class="btn btn-outline-secondary">글쓰기</button></a>
	</div>
	 <table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">글번호</th>
      <th scope="col">제목</th>
      <th scope="col">닉네임</th>
      <th scope="col">조회수</th>
      <th scope="col">작성시간</th>
      <th scope="col">추천수</th>
		</tr>
		<!-- 공지글 -->
		<c:forEach var="notice" items="${petplaceNotice}">
			<tr>
				<td>공지</td>
				<td>
					<a href="<c:url value="/petplaceContent/${notice.boardNumber}" />" id="notice" class="notice">
					${notice.subtitle}&nbsp;${notice.title}[${replyCount}]
					</a>
				</td>
				<td>${notice.nickName}</td>
				<td>${notice.readCount}</td>
				<td>${notice.writeDate}</td>
				<td>${notice.likeCount}</td>
			</tr>
		</c:forEach>
		<!-- //공지글 -->
		<!-- 일반 게시글 + 검색x -->
		<c:if test="${searchKey == null}">
			<c:if test="${arrayList == null}"> <!-- 최신순 정렬 default -->
				<c:forEach var="petplace" items="${petplaceList}" varStatus="status">
				<!-- 게시판 글 넘버링 varStatus="status" 하고 status.index+1 하면 하나씩 순서대로 넘버링 됨 -->
					<tr>
						<td>${status.index+1}</td>
						<td>
							<a href="<c:url value="/petplaceContent/${petplace.boardNumber}" />">
							[${petplace.subtitle}]&nbsp;${petplace.title}[${replyCount}]
							</a>
						</td>
						<td>${petplace.nickName}</td>
						<td>${petplace.readCount}</td>
						<td>${petplace.writeDate}</td>
						<td>${petplace.likeCount}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'likeCount'}"> <!-- 추천순 정렬 -->
				<c:forEach var="petplace" items="${petplaceList}" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td>
							<a href="<c:url value="/petplaceContent/${petplace.boardNumber}" />">
							[${petplace.subtitle}]&nbsp;${petplace.title}[${replyCount}]
							</a>
						</td>
						<td>${petplace.nickName}666</td>
						<td>${petplace.readCount}</td>
						<td>${petplace.writeDate}</td>
						<td>${petplace.likeCount}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'old'}"> <!-- 오래된순 정렬 -->
				<c:forEach var="petchat" items="${petplaceList}" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td>
							<a href="<c:url value="/petplaceContent/${petplace.boardNumber}" />">
							[${petplace.subtitle}]&nbsp;${petplace.title}[${replyCount}]
							</a>
						</td>
						<td>${petplace.nickName}777</td>
						<td>${petplace.readCount}</td>
						<td>${petplace.writeDate}</td>
						<td>${petplace.likeCount}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'readCount'}"> <!-- 조회순 정렬 -->
				<c:forEach var="petchat" items="${petplaceList}" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td>
							<a href="<c:url value="/petplaceContent/${pepetplacetchat.boardNumber}" />">
							[${petplace.subtitle}]&nbsp;${petplace.title}[${replyCount}]
							</a>
						</td>
						<td>${petplace.nickName}888</td>
						<td>${petplace.readCount}</td>
						<td>${petplace.writeDate}</td>
						<td>${petplace.likeCount}</td>
					</tr>
				</c:forEach>
			</c:if>
		</c:if>
		<!-- //일반 게시글 + 검색x -->
		<!-- 일반 게시글 + 검색0 -->
		<c:if test="${searchKey == 'keyword'}">
			<c:if test="${arrayList == null}"> <!-- 최신순 정렬 default -->
				<c:forEach var="petplace" items="${petplaceList}" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td>
							<a href="<c:url value="/petplaceContent/${petplace.boardNumber}" />">
							[${petplace.subtitle}]&nbsp;${petplace.title}[${replyCount}]
							</a>
						</td>
						<td>${petplace.nickName}</td>
						<td>${petplace.readCount}</td>
						<td>${petplace.writeDate}</td>
						<td>${petplace.likeCount}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'likeCount'}"> <!-- 추천순 정렬 -->
				<c:forEach var="petplace" items="${petplaceList}" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td>
							<a href="<c:url value="/petplaceContent/${petplace.boardNumber}" />">
							[${petplace.subtitle}]&nbsp;${petplace.title}[${replyCount}]
							</a>
						</td>
						<td>${petplace.nickName}</td>
						<td>${petplace.readCount}</td>
						<td>${petplace.writeDate}</td>
						<td>${petplace.likeCount}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'old'}"> <!-- 오래된순 정렬 -->
				<c:forEach var="petchat" items="${petplaceList}" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td>
							<a href="<c:url value="/petplaceContent/${petplace.boardNumber}" />">
							[${petplace.subtitle}]&nbsp;${petplace.title}[${replyCount}]
							</a>
						</td>
						<td>${petplace.nickName}</td>
						<td>${petplace.readCount}</td>
						<td>${petplace.writeDate}</td>
						<td>${petplace.likeCount}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'readCount'}"> <!-- 조회순 정렬 -->
				<c:forEach var="petchat" items="${petplaceList}" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td>
							<a href="<c:url value="/petchatContent/${petplace.boardNumber}" />">
							[${petplace.subtitle}]&nbsp;${petplace.title}[${replyCount}]
							</a>
						</td>
						<td>${petplace.nickName}</td>
						<td>${petplace.readCount}</td>
						<td>${petplace.writeDate}</td>
						<td>${petplace.likeCount}</td>
					</tr>
				</c:forEach>
			</c:if>
		</c:if>
		<!-- //일반 게시글 + 검색0 -->
	</table>
	</div>
	<div class="pagingNum"></div>
<!-- //container -->

<!-- footer -->
<jsp:include page="/WEB-INF/view/include/footer.jsp" />
<!-- //footer -->
</body>
</html>










