<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp" %>
<title>사랑하냥? 사랑하개!</title>
</head>
<body>
<style> 
.centered { display: table; margin-left: auto; margin-right: auto; } 
</style>
<div class="centeringContainer"  style='float: center; margin-top: 50px'>
 <span class="centered">
 <form action="mypageaccess.do"  method="post">
 <center><h2>마이페이지</h2></center>
 	
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호를 입력해주세요.</label>
      <input type="password" class="form-control" name = "enterpassword" id="password" placeholder="Password" required/>${msg}
    </div>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    
&nbsp;&nbsp;

  		<input type="submit" value="확인" class="btn btn-secondary" />
</form>



</span>
</div>

</body>
</html>