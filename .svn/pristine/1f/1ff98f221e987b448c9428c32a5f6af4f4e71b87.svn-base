<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사랑하냥? 사랑하개!</title>
</head>
<body>
 

  <center>
	<table>
				<tr>
					<td>글쓴이&nbsp;</td>
					<td><input type="text" name="writer" value="${boardVo.nickName}" /></td>
				</tr>
				<tr>
					<td>제목&nbsp;</td>
					<td><input class="form-control mr-sm-2" type="text" name="title" value=">${boardVo.subtitle}${boardVo.title}" style="width:1000px;"/></td>
				</tr>
				<tr>
					<!--  <td>내용&nbsp;</td>
				<td><textarea name="content" rows="13" cols="50">${board.content}</textarea></td>  -->
					<td>내용&nbsp;</td>
					<td><textarea id="content" rows=10 name="content">${boardVo.content}</textarea>
						<script>
							CKEDITOR.replace('content'); // 에디터로 생성
						</script></td>
				</tr>
				<tr>
					<td>
						<a href="/board/lostpetboard/LostpetEidt/{${boardVo.boardNumber}"><input type="submit" value="수정하기"></td>
						<input type="button" value="뒤로가기"
						onClick="javascript: form.action='lostpetboard';">
					</td>
				</tr>

		</table>
	</center>


</body>
</html>