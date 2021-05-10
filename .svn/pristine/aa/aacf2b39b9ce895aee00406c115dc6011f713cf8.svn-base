<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" 
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f850654c021fcb52efb271b62ce441eb&libraries=services"></script>
<!-- <script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script> -->
<title>사랑하냥? 사랑하개!</title>
</head>
<body>
<!-- header -->
<jsp:include page="/WEB-INF/view/include/header.jsp" />
<!-- //header -->
<div style="margin-top: 50px;">
<!-- container -->
<form method="post" name="form" enctype="multipart/form-data">	
	<center>
		<h2>멍냥여행사</h2><br><br>
		<c:if test="${boardVo.notice eq 'n'.charAt(0)}">
		<table>
			<tr>
				<td>제목&nbsp;</td>
				<td>
				${boardVo.area}[${boardVo.subtitle}]${boardVo.title}</td>
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
					<input type="submit" value="수정하기" onClick="javascript: form.action='../petplaceUpdatePage/${boardVo.boardNumber}&${boardVo.nickName}';"  
					class="btn btn-secondary my-2 my-sm-0"> 
					</c:if>
					<input type="submit"  value="목록" onClick="javascript: form.action='../petplaceboard';"
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
					<input type="submit" value="수정하기" onClick="javascript: form.action='../petplaceUpdatePage/${boardVo.boardNumber}&${boardVo.nickName}';"  
					class="btn btn-secondary my-2 my-sm-0"> 
					</c:if>
					<input type="submit"  value="목록" onClick="javascript: form.action='../petplaceboard';"
					class="btn btn-secondary my-2 my-sm-0">
					<c:if test="${loginNick eq boardVo.nickName || memberLevel == 0}">
					<input type="submit" value="삭제하기" 
					onClick="javascript: form.action='../petplaceDelete/${boardVo.boardNumber}';" 
					class="btn btn-secondary my-2 my-sm-0">
					</c:if>
					
					</div>
				</td>
				</tr>
		</table>
	</c:if>
</form>
</center>


<br><br>

<!-- 댓글 -->
<!-- Reply Form {s} -->
			<c:if test="${sessionScope.nickName != null}">
			<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
				<form:form name="form" id="form" role="form" modelAttribute="replyVo" method="post">
				<form:hidden path="boardNumber" id="boardNumber"/>
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
	var url = "${path}/petplacegetReplyList";
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
			url: "${path}/petplacesaveReply"
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
		url: "${path}/petplaceupdateReply"
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
		url: "${path}/petplacedeleteReply"
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
<script type="text/javascript">
//마커를 담을 배열입니다
var markers = [];

// 수정 시 지도에 포인트 찍기 (추가된 부분)
var latitude = ${boardVo.latitude};
var longitude = ${boardVo.longitude};
	
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
	center : new kakao.maps.LatLng(longitude, latitude), // 지도의 중심좌표
	level : 3
// 지도의 확대 레벨
};

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption);

