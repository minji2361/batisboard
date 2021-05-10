<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
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
				 <td>&nbsp;<span id="likeCount"></span></td>
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
					<c:if test="${memberNumber == boardVo.memberNumber || memberLevel == 0}">
					<input type="submit" value="수정하기" onClick="javascript: form.action='../HospitalUpdatePage/${boardVo.boardNumber}&${boardVo.nickName}';"  
					class="btn btn-secondary my-2 my-sm-0"> 
					</c:if>
					<input type="submit"  value="목록" onClick="javascript: form.action='../HospitalBoard';"
					class="btn btn-secondary my-2 my-sm-0">
					<c:if test="${memberNumber == boardVo.memberNumber || memberLevel == 0}">
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
		                url: "/petBoard/HospitalupdateLike/${boardNumber}",
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
		                url: "/petBoard/HospitallikeCount/${boardNumber}",
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
						url:"../HospitalDelete/${boardVo.boardNumber}",
						data: String,
						contentType:false,
						success:function(data){
							window.location.replace("../HospitalDelete/${boardVo.boardNumber}");
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

	<c:if test="${boardVo.notice eq 'y'.charAt(0)}">
	<table>
			<tr>
				<td>제목&nbsp;</td>
				<td>${boardVo.subtitle}${boardVo.title}</td>
			</tr>
			<tr>
				<td>작성자&nbsp;</td>
				<td>${boardVo.nickName}</td>
				<td>작성일</td>
				<td>${boardVo.writeDate}</td>
				<td>조회수</td>
				<td>${boardVo.readCount}</td>
				<td>추천수</td>
				<td>&nbsp;<span id="likeCount"></span></td>
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
					<c:if test="${memberNumber == boardVo.memberNumber || memberLevel == 0}">
					<input type="submit" value="수정하기" onClick="javascript: form.action='../HospitalUpdatePage/${boardVo.boardNumber}&${boardVo.nickName}';"  
					class="btn btn-secondary my-2 my-sm-0"> 
					</c:if>
					<c:if test="${memberNumber == boardVo.memberNumber || memberLevel == 0}">
					<input type="submit" value="삭제하기" 
					onClick="javascript: form.action='../HospitalDelete/${boardVo.boardNumber}';" 
					class="btn btn-secondary my-2 my-sm-0">
					</c:if>
					<input type="submit"  value="목록" onClick="javascript: form.action='../HospitalBoard';"
					class="btn btn-secondary my-2 my-sm-0">					
					</div>
				</td>
				</tr>
		</table>
	</c:if>
</center>
</form>
<br><br>

<!-- 댓글 -->
<!-- Reply Form {s} -->
			<c:if test="${sessionScope.nickName != null}">
			<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
				<form:form name="form" id="form" role="form" modelAttribute="replyVo" method="post">
	<%-- 			<form:hidden path="boardNumber" id="boardNumber"/> --%>
				<div class="row">
					<div class="col-sm-10">
						<form:textarea path="replyText" id="replyText" class="form-control" rows="2" placeholder="댓글을 입력해 주세요"></form:textarea>
					</div>
					<div class="col-sm-2">
						<button type="button" class="btn btn-sm btn-primary" id="btnReplySave" style="width: 100%; margin-top: 10px"> 저 장 </button>
					</div>
				</div>
				</form:form>
			</div>
			</c:if>
			<!-- Reply Form {e} -->

			<!-- Reply List {s}-->
			<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
				<h6 class="border-bottom pb-2 mb-0">댓글 </h6>
				<div id="replyList"></div>
			</div> 
			<!-- Reply List {e}-->

		
<script>

$(document).ready(function(){
	showReplyList();
});

function showReplyList(){
	var url = "${path}/HospitalgetReplyList";
	var paramData = {"boardNumber" : "${boardVo.boardNumber}"};
	var loginNick = "${loginNick}";
	var memberLevel = "${memberLevel}";
	var memberNumber = "${memberNumber}";
	
	$.ajax({
        type: 'POST',
        url: url,
        data: paramData,
        dataType: 'json',
        success: function(result) {
           	var htmls = "";
           	
		if(result.length < 1){
			htmls="등록된 댓글이 없습니다.";

		} else {
                    $(result).each(function(){
                    	var replyer = this.memberNumber;
                    if(memberNumber == replyer || memberLevel == 0) {
                     htmls += '<div class="media text-muted pt-3" id="replyNumber' + this.replyNumber + '">';
                     htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
                     htmls += '<span class="d-block">';
                     htmls += '<strong class="text-gray-dark">' + this.nickName + '</strong>';
                     htmls += '<span style="padding-left: 7px; font-size: 9pt">';
                     htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + this.replyNumber + ', \'' + this.nickName + '\', \'' + this.replyText + '\' )" style="padding-right:5px">수정</a>';
                     htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.replyNumber + ')" >삭제</a>';
                     htmls += '</span>';
                     htmls += '</span>';
                     htmls += this.replyText;
                     htmls += '</p>';
                     htmls += '</div>';
                     console.log("로그인 : " + memberNumber);
                     console.log("작성자 : " + replyer);
                     console.log("등급 : " + memberLevel);
                    } else {
                    	htmls += '<div class="media text-muted pt-3" id="replyNumber' + this.replyNumber + '">';
                        htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
                        htmls += '<span class="d-block">';
                        htmls += '<strong class="text-gray-dark">' + this.nickName + '</strong>';
                        htmls += '<span style="padding-left: 7px; font-size: 9pt">';
                        htmls += '</span>';
                        htmls += '</span>';
                        htmls += this.replyText;
                        htmls += '</p>';
                        htmls += '</div>';
                        console.log("로그인 : " + memberNumber);
                        console.log("작성자 : " + replyer);
                        console.log("등급 : " + memberLevel);
                    }
                });	//each end
		}
		$("#replyList").html(htmls);
        }	   // Ajax success end
	});	// Ajax end

}
</script>
<script>
//댓글 저장 버튼 클릭 이벤트
	$(document).on('click', '#btnReplySave', function(){
		console.log("작동?");
		var replyContent = $('#replyText').val();

		var paramData = JSON.stringify({
				"replyText": replyContent
				, "boardNumber":'${boardVo.boardNumber}'
		});

		var headers = {"Content-Type" : "application/json"
				, "X-HTTP-Method-Override" : "POST"};

		$.ajax({
			url: "${path}/HospitalsaveReply"
			, headers : headers
			, data : paramData
			, type : 'POST'
			, dataType : 'text'
			, success: function(result){
				showReplyList();
				$('#replyText').val('');
			}
			, error: function(error){
				console.log("에러 : " + error);
			}
		});
	});
</script>	
<script>
//댓글 수정 폼 이벤트 추가
function fn_editReply(replyNumber, nickName, replyText){
		var htmls = "";
		htmls += '<div class="media text-muted pt-3" id="replyNumber' + this.replyNumber + '">';
		htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
		htmls += '<span class="d-block">';
		htmls += '<strong class="text-gray-dark">' + nickName + '</strong>';
		htmls += '<span style="padding-left: 7px; font-size: 9pt">';

		htmls += '<a href="javascript:void(0)" onclick="fn_updateReply(' + replyNumber + ', \'' + nickName + '\')" style="padding-right:5px">저장</a>';

		htmls += '<a href="javascript:void(0)" onClick="showReplyList()">취소<a>';
		htmls += '</span>';
		htmls += '</span>';		
		htmls += '<textarea name="editContent" id="editContent" class="form-control" rows="3">';
		htmls += replyText;
		htmls += '</textarea>';
	
		htmls += '</p>';
		htmls += '</div>';
		
		$('#replyNumber' + replyNumber).replaceWith(htmls);
		$('#replyNumber' + replyNumber + ' #editContent').focus();
	}
</script>
<script>
function fn_updateReply(replyNumber, nickName){
	var replyEditContent = $('#editContent').val();
	var paramData = JSON.stringify({
			"replyText": replyEditContent
			, "replyNumber": replyNumber
	});

	var headers = {
			"Content-Type" : "application/json"
			, "X-HTTP-Method-Override" : "POST"};
	
	$.ajax({
		url: "${path}/HospitalupdateReply"
		, headers : headers
		, data : paramData
		, type : 'POST'
		, dataType : 'text'
		, success: function(result){
                            console.log(result);
			showReplyList();
		}
		, error: function(error){
			console.log("에러 : " + error);
		}
	});

}
</script>
<script>
function fn_deleteReply(replyNumber){
	console.log("작동?");
	var paramData = JSON.stringify({
		"replyNumber": replyNumber
	});
	
	var headers = {
			"Content-Type" : "application/json"
			, "X-HTTP-Method-Override" : "POST"};

	$.ajax({
		url: "${path}/HospitaldeleteReply"
		, data : paramData
		, headers : headers
		, type : 'POST'
		, dataType : 'text'
		, success: function(result){
			showReplyList();
		}
		, error: function(error){
			console.log("에러 : " + error);
			console.log(replyNumber);
		}
	});
}
</script>

<!-- //container -->

<!-- footer -->
<jsp:include page="/WEB-INF/view/include/footer.jsp" />
<!-- //footer -->
</body>
</html>