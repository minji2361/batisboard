<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp" %>
<title>사랑하냥? 사랑하개!</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
		$(document).ready(function(){
			// 취소
			$(".cencle").on("click", function(){
				
				location.href = "/";
						    
			})
		
			$("#submit").on("click", function(){
				if($("#password").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#password").focus();
					return false;
				}	
			});
			
				
			
		})
	</script>


</head>
<body>
<style> 
.centered { display: table; margin-left: auto; margin-right: auto; } 
</style>
<div class="centeringContainer" style="margin-top: 50px;">
 <span class="centered">
 <center><h2>회원 탈퇴</h2></center>
 <form action="memberdelete" method="post">
  <div class="form-group">
      <label for="exampleInputPassword1">비밀번호를 입력해주세요.</label>
      <input type="password" class="form-control" name="enterpassword" id="password" placeholder="Password">
    </div>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    
&nbsp;&nbsp;
<button type="submit" class="btn btn-secondary" id = "submit">확인</button>
<a href="main"><button type="button" class="btn btn-secondary">취소</button></a>
</form>
</span>
</div>
<div>
				<c:if test="${msg == false}">
					비밀번호가 맞지 않습니다.
				</c:if>
			</div>
</body>
</html>