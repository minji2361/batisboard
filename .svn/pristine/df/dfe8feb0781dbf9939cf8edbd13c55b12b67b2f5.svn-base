<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/view/include/header.jsp" />
<title>로그인</title>
</head>
<body>
	<form action="enterLogin" method="post" id="loginForm">
	<div class ="container" style='width:500px;float: center; margin-top: 50px;'>
	<h2>로그인</h2>
		<!-- <table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="email"></td>
				<td><input type="checkbox">아이디 기억하기</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="password"></td>
			</tr> -->
      <label for="exampleInputEmail1">이메일</label>
      <input type="email" class="form-control" name="email" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
      <td><input type="checkbox">이메일 기억하기</td>
  	  </div>
 		 <div class ="container" style='width:500px;float: center; margin-bottom: 20px;'>
     	 <label for="exampleInputPassword1">비밀번호</label>
      	<input type="password" class="form-control" name="password" id="exampleInputPassword1" placeholder="Password">
   		 </div>
			
			<center>
			<button type="submit" class="btn btn-secondary" onClick="javascript: location.href='#';">로그인</button>
	        <button type="button" class="btn btn-secondary" onClick="javascript: location.href='#';">회원가입</button>
	        <a href="FindPwd"><button type="button" class="btn btn-secondary" >아이디/비밀번호찾기</button></a>
				<!-- <td>
				<input type="submit" value="로그인"  /> 
				<input type="button" value="회원가입" /> 
				<input type="button" value="아이디/비밀번호찾기" />
				</td> -->
			</center>
		</table>
			<script>
				var email = document.loginForm.email.value;
				var password = document.loginForm.password.value;
					console.log(email);
					console.log(password);
			</script>
	</form>
</body>
</html>