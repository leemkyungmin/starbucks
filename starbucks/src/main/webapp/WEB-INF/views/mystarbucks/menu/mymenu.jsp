<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/Template/header.jsp"%>
<link rel="stylesheet" href="${url}/resources/assets/style/mymenu.css">
<link
	href="${url}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="${url}/resources/bootstrap/css/sb-admin-2.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="http://ajax.microsoft.com/ajax/jquery.templates/beta1/jquery.tmpl.min.js"></script>
<script>
	$().ready(function() {
		var slider=$('.bxslider').bxSlider({
			auto : false,
			autoControls : true,
			pager : false,
			slideWidth : 499,
			slideWidth :499
		});
		
			var order = new Object();
			var orderList = new Array();
						
			$('.chkAll').change(function() {
				if ($(this).parent().hasClass('ez-checked')) {
					$(this).parent().removeClass('ez-checked');
					$(this).parents('table').find('.ez-checkbox').removeClass('ez-checked');
					$(this).parents('table').find('input:checkbox[name="drinkShop_view_ck2"]').prop('checked', false);

				} else {
					$(this).parent().addClass('ez-checked');
					$(this).parents('table').find('.ez-checkbox').addClass('ez-checked');
					$(this).parents('table').find('input:checkbox[name="drinkShop_view_ck2"]').prop('checked', true);
			   }
			});

			$(document).on('click','input:checkbox[name="drinkShop_view_ck2"]',function() {
				if (!$(this).is(':checked')) {
					$(this).parent().removeClass('ez-checked');
				} else {
					$(this).parent().addClass('ez-checked');
				}

				var checkboxLen = $(this).parents('table').find('tbody').find('input:checkbox[name="drinkShop_view_ck2"]').length; // 개별 체크박스의 개수
				var checkboxCheckedLen = $(this).parents('table').find('tbody').find('input:checkbox[name="drinkShop_view_ck2"]:checked').length; // 개별 체크박스 중 선택된 체크박스의 개수

				if (checkboxLen == checkboxCheckedLen) {
					$(this).parents('table').find('thead').find('div').addClass('ez-checked');
					$(this).parents('table').find('thead').find('input:checkbox[name="drinkShop_view_ck_all"]').prop("checked", true);
				} else {
					$(this).parents('table').find('thead').find('div').removeClass('ez-checked');
					$(this).parents('table').find('thead').find('input:checkbox[name="drinkShop_view_ck_all"]').prop("checked", false);
				}

			});

			$(document).on('click','.myMenu_wrap dl dt h4 a',function() {
				var type = $(this).data('target');

				$('.myMenu_wrap dl dt').removeClass('on');
				$(this).parent().parent().addClass('on');

				$('.myMenu_wrap dl article').css({'display' : 'none'});
				$(this).parent().parent().next().children().css({
														'display' : 'block'});
				$.ajax({
					url : '${url}/my/menu/myMenu_ajax',
					data : 'type=' + type,
					method : 'post',
					success : function(e) {
						console.log(e.length);
						var html = '';
						if (e.length == 0) {
							html += '<tr class="odd">';
							html += '<td colspan="6">';
							if (type == 'FOOD') {
								html += 'My 메뉴에 담긴 음식이 없습니다.';
							} else if (type == 'DRINK') {
								html += 'My 메뉴에 담긴 음료가 없습니다.';
							} else {
								html += 'My 메뉴에 담긴 상품이 없습니다.';
							}
								html += '</td>';
								html += '</tr>';
							} else {
								for (var i = 0; i < e.length; i++) {

									if (i % 2 == 0) {
										html += '<tr class="odd" data-mcidx="'+e[i].mcIdx+'">';
									} else {
										html += '<tr class="even" data-mcidx="'+e[i].mcIdx+'">';
									}
										html += '<td>';
										html += '<div class="ez-checkbox">';
										html += '<input type="checkbox" name="drinkShop_view_ck2" title="선택" value="'+e[i].mcIdx+'" class="ez-hide">';
										html += '</div>';
										html += '</td>';
										html += '<td>';
										html += e[i].mcIdx;
										html += '</td>';
										html += '<td>';
										html += e[i].mcName;
										html += '</td>';
										html += '<td>';
										html += e[i].mcPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g,",");
										html += '</td>';
										html += '<td>';
										html += '<input type="text" name="mcprice" value="'+ e[i].mcCount+ '" oninput="this.value = this.value.replace(/[^0-9.]/g, "").replace(/(\..*)\./g, "$1");">';
										html += '</td>';
										html += '<td>';
										html += e[i].mcDate;
										html += '</td>';
										html += '</tr>';
									}
								}

								if (type == 'FOOD') {
									$('.food_cart tbody').text('');
									$('.food_cart tbody').append(html);
								} else if (type == 'DRINK') {
									$('.drink_cart tbody').text('');
									$('.drink_cart tbody').append(html);
								} else {
									$('.product_cart tbody').text('');
									$('.product_cart tbody').append(html);
								}

							},error : function() {
								console.log('ajax통신 실패');
							}
					});

			});

			$(document).on('click','#buy_myMenu',function() {

				var checkboxCheckedLen = $(this).parents('article').find('table').find('input:checkbox[name="drinkShop_view_ck2"]:checked').length;

				var orderList = new Array();
				var tot = new Object();

				if (checkboxCheckedLen == 0) {
					alert('체크된 상품이 없습니다.');
				} else {
					var total = 0;
					for (var i = 0; i < checkboxCheckedLen; i++) {
						var tr = $(this).parents('article').find('table').find('input:checkbox[name="drinkShop_view_ck2"]:checked:eq('+ i + ')').parents('tr');
						var mcidx = tr.find('td:eq(1)').text();
						var mcname = tr.find('td:eq(2)').text();
						var mcprice = tr.find('td:eq(3)').text();
						var mccount = tr.find('td:eq(4)').find('input').val();
						var mctotal = (mcprice.replace(",", ""))* (mccount * 1);


						var order = new Object();

						order.mcidx = mcidx;
						order.mcname = mcname;
						order.mcprice = mcprice;
						order.mccount = mccount;
						order.mctotal = mctotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
						orderList.push(order);
						total += mctotal;
					}

					tot.total = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");

					$('#MyModal table tbody').text('');
					$('#MyModal table tfoot').text('');
					$("#order-list").tmpl(orderList).appendTo("#orderlist");
					$("#totalprice").tmpl(tot).appendTo("#total");
					$('#MyModal').modal('show');
					
					console.log(JSON.stringify(orderList));
					
					slider.destroySlider();
					slider.reloadSlider({
						slideWidth:499,
						mode: 'horizontal',// 가로 방향 수평 슬라이드
						speed: 1000,        // 이동 속도를 설정
						pager: false,     // 현재 위치 페이징 표시 여부 설정
						slideMargin:10,    // 슬라이드간의 간격
						auto: false,        // 자동 실행 여부
						controls: true,    // 이전 다음 버튼 노출 여부

						
					});
				
					
					
				}

			});
			
			
			

		});
