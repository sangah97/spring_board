<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp"%>
<!--  
	#1. 등록 입력 페이지 / 등록처리
	 a. GET방식으로 입력페이지 볼수 있도록 -> BoardController에 @GetMapping("/register")
	 b. 게시물 등록 작업 = POST방식으로 처리
	 c. 한글 깨짐 필터 추가
	
	#2. sendRedirect 처리 = RedirectAttributs 객체 사용
-->
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">Board Register</div>
			<div class="panel-body">
				<form role="form" action="/board/register" method="post">
					<div class="form-group">
						<label>Title</label>
						<!-- name값을 멤버변수명과 일치시켜야 함 -->
						<input class="form-control" name='title'>
					</div>

					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name='content'></textarea>
					</div>

					<div class="form-group">
						<label>Writer</label>
						<input class="form-control" name='writer'>
					</div>
					<button type="submit" class="btn btn-default">
						Submit
					</button>
					<button type="reset" class="btn btn-default">
						Reset
					</button>
				</form>

			</div>

		</div>
	</div>
</div>

<%@ include file="../includes/footer.jsp"%>