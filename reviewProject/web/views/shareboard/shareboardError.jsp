<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shareboardError</title>
</head>
<body>
<h2>정보공유 게시판 에러 : <%= request.getAttribute("errorMessage") %></h2>
</body>
</html>