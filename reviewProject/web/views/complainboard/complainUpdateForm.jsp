<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberComplainBoard.model.vo.ComplainBoard"%>
    <%
    	ComplainBoard Complainboard = (ComplainBoard)request.getAttribute("Complainboard");
    	int currentPage = (Integer)request.getAttribute("Page");
    
    %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta charset=utf-8>
    <!--<link rel="icon" href="img/favicon.ico">-->
	
	<!-- CSS Global -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet">

    <!-- CSS Plugins -->
    <link href="${pageContext.request.contextPath}/resources/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/animate.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700' rel='stylesheet' type='text/css'>
</head>
<body>
<%@ include file = "../../header.jsp" %>
<div class="container">
	<div class="row">
		<div align="left" style="margin-left: 15%; margin-right: 15%">
			<h3 style="color: black;"><b>Complainboard Write</b></h3><br>
			<p class="text-muted">불건전한 게시글을 신고해 주세요</p>
			<form role="form" action="/review/cup?bnum=<%=Complainboard.getPostingNo() %>&Page=<%=currentPage %>" method="post">
			<input type="hidden" name="postno" value="<%= Complainboard.getPostingNo() %>">
				<div class="form-group">
					<label for="title">Title</label> 
					<input type="text" name="title" class="form-control" id="title" placeholder="title"
						value="<%= Complainboard.getTitle() %>"> 
					<span class="help-block"></span>
				</div>
				<div class="form-group">
					<label for="content">Content</label>
					<textarea cols="20" rows="20" name="content" class="form-control"  id="content" placeholder="content"><%= Complainboard.getContent() %>
					</textarea>
					 <span class="help-block"></span>  
				</div>
				<!-- <div class="form-group">
					<label for="image">image</label> <input type="file" name="image"
						class="form-control" id="image" placeholder="picture"> <span
						class="help-block"></span>
				</div> -->
				<div align="center">
					<button type="submit"  class="btn btn-primary" style="width: 100px; background: red; color: white">수정하기</button>
					<button type="reset" class="btn btn-primary" style="width: 100px; background: red; color: white">작성 취소</button>
					<button  class="btn btn-primary" style="width: 100px; background: red; color: white" onclick="javascript:history.go(-1); return false">뒤로가기</button>
				</div>
			</form>

		</div>
		</div>
</div>
<%@ include file = "../../footer.jsp" %>
</body>
</html>