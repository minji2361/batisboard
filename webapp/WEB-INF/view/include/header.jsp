<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	String email = (String)(session.getAttribute("email")); 
%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<title>사랑하냥? 사랑하개!</title>
<link href="<%=request.getContextPath() %>/resources/css/bootstrap.min.css" rel="stylesheet">
<style>
	body header #navigator .title{
		margin: auto;
		width: 600px;
	}
	body header #navigator{
		margin: auto;
		width: 800px;
	}
/* 	body header #search{
		margin-top: 25px;
		margin-right: auto;
		margin-bottom: 15px;
		margin-left: auto; 
		width: 600px;
	} */

</style>
</head>
<body>
<!-- header -->
<header>

		
	<div style='width:250px;float: right; margin-top:20px;'>
	   	<% if(email == null) { %>
	    <a href="/petBoard/loginPage"><button type="button" class="btn btn-secondary">로그인</button></a>
	   <a href="/petBoard/joinPage"><button type="button" class="btn btn-secondary">회원가입</button></a>
	    <% } else { %>
	    <h5>${nickName}${message} 환영합니다.</h5>
	    <a href="/petBoard/logout"><button type="button" class="btn btn-secondary">로그아웃</button></a>
	    <a href="/petBoard/mypageaccess"><button type="button" class="btn btn-secondary">마이페이지</button></a>
	    <% } %>
	</div>
	
<div style="text-align : center; margin-left: 250px;">
		<h1 class="title">
			<a href="/petBoard/main"><img src="${path}/resources/img/008.png"></a>
		</h1>
	</div>


<!-- 흰색 바 -->
<form action="">
 <nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">메뉴</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor03" aria-controls="navbarColor03" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarColor03">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="/petBoard/main">홈
         <!--  <span class="sr-only">(current)</span> -->
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/petBoard/itemboard">멍냥잡화점</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/petBoard/lostpetboard">구해줘펫즈</a>
      </li>
      <li class="nav-item">
         <a class="nav-link" href="/petBoard/petplaceboard">멍냥여행사</a>
      </li>
      <li class="nav-item">
        <!-- <a class="nav-link" href="#">동물병원</a> -->
        <a class="nav-link" href="/petBoard/Hospitalboard">멍냥치료소</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/petBoard/petchat">집사들의 수다</a>
      </li> 
      <li>
      </li>  
    </ul>
   </div>
   </form>
       
    <form class="form-inline my-2 my-lg-0" action="search">
	
    <select class="custom-select" id="searchType" name="searchType" onchange="javascript:change();">
				<option value="title">제목</option>
				<option value="nickname">작성자</option>
				<option value="content">내용</option>
			</select>
      <input class="form-control mr-sm-2" name="searchText" placeholder="검색">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">검색</button>
    </form>
</header>
<!-- //header -->


