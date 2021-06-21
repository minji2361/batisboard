<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="col-lg-12">
		<div class="card">
			<div class="card-header with-border">
				<h3 class="card-title">댓글</h3> 
			</div>
			<c:if test="${sessionScope.nickName != null }">
			<div class="card-body">
			<div class="row">
				<div class="form-group col-sm-8">
				<input class="form-control input-sm" id="newReplyText" type="text" name="replyText" placeholder="댓글 입력...">
				</div>
				<div class="form-group col-sm-2"> 
				<input class="form-control input-sm" id="newReplyWriter" type="text" name="nickName" placeholder="작성자">
				</div>
				<div class="form-group col-sm-2">
				<button type="button" class="btn btn-primary btn-sm btn-block replyAddBtn">
				<i class="fa fa-save"></i> 저장 </button>
				</div>
			</div>
			</div>
						</c:if>
			<div class="card-footer"> 
				<ul id="replies">
				</ul>
			</div>
			<div class="card-footer">
				<nav aria-label="Contacts Page Navigation">
				<ul class="pagination pagination-sm no-margin justify-content-center m-0">
				
				</ul>
				</nav>
			</div>

		</div> 
	</div> 
	
	
	
	<div class="modal fade" id="modifyModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">댓글 수정창</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="replyNumber">댓글 번호</label>
						<input class="form-control" id="replyNumber" name="replyNumber" readonly>
					</div>
					<div class="form-group">
						<label for="replyText">댓글 내용</label>
						<input class="form-control" id="replyText" name="replyText" placeholder="댓글 내용을 입력해주세요">
					</div>
					<div class="form-group"> 
						<label for="nickName">댓글 작성자</label>
						<input class="form-control" id="nickName" name="nickName" readonly> 
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-success modalModBtn">수정</button> 
					<button type="button" class="btn btn-danger modalDelBtn">삭제</button>
				</div>
			</div>
		</div>
	</div>

<script>
	
	//댓글 목록
	 var boardNumber = 8; 
	 // 댓글 목록 호출
	 getReplies(); 
	 // 댓글 목록 출력 함수 
	 function getReplies() { 
		 $.getJSON("${path}/all/" + boardNumber, function (data) { 
			 console.log(data); 
			 var str = ""; 
			 
			 $(data).each(function () { 
				 str += "<li data-replyNumber='" + this.replyNumber + "'class='replyLi'>" 
				 	 + "<p class='replyText'>" + this.replyText + "</p>" 
				 	 + "<p class='nickName'>" + this.nickName + "</p>" 
				 	 + "<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>" 
				 	 + "</li>" 
				 	 + "<hr/>"; 
			  }); 
			 
			 $("#replies").html(str); 
		});
	}
	 
	 
	 
	//댓글 등록 
	 $(".replyAddBtn").on("click",function() { 
		 
		 // 화면으로부터 입력 받은 변수값의 처리 
		 var replyText = $("#newReplyText"); 
		 var nickName = $("#newnickName");
		 
		 var replyTextVal = replyText.val(); 
		 var nickNameVal = nickNameVal.val();
		 
		 // AJAX 통신 : POST 
		 $.ajax({ 
			 type : "post", 
			 url : "${path}/", 
			 headers : { 
				 "Content-type" : "application/json", 
				 "X-HTTP-Method-Override" : "POST" 
		  	 }, 
		  	 dataType : "text", 
		  	 data : JSON.stringify({ 
		  		 boardNumber : boardNumber, 
		  		 replyText : replyTextVal, 
		  		 nickName : nickNameVal

		  	  }), 
		  	  success : function (result) { 
		  		  // 성공적인 댓글 등록 처리 알림 
		  		  if (result == "regSuccess") {
		  			  alert("댓글 등록 완료!"); 
		  		  } 
		  		  getReplies(); // 댓글 목록 출력 함수 호출 
		  		  replyText.val(""); // 댓글 내용 초기화 
		  		  nickName.val(""); // 댓글 내용 초기화 

		  	    } 
		  	}); 
		 });
	 
	
	//댓글 수정창 띄우기
	$("#replies").on("click", ".replyLi button", function () { 
		var reply = $(this).parent(); 
		
		var replyNumber = reply.attr("date-replyNumber"); 
		var replyText = reply.find(".replyText").text(); 
		var nickName = reply.find(".nickName").text(); 
		
		$("#replyNumber").val(replyNumber); 
		$("#replyText").val(replyText); 
		$("#nickName").val(nickName); 
		
	});

	
	//댓글 수정
	$(".modalModBtn").on("click", function () { 
		
		// 댓글 선택자 
		var reply = $(this).parent().parent(); 
		// 댓글번호
		var replyNumber = reply.find("#replyNumber").val(); 
		// 수정한 댓글내용 
		var replyText = reply.find("#replyText").val(); 
		
		// AJAX통신 : PUT 
		$.ajax({ 
			type : "put", 
			url : "${path}/" + replyNumber, 
			headers : { 
				"Content-type" : "application/json", 
				"X-HTTP-Method-Override" : "PUT" 
			}, 
			data : JSON.stringify( 
				{replyText : replyText} 
			), 
			dataType : "text", 
			success : function (result) { 
				console.log("result : " + result); 
				if (result == "modSuccess") { 
					alert("댓글 수정 완료!"); 
					$("#modifyModal").modal("hide"); // Modal 닫기
					getReplies(); // 댓글 목록 갱신 
				} 
			} 
		}); 
	});
	
	
	
</script>	
	
	
</body>
</html>