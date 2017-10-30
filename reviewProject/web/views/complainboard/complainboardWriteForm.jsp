<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberComplainBoard.model.vo.ComplainBoard"%>
<%
    ComplainBoard Complainboard = (ComplainBoard)request.getAttribute("ComplainBoard");
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
<script type="text/javascript">	
	<%-- function pleaseInputMessage(){
		var reviewNum = $("#reviewNum").val();
		var reviewTitle = $("#reviewTitle").val();
	
		if(reviewNum=="" || reviewTitle==""){
			alert("신고할 게시글의 글 번호와 글 제목을 입력해 주세요");
			return false;
		}else{	//리뷰게시판에서 신고 버튼 누른 경우 전달받은 신고게시물을 처리
			location.href = "/review/adminReceiveReviewinfo?reviewNo=<%=reviewNo%>&reviewTitle=<%=reviewTitle%>";
			return true;
		}
	} --%>
</script>
<div class="container">
	<div class="row">
		<div class="col-sm-8">
			<h3 class="header">Complainboard Write</h3>
			<p class="text-muted">불 건전한 게시글을 신고해 주세요</p>
			<form role="form" action="/review/cinsert" method="post">
			<input type="hidden" name="id" value="<%= member.getId() %>">
				<div class="form-group">
					<label for="title">Title</label> 
					<input type="text" name="title" class="form-control" id="title" placeholder="title"> 
					<span class="help-block"></span>
				</div>
				<!-- 수정한 부분 -->
				<%-- <%if(reviewNo==0){ %>
					<div class="form-group">
						<label for="reviewNum">신고 게시물 글 번호</label> 
						<input type="text" name="reviewNum" class="form-control" id="reviewNum" placeholder="신고할  게시물 번호" style="width:50%"> 
						<span class="help-block"></span>
					</div>
					<div class="form-group">
						<label for="reviewNum">신고 게시물 글 제목</label> 
						<input type="text" name="reviewTitle" class="form-control" id="reviewTitle" placeholder="신고할  게시물 제목" style="width:50%"> 
						<span class="help-block"></span>
					</div>
				<%}else{ %>
					<div class="form-group">
						<label for="reviewNum">신고 게시물 글 번호</label> 
						<input type="text" name="reviewNum" class="form-control" id="reviewNum" placeholder="신고할  게시물 번호" style="width:50%" value=<%=reviewNo %> readonly> 
						<span class="help-block"></span>
					</div>
					<div class="form-group">
						<label for="reviewNum">신고 게시물 글 제목</label> 
						<input type="text" name="reviewTitle" class="form-control" id="reviewTitle" placeholder="신고할  게시물 제목" style="width:50%" value=<%=reviewTitle %> readonly> 
						<span class="help-block"></span>
					</div>
				<%} %> --%>
				<!-- 수정 부분 끝 -->
				
				
				<div class="form-group">
					<label for="content">Content</label>
					<textarea cols="20" rows="20" name="content" class="form-control"  id="content" placeholder="content"></textarea>
					 <span class="help-block"></span>  
				</div>
				<!-- <div class="form-group">
					<label for="image">image</label> <input type="file" name="image"
						class="form-control" id="image" placeholder="picture"> <span
						class="help-block"></span>
				</div> -->
				<!-- 바꾼부분 -->
					<button type="submit" class="btn btn-primary" onclick="return pleaseInputMessage();" style="background:#4D81B0">글작성</button>
				
				<!-- 바꾼부분 -->
					<button type="reset" class="btn btn-primary" onclick="reviewWriteCancel()" style="background:#4D81B0">작성 취소</button>
					<button type="submit" class="btn btn-primary" onclick="/review/clist" style="background:#4D81B0">돌아가기</button>
			</form>

		</div>
		</div>
</div>
</body>
</html>