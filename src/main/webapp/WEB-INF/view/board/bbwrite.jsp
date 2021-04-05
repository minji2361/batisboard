<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<!-- jquery -->﻿
<script type="text/javascript" src="jquery-3.4.1.min.js" ></script>
<!-- ckeditor 4 -->
<link rel="stylesheet" href="${path}/resource/ckeditor/contents.css">
<!-- <script src="https://cdn.ckeditor.com/4.12.1/standard-all/ckeditor.js"></script> -->
<script type="text/javascript" src="${path}/resource/ckeditor/ckeditor.js" ></script>﻿
<meta charset="UTF-8">
<title>BBOARD</title>
</head>
<body>
	<form method="post" name="form" enctype="multipart/form-data">
		<table border="1">
		<c:if test="${id == null}">
			<tr>
				<td>글쓴이&nbsp;</td>
				<td><input type="text" name="writer" /></td>
			</tr>
			<tr>
				<td>제목&nbsp;</td>
				<td><input type="text" name="title" /></td>
			</tr>
			<tr>
				<td>내용&nbsp;</td>
				<td>
				<textarea id="content" rows=10  name="content"></textarea>
				<script >
				CKEDITOR.replace('content'); // 에디터로 생성
				</script >
				</td>
			</tr>
			<tr>
				<td>파일&nbsp;</td>
				<td><input type="file" name="file" /></td>
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
				<td>글쓴이&nbsp;</td>
				<td><input type="text" name="writer" value="${board.writer}"/></td>
			</tr>
			<tr>
				<td>제목&nbsp;</td>
				<td><input type="text" name="title" value="${board.title}"/></td>
			</tr>
			<tr>
				<td>내용&nbsp;</td>
				<td><textarea name="content" rows="13" cols="50">${board.content}</textarea></td>
			</tr>
			<tr>
				<td>파일&nbsp;</td>
				<td class="file"><a href="#"> 
					</a>
				</td>
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