<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String id = (String)(session.getAttribute("loginId")); %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
</head>
<body>
<!-- header -->
<header>
	<div>
		<h1 class="title"><a href=""><img src="${path}/resource/img/006.png"></a></h1>
		<nav class="menu">
			&nbsp;|&nbsp;
			<input type="button" value="멍냥 잡화점" onClick="javascript: form.action='#';"> &nbsp;|&nbsp;
			<input type="button" value="유기동물" onClick="javascript: form.action='#';"> &nbsp;|&nbsp;
			<input type="button" value="멍냥 여행사" onClick="javascript: form.action='#';"> &nbsp;|&nbsp;
			<input type="button" value="동물병원" onClick="javascript: form.action='#';"> &nbsp;|&nbsp;
			<input type="button" value="집사들의 수다" onClick="javascript: form.action='#';">&nbsp;|&nbsp;
			<% if(id == null) { %>
			<input type="button" value="로그인" onClick="javascript: form.action='#';">&nbsp;|&nbsp;
			<input type="button" value="회원가입" onClick="javascript: form.action='#';">&nbsp;|&nbsp;
			<% } else { %>
			<input type="button" value="마이페이지" onClick="javascript: form.action='#';">&nbsp;|&nbsp;
			<input type="button" value="로그아웃" onClick="javascript: form.action='#';">&nbsp;|&nbsp;
			<% } %>
		</nav>
	</div>
	<div>
		<form>
			<select class="searchType" id="searchType" name="searchType">
				<option value="title">제목</option>
				<option value="nickname">작성자</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="searchKey" />
			<input type="submit" value="검색" onClick="javascript: form.action='#';"><br>
			<div class="areaRadio">
				<input type="radio" id="all" value="전체" checked>
				<label for="all">전체</label>
				<input type="radio" id="seoul" value="서울">
				<label for="seoul">서울</label>
				<input type="radio" id="incheon" value="인천">
				<label for="incheon">인천</label>
				<input type="radio" id="gwangju" value="광주">
				<label for="gwangju">광주</label>
				<input type="radio" id="dageu" value="대구">
				<label for="dageu">대구</label>
				<input type="radio" id="dajeon" value="대전">
				<label for="dajeon">대전</label>
				<input type="radio" id="busan" value="부산">
				<label for="busan">부산</label>
				<input type="radio" id="ulsan" value="울산">
				<label for="ulsan">울산</label><br>
				<input type="radio" id="gyeongi" value="경기">
				<label for="gyeongi">경기</label>
				<input type="radio" id="gangone" value="강원">
				<label for="gangone">강원</label>
				<input type="radio" id="cheonam" value="충남">
				<label for="cheonam">충남</label>
				<input type="radio" id="cheonpuk" value="충북">
				<label for="cheonpuk">충북</label>
				<input type="radio" id="gyengnam" value="경남">
				<label for="cheonpuk">경남</label>
				<input type="radio" id="gyengpuk" value="경북">
				<label for="cheonpuk">경북</label>
				<input type="radio" id="joennam" value="전남">
				<label for="cheonpuk">전남</label>
				<input type="radio" id="joenpuk" value="전북">
				<label for="cheonpuk">전북</label>
				<input type="radio" id="jeju" value="제주">
				<label for="jeju">제주</label>
			</div>			
		</form>
	</div>
</header>
<!-- //header -->
</body>
</html>
