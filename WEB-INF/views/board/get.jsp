<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">Board Read Page</div>
			<div class="panel-body">
				<div class="form-group">
					<label>Bno</label>
					<input class="form-control" name='bno' value='<c:out value="${board.bno }"></c:out>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Title</label>
					<input class="form-control" name='title' value='<c:out value="${board.title }"></c:out>' readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name='content' readonly="readonly"><c:out value="${board.content }"></c:out></textarea>
				</div>
				
				<div class="form-group">
					<label>Writer</label>
					<input class="form-control" name='writer' value='<c:out value="${board.writer }"/>' readonly="readonly">
				</div>
<!-- jQuery 이벤트 방식으로 변경 -->
				<button data-oper='modify' class="btn btn-default">Modify</button>
				<button data-oper='list' class="btn btn-info">List</button>
				<button data-oper='remove' class="btn btn-danger">Remove</button>

<!-- #e. 조회 페이지 작업 = 수정/삭제 페이지 -->				
				<form id="operForm" action="/board/modify" method="get">
					<input type="hidden" name="bno" id="bno" value='<c:out value="${board.bno }"/>' />
					<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>' />					
					<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>' />
				</form>
						

			</div>

		</div>
	</div>
</div>

<!-- 스크립트 처리 -->
<script type="text/javascript">
$(document).ready(function(){
	var operForm = $("#operForm");
	// modify
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/board/modify").submit();
	});
	// list
	$("button[data-oper='list']").on("click",function(e){
		// 목록에는 pk bno 필요없음
		operForm.find("#bno").remove();
		operForm.attr("action","/board/list")
		operForm.submit();
	});
	// remove
	$("button[data-oper='remove']").on("click",function(e){
		operForm.attr("action","/board/remove").attr("method","post").submit();
	});
});	
</script>


<%@ include file="../includes/footer.jsp"%>