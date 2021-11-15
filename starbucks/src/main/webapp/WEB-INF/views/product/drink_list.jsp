<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp" %>
<link rel="stylesheet" href="${url}/resources/assets/style/coffee_list.css">
	
	
	<script>
	
		
		function drink_list(){
			$("input:checkbox[name='chkbox']").each(function(){
				
				if($(this).prop('checked')) {
					
					var optionTemp = '.'+$(this).val();
					$(optionTemp).css({'display' : 'block'});
					
				} else {
					var optionTemp = '.'+$(this).val();
					$(optionTemp).css({'display' : 'none'});
					console.log('1111');
				}
				
			})
			
			
		}
		
		$().ready(function(){
			
			var type = ${type};
			
			if( type = null){
				$("input:checkbox[name='chkbox']").prop("checked", true);
				$("input:checkbox[name='chkboxAll']").prop("checked", true);
			} else {
				$("input:checkbox[name='chkbox']").prop("checked", false);
				$("input:checkbox[name='chkboxAll']").prop("checked", false);
				$('#${type}').prop('checked',true);
			}
			drink_list();
			
			
			$("input:checkbox[name='chkboxAll']").click(function(){ 
				
				if($(this).is(":checked")){
				
					$("input:checkbox[name='chkbox']").prop("checked", true);
				
				} else {
					
					$("input:checkbox[name='chkbox']").prop("checked", false);
				}
				drink_list();
			});
			
			// 개별 체크박스 클릭 시 전체 체크박스 선택
			$("input:checkbox[name='chkbox']").click(function(){ 
							
				var checkboxLen 	   = $("input:checkbox[name='chkbox']").length; // 개별 체크박스의 개수
				var checkboxCheckedLen = $("input:checkbox[name='chkbox']:checked").length; // 개별 체크박스 중 선택된 체크박스의 개수
				
				if(checkboxLen == checkboxCheckedLen){
					
					$("input:checkbox[name='chkboxAll']").prop("checked", true);
				} else {
					$("input:checkbox[name='chkboxAll']").prop("checked", false);
				}
				drink_list();
			});
			
			
			 $('.coffeeData a>img').on('click',function(){
				var didx =$(this).parent().data('target');

				var form =document.createElement('form');
				form.setAttribute('method','post');
				form.setAttribute('action','${url}/menu/drink/product_view');
				document.charset='utf-8';
				
				var data = document.createElement('input');
				data.setAttribute('type','hidden');
				data.setAttribute('name','didx');
				data.setAttribute('value',didx);
				form.appendChild(data);
				
				document.body.appendChild(form);
				
				form.submit();
				 
			});
		});
	</script>

	<div class="wrap">
		<div class="title_wrap">
			<div class="title_inner">
				<h2>음료</h2>
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
						<dt class="dt_mt">
							<a href="javascript:void(0)"  class="coffee_item selected">카테고리</a>
						</dt>
						<dd>
							<form method="post">
								<ul>
									<li>
										<input type="checkbox" onclick="chekcboxcontroll();" class="chk product_all" name="chkboxAll" id="product_all"  value="all">
										<label for="product_all">전체상품보기</label>
									</li>
									<c:forEach var="mt" items="${mtlist}" varStatus="mtcount">
										<li>
											<input type="checkbox" onclick="chekcboxcontroll();" class="chk ${mt.getFtName2() }" name="chkbox" id="${mt.getFtName2() }"  value="${mt.getFtName2() }">
											<label for="${mt.getFtName2()}">${mt.getFtName() }</label>
											
										</li>
									</c:forEach>
								</ul>
							</form>
						</dd>
						
					</dl>
				</div>
			</section>
			
			<div class="coffee_inner">
				<c:forEach var="mtlist" items="${mtlist}" varStatus="mtcount">
					<c:if test="${mtcount.count eq 1 }">
						<div class="coffee_list_wrap coffee_list_wrap">
							<ul class="coffee_view_pannel">
							
								<li class="coffee_view_tab1">
								 
							<div class="product_list">
								<dl>
								
					</c:if>
								<dt class="dti ${mtlist.getFtName2() }"> 
										<a href="javascript:void(0);">${mtlist.getFtName()}</a>
										<i class="sumaryicon">
											<img alt="" src="${url}/resources/assets/images/coffee/logo_decaf.png">
										</i>
										<span class="sumary">디카페인 에스프레소 샷 추가 가능 (일부 음료 제외)</span>
										
								</dt>
								<dd class="${mtlist.getFtName2() }">
									<ul>
										
										<c:forEach var="dlist" items="${dlist}">
											<c:if test="${dlist.getFtIdx() eq mtlist.getFtIdx() }"  var="a">
												
												<li class="coffeeData">
													<dl>
														<dt>
															<a href="javascript:void(0)" data-target="${dlist.getDIdx() }" class="coffee_img">
																<img alt="${dlist.getDName()}"  src="${url}/resources/assets/images/drink_img_test/${dlist.getDSumnail()}">
															</a>
														</dt>
														<dd >${dlist.getDName()}</dd>
													</dl>
												</li>
											</c:if>
										</c:forEach>
										</ul> 
									</dd>
				</c:forEach>
									
								</dl>
								</li>
							</ul>
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
