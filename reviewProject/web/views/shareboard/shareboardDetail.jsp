<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberSharedBoard.model.vo.SharedBoard"%>
<%
	//int pnum = Integer.parseInt(request.getParameter("pnum"));
	SharedBoard sb = (SharedBoard)request.getAttribute("sharedBoard");
	int index = (Integer)request.getAttribute("index");
	int location = 0;

	if(index==1){
		location=1;
	}
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
<%@include file="../../header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-sm-8 col-md-9">
			<a href="#"><span class="badge">No.<%= sb.getPostingNum() %></span></a> 
			<a href="#"><span class="badge">조회수 : <%= sb.getHits() %></span></a> 	
			<a href="#"><span class="badge">날짜 : <%= sb.getPostingDate() %></span></a>
		</div>
		<div class="nav nav-pills col-md-8 text-right">
			<a href="#">작성자 : <%= sb.getId() %></a> 
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-md-9">
				<div class="well well">글제목 : <%= sb.getTitle() %></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%= sb.getContent() %></td>
						</tr>
					</table>
				</div>
				
				<div class="panel-footer">
					<div class="btn-group btn-group-justified">
				<% if(member.getId().equals(sb.getId())) {%>
						<a href="/review/supview?no=<%= sb.getPostingNum() %>" class="btn btn-default">수정</a>
						<a href="/review/sdelete?no=<%= sb.getPostingNum() %>&location=<%=location %>&index=<%= index %>" class="btn btn-default">삭제</a>
						<a href="/review/slist" class="btn btn-default">목 록</a>
				<% }else{ %>
						<a href="/review/slist" class="btn btn-default">목 록</a>
				<%} %>
					</div>
				</div>
		</div>
	</div>
</div>
</div>
<br>

	
	
<!-- 댓글공간 -->
	<div class="container">
	<div class="col-sm-8 col-md-9">
	<div class="well well">
	
	<!--  댓글 입력 테이블 -->
	<form action="/review/screply" method="get">
	<input type="hidden" name="pnum" value="<%=sb.getPostingNum() %>">
	
	<table>
	<tr>
		<th><%= member.getId() %></th> 
		<td>&nbsp; &nbsp;<textarea cols="70" rows="3"></textarea></td>
	</tr>
	</table>

<!-- 댓글 등록/취소 버튼 -->
	<div align="right">
		<input type="submit" value="댓글등록"></input>
		<input type="reset" value="작성취소"></input>
		
	</div>
	</form>
	
	</div>
	</div>
	</div>
	
	
	<!--  댓글이 표시될 영역 -->
		<div class="container">
		<div class="col-sm-8 col-md-9">
		<div>
			<table id="replylist">
			<hr>
				<tr>
					<th><%= member.getId()%></th>
					<td>&nbsp; &nbsp;
					<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
					<script type="text/javascript">
						$(function(){
							$.ajax({
								url:"/review/screply" ,
								type:"get" ,
								dataType: "json",
								success: function(data){
									var json = JSON.parse(JSON.stringify(data));
									var values="";
									for(var i in json.list){
										values += decodeURIComponent(json.list[i].content)
									}
									$('#replylist').html(values);
								}
								
								
							})
						})
					
					</script>
					</td>
				</tr>
			</table>
		</div>
	
	</div>
	</div>
	
</body>
</html>