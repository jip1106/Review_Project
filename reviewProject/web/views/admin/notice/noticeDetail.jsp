<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="adminNotice.model.vo.Notice,adminNotice.model.service.NoticeService,adminNotice.model.dao.NoticeDao" %>
<%
	Notice notice = (Notice)request.getAttribute("notice");
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

	<style type="text/css">
.btn {
	background: #4D81B0;
	background-image: -webkit-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: -moz-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: -ms-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: -o-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: linear-gradient(to #4D81B0, #4D81B0, #4D81B0);
	-webkit-border-radius: 4;
	-moz-border-radius: 4;
	border-radius: 4px;
	font-family: Arial;
	color: #ffffff;
	font-size: 20px;
	padding: 10px 20px 10px 20px;
	text-decoration: none;
}

.btn:hover {
	background: #C2D6E9;
	background-image: -webkit-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: -moz-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: -ms-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: -o-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: linear-gradient(to bottom, #C2D6E9, #C2D6E9);
	text-decoration: none;
}


</style>   	
</head>
<body>
<%@include file="../../../../header.jsp" %>

<%if(member.getUserType()==0){ %><!-- 관리자 -->
<div class="container">
	<div align="left" style="margin-left: 10%; margin-right: 10%">  
		<div style="float: left;">
			<span class="badge">No. <%=notice.getPostingNo() %></span>
			<span class="badge">조회수 : <%=notice.getHits() %></span>
			<span class="badge">날짜 : <%=notice.getPostingDate() %></span>
		</div>
		 <div style="float: right;">
			  <font color="red">작성자 : </font><font color="black"><%=notice.getId() %> </font>
		</div>
		 <br><br>
				<div class="well well"><%=notice.getTitle() %></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%=notice.getContent() %></td>
						</tr>
					</table>
					<br><br><br><br><hr>
				</div>
				<div align="center">
					
						<%if(member.getId().equals(notice.getId())){ %>
						
							<a href="/review/noticeupdateservlet?postno=<%=notice.getPostingNo()%>&title=<%=notice.getTitle()%>&content=<%=notice.getContent()%>" class="btn btn-primary" style="background: red; width: 100px;">수정하기</a> 						
							<a href="/review/noticedel?postno=<%=notice.getPostingNo()%>" class="btn btn-primary" style="background: red; width: 100px;">공지사항 삭제</a> 
						<%}%>
							<a href="views/admin/main/adminMain.jsp" class="btn btn-primary" style="background: red; width: 100px;">메인으로</a>						
					</div>
				</div>
			</div>
<%}else{ %> <!-- 사용자 -->
<div class="container">
	 <div align="left" style="margin-left: 10%; margin-right: 10%">  
		<div style="float: left;">
			<a href="#"><span class="badge">No. <%=notice.getPostingNo() %></span></a> <a
				href="#"><span class="badge">조회수 : <%=notice.getHits() %></span></a> <a
				href="#"><span class="badge">날짜 : <%=notice.getPostingDate() %></span></a>
		</div>
		 <div style="float: right;">
			<font color="red">작성자 : </font><font color="black"><%=notice.getId() %> </font>
		</div>
	<br><br>
				<div class="well well"><%=notice.getTitle() %></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%=notice.getContent() %></td>
						</tr>
					</table>
					 <br><br><br><br><hr>
				</div>
				   <div align="center">
						<a href="views/main/main.jsp" class="btn btn-primary" style="background: red; width: 100px;">메인으로</a>						
				</div>
			</div>
		</div>
<%} %>
<%@include file="../../../../footer.jsp" %>
</body>
</html>