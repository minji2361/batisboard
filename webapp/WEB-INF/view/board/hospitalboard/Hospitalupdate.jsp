<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<!-- jquery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
﻿
<!-- ckeditor 4 -->
<link rel="stylesheet" href="${path}/resources/ckeditor/contents.css">
<!-- <script src="https://cdn.ckeditor.com/4.12.1/standard-all/ckeditor.js"></script> -->
<script type="text/javascript"
	src="${path}/resources/ckeditor/ckeditor.js"></script>
<!-- 카카오 지도 -->
<link rel="stylesheet" href="${path}/resources/css/kakaoMap.css">
﻿<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f850654c021fcb52efb271b62ce441eb&libraries=services"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>
<meta charset="UTF-8">
<title>사랑하냥? 사랑하개!</title>
</head>
<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/view/include/header.jsp" />
	<!-- //header -->

	<!-- container -->
	<form method="post" name="writeForm" action="HospitalUpdate"<%-- enctype="multipart/form-data" --%>>
	<center>
		<table>
			
			<!-- 글 수정 -->
			<c:if test="${boardVo.boardNumber != null}">
				<tr>
					<td>글쓴이&nbsp;</td>
					<td>
						<input type="text" name="writer" value="${boardVo.nickName}" readonly/>
						<input type="hidden" name="boardNumber" value="${boardVo.boardNumber}" />
					</td>
				</tr>
				<tr>
					<td>제목&nbsp;</td>
					<td>
					<input class="form-control mr-sm-2" type="text" name="title" 
					value="${boardVo.title}" style="width:1000px;"/>
					<c:if test="${memberLevel==0}&&${memberVo.boardStatus == 'y'}">
					<label>
						<input type="checkbox" id="notice" name="notice" value='n'
						check='checked' onClick="checkbox_Check()"/>
						공지글
					</label>
					</c:if>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
					<select class="custom-select" id="board_type" name="type" style="width:150px;"
						onchange="javascript:change();">
							<option value="item" <c:if test="${boardVo.type=='item'}"> selected </c:if>>멍냥잡화점</option>
							<option value="lostpet" <c:if test="${boardVo.type=='lostpet'}"> selected </c:if>>구해줘 팻즈</option>
							<option value="petplace" <c:if test="${boardVo.type=='petplace'}"> selected </c:if>>멍냥 여행사</option>
							<option value="hospital" <c:if test="${boardVo.type=='hospital'}"> selected </c:if>>멍냥 치료소</option>
							<option value="petchat" <c:if test="${boardVo.type=='petchat'}"> selected </c:if>>집사들의 수다</option>
					</select> 
					<select class="custom-select" id="board_hospital" name="subtitle"
						style="display: ;width:150px;">
							<option value="일상" <c:if test="${boardVo.subtitle=='일상'}"> selected </c:if>>일상</option>
							<option value="여행" <c:if test="${boardVo.subtitle=='여행'}"> selected </c:if>>여행</option>
							<option value="질문" <c:if test="${boardVo.subtitle=='질문'}"> selected </c:if>>질문</option>
					</select>
				</tr>
				<tr>
					<!--  <td>내용&nbsp;</td>
				<td><textarea name="content" rows="13" cols="50">${board.content}</textarea></td>  -->
					<td>내용&nbsp;</td>
					<td><textarea id="content" rows=10 name="content">${boardVo.content}</textarea>
						<script>
							CKEDITOR.replace('content'); // 에디터로 생성
						</script>
					</td>
				</tr>
				<tr>
						<td>지도</td>
						<td>
							<div class="map_wrap">
								<div id="map"
									style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
								<div id="result"></div>
								<div id="menu_wrap" class="bg_white">
									<div class="option">
										<div>
											키워드 : <input type="text" value="" id="keyword"
												size="15"> <input type="button" value="검색"
												id="searchBtn" onClick="searchPlaces()">
										</div>
									</div>
									<hr>
									<ul id="placesList"></ul>
									<div id="pagination"></div>
									<input type="hidden" id="latitude" name="latitude"> <input
										type="hidden" id="longitude" name="longitude"> <input
										type="hidden" id="mapPlace" name="mapPlace">
								</div>
							</div>
						</td>
					</tr>
				<tr>
					<td></td>
					<td>
					<input type="submit" class="btn btn-secondary my-2 my-sm-0" value="수정하기">
						<a href="hospital">
							<button class="btn btn-secondary my-2 my-sm-0">뒤로가기</button>
						</a>
					</td>
				</tr>
			</c:if>
		</table>
	</center>
	</form>

	<script>
	
	function checkbox_Check(){
        if ($("input:checkbox[name=notice]").is(":checked") == true) {
        	document.writeForm.notice.value = 'y';
        	console.log("체크됨" + document.writeForm.notice.value);
                //체크가 되어있을때.    
        } else {
        	document.writeForm.notice.value = 'n';
        	console.log("체크 해제" + document.writeForm.notice.value);
                //체크가 안되어있을때.
        }
    }
	
	<!-- 말머리 관리 스크립트 -->
		function change() {
			if ($("#board_type").val() == "item") {
				document.getElementById("board_item").style.display = "";

			} else {
				document.getElementById("board_item").style.display = "none";
			}

			if ($("#board_type").val() == "lostpet") {
				document.getElementById("board_lostpet").style.display = "";
				document.getElementById("board_lostpet1").style.display = "";
			} else {
				document.getElementById("board_lostpet").style.display = "none";
				document.getElementById("board_lostpet1").style.display = "none";
			}
			
			if ($("#board_type").val() == "petplace") {
				document.getElementById("board_petplace").style.display = "";
				document.getElementById("board_petplace1").style.display = "";
			} else {
				document.getElementById("board_petplace").style.display = "none";
				document.getElementById("board_petplace1").style.display = "none";
			}
			
			if ($("#board_type").val() == "hospital") {
				document.getElementById("board_hospital").style.display = "";
			} else {
				document.getElementById("board_hospital").style.display = "none";
			}
			
			if ($("#board_type").val() == "petchat") {
				document.getElementById("board_petchat").style.display = "";
			} else {
				document.getElementById("board_petchat").style.display = "none";
			}
		}
	
		// 마커를 담을 배열입니다
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

	<!-- footer -->
	<jsp:include page="/WEB-INF/view/include/footer.jsp" />
	<!-- //footer -->
</body>
</html>