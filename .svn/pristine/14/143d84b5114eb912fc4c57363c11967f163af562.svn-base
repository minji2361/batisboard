<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/view/include/header.jsp" />
<title>사랑하냥? 사랑하개!</title>
</head>
<body>
	
	
	
<!-- select userNumber count  -->
	<div class ="container" style='margin-top: 50px'>
	<h1>관리자 님의 마이페이지</h1>
	<form name="Adminpage" action="Adminpage" method="post">
		<table class="table table-hover" >
				<tr>
				<th><b>유저 찾기</b></th>
		
               		 <th><select class="custom-select" name="option" id="option">
               		 <option value="email">이메일</option> 
               		 <option value="nickname">닉네임</option> 
				</select>
				<td><input class="form-control" type="text" name = "searchText" placeholder = "내용을 입력 해주세요."/></td>
				<td><input type="submit" class="btn btn-outline-info" value="찾아보기"></td>
				</tr>
				
		</table>
				<table class="table table-hover">
				<tr>
						<th>사용자번호</th>
						<th>아이디 (이메일)</th>
						<th>이름</th>
						<th>닉네임</th>
						<th>반려동물 종류</th>
						<th>가입 날짜</th>
						<th>탈퇴여부</th>
				</tr>
				<c:forEach items="${showNewOption}" var="list" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${list.email}</td>
					<td>${list.name}</td>
					<td>${list.nickName}</td>
					<td>${list.pet}</td>
					<td>${list.joinDate}</td>
					<td>${list.memberStatus}</td>
				</tr>
				</c:forEach>
		</table>	
	</form>
			<h2>작성된 글</h2>	<!-- select boardNumber count -->

		<table class="table table-hover">
				<tr>
						<th>글 번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>닉네임(작성자)</th>
						<th>조회수</th>
						<th>작성시간</th>
						<th>추천수</th>
				</tr>
				<c:forEach items="${showNewStatus}" var="list" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${list.type}</td>
					<td>${list.title}</td>
					<td>${list.nickName}</td>
					<td>${list.readCount}</td>
					<td>${list.writeDate}</td>
					<td>${list.likeCount}</td>
				</tr>
				</c:forEach>
		</table>	
		
			<h2>삭제된 글 </h2>	<!-- select boardNumber delect count -->
		
		<table class="table table-hover">
				<tr>
						<th>글 번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>닉네임(작성자)</th>
						<th>조회수</th>
						<th>작성시간</th>
						<th>추천수</th>
				</tr>
				<c:forEach items="${showNewDelect}" var="list" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${list.type}</td>
					<td>${list.title}</td>
					<td>${list.nickName}</td>
					<td>${list.readCount}</td>
					<td>${list.writeDate}</td>
					<td>${list.likeCount}</td>
				</tr>
				</c:forEach>
		</table>	
		</div>
</body>
</html>