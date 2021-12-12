<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Template/header.jsp"%>
<script type="text/javascript" src="http://ajax.microsoft.com/ajax/jquery.templates/beta1/jquery.tmpl.min.js"></script>
<link href="${url}/resources/bootstrap/css/sb-admin-2.min.css"
	rel="stylesheet">
<link href="${url}/resources/assets/style/orderlist.css"
	rel="stylesheet">
<!-- Custom styles for this page -->
<link
	href="${url}/resources/bootstrap/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link id="bsdp-css"
	href="https://unpkg.com/bootstrap-datepicker@1.9.0/dist/css/bootstrap-datepicker3.min.css"
	rel="stylesheet">
<script>
	$().ready(function(){
		
		$('#pickDate01').val('${pickdate01}');
		$('#pickDate02').val('${pickdate02}');
		getorderlist(1,'${pickdate01}','${pickdate02}');
		var lang_kor = {
				"decimal" : "",
				"emptyTable" : "데이터가 없습니다.",
				"info" : "_START_ - _END_ (총 _TOTAL_ 명)",
				"infoEmpty" : "0명",
				"infoFiltered" : "(전체 _MAX_ 명 중 검색결과)",
				"infoPostFix" : "",
				"thousands" : ",",
				"lengthMenu" : "_MENU_ 개씩 보기",
				"loadingRecords" : "로딩중...",
				"processing" : "처리중...",
				"search" : "검색 : ",
				"zeroRecords" : "검색된 데이터가 없습니다.",
				"paginate" : {
					"first" : "첫 페이지",
					"last" : "마지막 페이지",
					"next" : "다음",
					"previous" : "이전"
				},
				"aria" : {
					"sortAscending" : " :  오름차순 정렬",
					"sortDescending" : " :  내림차순 정렬"
				}
			};

			var table=$('#dataTable').DataTable({
				searching : false,
				lengthChange : false,
				ordering : false,
				info : false,
		        language : lang_kor
			});
		
		
			$('#pickDate01 ,#pickDate02').datepicker({
			    language: "ko",
			    todayHighlight: true,
			    autoclose: true,
			    orientation: "bottom left",
			    templates : {
			        leftArrow: '&laquo;',
			        rightArrow: '&raquo;'
			    } //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징


			}).on('changeDate', function (ev) {
			    (ev.viewMode == 'days') ? $(this).datepicker('hide') : '';      
			});;
			
		
		
		
		
		$(document).on('click','#starHistoryBtn a',function(){
			var pickdate01 =$('#pickDate01').val();
			var pickdate02 =$('#pickDate02').val();
			
			if(pickdate01 > pickdate02){
				alert('시작일이 종료일보다 큽니다.');
				$('#pickDate01').focus();
			} else {
				getorderlist(1,pickdate01,pickdate02);
			}
			
			
		});
		
		$(document).on('click','.pagecontroll ul li a',function(){
			if( !$(this).parent().hasClass('active') ){
				var page = $(this).text()*1;
				var pickdate01 =$('#pickDate01').val();
				var pickdate02 =$('#pickDate02').val();
				
				console.log(page);
				console.log(pickdate01);
				console.log(pickdate02);
				
				getorderlist(page,pickdate01,pickdate02);
			} 
		});
		
		$(document).on('change','input[name=pickPeriod]:radio',function(){
			var radio_value = $(this).val();
			
			if( radio_value== '1_YEAR'){
				
				var date = new Date();
				var one_year_ago =new Date(date.setFullYear(date.getFullYear() - 1));
					
				var begin = one_year_ago.getFullYear()+'-'+one_year_ago.getMonth()+'-'+one_year_ago.getDate();
				$('#pickDate01').val(begin);
				$('#pickDate02').val('${pickdate02}');
			} else {
				$('#pickDate01').val('${pickdate01}');
				$('#pickDate02').val('${pickdate02}');
			}
		});
		
		
		
		
		function getorderlist(page,pickdate01,pickdate02){
			
			var obj =new Object();
			obj.page =page;
			obj.pickdate01 =pickdate01;
			obj.pickdate02 =pickdate02;
			
			var data= JSON.stringify(obj);
			
			$.ajax({
				url:'${url}/my/order/orderlist_ajax',
				data :{
					data :data
				},
				method:'post', 
				success:function(e){
					
					$('.pagecontroll').text('');
					$('.pagecontroll').append(e[0].pagemaker);
					delete e[0];
					 
					var orderlist =$('#orderlist').tmpl(e);
					
					$('#dataTable_wrapper table tbody').text('');
					$('#dataTable_wrapper table tbody').append(orderlist);
					
					
					
				},error:function(){
					console.log('ajax통신실패');
				}
			});
		}
		
		
		
	});
