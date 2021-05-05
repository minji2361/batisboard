<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- header -->
<jsp:include page="/WEB-INF/view/include/header.jsp" />
<!-- //header -->
<center>
<div>
	<img src="${path}/resources/img/mainslide/main001.png" id="mainImage" >
</div>
<center>

<script>
	var myImage=document.getElementById("mainImage");
	var imageArray=["${path}/resources/img/mainslide/main002.png",
		"${path}/resources/img/mainslide/main003.png", "${path}/resources/img/mainslide/main004.png",
		"${path}/resources/img/mainslide/main005.png", "${path}/resources/img/mainslide/main006.png",
		"${path}/resources/img/mainslide/main007.png"];
	var imageIndex=0;
	
	function changeImage(){
		myImage.setAttribute("src", imageArray[imageIndex]);
		imageIndex++;
		if(imageIndex>=imageArray.length){
			imageIndex=0;
		}
	}
	setInterval(changeImage,3000);
</script>

<!-- footer -->
<jsp:include page="/WEB-INF/view/include/footer.jsp" />
<!-- //footer -->
</body>
</html>