var markerPosition  = new kakao.maps.LatLng(longitude, latitude); 
// 이미지 지도에 표시할 마커입니다
// 이미지 지도에 표시할 마커는 Object 형태입니다
var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
//! 수정 시 지도에 포인트 찍기 (추가된 부분) 끝

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
	zIndex : 1
});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

	var keyword = document.getElementById('keyword').value;

	<%--if (!keyword.replace(/^\s+|\s+$/g, '')) {
		alert('키워드를 입력해주세요!');
		return false;
	}--%>

	// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	ps.keywordSearch(keyword, placesSearchCB);
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
	if (status === kakao.maps.services.Status.OK) {

		// 정상적으로 검색이 완료됐으면
		// 검색 목록과 마커를 표출합니다
		displayPlaces(data);

		// 페이지 번호를 표출합니다
		displayPagination(pagination);

	} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

		alert('검색 결과가 존재하지 않습니다.');
		return;

	} else if (status === kakao.maps.services.Status.ERROR) {

		alert('검색 결과 중 오류가 발생했습니다.');
		return;

	}
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

	var listEl = document.getElementById('placesList'), menuEl = document
			.getElementById('menu_wrap'), fragment = document
			.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

	// 검색 결과 목록에 추가된 항목들을 제거합니다
	removeAllChildNods(listEl);

	// 지도에 표시되고 있는 마커를 제거합니다
	removeMarker();

	for (var i = 0; i < places.length; i++) {

		// 마커를 생성하고 지도에 표시합니다
		var placePosition = new kakao.maps.LatLng(places[i].y,
				places[i].x), marker = addMarker(placePosition, i), itemEl = getListItem(
				i, places[i]); // 검색 결과 항목 Element를 생성합니다

		// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		// LatLngBounds 객체에 좌표를 추가합니다
		bounds.extend(placePosition);

		// 마커와 검색결과 항목에 mouseover 했을때
		// 해당 장소에 인포윈도우에 장소명을 표시합니다
		// mouseout 했을 때는 인포윈도우를 닫습니다
		(function(marker, title) {
			kakao.maps.event.addListener(marker, 'click',
					(function(placePosition) {
						displayInfowindow(marker, title);

						return function() {
							console.log("placePosition.La:"
									+ placePosition.La);
							console.log("placePosition.Ma:"
									+ placePosition.Ma);
							console.log("placeName:" + title);
							//console.log(); -> 브라우저 콘솔에서 출력해서 값을 볼 수 있음
							//document.getElementById("latitude").value = placePosition.La;
							//$("#longitude").val(placePosition.Ma);
							//$("#placeName").val(title);

							//#result 영역에 좌표정보 출력
							var resultDiv = document
									.getElementById('result');

							resultDiv.innerHTML = '선택하신 위치는' + '"'
									+ title + '"' + placePosition
									+ '입니다.';
						}
					})(placePosition));

			kakao.maps.event.addListener(marker, 'mouseout',
					function() {
						infowindow.close();
					});

			itemEl.onmouseover = function() {
				displayInfowindow(marker, title);
			};

			itemEl.onmouseout = function() {
				infowindow.close();
			};
		})(marker, places[i].place_name);

		fragment.appendChild(itemEl);
	}

	// 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
	listEl.appendChild(fragment);
	menuEl.scrollTop = 0;

	// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

	var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
			+ (index + 1)
			+ '"></span>'
			+ '<div class="info">'
			+ '   <h5>' + places.place_name + '</h5>';

	if (places.road_address_name) {
		itemStr += '    <span>' + places.road_address_name + '</span>'
				+ '   <span class="jibun gray">' + places.address_name
				+ '</span>';
	} else {
		itemStr += '    <span>' + places.address_name + '</span>';
	}

	itemStr += '  <span class="tel">' + places.phone + '</span>'
			+ '</div>';

	el.innerHTML = itemStr;
	el.className = 'item';

	return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
	var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
	imgOptions = {
		spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		offset : new kakao.maps.Point(13, 37)
	// 마커 좌표에 일치시킬 이미지 내에서의 좌표
	}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
			imgOptions), marker = new kakao.maps.Marker({
		position : position, // 마커의 위치
		image : markerImage
	});

	marker.setMap(map); // 지도 위에 마커를 표출합니다
	markers.push(marker); // 배열에 생성된 마커를 추가합니다

	return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
	for (var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
	var paginationEl = document.getElementById('pagination'), fragment = document
			.createDocumentFragment(), i;

	// 기존에 추가된 페이지번호를 삭제합니다
	while (paginationEl.hasChildNodes()) {
		paginationEl.removeChild(paginationEl.lastChild);
	}

	for (i = 1; i <= pagination.last; i++) {
		var el = document.createElement('a');
		el.href = "#";
		el.innerHTML = i;

		if (i === pagination.current) {
			el.className = 'on';
		} else {
			el.onclick = (function(i) {
				return function() {
					pagination.gotoPage(i);
				}
			})(i);
		}

		fragment.appendChild(el);
	}
	paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
	var content = '<div style="padding:5px;z-index:1;">' + title
			+ '</div>';

	infowindow.setContent(content);
	infowindow.open(map, marker);
}

// 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {
	while (el.hasChildNodes()) {
		el.removeChild(el.lastChild);
	}
}
</script>
<!-- //container -->
</div>
<!-- footer -->
<jsp:include page="/WEB-INF/view/include/footer.jsp" />
<!-- //footer -->
</body>
</html>