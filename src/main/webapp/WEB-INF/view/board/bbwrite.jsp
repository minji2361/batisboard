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
		<c:if test="${id == null}">
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer" /></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" /></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content"></textarea></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<input type="submit" value="등록하기" onClick="javascript: form.action='insert';">
					<input type="submit" value="뒤로가기" onClick="javascript: form.action='main';">
				</td>
			</tr>
		</c:if>
		<c:if test="${id != null}">
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer" value="${board.writer}"/></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value="${board.title}"/></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content" >${board.content}</textarea></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<input type="submit" value="수정하기" onClick="javascript: form.action='update?id=${board.id}';">
					<input type="submit" value="뒤로가기" onClick="javascript: form.action='main';">
				</td>
			</tr>
		</c:if>
		</table>
	</form>
</body>
</html>