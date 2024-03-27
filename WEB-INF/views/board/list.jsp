<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp"%>
<!-- Model에 담긴 데이터 출력
	-> BoardController에서 Model을 이용 -> 키명 list에 service에 있는 메서드 리턴값을 담음
	=> JSTL 이용 출력함 -->
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				Board List Pages
				<button id="regBtn" type="button" class="btn btn-xs pull-right btn-primary">
					Register
				</button>
			</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>#번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<c:forEach items="${list }" var="board">
						<tr>
							<td><c:out value="${board.bno }"/></td>
<%--							<td>
								<a href='/board/get?bno=<c:out value="${board.bno}"/>'>
									<c:out value="${board.title }"/>
								</a>
							</td> --%>
<!-- #d. 사용하던 조회페이지 이동 업그레이드 
	= 조회페이지로 갈때 현재는 무조건 1번 글묶음으로 감
	=(해결) pageNum과 amount같이 전달하면 됨
	=> form태그를 이용한 스크립트 코딩으로 해결
-->
							<td>
								<a class="move" href='${board.bno }'>
									<c:out value="${board.title }"/>
								</a>
							</td>
							<td><c:out value="${board.writer }"/></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }"/></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updatedate }"/></td>
						</tr>
					</c:forEach>					
				</table>
<!-- JSP 뷰작업 페이지 번호 출력 -->				
<!-- #a. 페이지 번호 출력 작업 = 임의의 total값 123으로 테스트
	 = Controller에서  -> Model 객체에 담아서 보냄 => pageMaker로 -> 화면에 페이지 번호들을 출력
	 = 아직은 해당 글묶음 페이지로 이동 안함 | 단 주소창에는 파라미터값 찍힘
-->            
	            <div class="pull-right">
	               <ul class="pagination">
	               	<c:if test="${pageMaker.prev}">
	                  <li class="paginate_button previous">
	                  	<a href="${pageMaker.startPage -1}">Previous</a>
	                  </li>
	               	</c:if>
	               	<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage }">
<!-- 	                  <li class="paginate_button"> -->
	                  <li class='paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }'>
	                  	<a href="${num}">${num}</a>
	                  </li>
	               	</c:forEach>
	               	<c:if test="${pageMaker.next }">
	                  <li class="paginate_button next">
	                  	<a href="${pageMaker.endPage + 1}">Next</a>
	                  </li>
	               	</c:if>
	               </ul>
	            </div>
	            <!-- end Pagination -->
            </div>
<!-- #b. 페이징 작업 = 실패 클릭하면 동작하는 부분 처리 -->
			<form id="actionForm" action="/board/list" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"/>
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
			</form>
				
			
<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
					aria-labelledby="myModalLabel" aria-hidden="true">
	                <div class="modal-dialog">
	                    <div class="modal-content">
	                        <div class="modal-header">
	                            <button type="button" class="close" data-dismiss="modal" 
	                            	aria-hidden="true">&times;</button>
	                            <h4 class="modal-title" id="myModalLabel">Modal 모달창</h4>
	                        </div>
	                        <div class="modal-body">
	                            처리가 완료되었습니다.
	                        </div>
	                        <div class="modal-footer">
	                            <button type="button" class="btn btn-default" 
	                            data-dismiss="modal">닫기</button>
<!-- 	                            <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button> -->
	                        </div>
	                    </div>
	                </div>
	            </div>				
<!-- /Modal -->					
			
		</div>
	</div>
</div>
<%@ include file="../includes/footer.jsp"%>

<!-- 모달창, 글쓰기 버튼 스크립트 -->
<script type="text/javascript">
	$(document).ready(function(){
		var result = '<c:out value="${result}" />';
		checkModel(result);
		history.replaceState({},null,null);
		function checkModel(result) {
			if (result === '' || history.state){
				return;
			}
			if (parseInt(result) > 0){
				$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.")
			}
			$("#myModal").modal("show");
		}
			
		/* 글쓰기 버튼 클릭시 글쓰기 페이지 이동 */
		$('#regBtn').on('click',function(){
			location.href = "/board/register";
		});
		
/* #c. 페이지 번호 클릭 스크립트 */ 
		var actionForm = $('#actionForm');
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			// 폼 전송
			actionForm.submit();
		});
		
/* #d. 사용하던 조회페이지 이동 업그레이드 */
      $(".move").on("click",function(e){
          e.preventDefault();
          actionForm.append("<input type='hidden' name='bno' value='"
                + $(this).attr("href")+ "'>");
          actionForm.attr("action","/board/get");
          actionForm.submit();
       });

	});
</script>


