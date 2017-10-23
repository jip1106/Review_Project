<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<div class="col-sm-8">
			<h3 class="header">Notice Write</h3>
			<p class="text-muted"><%= member.getName() %> 관리자님 공지사항을 등록하세요</p>
			<form role="form" name="noticeWrite" action="/review/nwrite" onsubmit="">
				<div class="form-group">
					<label for="title">Title</label> 
					<input type="text" name="title" class="form-control" id="title" placeholder="title"> 
					<span class="help-block"></span>
				</div>
				
				<div class="form-group">
					<label for="content">Content</label>
					<textarea cols="20" rows="20" name="content" class="form-control"  id="content" placeholder="content"></textarea>
					 <span class="help-block"></span>  
				</div>
				
				<input type="hidden" name="id" value="<%=member.getId() %>">
				
				
								
				<button type="submit" class="btn btn-primary">글작성</button>
				<button type="reset" class="btn btn-primary" onclick="reviewWriteCancel()">작성 취소</button>
				<button class="btn btn-primary" onclick="goMain();">메인 화면으로</button>
			</form>

		</div>
		</div>
</div>

</body> 
</html>