<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BBOARD</title>
</head>
<body>
	<form method="post" name="form">
		<table border="1">
			<tr>
				<td>글쓴이</td>
				<td>${board.writer}</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>${board.title}</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>${board.content}</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<input type="submit" value="수정하기" onClick="javascript: form.action='write?id=${board.id}';">
					<input type="submit" value="삭제하기" onClick="javascript: form.action='delete';">
					<input type="submit" value="뒤로가기" onClick="javascript: form.action='main';">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>