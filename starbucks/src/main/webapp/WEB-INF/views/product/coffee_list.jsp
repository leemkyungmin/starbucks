<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp" %>
<link rel="stylesheet" href="${url}/resources/assets/style/coffee_list.css">
	<script>
	
		function coffee_list_ajax(obj){
			$('.coffee_item').removeClass('selected');
			$(obj).addClass('selected');
			
			var Catagory = $(obj).data('target');
			
			if( $('.coffee_list_wrap'+Catagory).length ==0 ){
				$.ajax({
					url:'${url}/coffee/coffee_list_ajax',
					data:'Category='+Catagory,
					type:'get',
					success:function(e){
						
						$('.coffee_inner').append(e);			
						
					},error:function(){
						console.log('통신실패');
					}
				});
				
			} 
			$('.coffee_list_wrap').css({'display' : 'none'});
			$('.coffee_list_wrap'+Catagory).css({'display' : 'block'});
		}
		
	</script>

	<div class="wrap">
		<div class="title_wrap">
			<div class="title_inner">
				<h2>커피</h2>
			</div>
		</div>
		<div class="coffee_content">
			<!-- 컨트롤 부분 -->
			<section class="coffee_type_controll">
				<div class="type_title">
					<p>분류 보기</p>
				</div>
				<div class="product_toggle">
					<dl class="product_kinds">
						<dt class="dt1">
							<a href="javascript:void(0)" data-target="1" onclick="coffee_list_ajax(this);" class="coffee_item selected">스타벅스 원두</a>
						</dt>
						<dt class="dt2">
							<a href="javascript:void(0)" data-target="2" onclick="coffee_list_ajax(this);" class="coffee_item">스타벅스 비아</a>
						</dt>
						<dt class="dt3">
							<a href="javascript:void(0)" data-target="3" onclick="coffee_list_ajax(this);" class="coffee_item">스타벅스앳홈 by 캡슐</a>
						</dt>
					</dl>
				</div>
			</section>
			<div class="coffee_inner">
				<c:forEach var="cktlist" items="${cktlist}" varStatus="cktcount">
					<c:if test="${cktcount.count eq 1 }">
						<div class="coffee_list_wrap coffee_list_wrap${Category}">
							<div class="product_list">
								<dl>
					</c:if>
									<dt>${cktlist.getCktName()}</dt>
									<dd>
										<ul>
										
										<c:forEach var="cklist" items="${cklist}">
											<c:if test="${cktlist.getCktIdx() eq cklist.getCktIdx() }"  var="a">
												
												<li class="coffeeData">
													<dl>
														<dt>
															<a href="javascript:void(0)" data-target="${cklist.getCkIdx() }" class="coffee_img">
																<img alt="${cklist.getCkName()}" src="${url}/resources/assets/images/coffee_img_test/${cklist.getCkImg()}">
															</a>
														</dt>
														<dd>${cklist.getCkName()}</dd>
													</dl>
												</li>
											</c:if>
										</c:forEach>
										</ul> 
									</dd>
				</c:forEach>
								</dl>
							</div>
						</div>
						
						
				
			
			<!--  처음 페이지가 로딩 되면 첫번째 데이터를 가져온다 . 
				선택된 탭의 데이터가 없으면 ajax를 통해 데이터를 가져오고 
				선택된 탭의 데이터가 있으면 해당된 탭의  display:block 옵션을 주고 
				해당 되지 않은 탭은 display:none 형식으로 처리 
				
			 -->
				
					
			</div>
			
			
			
		</div>
	</div>

<%@ include file="../Template/fotter.jsp" %>