</script>

<script id="orderlist" type="text/x-jquery-tmpl"> 
		
	{{each orderlist}} 
	<tr> 
		{{if  $index==0}}
			<td rowspan={{= length}}>{{= oNum}}</td>
			<td>{{= oDate}}</td>
			<td>{{= oName}}</td>
			<td>{{= oCount}}개</td>
			<td>{{= oPrice}}원</td>
			<td rowspan={{= length}}>{{= oStatus}}</td>
			<td rowspan={{= length}}>{{= bName}}</td>
			
		{{else}}

			<td>{{= oDate}}</td>
			<td>{{= oName}}</td>
			<td>{{= oCount}}개</td>
			<td>{{= oPrice}}원</td>
			
		{{/if}}
	</tr>
 	{{/each}}
</script>


<div class="wrap">
	<header class="header_title_wrap">
		<div class="header_title_content">
			<div class="header_title_inner">
				<h4>My 주문내역</h4>
			</div>
		</div>
	</header>
	<div class="wrap_content">
		<div class="my_orderlist_wrap">
			<section class="my_orderlist_inner">
				<div class="date_controller">
					<dl class="date_radio_picker">
						<dt>기간별</dt>
						<dd>
							<input type="radio" name="pickPeriod" id="pickPeriod1" checked="checked" value="1_MONTH"> 
							<label for="pickPeriod1">1개월</label> <input type="radio" name="pickPeriod" id="pickPeriod2" value="1_YEAR"> <label for="pickPeriod1">1년</label>
						</dd>
					</dl>
					<dl class="date_time_picker">
						<dt>일자별</dt>
						<dd>
							<div class="pick_date_each">
								<div class="pick_date_each_left">
									<input id="pickDate01" name="pickDate" title="원하는 날짜를 선택해 주세요." type="text" class="hasDatepicker" readonly="readonly">
								</div>
								<div class="pick_date_each_right">
									<label for="pickDate01">날짜 선택</label>
								</div>
							</div>
							<p class="pick_slider">~</p>
							<div class="pick_date_each">
								<div class="pick_date_each_left">
									<input id="pickDate02" name="pickDate" title="원하는 날짜를 선택해 주세요." type="text" class="hasDatepicker" readonly="readonly">
								</div>
								<div class="pick_date_each_right">
									<label for="pickDate02">날짜 선택</label>
								</div>
							</div>
							<p class="btn_pick_date" id="starHistoryBtn">
								<a href="javascript:void(0);">검색</a>
							</p>
						</dd>
					</dl>
				</div>

				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">

					<div class="row">
						<div class="col-sm-12">
							<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
								<div class="row">
									<div class="col-sm-12 col-md-6"></div>
									<div class="col-sm-12 col-md-6"></div>
								</div>
								<div class="row">
									<div class="col-sm-12">
										<table class="table table-bordered dataTable no-footer" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
											<colgroup>
												<col width="15%">
												<col width="15%">
												<col width="20%">
												<col width="10%">
												<col width="10%">
												<col width="10%">
												<col width="20%">
											</colgroup>
											<thead>
												<tr role="row">
													<th class="sorting sorting_asc sorting_disabled" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >주문번호</th>
													<th class="sorting sorting_disabled" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending" >구매일</th>
													<th class="sorting sorting_disabled" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending" >상품명</th>
													<th class="sorting sorting_disabled" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending" >수량</th>
													<th class="sorting sorting_disabled" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending" >결제금액</th>
													<th class="sorting sorting_disabled" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending" >상태</th>
													<th class="sorting sorting_disabled" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending" >결제지점</th>
													
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
								</div>
								<div class="row">
									
									<div class="pagecontroll">
										
									</div>
									
								</div>
							</div>
						</div>
					</div>

				</div>

			</section>
		</div>
		<%@ include file="/WEB-INF/views/Template/mystarbucks_side_tab.jsp"%>
	</div>
</div>
<script
	src="${url}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script
	src="${url}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${url}/resources/bootstrap/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script
	src="${url}/resources/bootstrap/vendor/datatables/jquery.dataTables.min.js"></script>
<script
	src="${url}/resources/bootstrap/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<!-- <script src="${url}/resources/bootstrap/js/demo/datatables-demo.js"></script> -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"
	integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<%@ include file="/WEB-INF/views/Template/fotter.jsp"%>
