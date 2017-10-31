<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.model.vo.Member,member.model.service.MemberService,member.model.dao.MemberDao"%>
<%@ page import = "memberSharedBoard.model.vo.SharedBoard,memberSharedBoard.model.service.SharedBoardService,memberSharedBoard.model.dao.SharedBoardDao"%>
<%@ page import = "java.util.*" %> 

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
    
    <style>
      	button.btn:hover{
		background: #e9c2c2;
	}
	
	button.btn{
		background: red;
	}
    </style>
    
</head>
<body>
<%@ include file="../../../header.jsp" %>
<%@ include file="leftmenu.jsp" %> 

<%
	String id = member.getId();
	int currentPage = 1;
	
	if(request.getParameter("page") !=null){
		currentPage = Integer.parseInt(request.getParameter("page"));
	}
	int limit = 5;
	int mySharedlistCount = new MemberService().getMyShareBoardWriteCount(id);
	int maxPage = (int)((double)(mySharedlistCount)/limit+0.9);
	int startPage = ((int)((double)currentPage/limit + 0.9)-1)*limit+1;
	int endPage = startPage+limit-1;
	
	if(maxPage<endPage){
		endPage = maxPage;
	}
	
	ArrayList<SharedBoard> sboardList = new MemberService().viewMySharedBoard(id, currentPage, limit); 
%>
<div align="left" style="margin-left: 10%; margin-right: 10%">  
	<h2 style="color: black;"><b>내가 작성한 정보공유 게시글</b></h2>
	<h2>내가 작성한 정보공유 게시판 글 수 : <%= new MemberService().getMyShareBoardWriteCount(member.getId()) %></h2>
	<div class="table-responsive">
		<table class="table table-striped table-bordered">
				<tr>
					<th style="background-color: #4D81B0; text-align: center; color: white;">글번호</th>
					<th style="background-color: #4D81B0; text-align: center; color: white;">제목</th>
					<th style="background-color: #4D81B0; text-align: center; color: white;">작성자</th>
					<th style="background-color: #4D81B0; text-align: center; color: white;">작성일</th>
					<th style="background-color: #4D81B0; text-align: center; color: white;">조회수</th>	
					<th style="background-color: #4D81B0; text-align: center; color: white;">삭제</th>
				</tr>
			<tbody>
				<%for(SharedBoard board : sboardList){ %>
					<tr>
						<th class="col-md-2" style="text-align: center;"> <%=board.getPostingNum() %></th>
						<td class="col-md-2" style="text-align: center;">
							<a href="/review/sdetail?no=<%=board.getPostingNum()%>&index=1&page=<%=currentPage%>" style="color: red;"> <%=board.getTitle()%></a></td> 
						<td class="col-md-2" style="text-align: center;"><%=board.getId() %></td> 
						<td class="col-md-2" style="text-align: center;"><%=board.getPostingDate()%></td>
						<td class="col-md-2" style="text-align: center;"><%=board.getHits() %></td>
						<td style="text-align:center;">
						<a href="/review/sdelete?no=<%= board.getPostingNum()%>&index=1&location=1&page=<%=currentPage%>" >
							<button class="btn" style="color: white;">게시글 삭제</button>
						</a>
						<!-- 바뀐부분 -->
						</td>
					</tr>
					
				 <%} %>
			</tbody> 
		</table>
	</div>
	<!-- / .table-responsive -->
	
	<!-- paging -->
		<div class="ui__section" id="ui_pagination" align="center">
			<nav>
				<ul class="pagination">
					
				
					<!-- 이전페이지 처리 -->
					<%if(currentPage<=1){ %> <!-- 현재 페이지가 1페이지면 이전페이지 못하게 -->
						<li><span aria-hidden="true">«««</span></li>
					<%}else{ %>	<!-- 현재 페이지가 2페이지면 이전페이지 누룰 수 있음 할 수 있음 -->
						<li><a href="/review/views/mypage/member/mysharewrite.jsp?page=<%= currentPage-1 %>" aria-label="Previous"><span
								aria-hidden="true">«««</span></a></li>	
					<%} %>
					
					<!-- 페이지 보여주기 -->
					<%for(int p = startPage; p<=endPage; p++){ 
						if(p==currentPage){%>
							<li class="active"><a><%=p %></a></li>					
						<%}else{ %>
							<li><a href = "/review/views/mypage/member/mysharewrite.jsp?page=<%=p %>"><%=p %></a></li>
						<%} %>
					<%} %>
					
					<!-- 다음페이지 처리 -->
					<%if(currentPage>=maxPage){ %>
						<li><span aria-hidden="true">»»»</span></li>					
					<%}else{ %>
						<li><a href="/review/views/mypage/member/mysharewrite.jsp?page=<%= currentPage+1 %>" aria-label="Next">
							<span aria-hidden="true">»»»</span></a></li>
					<%} %>
				</ul>
			</nav>
		</div>
</div>
</body>
</html>