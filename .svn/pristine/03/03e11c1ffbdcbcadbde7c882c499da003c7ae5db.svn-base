<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	$(document).ready(function(){

	});
	function list(page){
		location.href = "petplaceboard?curPage="+page;
	}

/* 9-15 */
</script>
<title>사랑하냥? 사랑하개!</title>
</head>
<body>
<!-- header -->
<jsp:include page="/WEB-INF/view/include/header.jsp" />
<!-- //header -->

<!-- container -->
<div class ="container" style="margin-top: 50px;">
<table class="petplace"
     style="text-align: center; border: 1px solid #dddddd">
	<div>
		<center>
		<h2>멍냥여행사</h2></center>
		<center>
		<nav class="array">
			<button type="button" class="btn btn-outline-secondary"onClick="javascript:location.href='?oder=likeCount';">추천순</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-outline-secondary"onClick="javascript:location.href='?oder=recent';">최신순</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-outline-secondary"onClick="javascript:location.href='?oder=past';">오래된순</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-outline-secondary"onClick="javascript:location.href='?oder=readCount';">조회순</button>
		</nav>
		</center>
	</div>
	<div style='width:80px;float: right;'>
		<a href="petplaceWritePage"><button type="submit" class="btn btn-outline-secondary">글쓰기</button></a>
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
	</tr>
	
			<c:forEach var="list" items="${map.showNewList}" varStatus="status">
			<tr>
				<td>${list.rn}</td>
				
				 <td>
					<c:choose>
						<c:when test="${fn:contains(list.notice, 'y')}">
							<a href="<c:url value="/petplaceContent/${list.boardNumber}" />" id="notice" class="notice"> 
							${list.area}&nbsp;${list.subtitle}&nbsp;${list.title}[${replyCount}]
							</a>
						</c:when>
						<c:otherwise>
							<a href="<c:url value="/petplaceContent/${list.boardNumber}" />">
							${list.area}&nbsp;[${list.subtitle}]&nbsp;${list.title}[${replyCount}]
							</a>
						</c:otherwise>
					</c:choose> 
				</td>			
				<td>${list.nickName}</td>
				<td>${list.readCount}</td>
				<td>${list.writeDate}</td>
				<td>${list.likeCount}</td>
			</tr>
		</c:forEach>
  </thead>	
	</table>
	</div>
	<div class="paging" style="text-align:center;font-size:20px">
    	<c:if test="${map.pager.curBlock > 1}">
  			<a href="#" onclick="list('1')">[처음]</a>
        </c:if> 
        <c:if test="${map.pager.curBlock > 1}">
        	<a href="#" onclick="list('${map.pager.prevPage}')">[이전]</a>
        </c:if> <!-- 현재 블록이 1블록보다 크면 이전 블록으로 이동할 수 있도록 링크 추가 -->
        <c:forEach var="num" begin="${map.pager.blockBegin}" end="${map.pager.blockEnd}">
        	<c:choose>
            	<c:when test="${num == map.pager.curPage}">
                <!-- 현재 페이지인 경우 하이퍼링크 제거 -->
                <!-- 현재 페이지인 경우에는 링크를 빼고 빨간색으로 처리를 한다. -->
                	<span style="color:red;">${num}</span>
                </c:when>
                <c:otherwise>
                	<a href="#" onclick="list('${num}')"  style="color:black;">${num}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
            
            
            <c:if test="${map.pager.curBlock <= map.pager.totBlock}">
                <a href="#" onclick="list('${map.pager.nextPage}')" style="color:black;">[다음]</a>
            </c:if> <!-- 현재 페이지블록이 총 페이지블록보다 작으면 다음으로 갈 수있도록 링크를 추가 -->
            
            
            <c:if test="${map.pager.curPage <= map.pager.totPage}">
                <a href="#" onclick="list('${map.pager.totPage}')" style="color:black;">[끝]</a>
            </c:if> <!-- 현재 페이지블록이 총 페이지블록보다 작거나 같으면 끝으로 갈 수 있도록 링크를 추가함-->
  </div>
  <!-- 78-107  복붙 -->
<!-- //container -->

<!-- footer -->
<jsp:include page="/WEB-INF/view/include/footer.jsp" />
<!-- //footer -->
</body>
</html>
