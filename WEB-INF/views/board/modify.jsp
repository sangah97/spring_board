<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp"%>
<!--  
	# 수정페이지
	: 조회페이지 링크를 통해 -> GET방식 -> 수정/삭제 버튼이 보이는 페이지 제작
	  수정/삭제 작업 -> POST방식으로 처리 => 목록화면으로 결과 처리후 이동
	  
	 
	#. 처리 할것
	 a. Controller에 GetMapping({"/get","/modify"}) 추가
	 b. POST방식을 처리하는 부분 = form 추가 사용
	 c. 수정할 내용은 readonly 속성 제거
	 d. 등록일/수정일을 DB로 가공하여서 넘겨줌 = fmt
	 e. 스크립트로 처리할 삭제 버튼 추가
	 f. 버튼 type="submint"
-->
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Modify / Delete Page</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Modify Page / Delete Page</div>
			<div class="panel-body">
				<form role="form" action="/board/modify" method="post">
					<div class="form-group">
						<label>Bno</label>
						<input class="form-control" name='bno' value='<c:out value="${board.bno}"/>'  readonly="readonly">
					</div>
					<div class="form-group">
						<label>Title</label>
						<input class="form-control" name='title' value='<c:out value="${board.title }"/>' >
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name='content'><c:out value="${board.content }"/></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label>
						<input class="form-control" name='writer' value='<c:out value="${board.writer }"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>Reg Date</label>
						<input class="form-control" name='regdate' 
							value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.regdate }"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>Update Date</label>
						<input class="form-control" name='updatedate' 
							value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.updatedate }"/>' readonly="readonly">
					</div>

					<button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
					<button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
					<button type="submit" data-oper='list' class="btn btn-info">List</button>
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
		var formObj = $("form");
		$('button').on('click',function(e){
			e.preventDefault();
			var operation = $(this).data("oper");
			if(operation === 'remove') {
				formObj.attr("action","/board/remove");
				
			}else if (operation === 'list'){ // 목록 버튼 클릭시
				formObj.attr("action","/board/list").attr("method","get");
				// e-1. clone() = form태그에서 필요한 부분만 잠시 복제하여 보관
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				// e-2. 목록이동은 파라미터 필요없음 = empty()
				formObj.empty();
				// e-3. 다시 필요한 태그들만 추가해서 /board/list를 호출하는 형태를 이용함
				formObj.append(pageNumTag);
				formObj.append(amountTag);
			}
			formObj.submit();
		});
	});
</script>


<%@ include file="../includes/footer.jsp"%>