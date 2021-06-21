<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>


﻿
<script type="text/javascript" src="jquery-3.4.1.min.js" ></script>
<!-- ckeditor 4 -->
<link rel="stylesheet" href="${path}/resources/ckeditor/contents.css">
<!-- <script src="https://cdn.ckeditor.com/4.12.1/standard-all/ckeditor.js"></script> -->
<script type="text/javascript" 
	src="${path}/resources/ckeditor/ckeditor.js" ></script>
﻿<script type="text/javascript" 
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f850654c021fcb52efb271b62ce441eb&libraries=services"></script>﻿
<script type="text/javascript"
 	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
<script type="text/javascript" 
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
<script type="text/javascript" 
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>
<meta charset="UTF-8">
<style>
.map_wrap, .map_wrap * {
	margin:0;
	padding:0;
	font-family:'Malgun Gothic',dotum,'돋움',sans-serif;
	font-size:12px;
}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{
	color:#000;
	text-decoration: none;
}
.map_wrap {
	position:relative;
	width:100%;
	height:500px;}
#menu_wrap {
	position:absolute;
	top:0;
	left:0;
	bottom:0;
	width:250px;
	margin:10px 0 30px 10px;
	padding:5px;
	overflow-y:auto;
	background:rgba(255, 255, 255, 0.7);
	z-index: 1;
	font-size:12px;
	border-radius: 10px;
}
.bg_white {
	background:#fff;
}
#menu_wrap hr {
	display: block; 
	height: 1px;
	border: 0; 
	border-top: 2px solid #5F5F5F;
	margin:3px 0;
}
#menu_wrap .option{
	text-align: center;
}
#menu_wrap .option p {
	margin:10px 0;
}  
#menu_wrap .option button {
	margin-left:5px;
}
#placesList li {
	list-style: none;
}
#placesList .item {
	position:relative;
	border-bottom:1px solid #888;
	overflow: hidden;
	cursor: pointer;
	min-height: 65px;
}
#placesList .item span {
	display: block;
	margin-top:4px;
}
#placesList .item h5, #placesList .item .info {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
#placesList .item .info{
	padding:10px 0 10px 55px;
}
#placesList .info .gray {
	color:#8a8a8a;
}
#placesList .info .jibun {
	padding-left:26px;
	background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) 
	no-repeat;
}
#placesList .info .tel {
	color:#009900;
}
#placesList .item .markerbg {
	float:left;
	position:absolute;
	width:36px; 
	height:37px;
	margin:10px 0 0 10px;
	background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) 
	no-repeat;
}
#placesList .item .marker_1 {
	background-position: 0 -10px;
}
#placesList .item .marker_2 {
	background-position: 0 -56px;
}
#placesList .item .marker_3 {
	background-position: 0 -102px
}
#placesList .item .marker_4 {
	background-position: 0 -148px;
}
#placesList .item .marker_5 {
	background-position: 0 -194px;
}
#placesList .item .marker_6 {
	background-position: 0 -240px;
}
#placesList .item .marker_7 {
	background-position: 0 -286px;
}
#placesList .item .marker_8 {
	background-position: 0 -332px;
}
#placesList .item .marker_9 {
	background-position: 0 -378px;
}
#placesList .item .marker_10 {
	background-position: 0 -423px;
}
#placesList .item .marker_11 {
	background-position: 0 -470px;
}
#placesList .item .marker_12 {
	background-position: 0 -516px;
}
#placesList .item .marker_13 {
	background-position: 0 -562px;
}
#placesList .item .marker_14 {
	background-position: 0 -608px;
}
#placesList .item .marker_15 {
	background-position: 0 -654px;
}
#pagination {
	margin:10px auto;text-align: center;
}
#pagination a {
	display:inline-block;margin-right:10px;
}
#pagination .on {
	font-weight: bold; 
	cursor: default;
	color:#777;
}
</style>
<title>사랑하냥? 사랑하개!</title>
</head>
<body>
<!-- header -->
<jsp:include page="/WEB-INF/view/include/header.jsp" />
<!-- //header -->
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
                success: function () {
                    likeCount();
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
                    $("#likeCount").html(count);
                },
            })
        };
        likeCount(); // 처음 시작했을 때 실행되도록 해당 함수 호출
    })

    </script>
	<div style="margin-top: 50px;">
	<form method="post" name="form" enctype="multipart/form-data">	
	<center>
		<h2>멍냥잡화점</h2><br><br>
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
				<center>
					
					<c:if test="${loginNick == boardVo.nickName || memberLevel==0}">
				<a href="../itemboardUpdate/${boardVo.boardNumber}&${boardVo.nickName}"><input type="button" value="수정하기"  
					class="btn btn-secondary my-2 my-sm-0"> </a> 
					</c:if>
					<a href="../itemboard"><input type="button" id="list" value="목록" class="btn btn-secondary my-2 my-sm-0"></a>
					<c:if test="${loginNick == boardVo.nickName || memberLevel==0}">
					<%-- <input type="submit" value="삭제하기" 
					onClick="javascript: form.action='../petchatDelete/${boardVo.boardNumber}';" 
					class="btn btn-secondary my-2 my-sm-0"> --%>
					<a href="../itemboardDelete/${boardVo.boardNumber}"><input type="button" value="삭제하기"  
					class="btn btn-secondary my-2 my-sm-0"></a>
						</c:if>
					<!-- 추천 기능 -->
		
				<c:if test="${ email == null }">
					추천 기능은 로그인 후 사용 가능합니다.<br />				
				</c:if>
				<c:if test="${ email != null }">
				<button type="button" class="btn btn-secondary" id="updateLike" >추천하기</button>
					
					</button> 
				</c:if>
		
			
				</center>
				
				
					<script>
						
						$("#btnDelete").on('click',function(e){
							e.preventDefault();

							if(confirm("정말 삭제하시겠습니까??")){
								$.ajax({
									type:"GET",
									url:"../itemboardDelete/${boardVo.boardNumber}",
									data: String,
									contentType:false,
									success:function(data){
										window.location.replace("../itemboardDelete/${boardVo.boardNumber}");
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
				
					
					</div>
				</td>
			</tr>
		</table>
	</c:if>
	


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
					<center>
					<c:if test="${loginNick eq boardVo.nickName ||memberLevel == 0}">
					<a href="../itemboardUpdate/${boardVo.boardNumber}&${boardVo.nickName}"><input type="button" value="수정하기"  
					class="btn btn-secondary my-2 my-sm-0"> </a>
					</c:if>
					<a href="../itemboard"><input type="button" id="list" value="목록" class="btn btn-secondary my-2 my-sm-0"></a>
					<c:if test="${loginNick eq boardVo.nickName || memberLevel == 0}">
					<a href="../itemboardDelete/${boardVo.boardNumber}"><input type="button" value="삭제하기"  
					class="btn btn-secondary my-2 my-sm-0"></a>
					</c:if>
					<!-- 추천 기능 -->
		
				<c:if test="${ email == null }">
					추천 기능은 로그인 후 사용 가능합니다.<br />
					<span class="likeCount"></span>					
				</c:if>
				<c:if test="${ email != null }">
				<button type="button" class="btn btn-secondary" id="updateLike" >추천하기</button>
					
					</button> 
				</c:if>
				</center>
					
					
				</td>
				</tr>
		</table>
	</c:if>
</form>
</center>
<!-- Reply Form {s} -->
<div style="margin-left: 25%; margin-right: 25%;">
			<c:if test="${sessionScope.nickName != null}">
			<div  style="padding-top: 10px">
				<form:form name="form" id="form" role="form" modelAttribute="replyVo" method="post">
				<form:hidden path="boardNumber" id="boardNumber"/>
				<div class="row">
					<div class="col-sm-10">
						<form:textarea path="replyText" id="replyText" class="form-control" rows="2" placeholder="댓글을 입력해 주세요"></form:textarea>
					</div>
					<div class="col-sm-2">
						<button type="button" class="btn btn-sm btn-primary" id="btnReplySave" style="width: 50%; margin-top: 10px"> 저 장 </button>
					</div>
				</div>
				</form:form>
			</div>
			</c:if>
			<!-- Reply Form {e} -->

			<!-- Reply List {s}-->
			<div  style="padding-top: 10px">
				<h6 class="border-bottom pb-2 mb-0">댓글 </h6>
				<div id="replyList"></div>
			</div> 
			<!-- Reply List {e}-->

		</div>
<script>

$(document).ready(function(){
	showReplyList();
});

function showReplyList(){
	var url = "${path}/itemgetReplyList";
	var paramData = {"boardNumber" : "${boardVo.boardNumber}"};
	var loginNick = "${loginNick}";
	var memberLevel = "${memberLevel}";
	
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
                    	var replyer = this.nickName;
                    if(loginNick == replyer || memberLevel == 0) {
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
                     console.log("로그인 : " + loginNick);
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
			url: "${path}/itemsaveReply"
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
		url: "${path}/itemupdateReply"
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
		url: "${path}/itemdeleteReply"
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