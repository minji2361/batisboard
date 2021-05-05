<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<title>사랑하냥? 사랑하개!</title>
<link href="<%=request.getContextPath() %>/resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/view/include/header.jsp" />


					<table class= "table table=hover">
					<thead>
				<tr>
						<th>게시글번호</th>
						<th>제목</th>
						<th>닉네임</th>
						<th>게시판종류</th>
						<th>내용</th>
						<th>조회수</th>
						<th>작성일</th>
				</tr>

				<c:forEach items="${showNewsearchType}" var="list" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
									<td>
					<c:choose>
						<c:when test="${fn:contains(list.notice, 'y')}">
							<a href="Hospitalcontent?boardNumber=${list.boardNumber}" id="notice" class="notice">${list.subtitle}${list.title}</a>
						</c:when>
						<c:otherwise>
							<a href="Hospitalcontent?boardNumber=${list.boardNumber}">${list.title}</a>
						</c:otherwise>
					</c:choose> 
				</td>	
					<td>${list.nickName}</td>
					
					<td>
					
					<c:choose>
						<c:when test="${list.type eq 'petchat'}">
							집사들의 수다
						</c:when>

						<c:when test="${list.type eq 'hospital'}">
							멍냥 치료소
						</c:when>
					
						<c:when test="${list.type eq 'item'}">
							멍냥 잡화점
						</c:when>
					
						<c:when test="${list.type eq 'lostpet'}">
							구해줘 펫즈	
						</c:when>
					
						<c:when test="${list.type eq 'petplace'}">
							멍냥 여행사
						</c:when>
					</c:choose>
					
					</td>
					
					<td>${list.content}</td>
					<td>${list.readCount}</td>
					<td>${list.writeDate}</td>		
				</tr>				
				</c:forEach>
		</thead>		
		</table>
		
	<!-- footer -->
		<jsp:include page="/WEB-INF/view/include/footer.jsp" />
	<!-- //footer -->

</body>
</html>