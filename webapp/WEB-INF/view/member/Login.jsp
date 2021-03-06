<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/view/include/header.jsp" />
<title>로그인</title>
</head>
<body>
<div style="margin-top: 50px;">
<center><h2>로그인</h2></center>
	<form:form action="enterLogin" method="post" id="loginForm" name="loginForm"
		commandName="loginCommand" onsubmit="return inputCheck()">

		<div class="container" style='width: 500px; float: center;'>
			<label for="exampleInputEmail1">이메일</label>
			<form:input class="form-control" name="email" id="exampleInputEmail1"
				path="email" aria-describedby="emailHelp" placeholder="Enter email" />
			<label><form:checkbox id="rememberEmail" path="rememberEmail" />이메일기억하기</label>
		</div>
		<div class="container"
			style='width: 500px; float: center; margin-bottom: 20px;'>
			<label for="exampleInputPassword1">비밀번호</label>
			 <form:input path="password"
				type="password" class="form-control" name="password"
				id="exampleInputPassword1" placeholder="Password"/>
		</div>

		<center>
			<input type="submit" class="btn btn-secondary" value="로그인">
			<a href="joinPage"><button type="button" class="btn btn-secondary">회원가입</button></a>
			<a href="FindPwd"><button type="button" class="btn btn-secondary">아이디/비밀번호찾기</button></a>

		</center>
	</form:form>
	
		<script>
				var email = document.loginForm.email.value;
				var password = document.loginForm.password.value;
					console.log(email);
					console.log(password);
					
					function inputCheck(){
						if(document.loginForm.email.value==""){
							alert("이메일을 입력해 주세요.");
							document.loginForm.email.focus();
							return false;
						}
						
						if(document.loginForm.password.value == "") {
							alert("비밀번호를 입력해 주세요.");
							document.loginForm.password.focus();
							return false;
						}
						
					}

			</script>
	</div>
</body>
</html>