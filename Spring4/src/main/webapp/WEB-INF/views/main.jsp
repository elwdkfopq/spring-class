<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container">
		
		<jsp:include page="header.jsp"></jsp:include>
		<h2>Spring version 3.</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Member</div>
			<div class="panel-body" id="list">
				
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<td>번호</td>
							<td>제목</td>
							<td>작성자</td>
							<td>작성일</td>
							<td>조회수</td>
						</tr>
					</thead>
					<tbody id="view">

					</tbody>
					<tfoot>
						<tr>
							<td colspan="5">
								<button id="goForm" class="btn btn-primary">글쓰기</button>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>

			<!-- 글쓰기 폼 -->
			<div style="display: none;" class="panel-body" id="wform">
				<form action="_URL" method="POST" id="uploadForm"
					enctype="multipart/form-data">
					<table class="table table-hover">
						<tr>
							<td>제목</td>
							<td><input class="form-control" type="text" name="title"
								id="title"></td>
						</tr>
						<tr>
							<td>파일</td>
							<td><input class="form-control" type="file" name="imgpath"
								id="imgpath"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea class="form-control" id="content"
									name="content" rows="7" cols=""></textarea></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td><input class="form-control" type="text" name="writer"
								id="writer"></td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<button id="goInsert" type="button" class="btn btn-warning">글작성</button>
								<button id="fclear" type="reset" class="btn btn-danger">취소</button>
								<button id="goList" type="button" class="btn btn-info">목록</button>
							</td>
						</tr>

					</table>
				</form>
			</div>

			<div class="panel-footer">스프링게시판 - 박병관</div>
		</div>
	</div>





	<script type="text/javascript">
	
	let csrfName = "${_csrf.headerName}";
	let csrfToken = "${_csrc.token}";
	
		$(document).ready(function() {
			// HTML 문서가 전부 로딩되고 실행되는 부분
			
			

			loadList();

			// 글쓰기 버튼 눌렀을때 게시판은 가리고 글작성 폼은 보여주는 기능
			$("#goForm").on("click", function() {
				$("#list").css("display", "none");
				$("#wform").css("display", "block");
			});

			// 목록 버튼 눌렀을때 글작성은 가리고 게시판을 보여주는 기능
			$("#goList").on("click", function() {
				$("#list").css("display", "block");
				$("#wform").css("display", "none");
			});

			// 글쓰기 기능 (파일업로드)
			$("#goInsert").on("click", function() {

				let form = document.getElementById("uploadForm");
				let data = new FormData(form);

				$.ajax({
					url : "boardInsert.do",
					type : "post",
					enctype : "multipart/form-data",
					data : data,
					processData : false,
					contentType : false,
					cache : false,
					timeout : 600000,
					success : loadList,
					error : function() {
						alert("error...");
					}
				});

				$("#fclear").trigger("click");

			});

		});

		// 게시글 상세보기 기능
		function goContent(idx) {
			if ($("#c" + idx).css("display") == "none") {
				$("#c" + idx).css("display", "table-row");
			} else {
				$("#c" + idx).css("display", "none");

				// 게시글 조회수 올리기 기능
				$.ajax({
					url : "boardCount.do/" + idx,
					type : "get",
					success : loadList,
					error : function() {
						alert("error...");
					}
				});

			}
		}

		// 게시글 삭제 기능
		function goDelete(idx) {
			$.ajax({
				url : "boardDelte.do/" + idx, // boardDelte.do?idx=7 -> boardDelte.do/7
				type : "post",
				success : loadList,
				error : function() {
					alert("error...");
				}
			});
		}

		function loadList() {
			
			$.ajax({
				url : "boardList.do",
				type : "get",
				dataType : "json",
				success : makeView,
				error : function() {
					alert("error...");
				}
			});
		}

		function makeView(data) {
			// 서버에서 게시글 데이터 가져오기 성공했을때 실행되는 함수
			console.log(data);
			let list = "";

			$
					.each(
							data,
							function(index, obj) {
								list += "<tr>";
								list += "<td>" + (index + 1) + "</td>";
								list += "<td id='t"+obj.idx+"'>";
								list += "<a href='javascript:goContent("
										+ obj.idx + ")'>";
								list += obj.title + "</a></td>";
								list += "<td>" + obj.writer + "</td>";
								list += "<td>" + obj.indate + "</td>";
								list += "<td>" + obj.count + "</td>";
								list += "</tr>";

								// 상세내용 보여주기
								list += "<tr id='c"+ obj.idx +"' style='display:none'>";
								list += "<td>내용</td>";
								list += "<td colspan='4'>";
								if (obj.imgpath != null) {
									list += "<img width='200px' src='resources/board/"+ obj.imgpath +"'>";
								} else {
									list += "<img width='200px' src='resources/board/aischool.jpg'>";
								}

								list += "<br>";
								list += "<textarea id='ta"+ obj.idx +"' style='background-color : white;' class='form-control' row='7' readonly >";
								list += obj.content;
								list += "</textarea>";

								// 수정, 삭제 버튼 추가
								list += "<br>";
								list += "<span id='ub" + obj.idx + "'>";
								list += "<button onclick='goUpdateForm("
										+ obj.idx
										+ ")' class='btn btn-warning btn-sm'>수정</button>";
								list += "</span>";

								list += "&nbsp;&nbsp;<button onclick='goDelete("
										+ obj.idx
										+ ")' class='btn btn-danger btn-sm'>삭제</button>";
								list += "</td>";
								list += "</tr>";
							});

			$("#view").html(list);

			$("#list").css("display", "block");
			$("#wform").css("display", "none");
		}

		// 수정화면으로 만드는 기능
		function goUpdateForm(idx) {
			$("#ta" + idx).attr("readonly", false);

			let title = $("#t" + idx).text();

			let newInput = "<input id='nt"+idx+"' type='text' class='form-control' value='" + title + "' >";

			$("#t" + idx).html(newInput);

			let newButton = "<button onclick='goUpdate(" + idx
					+ ")' class='btn btn-primary btn-sm'>수정하기</button>";

			$("#ub" + idx).html(newButton);

		}

		// 수정기능
		function goUpdate(idx) {

			let title = $("#nt" + idx).val();
			let content = $("#ta" + idx).val();

			console.log(title + "/" + content);

			$.ajax({
				url : "boardUpdate.do",
				type : "post",
				data : {
					"idx" : idx,
					"title" : title,
					"content" : content
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfName, csrfToken)
				},
				success : loadList,
				error : function() {
					alert("error...");
				}

			});

		}
	</script>
</body>
</html>

















































































