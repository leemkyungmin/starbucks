<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/Template/header.jsp"%>
<link rel="stylesheet" href="${url}/resources/assets/style/mymenu.css">

<script>
	$().ready(function() {
		var order = new Object();
		/*
					
			1. 결제 하기 누를시 checkbox선택된 상품들의 데이터 
			   jsonArray 에서 
		*/
		
		
		$('.chkAll').change(function() {
			if ($(this).parent().hasClass('ez-checked')) {
				
				$(this).parent().removeClass('ez-checked');
				$(this).parents('table').find('.ez-checkbox').removeClass('ez-checked');
				$(this).parents('table').find('input:checkbox[name="drinkShop_view_ck2"]').prop('checked',false);
				
			} else {
				
				$(this).parent().addClass('ez-checked');
				$(this).parents('table').find('.ez-checkbox').addClass('ez-checked');
				$(this).parents('table').find('input:checkbox[name="drinkShop_view_ck2"]').prop('checked',true);
			}
		});
		
		$(document).on('click','input:checkbox[name="drinkShop_view_ck2"]',function(){
			if(!$(this).is(':checked')){
				$(this).parent().removeClass('ez-checked');
			} else {
				$(this).parent().addClass('ez-checked');
				insert_order($(this).parents('tr'));
			}
			
			var checkboxLen 	   = $(this).parents('table').find('tbody').find('input:checkbox[name="drinkShop_view_ck2"]').length; // 개별 체크박스의 개수
			var checkboxCheckedLen = $(this).parents('table').find('tbody').find('input:checkbox[name="drinkShop_view_ck2"]:checked').length; // 개별 체크박스 중 선택된 체크박스의 개수
			
			if(checkboxLen == checkboxCheckedLen){
				$(this).parents('table').find('thead').find('div').addClass('ez-checked');
				$(this).parents('table').find('thead').find('input:checkbox[name="drinkShop_view_ck_all"]').prop("checked", true);
			} else {
				$(this).parents('table').find('thead').find('div').removeClass('ez-checked');
				$(this).parents('table').find('thead').find('input:checkbox[name="drinkShop_view_ck_all"]').prop("checked", false);
			}
			
			
			
		});
		

		$(document).on('click', '.myMenu_wrap dl dt h4 a', function() {
			var type = $(this).data('target');

			$('.myMenu_wrap dl dt').removeClass('on');
			$(this).parent().parent().addClass('on');
			
			$('.myMenu_wrap dl article').css({'display':'none'});
			$(this).parent().parent().next().children().css({'display':'block'});
			
			$.ajax({
				url : '${url}/my/menu/myMenu_ajax',
				data : 'type='+type,
				method : 'post',
				success : function(e) {
					console.log(e.length);
					var html ='';
					if(e.length ==0){
						html +='<tr class="odd">';
						html +='<td colspan="6">';
						if(type=='FOOD'){
							html +='My 메뉴에 담긴 음식이 없습니다.';
						} else if(type =='DRINK'){
							html +='My 메뉴에 담긴 음료가 없습니다.';
						} else{
							html +='My 메뉴에 담긴 상품이 없습니다.';
						}
						html +='</td>';
						html +='</tr>';
					} else {
						for(var i=0; i<e.length; i++){
							
							if(i%2 ==0){
								html +='<tr class="odd" data-mcidx="'+e[i].mcIdx+'">';
							} else {
								html +='<tr class="even" data-mcidx="'+e[i].mcIdx+'">';
							}
							html += '<td>'; 
							html +='<div class="ez-checkbox">';
							html +='<input type="checkbox" name="drinkShop_view_ck2" title="선택" value="'+e[i].mcIdx+'" class="ez-hide">';
							html +='</div>';
							html +='</td>';
							html += '<td>';
							html +=e[i].mcIdx;
							html +='</td>';
							html += '<td>';
							html +=e[i].mcName;
							html +='</td>';
							html += '<td>';
							html +=e[i].mcPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
							html +='</td>';
							html += '<td>';
							html +='<input type="text" name="mcprice" value="'+e[i].mcCount+'" oninput="this.value = this.value.replace(/[^0-9.]/g, "").replace(/(\..*)\./g, "$1");">';
							html +='</td>';
							html += '<td>'; 
							html +=e[i].mcDate;
							html +='</td>';
							html +='</tr>';
						}
					}
					
					if(type =='FOOD'){
						$('.food_cart tbody').text('');
						$('.food_cart tbody').append(html);
					} else if(type=='DRINK'){
						$('.drink_cart tbody').text('');
						$('.drink_cart tbody').append(html);
					} else {
						$('.product_cart tbody').text('');
						$('.product_cart tbody').append(html);
					}
					
					
				},
				error : function() {
					console.log('ajax통신 실패');
				}
			});
			/*
				data-target(DRINK,FOOD,PRODUCT)를 이용해 
				ajax로 해당 되는 탭의 데이터를 채우고 display:block 처리 
				
			 */
			
		});
		
		
		function insert_order(tr){
			var mcidx=tr.find('td:eq(1)').text(); 
			var mcname=tr.find('td:eq(2)').text(); 
			var mcprice=tr.find('td:eq(3)').text();
			var mccount=tr.find('td:eq(4)').find('input').val();
			
			var obj = new Object();
			obj.mcidx=mcidx;
			obj.mcname=mcname;
			obj.mcprice=mcprice;
			obj.mccount=mccount;
			
			order.mcidx={obj};
			
			console.log(order);
			
		}
		function delete_order(tr){
			
		}

	});
