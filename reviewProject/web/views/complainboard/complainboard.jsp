<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberComplainBoard.model.vo.ComplainBoard, java.util.ArrayList"%>
	<%
	ArrayList<ComplainBoard> list = (ArrayList<ComplainBoard>)request.getAttribute("list");
	int listCount = ((Integer)request.getAttribute("listCount")).intValue();
	int currentPage = ((Integer)request.getAttribute("Page")).intValue();
	
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	
	String searchValue = (String)request.getAttribute("searchValue");
	String searchKeyWord = (String)request.getAttribute("searchKeyWord");
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
<%@ include file="../../header.jsp" %>

<br>
<div align="left"  style="margin-left: 10%; margin-right: 10%">
			<div align="left">
			<form class="form-group" role="form" action="/review/csearch" method="get" >
				<select class="btn" name="searchValue" id="findType" style="height: 30px; color: #ffffff;">
					<option value="findByTitle">제목</option>
				</select> 
				<input style="height: 25px; width: 200px;" name ="searchKeyWord" type="search"
					id="searchKeyWord" placeholder="제목으로 검색" class="btn2">
				<button type="submit" id="searchSubmit" value="검색" class="btn" style="background-color:#4D81B0; color: #ffffff">검색</button>
			&nbsp;&nbsp;&nbsp;&nbsp;	
			</form>
</div>
</div>
<div align="left" style="margin-left: 10%; margin-right: 10%">
	<h2>신고게시판</h2>
		<%if(searchKeyWord == null){ %>
		<h3>전체 게시글 수 : <%= listCount %></h3>
		<%}else{ %>
		<h3> 검색된 게시글 수 : <%= request.getAttribute("SearchCount") %></h3>
		<%} %>
		<div class="table-responsive">
		<table class="table table-striped table-bordered">
			<caption>불건전한 게시글 신고해주세요</caption>
			
				<tr>
						<th style="background-color: #4D81B0; text-align: center; color: white;">글번호</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">제목</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">작성자</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">작성일</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">조회수</th>
				</tr>
		
			<%
			for(ComplainBoard cb : list){
				%>
			<tr>
					<td style="text-align: center;"><%= cb.getPostingNo() %></td>
					<td style="text-align: center;"><a style="color:red" href="/review/cdetail?bnum=<%= cb.getPostingNo() %>&Page=<%= currentPage %>"><%= cb.getTitle() %></a></td> 
					<td style="text-align: center;"><%= cb.getId() %></td>
					<td style="text-align: center;"><%= cb.getPostingDate() %></td>
					<td style="text-align: center;"><%= cb.getHits() %></td>
				</tr>
				<% } %>
		</table>
		<!-- 글작성버튼 -->
	<br>
	<div  id="ui_buttons" align="right" >
		<a href="/review/views/complainboard/complainboardWriteForm.jsp" class="btn" style="background:red">글작성</a>
	</div>
	</div>
	
	<!-- / .table-responsive -->
	
<!-- <<<<<<< HEAD

	글작성버튼
	<div class="ui__section" id="ui_buttons" align="right">
		<a href="/review/views/complainboard/complainboardWriteForm.jsp" class="btn btn-sm btn-primary">글작성</a>
	 
	</div>

=======
	
	
>>>>>>> somi -->
	<!-- paging -->
	<br>
	<div id="ui_pagination" align="center">
		<nav>
			<ul class="pagination">
			<% if(searchKeyWord == null || searchKeyWord.equals("")) {%>
			<% if(currentPage <= 1){ %>
					<li><span aria-hidden="true">««</span></li>
				<%}else{ %>
					<li><a href="/review/clist?Page=<%= currentPage-1 %>" aria-label="Previous"><span
								aria-hidden="true">««</span></a></li>
				<% } %>
				
				<% for(int p = startPage; p<=endPage; p++){ 
					if(p==currentPage){%>
						<li class="active"><a><%= p %></a></li>
			 <%}else{ %>
			 	<li><a href="/review/clist?Page=<%= p %>"><%= p %></a></li>
			<% } %>
			<%} %>
			<%if(currentPage>=maxPage){ %>
				<li><span aria-hidden="true">»»</span></li>		
			<%}else{%>
			<li><a href="/review/clist?Page=<%= currentPage+1 %>"
				 aria-label="Next"><span aria-hidden="true">»»</span></a></li>
			<%} %>
			<%}else{ %>
			
			
			<!-- 여기부터 검색 -->
				<% if(currentPage <= 1){ %>
					<li><span aria-hidden="true">««</span></li>
				<%}else{ %>
					<li><a href="/review/csearch?searchValue=<%= searchValue%>&searchKeyWord=<%= searchKeyWord%>&Page=<%= currentPage-1 %>" aria-label="Previous"><span
								aria-hidden="true">««</span></a></li>
				<% } %>
				
				<% for(int p = startPage; p<=endPage; p++){ 
					if(p==currentPage){%>
						<li class="active"><a><%= p %></a></li>
			 <%}else{ %>
			 	<li><a href="/review/csearch?searchValue=<%= searchValue%>&searchKeyWord=<%= searchKeyWord%>&Page=<%= p%>"><%= p %></a></li>
			<% } %>
			<%} %>
			<%if(currentPage>=maxPage){ %>
				<li><span aria-hidden="true">»»</span></li>		
			<%}else{%>
			<li><a href="/review/csearch?searchValue=<%= searchValue%>&searchKeyWord=<%= searchKeyWord%>&Page=<%= currentPage+1 %>"
				 aria-label="Next"><span aria-hidden="true">»»</span></a></li>
				 
			<%}} %>
			</ul>
		</nav>
	</div>
	<!-- / .ui__section -->
</div>
</body>
</html>