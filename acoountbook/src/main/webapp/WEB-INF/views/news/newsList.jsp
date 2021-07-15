<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<style>
table {
border: 1px solid black;
}

tr td{
border-bottom: 1px solid grey;
font-size: 12px;
}

a{
text-decoration: none;
color: black;
font-size: 12px;
}

#writer{
color: grey;
font-size: 10px;
}

#writeDate{
color: skyblue;
font-size: 10px;
}

/* .news_btn{
  margin: 0;
  padding: 5px;

  font-size: 1rem;
  font-weight: 400;
  text-align: center;
  text-decoration: none;

  display: inline-block;
  width: auto;

  border: 1px solid black;
} */

</style>
<body>
<script type="text/javascript">
	
	// 페이지 시작시 기사 불러오기
	$(function(){
		update_news(100);
	})
	
	// 카테고리 클릭시 기사 가져오기
	function update_news(type){
		$("#newsList").empty();
					$.ajax({
						type:'GET',
						url:'${contextPath}/newsListAjax',
						data:{
							 sid1: type
						},
						contentType : "application/json",  // 보낼때는 이렇게쓰고
						dataType: "json",  // 받는 데이터타입에는 application을 붙이지 않는다.
						success:function(result){
							console.log("ajax 통신 성공");			
							//console.log(result);	
							callback(result);
						},
						error:function(err){
							console.log("ajax통신 실패");
						}
					});
	}
	
	// 가져온 데이터 뿌리기
	function callback(result){
		var newsList = result;
		
		var i = 0;
		$.each(newsList, function(index, items){
			//console.log(items.title);
			
			var contents = "";
			
			contents += "<tr>" + "<td>" + (index + 1) + "<td>"
						+ "<td id=headline><a href='" + items.href + "'>" + items.title + "</a>  <span id='writer'>" + items.writer + " | </span>" 
						+ "<span id = writeDate>" + items.writeDate + "</span></td></tr>"
			
			$("#newsList").append(contents);
			i += 1;
			if(i == 20){
				return false;
			}
		});
	}
	
	
</script>

	<h1>실시간 뉴스속보</h1>
	 <br/>
	
	<input type="button" onclick="update_news('100')" value="정치" id="politics" class="news_btn">
	<input type="button" onclick="update_news('101')" value="경제" id="economy" class="news_btn">
	<input type="button" onclick="update_news('102')" value="사회" id="society" class="news_btn">
	<input type="button" onclick="update_news('103')" value="생활 문화" id="curture" class="news_btn">
	<input type="button" onclick="update_news(100);" value="새로고침" id="refresh" class="news_btn">

	<table id="newsList">

	</table>

</body>
</html>