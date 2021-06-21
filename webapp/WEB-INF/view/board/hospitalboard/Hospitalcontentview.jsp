<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/view/include/header.jsp" />
<title>사랑하냥? 사랑하개!</title>
</head>
<body>
<table class="table table-hover">
<thead>
    <tr>
    	<th scope="col" width="10%">제목</th>
    	<td>${showNewSelect.title}</td>
	</tr>
	 <tr>
    	<th scope="col" width="10%">작성자</th>
    	<td>${showNewSelect.nickName}</td>
	</tr>
	<tr>
		<th scope="col">내용</th>
		<td>${showNewSelect.content}</td>
	</tr>
</thead>
</table>
		<div style="float:right;">
			<input type="submit" value="수정하기" onClick="javascript: form.action='../lostpetEdit/${boardNumber}';" class="btn btn-secondary my-2 my-sm-0"> 
			<input type="submit" value="삭제하기" onClick="javascript: form.action='#';" class="btn btn-secondary my-2 my-sm-0"> 
		    <input type="submit" value="목록" onClick="javascript: form.action='../lostpetboard';" class="btn btn-secondary my-2 my-sm-0">
		</div>
  	<!-- footer -->
		<jsp:include page="/WEB-INF/view/include/footer.jsp" />
	<!-- //footer -->
	
</body>
</html>