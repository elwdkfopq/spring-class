<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
			<div class="panel-heading">Panel Heading</div>
			<div class="panel-body">Panel Content</div>

			<form action="join.do" method="post">
			
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<table class="table table-bordered table-hover">
					<tr>
						<td>아이디</td>
						<td><input type="text" name="id" class="form-control"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pw" class="form-control"></td>
					</tr>
					<tr>
						<td>닉네임</td>
						<td><input type="text" name="nick" class="form-control"></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<button type="submit" class="btn btn-warning">회원가입</button>
							<button type="reset" class="btn btn-danger">취소</button>
							<a href="/controller/"><button type="button" class="btn btn-info">목록</button></a>
						</td>
					</tr>
				</table>
			</form>
			<div class="panel-footer">Panel Footer</div>
		</div>
	</div>

</body>
</html>
