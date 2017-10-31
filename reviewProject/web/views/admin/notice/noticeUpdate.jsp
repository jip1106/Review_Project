<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int postNo = Integer.parseInt(request.getParameter("postno"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	System.out.println("수정하는 페이지"+postNo);
	System.out.println("수정하는 페이지"+title);
	System.out.println("수정하는 페이지"+content);
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

	<script type="text/javascript">
		function goMain(){
			location.href = "../main/adminMain.jsp";
		}
	</script>
</head>
<body>

<%@ include file = "../../../../header.jsp" %>
<div class="container">
	<div class="row">
		<div align="left" style="margin-left: 15%; margin-right: 15%">
			<h3 style="color: black;"><b>공지사항 수정하기</b></h3>
			<p class="text-muted"><%= member.getName() %> 관리자님 공지사항을 수정하세요</p>
			<form role="form" name="noticeWrite" action="/review/noticeUpdateSuccess">
				<div class="form-group">
					<label for="title">Title</label> 
					<input type="text" name="title" class="form-control" id="title" value="<%=title%>"> 
					<!-- UpdateSuccess 서블릿으로 보냄 -->
					<span class="help-block"></span>
				</div>
				
				<div class="form-group">
					<label for="content">Content</label>
					<textarea cols="20" rows="20" name="content" class="form-control"  id="content" >
						<%=content %>
					</textarea>
					 <!-- UpdateSuccess 서블릿으로 보냄 -->
					 <span class="help-block"></span>  
				</div>
				
				<input type="hidden" name="postno" value="<%=postNo %>">
				<!-- UpdateSuccess 서블릿으로 보냄 -->				
						<div align="center">		
				<button type="submit" class="btn btn-primary" style="width: 100px; background: red; color: white">수정하기</button>
				<button type="reset" class="btn btn-primary" style="width: 100px; background: red; color: white" onclick = "reviewWriteCancel()">작성 취소</button>
				<button  class="btn btn-primary" style="width: 100px; background: red; color: white" onclick="javascript:history.go(-1); return false">뒤로가기</button>
				</div>
			</form>

		</div>
		</div>
</div>
<%@ include file = "../../../../footer.jsp" %>
</body> 
</html>