<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>사랑하냥? 사랑하개!</title>
<style>
	.message {
		color:red;
	}
	a.toHome {
    color: #FFFFFF;
    text-decoration: none;
    background-color: transparent
	}
	
	a:hover.toHome {
	    color: #FFFFFF;
	    text-decoration: none;
	}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="/WEB-INF/view/include/header.jsp" />
<!-- //header -->

<!-- container -->
<div style="margin-top: 50px;">
<center>
<h2>회원가입</h2><br>
<form name="joinForm" action="joinUser" method="post" onsubmit="return inputCheck()">
	<table>
		<tr>
			<td>아이디(이메일)</td>
			<td><input type="text" name="email" id="email" value="${email}" placeholder="이메일 입력"></td>
			<td>
				<button type="button" class="btn btn-secondary" onclick='checkEmailExist()'>이메일 중복검사</button>
				<input class="btn btn-secondary" type="submit" value="이메일 인증하기" onClick="javascript: form.action='joinPw';">
			</td>
		</tr>
		<%-- <tr>
			<td></td>
			<td><p class="message">${emailMessage}</p></td>
			<td>
				<input type="hidden" id="emailduple" name="emailduple" value="${emailCheck}">
			</td>
		</tr> --%>
		<tr>
			<td>이메일 인증</td>
			<td><input type="text" name="emailverifyNum" placeholder="인증번호 입력" /></td>
			<td>
				<input type="button" class="btn btn-secondary" value="인증 확인" onClick="emailCheck()">
				<input type="hidden" id="emailVerify" name="emailVerify" value="n">				
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="password" placeholder="비밀번호 입력"/></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="passwordcheck" placeholder="비밀번호 확인"/></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="name" placeholder="이름 입력"/></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><input type="text" name="nickName" id="nickName" placeholder="닉네임 입력" value="${nickName}"/></td>
			<td>
				<button type="button" class="btn btn-secondary" onclick='checkNickName()'>닉네임 중복검사</button>
			</td>
			
		</tr>
		<%-- <tr>
			<td></td>
			<td><p class="message">${nickNameMessage}</p></td>	
		</tr> --%>
		<tr>
			<td>키우는 반려동물</td>
			<td>
				<input type="radio" name="pet" value="강아지" checked="checked"> 강아지
				<input type="radio" name="pet" value="고양이"> 고양이
				<input type="radio" name="pet" value="없음"> 없음
			</td>
		</tr>
	</table><br>		
			<input class="btn btn-secondary" type="submit" value="회원가입">
			<button class="btn btn-secondary"><a href="/petBoard/main" class="toHome">홈으로</a></button>
	</form>
</center>
</div>

<script>	
// 이메일 중복 검사 ajax
	function checkEmailExist(){
		var email = $("#email").val()
		
		if(email.length == 0){
			alert('이메일을 입력해주세요')
			return
		}
		
		$.ajax({
			url : '${path}/checkEmail/' + email,
			type : 'get',
			dataType : 'text',
			success : function(result){
				if(result.trim() == 'true'){
					alert('사용할 수 있는 이메일입니다')					
				} else {
					alert('사용할 수 없는 이메일입니다')					
				}
			}
		})
	}
	
//닉네임 중복검사 ajax
	function checkNickName(){
		var nickName = $("#nickName").val()
		
		if(nickName.length == 0){
			alert('닉네임을 입력해주세요')
			return
		}
		
		$.ajax({
			url : '${path}/checkNickName/' + nickName,
			type : 'get',
			dataType : 'text',
			success : function(result){
				if(result.trim() == 'true'){
					alert('사용할 수 있는 닉네임입니다')					
				} else {
					alert('사용할 수 없는 닉네임입니다')					
				}
			}
		})
	}

	function emailCheck(){
		console.log("emailVerify:" + emailVerify.value);
    	var keyNum = "${key}";
		if(document.joinForm.emailverifyNum.value != keyNum){
			alert("인증번호를 확인해 주세요.");
			document.joinForm.emailverifyNum.focus();
			return;
		}
		else {
			if(document.joinForm.emailverifyNum.value == keyNum) { 
				alert("인증되었습니다.");
				document.joinForm.emailVerify.value='y';
				console.log("emailVerify:" + emailVerify.value);
				return;
				} else{
					alert("잘못된 인증번호 입니다.");
					return;
				}
		}
	}
	
	function inputCheck(){
		if(document.joinForm.email.value==""){
			alert("이메일을 입력해 주세요.");
			document.joinForm.email.focus();
			return false;
		}
		if(document.joinForm.emailduple.value==1){
			alert("이메일 중복검사를 해주세요.");
			document.joinForm.email.focus();
			return false;
		}
		if(document.joinForm.emailstatus.value == "n"){
			alert("이메일 인증을 해주세요.");
			document.joinForm.emailverify.focus();
			return false;
		}
		if(document.joinForm.password.value == "") {
			alert("비밀번호를 입력해 주세요.");
			document.joinForm.password.focus();
			return false;
		}
		if(document.joinForm.passwordcheck.value == ""){
			alert("비밀번호를 확인해 주세요.");
			document.joinForm.passwordcheck.focus();
			return false;
		}
		if(document.joinForm.password.value != document.joinForm.passwordcheck.value){
			alert("비밀번호 확인을 다시 해주세요.");
			return false;
		}
		if(docuemnt.joinForm.username.value == ""){
			alert("이름을 입력해 주세요.");
			document.joinForm.username.focus();
			return false;
		}
		if(document.joinForm.nickname.value==""){
			alert("닉네임을 입력해 주세요.");
			document.joinForm.nickname.focus();
			return false;
		}
		var chk_radio = document.getElementsByName('pet');
		var pet_type=null;
		for(var i=0;i<ch_radio.length;i++){
			if(chk_radio[i].checked==true){
				pet_type=chk_radio[i].value;
			}
		}
		if(pet_type==null){
			alert("반려동물을 선택해 주세요.");
			document.joinForm.name.focus();
			return false;
		}
	}
</script>
<!-- //container -->

<!-- footer -->
<jsp:include page="/WEB-INF/view/include/footer.jsp" />
<!-- //footer -->
</body>
</html>