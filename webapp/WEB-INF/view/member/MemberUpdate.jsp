<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style>
.map_wrap, .map_wrap * {
	margin:0;
	padding:0;
	font-family:'Malgun Gothic',dotum,'돋움',sans-serif;
	font-size:12px;
}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{
	color:#000;
	text-decoration: none;
}
.map_wrap {
	position:relative;
	width:100%;
	height:500px;}
#menu_wrap {
	position:absolute;
	top:0;
	left:0;
	bottom:0;
	width:250px;
	margin:10px 0 30px 10px;
	padding:5px;
	overflow-y:auto;
	background:rgba(255, 255, 255, 0.7);
	z-index: 1;
	font-size:12px;
	border-radius: 10px;
}
.bg_white {
	background:#fff;
}
#menu_wrap hr {
	display: block; 
	height: 1px;
	border: 0; 
	border-top: 2px solid #5F5F5F;
	margin:3px 0;
}
#menu_wrap .option{
	text-align: center;
}
#menu_wrap .option p {
	margin:10px 0;
}  
#menu_wrap .option button {
	margin-left:5px;
}
#placesList li {
	list-style: none;
}
#placesList .item {
	position:relative;
	border-bottom:1px solid #888;
	overflow: hidden;
	cursor: pointer;
	min-height: 65px;
}
#placesList .item span {
	display: block;
	margin-top:4px;
}
#placesList .item h5, #placesList .item .info {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
#placesList .item .info{
	padding:10px 0 10px 55px;
}
#placesList .info .gray {
	color:#8a8a8a;
}
#placesList .info .jibun {
	padding-left:26px;
	background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) 
	no-repeat;
}
#placesList .info .tel {
	color:#009900;
}
#placesList .item .markerbg {
	float:left;
	position:absolute;
	width:36px; 
	height:37px;
	margin:10px 0 0 10px;
	background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) 
	no-repeat;
}
#placesList .item .marker_1 {
	background-position: 0 -10px;
}
#placesList .item .marker_2 {
	background-position: 0 -56px;
}
#placesList .item .marker_3 {
	background-position: 0 -102px
}
#placesList .item .marker_4 {
	background-position: 0 -148px;
}
#placesList .item .marker_5 {
	background-position: 0 -194px;
}
#placesList .item .marker_6 {
	background-position: 0 -240px;
}
#placesList .item .marker_7 {
	background-position: 0 -286px;
}
#placesList .item .marker_8 {
	background-position: 0 -332px;
}
#placesList .item .marker_9 {
	background-position: 0 -378px;
}
#placesList .item .marker_10 {
	background-position: 0 -423px;
}
#placesList .item .marker_11 {
	background-position: 0 -470px;
}
#placesList .item .marker_12 {
	background-position: 0 -516px;
}
#placesList .item .marker_13 {
	background-position: 0 -562px;
}
#placesList .item .marker_14 {
	background-position: 0 -608px;
}
#placesList .item .marker_15 {
	background-position: 0 -654px;
}
#pagination {
	margin:10px auto;text-align: center;
}
#pagination a {
	display:inline-block;margin-right:10px;
}
#pagination .on {
	font-weight: bold; 
	cursor: default;
	color:#777;
}
</style>
<meta charset="UTF-8">
<title>사랑하냥? 사랑하개!</title>
<!-- header -->
<jsp:include page="/WEB-INF/view/include/header.jsp" />
<!-- //header -->
</head>
<body>
<center>
<form action="../updateMember/${memberNumber}" method="post">
<h2>${memberVo.nickName}님의 정보</h2>
	<table>
	<form:form commandName="memberVo" method="POST">
		<tr>
			<td>아이디(이메일)</td>		
			<td>${memberVo.email}</td>
		</tr>
		<tr>
			<td>가입일</td>
			<td>${memberVo.joinDate}</td>
		</tr>
		<tr>
				<td>이름</td>
			<td>${memberVo.name}</td>
		</tr>
		<tr>
				<td><form:label path="nickName">닉네임</form:label></td>
				<td><form:input path="nickName" />
					<form:errors path="nickName" /></td>
				<td><button type="button" class="btn btn-primary" onclick='checkNickName()'>닉네임 중복검사</td>
		</tr>
		<tr>
			<td>키우는 반려동물</td>
			<td><input type="radio" id ="dog" name="pet" value="강아지"> 강아지
				<input type="radio" id ="cat" name="pet" value="고양이" > 고양이
				<input type="radio" id ="none" name="pet" value="없음"> 없음				
			</td>
		</tr>	
		</form:form>
	</table>
	<div>
		<input type="submit" value="수정하기" class="btn btn-secondary my-2 my-sm-0">
		<a href="../memberpage/${memberNumber}"><input type="button" value="뒤로가기" class="btn btn-secondary my-2 my-sm-0"></a>
	</div>
	</form>
	</center>
	
	<script>
	//닉네임 중복검사 ajax
	function checkNickName(){
		var nickName = $("#nickName").val()
		
		if(nickName.length == 0){
			alert('닉네임을 입력해주세요');
			return
		}
		
		$.ajax({
			url : '${path}/checkNickName/' + nickName,
			type : 'get',
			dataType : 'text',
			success : function(result){
				if(result.trim() == 'true'){
					alert('사용할 수 있는 닉네임입니다');					
				} else {
					alert('사용할 수 없는 닉네임입니다');					
				}
			}
		})
	}
	</script>
	
	<!-- <script>
		/* var MemberVo = "${memberVo.pet}";
		switch(MemberVo){
		case "강아지":
			document.getElementById("dog").checked = true;;
		break;
		case "고양이":
			document.getElementById("cat").checked = true;;
		break;
		case "없음":
			document.getElementById("none").checked = true;;
			break;
		} */
		
	<!-- 	var checkedPet = "강아지";
		$('input:radio[name=pet]:input[value="강아지"]').attr("checked", true);
	</script> -->
</body>
</html>