</script>

<div class="wrap">
	<header class="header_title_wrap">
		<div class="header_title_content">
			<div class="header_title_inner">
				<h4>My 메뉴</h4>
			</div>
		</div>
	</header>
	<div class="wrap_content">
		<div class="myMenu_wrap">
			<dl>
				<!-- 음료 -->
				<dt class="tab drink_tab on">
					<h4>
						<a href="javascript:void(0)" data-target="DRINK">나만의 음료</a>
					</h4>
				</dt>
				<dd>
					<article class="tab drink_wrap" style="display: block">
						<fieldset>
							<table class="drink_cart">
								<colgroup>
									<col width="52">
									<col width="60">
									<col width="300">
									<col width="100">
									<col width="177">
									<col width="200">
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><div class="ez-checkbox">
												<input type="checkbox" name="drinkShop_view_ck_all"
													class="chkAll ez-hide" title="전체 선택">
											</div></th>
										<th class="en" scope="col">번호</th>
										<th scope="col">음료명</th>
										<th scope="col">가격</th>
										<th scope="col">수량</th>
										<th scope="col">등록일</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${fn:length(mclist) eq 0 }">
										<tr class="odd">
											<td colspan="6">My 메뉴에 담긴 음료가 없습니다.</td>
										</tr>
									</c:if>
									<c:forEach var="mclist" items="${mclist}" varStatus="mcCount">
										<fmt:parseDate value="${mclist.getMcDate()}" var="date" pattern="yyyy-MM-dd" />
										<c:if test="${mcCount.count%2 eq 1}">
											<tr class="odd" data-mcidx="${mclist.getMcIdx() }">
										</c:if>
										<c:if test="${mcCount.count%2 eq 0}">
											<tr class="even" data-mcidx="${mclist.getMcIdx() }">
										</c:if>
										<td>
											<div class="ez-checkbox">
												<input type="checkbox" name="drinkShop_view_ck2" title="선택"
													value="${mclist.getMcIdx() }" class="ez-hide">
											</div>
										</td>
										<td>${mclist.getMcIdx() }</td>
										<td>${mclist.getMcName() }</td>
										<td><fmt:formatNumber value="${mclist.getMcPrice() }" pattern="#,###" /></td>
										<td>
											<input type="text" name="mcprice" value="${mclist.getMcCount() }" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
										</td>
										<td><fmt:formatDate value="${date}" pattern="yyyy-MM-dd" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table> 
						</fieldset>
					</article>
				</dd>

				<!-- 음식 -->
				<dt class="tab food_tab">
					<h4>
						<a href="javascript:void(0)" data-target="FOOD">나만의 푸드</a>
					</h4>
				</dt>
				<dd>
					<article class="food_wrap">
						<fieldset>
							<table class="food_cart">
								<colgroup>
									<col width="52">
									<col width="60">
									<col width="300">
									<col width="100">
									<col width="177">
									<col width="200">
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><div class="ez-checkbox ">
												<input type="checkbox" name="drinkShop_view_ck_all"
													class="chkAll ez-hide" title="전체 선택">
											</div></th>
										<th class="en" scope="col">번호</th>
										<th scope="col">푸드명</th>
										<th scope="col">가격</th>
										<th scope="col">수량</th>
										<th scope="col">등록일</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</fieldset>
					</article>
				</dd>

				<!-- 상품 -->

				<dt class="tab product_tab">
					<h4>
						<a href="javascript:void(0)" data-target="PRODUCT">나만의 상품</a>
					</h4>
				</dt>
				<dd>
					<article class="product_wrap">
						<fieldset>
							<table class="product_cart">
								<colgroup>
									<col width="52">
									<col width="60">
									<col width="300">
									<col width="100">
									<col width="177">
									<col width="200">
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><div class="ez-checkbox">
												<input type="checkbox" name="drinkShop_view_ck_all"
													class="chkAll ez-hide" title="전체 선택">
											</div></th>
										<th class="en" scope="col">번호</th>
										<th scope="col">상품명</th>
										<th scope="col">가격</th>
										<th scope="col">수량</th>
										<th scope="col">등록일</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</fieldset>
					</article>
				</dd>


			</dl>
		</div>
		<%@ include file="/WEB-INF/views/Template/mystarbucks_side_tab.jsp"%>
	</div>
</div>

<%@ include file="/WEB-INF/views/Template/fotter.jsp"%>