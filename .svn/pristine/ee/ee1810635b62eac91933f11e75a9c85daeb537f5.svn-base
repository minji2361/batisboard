<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<title>Insert title here</title>
</head>
<body>
	<div style="margin-top: 50px;">
	<form action="editPassword" method="post" onsubmit="return checkPwdExist();">
		<table style="margin-left: auto; margin-right: auto;">

			<tr>
				<td>기존 비밀번호</td>
				<td><input type="password" class="form-control" name="authpassword" id="authpassword"></td>
				<td><button type="button"  class="btn btn-secondary" onclick='checkPwdExist()'>확인</button>
				</td>
			</tr>
			<tr>
				<td>새비밀번호</td>
				<td><input type="password" class="form-control" id="password" name="password">
				</tr>
				<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" class="form-control" id="password1"></td>
				<td><button type="button" class="btn btn-secondary" onclick='test()'>확인</button></td>
				</tr>
				<tr>				
				<td><input type="submit" class="btn btn-secondary" value="변경하기"></td></tr>
		</table>
	</form>
	</div>
				
  <script>
  //기존 비밀번호 확인
  function checkPwdExist(){
		var authpassword = $("#authpassword").val()
		
		if(authpassword.length == 0){
			alert('비밀번호를 입력해주세요')
			return
		}
		
		$.ajax({
			url : 'checkpwd',
			type : 'post',
			dataType : 'text',
			data : 'authpassword='+$('#authpassword').val(),
			success : function(result){
				if(result.trim() == 'true'){
					alert('비밀번호가 확인되었습니다')					
				} else {
					alert('비밀번호가 틀렸습니다')					
				}
			}
		})
	}


	//비밀번호 확인 후 변경되게
  function submitCheck() {

	  checkPwd = $("#checkPwd").val();

	   if(checkPwd==true && pwd==true) {
		   alert('비밀번호가 변경 되었습니다')
	   return true;

	 }

	  return false;

	}

  	//비밀번호 위아래 같은지
    function test() {
      var p1 = document.getElementById('password').value;
      var p2 = document.getElementById('password1').value;
      if( p1 != p2 ) {
        alert("비밀번호가 일치 하지 않습니다");
        return pwd=false;
      } else{
        alert("비밀번호가 일치합니다");
        return pwd=true;
      }
    
    }
    
  </script>
</body>
</html>