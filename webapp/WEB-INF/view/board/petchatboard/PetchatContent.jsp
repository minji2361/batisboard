<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" 
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f850654c021fcb52efb271b62ce441eb&libraries=services"></script>
<title>사랑하냥? 사랑하개!</title>
</head>
<body>
<!-- header -->
<jsp:include page="/WEB-INF/view/include/header.jsp" />
<!-- //header -->

<!-- container -->
<form method="post" name="form" enctype="multipart/form-data">	
	<center>
		<h2>집사들의 수다</h2><br><br>
		<c:if test="${boardVo.notice eq 'n'.charAt(0)}">
		<table>
			<tr>
				<td>제목&nbsp;</td>
				<td>
				[${boardVo.subtitle}][${boardVo.area}]${boardVo.title}</td>
			</tr>
			<tr>
				<td>작성자&nbsp;</td>
				<td>
				${boardVo.nickName}
				<input type="hidden" name="writerNickName" value="${boardVo.nickName}" />
				</td>
			</tr>
			<tr>
				<td>작성일</td>
				<td>${boardVo.writeDate}</td>
			</tr>
			<tr>
				<td>조회수</td>
				<td>${boardVo.readCount}</td>
			</tr>
			<tr>
				<td>추천수</td>
				<td>${boardVo.likeCount}</td>
			</tr>
			
			<tr>
				<td>내용&nbsp;</td>
				<td>${boardVo.content}
				<script>
					CKEDITOR.instances.content.getData();
				</script>
				</td>
			</tr>
			<c:if test="${boardVo.latitude != 0 && boardVo.longitude != 0}">
			<tr>
				<td>지도</td>
				<td>
					<!-- 이미지 지도를 표시할 div 입니다 -->
					<div id="staticMap" style="width:600px;height:350px;"></div>    
					
					<script>
					// 이미지 지도에서 마커가 표시될 위치입니다 
					var latitude = ${boardVo.latitude};
					var longitude = ${boardVo.longitude};
					console.log(latitude);
					console.log(longitude);
					var markerPosition  = new kakao.maps.LatLng(longitude, latitude); 
					// 이미지 지도에 표시할 마커입니다
					// 이미지 지도에 표시할 마커는 Object 형태입니다
					var marker = {
					    position: markerPosition
					};
					var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
					    staticMapOption = { 
					        center: new kakao.maps.LatLng(longitude, latitude), // 이미지 지도의 중심좌표
					        level: 3, // 이미지 지도의 확대 레벨
					        marker: marker // 이미지 지도에 표시할 마커 
					    };    
					// 이미지 지도를 생성합니다
					var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
					</script>
				</td>
			</tr>
			</c:if>
			<tr>
				<td></td>
				<td>
					<div style="float:right;">
					<c:if test="${loginNick == boardVo.nickName || memberLevel==0}">
					<input type="submit" value="수정하기" onClick="javascript: form.action='../petchatUpdatePage/${boardVo.boardNumber}&${boardVo.nickName}';"  
					class="btn btn-secondary my-2 my-sm-0"> 
					</c:if>
					<input type="submit"  value="목록" onClick="javascript: form.action='../petchat';"
					class="btn btn-secondary my-2 my-sm-0">
					<c:if test="${loginNick == boardVo.nickName || memberLevel==0}">
					<%-- <input type="submit" value="삭제하기" 
					onClick="javascript: form.action='../petchatDelete/${boardVo.boardNumber}';" 
					class="btn btn-secondary my-2 my-sm-0"> --%>
					<button type="button" id="btnDelete" class="btn btn-secondary my-2 my-sm-0">삭제하기</button>
					
					</c:if>
					<c:if test="${ email == null }">
					추천 기능은 로그인 후 사용 가능합니다.<br />				
					</c:if>
					<c:if test="${ email != null }">
					<button type="button" class="btn btn-secondary" id="updateLike" >추천하기</button>
					</c:if>
					</div>
				</td>
			</tr>
		</table>
	</c:if>
	
	<script>
			//추천 기능
			$(document).ready(function(){
		        // 추천버튼 클릭시(추천 추가 또는 추천 제거)
		        console.log("ajax 이벤트 등록");
		        $("#updateLike").click(function(){
		            $.ajax({
		                url: "/petBoard/petchatupdateLike/${boardNumber}",
		                type: "POST",
		                data: {
		                    no: '${boardNumber}',
		                    id: '${email}'
		                },
		                success: function () {
		                    likeCount();
		                },
		            })
		        })
		
		        // 게시글 추천수
		        function likeCount() {
		            $.ajax({
		                url: "/petBoard/petchatlikeCount/${boardNumber}",
		                type: "POST",
		                data: {
		                    no: '${boardNumber}'
		                },
		                success: function (count) {
		                    $("#likeCount").html(count);
		                },
		            })
		        };
		        likeCount(); // 처음 시작했을 때 실행되도록 해당 함수 호출
		    })		
	
			// 삭제 버튼
			$("#btnDelete").on('click',function(e){
				e.preventDefault();

				if(confirm("정말 삭제하시겠습니까??")){
					$.ajax({
						type:"GET",
						url:"../petchatDelete/${boardVo.boardNumber}",
						data: String,
						contentType:false,
						success:function(data){
							window.location.replace("../petchatDelete/${boardVo.boardNumber}");
						},
						fail: function(data){
							return;
						}
					});
				} else {
					return false;
				}
			});
		</script>
	
		<!-- <link rel="stylesheet"
			href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
		<div id="dialog-confirm" title="정말로 삭제?" style="display: ">
			<p>삭제하시면 복구할 수 없습니다. 그래도 삭제하실 건가요?</p>
		</div>
	
		<script>
			//삭제 버튼을 눌렀을 때 처리
			document.getElementById("deletebtn").addEventListener(
				"click", function(){
				$("#dialog-confirm").dialog({
				      resizable: false,
				      height: "auto",
				      width: 400,
				      modal: true,
				      buttons: {
				        "삭제": function() {
				          $(this).dialog("close");
				          location.href="../petchatDelete/${boardVo.boardNumber}&${boardVo.nickName}";
				        },
				        "취소": function() {
				          $(this).dialog("close");
				        }
				      }
				    });	
			});
		</script> -->


	<c:if test="${boardVo.notice eq 'y'.charAt(0)}">
	<table>
			<tr>
				<td>제목&nbsp;</td>
				<td>[${boardVo.subtitle}][${boardVo.area}]${boardVo.title}</td>
			</tr>
			<tr>
				<td>작성자&nbsp;</td>
				<td>${boardVo.nickName}</td>
				<td>작성일</td>
				<td>${boardVo.writeDate}</td>
				<td>조회수</td>
				<td>${boardVo.readCount}</td>
				<td>추천수</td>
				<td>${boardVo.likeCount}</td>
			</tr>
			
			<tr>
				<td>내용&nbsp;</td>
				<td>${boardVo.content}
				<script>
					CKEDITOR.instances.content.getData();
				</script>
				</td>
			</tr>
			<tr>
				<td>지도</td>
			</tr>
			<tr>
					<td></td>
					<td>
					<div style="float:right;">
					<c:if test="${loginNick eq boardVo.nickName ||memberLevel == 0}">
					<input type="submit" value="수정하기" onClick="javascript: form.action='../petchatUpdatePage/${boardVo.boardNumber}&${boardVo.nickName}';"  
					class="btn btn-secondary my-2 my-sm-0"> 
					</c:if>
					<input type="submit"  value="목록" onClick="javascript: form.action='../petchat';"
					class="btn btn-secondary my-2 my-sm-0">
					<c:if test="${loginNick eq boardVo.nickName || memberLevel == 0}">
					<input type="submit" value="삭제하기" 
					onClick="javascript: form.action='../petchatDelete/${boardVo.boardNumber}';" 
					class="btn btn-secondary my-2 my-sm-0">
					</c:if>
					
					</div>
				</td>
				</tr>
		</table>
	</c:if>
</form>
</center>
<!-- //container -->

<!-- footer -->
<jsp:include page="/WEB-INF/view/include/footer.jsp" />
<!-- //footer -->
</body>
</html>