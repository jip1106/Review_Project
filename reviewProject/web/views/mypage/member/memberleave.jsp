<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>memberleave</title>
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
    	function memberDel(){
    		if(confirm("정말 탈퇴하시겠습니까?")){
    			if(document.getElementById('password').value == document.getElementById('password').getAttribute("target")){
    				submit();	
    			}else{
    				alert("비밀번호를 확인해주세요");
    				return false;
    			}
    			
    		}else{
    			return false; 
    		} 
    	}
    </script>
</head>
<body>
<%@ include file="../../../header.jsp" %>
<%@ include file="leftmenu.jsp" %>

<div class="container">
	<div class="row">

		<div style="margin-left: 10%; margin-right: 10%;">
			<form action="/review/mdelete" method="post" id="memberDeleteForm" onsubmit="return memberDel()">
				<!-- Tab content -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="personal-info">
						<h3 style="color: black;"><b>회원 탈퇴</b></h3>
						<div class="table-responsive">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">아이디</th>
										<td><input type="text" id= "id" name="id" class="form-control" value=<%=member.getId() %> readonly><td> 
									</tr>
									<tr>
										<th scope="row">비밀번호</th>
										<td><input type="password" id="password" name="password" target=<%=member.getPassword()%> class="form-control" placeholder="비밀번호 입력하세요" required></td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- / .table-responsive -->
					</div>
					<br><br>
					<div align="center"> 
						<input type="submit" class="btn btn-primary" value="탈퇴하기" style="width: 150px; background: red;"> &nbsp;
						<input type="reset" class="btn btn-primary" value="취소하기" style="width: 150px; background: red;"> 
					</div>
				
				</div>
				<!-- / .tab-content -->
			</form>
			
		</div> 


	</div>
	<!-- / .row -->

</div>
<%@ include file="../../../footer.jsp" %>
</body>
</html>