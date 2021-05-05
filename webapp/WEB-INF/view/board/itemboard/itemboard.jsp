<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<jsp:include page="/WEB-INF/view/include/header.jsp" />
	<script type="text/javascript">
	$(document).ready(function(){
		// 추천버튼 클릭시(추천 추가 또는 추천 제거)
		console.log("ajax 이벤트 등록");
		$("#updateLike").click(function(){
			$.ajax({
				url: "/petBoard/updateLike/${boardNumber}",
                type: "POST",
                data: {
                    no: '${boardNumber}',
                    id: '${email}'
                },
                success: function (count) {
                	$(".likeCount").html(count);
                	//likeCount();
                },
			})
		})
		
		// 게시글 추천수
	    function likeCount() {
			$.ajax({
				url: "/petBoard/likeCount/${boardNumber}",
                type: "POST",
                data: {
                    no: '${boardNumber}'
                },
                success: function (count) {
                	$(".likeCount").html(count);
                },
			})
	    };
	    //likeCount(); // 처음 시작했을 때 실행되도록 해당 함수 호출
	})
	
	</script>
<title>사랑하냥? 사랑하개!</title>
</head>
<body>
<div class ="container">
   <table class="itemboard"
     style="text-align: center; border: 1px solid #dddddd">
     <div>
		<h2>멍냥 잡화점</h2>
		<nav class="array">
		<center>
			<button type="button" class="btn btn-outline-secondary"onClick="javascript: form.action='likeCount';">추천순</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-outline-secondary"onClick="javascript: form.action='recent';">최신순</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-outline-secondary"onClick="javascript: form.action='past';">오래된순</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-outline-secondary"onClick="javascript: form.action='readCount';">조회순</button>
		</nav>
		  </center>
	</div>
	<div style='width:80px;float: right;'>
		<a href="itemboardWrite"><button type="submit" class="btn btn-outline-secondary">글쓰기</button></a>
	</div>

       <table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">글번호</th>
      <th scope="col">제목</th>
      <th scope="col">닉네임</th>
      <th scope="col">조회수</th>
      <th scope="col">작성시간</th>
      <th scope="col">추천수</th>
	    <!-- 공지글 -->
		<c:forEach var="notice" items="${itemNotice}">
				<tr>
					<td>${notice.boardNumber}</td>
					<td><a href="<c:url value="/itemboardContent/${notice.boardNumber}" />"id="notice" class="notice">
					${notice.subtitle}${notice.title}<%-- (${notice.replyCount}) --%></a></td>
					<td>${notice.nickName}</td>
					<td>${notice.readCount}</td>
					<td>${notice.writeDate}</td>
					<td>${notice.likeCount}</td>
				</tr>
		</c:forEach>
		<!-- 일반게시판 글 (검색x) -->
		<c:if test="${searchKey == null}">
			<c:if test="${arrayList == null}"> <!-- 최신순 정렬 default -->
			<c:forEach var="item" items="${itemList}">
				<tr>
					<td>${item.boardNumber}</td>
					<td><a href="<c:url value="/itemboardContent/${item.boardNumber}" />">
					[${item.subtitle}]${item.title}(${replyCount})</a></td>
					<td>${item.nickName}</td>
					<td>${item.readCount}</td>
					<td>${item.writeDate}</td>
					<td>${item.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'likeCount'}"> <!-- 추천순 정렬  -->
			<c:forEach var="item" items="${itemList}">
				<tr>
					<td>${item.boardNumber}</td>
					<td><a href="<c:url value="/itemboardContent/${item.boardNumber}" />">
					[${board.subtitle}]${board.title}(${replyCount})</a></td>
					<td>${item.nickName}</td>
					<td>${item.readCount}</td>
					<td>${item.writeDate}</td>
					<td>${item.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'old'}"> <!-- 오래된순 정렬  -->
			<c:forEach var="item" items="${itemList}">
				<tr>
					<td>${item.boardNumber}</td>
					<td><a href="<c:url value="/itemboardContent/${item.boardNumber}" />">
					[${item.subtitle}]${item.title}(${replyCount})</a></td>
					<td>${item.nickName}</td>
					<td>${item.readCount}</td>
					<td>${item.writeDate}</td>
					<td>${item.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'readCount'}"> <!-- 조회순 정렬  -->
			<c:forEach var="item" items="${itemList}">
				<tr>
					<td>${item.boardNumber}</td>
					<td><a href="<c:url value="/itemboardContent/${item.boardNumber}" />">
					[${item.subtitle}]${item.title}(${replyCount})</a></td>
					<td>${item.nickName}</td>
					<td>${item.readCount}</td>
					<td>${item.writeDate}</td>
					<td>${item.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
		</c:if>
		<!-- 검색 글 -->
		<c:if test="${searchKey == 'keyword'}">
			<c:if test="${arrayList == null}"> <!-- 최신순 정렬 default -->
			<c:forEach var="item" items="${itemList}">
				<tr>
					<td>${item.boardNumber}</td>
					<td><a href="<c:url value="/itemboardContent/${item.boardNumber}" />">
					[${item.subtitle}]${item.title}(${replyCount})</a></td>
					<td>${item.nickName}</td>
					<td>${item.readCount}</td>
					<td>${item.writeDate}</td>
					<td>${item.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'likeCount'}"> <!-- 추천순 정렬  -->
			<c:forEach var="item" items="${itemList}">
				<tr>
					<td>${item.boardNumber}</td>
					<td><a href="<c:url value="/itemboardContent/${item.boardNumber}" />">
					[${item.subtitle}]${item.title}(${replyCount})</a></td>
					<td>${item.nickName}</td>
					<td>${item.readCount}</td>
					<td>${item.writeDate}</td>
					<td>${item.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'old'}"> <!-- 오래된순 정렬  -->
			<c:forEach var="item" items="${itemList}">
				<tr>
					<td>${item.boardNumber}</td>
					<td><a href="<c:url value="/itemboardContent/${item.boardNumber}" />">
					[${item.subtitle}]${item.title}(${replyCount})</a></td>
					<td>${item.nickName}</td>
					<td>${item.readCount}</td>
					<td>${item.writeDate}</td>
					<td>${item.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${arrayList == 'readCount'}"> <!-- 조회순 정렬  -->
			<c:forEach var="item" items="${itemList}">
				<tr>
					<td>${item.boardNumber}</td>
					<td><a href="<c:url value="/itemboardContent/${item.boardNumber}" />">
					[${item.subtitle}]${item.title}(${replyCount})</a></td>
					<td>${item.nickName}</td>
					<td>${item.readCount}</td>
					<td>${item.writeDate}</td>
					<td>${item.likeCount}</td>
				</tr>
			</c:forEach>
			</c:if>
		 </c:if> 
	</table>
	</div>
	
<!-- footer -->
<jsp:include page="/WEB-INF/view/include/footer.jsp" />
<!-- //footer -->	
</body>
</html>