</script>

<script id="order-list" type="text/x-jquery-tmpl"> 
	<tr>
		<td>{{= mcidx}}</td>
		<td>{{= mcname}}</td>
		<td>{{= mcprice}}원</td>
		<td>{{= mccount}}</td>
		<td>{{= mctotal}}원</td>
	</tr>
</script>
<script id="totalprice" type="text/x-jquery-tmpl"> 
	<tr>
		<td colspan="1">총합</td>
		<td colspan="4">{{= total}}원</td>
	</tr>
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
										<fmt:parseDate value="${mclist.getMcDate()}" var="date"
											pattern="yyyy-MM-dd" />
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
										<td><fmt:formatNumber value="${mclist.getMcPrice() }"
												pattern="#,###" /></td>
										<td><input type="text" name="mcprice"
											value="${mclist.getMcCount() }"
											oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
										</td>
										<td><fmt:formatDate value="${date}" pattern="yyyy-MM-dd" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="myMenu_btns">
								<ul>
									<li><a href="javascript:void(0)">전체선택</a></li>
									<li><a href="javascript:void(0)">선택 삭제</a></li>
									<li><a href="javascript:void(0)" id="buy_myMenu">구매하기</a>
									</li>
								</ul>
							</div>
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
							<div class="myMenu_btns">
								<ul>
									<li><a href="javascript:void(0)">전체선택</a></li>
									<li><a href="javascript:void(0)">선택 삭제</a></li>
									<li><a href="javascript:void(0)" id="buy_myMenu">구매하기</a>
									</li>
								</ul>
							</div>
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
							<div class="myMenu_btns">
								<ul>
									<li><a href="javascript:void(0)">전체선택</a></li>
									<li><a href="javascript:void(0)">선택 삭제</a></li>
									<li><a href="javascript:void(0)" id="buy_myMenu">구매하기</a>
									</li>
								</ul>
							</div>

						</fieldset>
					</article>
				</dd>

			</dl>



		</div>
		<%@ include file="/WEB-INF/views/Template/mystarbucks_side_tab.jsp"%>
	</div>
</div>

<div class="modal" id="MyModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">주문리스트</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="order_wrap">
					<table>
						<colgroup>
							<col width="50">
							<col width="200">
							<col width="100">
							<col width="50">
							<col width="100">
						</colgroup>
						<thead>
							<tr>
								<td>번호</td>
								<td>상품명</td>
								<td>가격</td>
								<td>수량</td>
								<td>총합</td>
							</tr>
						</thead>
						<tbody id="orderlist">

						</tbody>
						<tfoot id="total">
						</tfoot>
					</table>
				</div>
				
				<div class="card_wrap">
					<div class="card_wrap_title">
						<h4>결제할 카드 선택</h4>
					</div>
					<div class="card_info">
						<c:if test="${fn:length(ucllist) eq 0 }">
							<p>등록된 카드가 없습니다.</p>
							<a href="javascript:void(0)">새로운 카드 등록하러가기</a>
						</c:if>
						<ul class="bxslider">
							<c:forEach var="ucllist" items="${ucllist }">
								<li>
									<dl>
										<dt>
											<img src="${url}/resources/assets/images/card_img_test/${ucllist.getClImg()}">
										</dt>
										<dd>
											<div class="card_info_inner">
												<dl>  
													<dt>카드이름</dt>
													<dd>${ucllist.getUclName() }</dd>
													<dt>카드 잔액</dt>
										 			<dd><fmt:formatNumber value="${ucllist.getUclMoney() }" pattern="#,###"/>원</dd>
												</dl>	
											</div>
											<div class="card_pin_form">
												<input type="password" name="cardpinNum" id="cardpinNum" placeholder="카드 핀번호(8자리)" maxlength="8">		
												<a href="javascript:void(0)" data-uclidx="${ucllist.getUclIdx() }">결제하기</a>
											</div>
										</dd>
									</dl>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				
				
				
			</div>

		</div>
	</div>
</div>
<script
	src="${url}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script
	src="${url}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${url}/resources/bootstrap/js/sb-admin-2.min.js"></script>

<%@ include file="/WEB-INF/views/Template/fotter.jsp"%>