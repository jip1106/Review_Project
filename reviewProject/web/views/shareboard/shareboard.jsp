<%@page import="adminShareBoard.model.dao.ShareBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberSharedBoard.model.vo.SharedBoard, java.util.*,
    member.model.vo.Member"%>
<% 
   ArrayList<SharedBoard> list = (ArrayList<SharedBoard>)request.getAttribute("list");
   int listCount = ((Integer)request.getAttribute("listCount")).intValue();
   int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
   int startPage = ((Integer)request.getAttribute("startPage")).intValue();
   int endPage = ((Integer)request.getAttribute("endPage")).intValue();
   int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
   String searchMenu = (String)request.getAttribute("searchMenu");
   String keyword = (String)request.getAttribute("keyword");
   
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
.col-sm-8 {
   left: 50px;
}

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

<div align="left" style="margin-left: 10%; margin-right: 10%">
		<div align="left">    
			<form class="form-group" role="form" action="/review/ssearch" method="get">
				<select id="findType" name="searchMenu" class="btn" style="height: 30px; color: #ffffff;">
				
				<%if(searchMenu!=null){ %>
					<option value="findByTitle" <%= searchMenu.equals("findByTitle")?"selected":"" %>>제목</option>
					<option value="findByWriter" <%= searchMenu.equals("findByWriter")?"selected":"" %>>작성자</option>
					<option value="findByTitleContent" <%= searchMenu.equals("findByTitleContent")?"selected":"" %>>제목+내용</option>
					<option value="findByDate" <%= searchMenu.equals("findByDate")?"selected":"" %>>작성일</option>
	
				<%}else {%>
					<option value="findByTitle" >제목</option>
					<option value="findByWriter" >작성자</option>
					<option value="findByTitleContent" >제목+내용</option>
					<option value="findByDate">작성일</option>
				<%} %>
				</select> 
				<input style="height: 25px; width: 200px;" type="text" id="searchKeyWord" name="keyword" 
				placeholder="작성일 검색 예:'17/10/27' " class="btn2">

            <button type="submit" id="searchSubmit" class="btn" style="color: #ffffff;">검색</button>
            &nbsp;&nbsp;&nbsp;&nbsp;
         </form>
      </div>
</div>

<div align="left" style="margin-left: 10%; margin-right: 10%">  

	<h2>정보공유 게시판</h2>
			<!-- 검색 유무에 따라 게시글 수 조회 -->
			<%if(keyword==null || keyword.equals("")) {%>
				<h3>전체 게시글 수 : <%= listCount %></h3>
			<%}else if(list != null){%>
				<h3>검색된 게시글 수: <%= request.getAttribute("searchCount") %></h3>
			<%}%>
			<div class="table-responsive">
			<table class="table table-striped table-bordered">
			<caption>자유로운 정보공유 부탁드립니다</caption>
					<tr>
						<th style="background-color: #4D81B0; text-align: center; color: white;">글번호</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">제목</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">작성자</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">작성일</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">조회수</th>	
					</tr>
		<% for(SharedBoard sb:list){ %>
				<tr>
					<td style="text-align: center;"><%= sb.getPostingNum() %></td>
					<td style="text-align: center;"><a href="/review/sdetail?no=<%= sb.getPostingNum()%>&page=<%=currentPage%>">
					<font color="red"><%= sb.getTitle() %></font></a></td> 
						<!-- 상세정보로 이동하는 링크입니다. -->
					<td style="text-align: center;"><%= sb.getId() %></td> 
					<td style="text-align: center;"><%= sb.getPostingDate() %></td>
					<td style="text-align: center;"><%= sb.getHits() %></td>
				</tr>
		<%} %>
		</table>
		
	</div>
	<!-- / .table-responsive -->
	<div id="ui_buttons" align="right">
		<a href="views/shareboard/shareboardWriteForm.jsp" class="btn btn-sm btn-primary" style="background: red;">글작성</a>
	</div>
	 
	
	<!-- paging -->
	<div id="ui_pagination" align="center">
		<nav>
			<ul class="pagination"> 
			
			<!-- 검색 결과에 따른 페이징 처리 -->
			<!-- 검색결과가 존재하지 않을때 전체 출력 -->
			
					 <% if(keyword==null || keyword.equals("")){ %>
					 
			<!-- 이전페이지 처리 --> 
				<% if(currentPage <= 1) { %>
				<li><span aria-hidden="true">«</span></li>
				<%}else{ %>
					<li><a href="/review/slist?page=<%=currentPage-1 %>" aria-label="Previous"><span
						aria-hidden="true">«</span></a></li>
				<%} %>
				
				<!-- 현재 페이지 처리 -->
				<%for(int p = startPage; p <= endPage; p++ ) { 
					if(p == currentPage) { %>
				<li class="active"><a><%=p %></a></li> 
			 	<% }else{ %>
			 	<li>
				<a href="/review/slist?page=<%=p%>"><%=p %>
				<span class="sr-only" >(current)</span></a></li> 
			 	<%}} %>
			
			<!-- 다음페이지 처리 -->
				<% if(currentPage >= maxPage){ %>
				 <li><span aria-hidden="true">»</span></li>
				<%}else{ %>
				<li><a href="/review/slist?page=<%=currentPage +1 %>"
				 aria-label="Next"><span aria-hidden="true">»</span></a></li>
				 <%} %>	 
				 
			<!-- 검색결과가 존재할 때   -->
				 <%}else{ %>
				 
				 <!-- 이전페이지 처리 --> 
				<% if(currentPage <= 1) { %>
				<li><span aria-hidden="true">«</span></li>
				<%}else{ %>
					<li><a href="/review/ssearch?searchMenu=<%=searchMenu %>&keyword=<%=keyword %>&page=<%=currentPage-1 %>" aria-label="Previous"><span
						aria-hidden="true">«</span></a></li>
				<%} %>
				
				<!-- 현재 페이지 처리 -->
				<%for(int p = startPage; p <= endPage; p++ ) { 
					if(p == currentPage) { %>
				<li class="active">
					<a><%=p %></a>
				</li> 
			 	<% }else{ %>
			 	<li>
				<a href="/review/ssearch?searchMenu=<%=searchMenu %>&keyword=<%=keyword %>&page=<%=p%>"><%=p %>
				<span class="sr-only"></span></a></li> 
			 	<%}} %>
			
			<!-- 다음페이지 처리 -->
				<% if(currentPage >= maxPage){ %>
				 <li><span aria-hidden="true">»</span></li>
				<%}else{ %>
				<li><a href="/review/ssearch?searchMenu=<%=searchMenu %>&keyword=<%=keyword %>&page=<%=currentPage +1 %>"
				 aria-label="Next"><span aria-hidden="true">»</span></a></li>
				 <%}}%>	 
				
			</ul>
		</nav>
	</div>
	<!-- / .ui__section -->
</div>
</body>
</html>