<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Template/header.jsp"%>


<link
	href="${url}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="${url}/resources/bootstrap/css/sb-admin-2.min.css"
	rel="stylesheet">
<link href="${url}/resources/assets/style/myreward_history.css"
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
		
		
		$('#pickDate01').val('${begin_day}');
		$('#pickDate02').val('${today}');
		
		$('input[name=pickPeriod]:radio').change(function(){
			
			var radio_value = $(this).val();
			
			if( radio_value== '1_YEAR'){
				
				var year = ${fn:substring(today,0,4)};
				var month = ${fn:substring(today,5,7)};
				var day = ${fn:substring(today,8,10)};
				
				var date = new Date(year,month,day);
				date.setFullYear(date.getFullYear() - 1);
				
				var begin = date.getFullYear()+'-'+date.getMonth()+'-'+date.getDate();
				$('#pickDate01').val(begin);
				$('#pickDate02').val('${today}');
			} else {
				$('#pickDate01').val('${begin_day}');
				$('#pickDate02').val('${today}');
			}
			
		});
		
		$('#starHistoryBtn').on('click',function(){
			
			var  begin_date = $('#pickDate01');
			var  end_date = $('#pickDate02');
			
			if(begin_date.val() > end_date.val()) {
				alert('시작일이 종료일 보다 큽니다.');
				begin_date.focus();
			} else {
				
				var obj = new Object();
				obj.begin = begin_date.val();
				obj.end = end_date.val();
				
				var data = JSON.stringify(obj);
				$.ajax({
					url : '${url}/my/reward/myreward_history_ajax',
					data : {
                        json : data
                	},
					method:'post',
					dataType : "json",
					success:function(data){
						var result       ='';
						for(var i=0; i<data.length; i++){
							
							
							var  oNum 		 =data[i].oNum;
							var  mrMoney     =(data[i].mrMoney);
							var  bName 	 	 =data[i].bName;
							var  mrStar      =data[i].mrStar;
							var  mrDate      =data[i].mrDate.substring(0,4)+'-'+data[i].mrDate.substring(5,7)+'-'+data[i].mrDate.substring(8,10)

							result +='<tr data-target='+oNum+'>';
							result +='<td class="sorting_1">'+oNum+'</td>';
							result +='<td>'+mrMoney.toLocaleString()+'원</td>';
							result +='<td>'+bName+'</td>';
							result +='<td>'+mrStar+'개</td>';
							result +='<td>'+mrDate+'</td></tr>';
							
							 
						}
						
						//테이블 재사용을 위한 table destory();
						table.destroy();
						$('#dataTable_wrapper table tbody').text('');
						$('#dataTable_wrapper table tbody').append(result);
						table=$('#dataTable').DataTable({
							searching : false,
							lengthChange : false,
							ordering : false,
							info : false,
					        language : lang_kor
						});
						
					},error:function(){
						console.log('ajax통신 실패');
					}
				});
			}
			
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
		
		
		$(document).on('click','#dataTable_wrapper table tbody tr',function(){
			
			var oNum =$(this).data('target');
			
			$.ajax({
				url : '${url}/my/reeward/oder_list_ajax',
				data : 'oNum='+oNum,
				method : "post",
				success:function(data){
					
					var html ='';
					
					html +=		'<table class="order_info">';
					html +=		'<thead>';
					html +=		'<tr>';
					
					html +=		'<th>주문번호</th>';
					html +=		'<th>주문지점</th>';
					html +=		'<th>제품명</th>';
					html +=		'<th>수량</th>';
					html +=		'<th>금액</th>';
					html +=		'<th>주문상태</th>';
					html +=		'<th>주문일</th>';
					
					html +=		'</tr>';
					html +=		'</thead>';
					html +=		'<tbody>';
					for(var i=0; i<data.length; i++){
						html +=	'<tr>';
						if(i==0){
							html +='<td class="both_box" rowspan='+data.length+'>'+data[i].oNum+'</td>';
							html +=	'<td class="right_box" rowspan='+data.length+'>'+data[i].bName+'</td>';
						}
						html +=	'<td>'+data[i].oName+'</td>';
						html +=	'<td>'+data[i].oCount+'(ea)</td>';
						html +=	'<td>'+(data[i].oPrice).toLocaleString()+'원</td>';
						html +=	'<td>'+(data[i].oStatus ==1 ? "주문접수중" :data[i].oStatus ==2 ? "판매완료" : "취소")+'</td>';
						if(i==0){
							var year=data[i].oDate.substring(0,4);
							var month=data[i].oDate.substring(5,7);
							var date=data[i].oDate.substring(8,10);
							
							html +=	'<td class="both_box" rowspan='+data.length+'>'+year+'-'+month+'-'+date+'</td>';
						}
						html +=	'</tr>';
						
					}
					html +=	'</tbody>';
					html +=		'</table>';
					$('.modal-body').text('');
					$('.modal-body').append(html);
					
					
					
				},error:function(){
					console.log('ajax통신 실패');
				}
			});
			
			/* 
				주문번호로 선택한 주문데이터를 modal 창에 출력 하기 
				
			*/
			
			$('#MyModal').modal("show");
		});
		
		
	});
	
	
	
</script>



<div class="wrap">
	<header class="header_title_wrap">
		<div class="heaer_title_content">
			<div class="header_title_inner">
				<h4>별 히스토리</h4>
			</div>
		</div>
	</header>
	<div class="wrap_content">
		<div class="reward_history_wrap">
			<section class="myreward_info">
				<ul class="myreward_info_inner">
					<li class="box1">
						<p class="t1">사용 가능한별</p>
						<p class="t2" id="userStar">${udto.getUStarcount()}개</p>
					</li>

					<li class="box2">
						<p class="t1">적립된 별</p> <span class="star_month_reward">(1개월
							이내)</span>
						<p class="t2" id="monthStar">${month_reward }개</p>
					</li>

					<li class="box3">
						<p class="t1">총 누적 별</p>
						<p class="t2" id="totalstar">${total_reward }개</p>
					</li>

					<li class="box4">
						<p class="t1">총 사용 별</p>
						<p class="t2" id="all_use_star">${use_reward }개</p>
					</li>

				</ul>
			</section>

			<section class="date_picker_controll">
				<form>
					<dl class="date_radio_picker">
						<dt>기간별</dt>
						<dd>
							<input type="radio" name="pickPeriod" id="pickPeriod1"
								checked="checked" value="1_MONTH"> <label
								for="pickPeriod1">1개월</label> <input type="radio"
								name="pickPeriod" id="pickPeriod2" value="1_YEAR"> <label
								for="pickPeriod1">1년</label>
						</dd>
					</dl>
					<dl class="date_time_picker">
						<dt>일자별</dt>
						<dd>
							<div class="pick_date_each">
								<div class="pick_date_each_left">
									<input id="pickDate01" name="pickDate" title="원하는 날짜를 선택해 주세요."
										type="text" class="hasDatepicker" readonly="readonly">
								</div>
								<div class="pick_date_each_right">
									<label for="pickDate01">날짜 선택</label>
								</div>
							</div>
							<p class="pick_slider">~</p>
							<div class="pick_date_each">
								<div class="pick_date_each_left">
									<input id="pickDate02" name="pickDate" title="원하는 날짜를 선택해 주세요."
										type="text" class="hasDatepicker" readonly="readonly">
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
				</form>
			</section>

			<!-- bootStarp table start -->


			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">

				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered dataTable" id="dataTable"
							width="100%" cellspacing="0" role="grid"
							aria-describedby="dataTable_info" style="width: 100%;">
							<thead>
								<tr role="row">
									<th class="sorting sorting_asc" tabindex="0"
										aria-controls="dataTable" rowspan="1" colspan="1"
										aria-sort="ascending"
										aria-label="Name: activate to sort column descending"
										style="width: 25%;">주문번호</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Position: activate to sort column ascending"
										style="width: 15%;">결제 금액</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Office: activate to sort column ascending"
										style="width: 167px;">결제 지점</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Age: activate to sort column ascending"
										style="width: 82px;">적립 별/사용별</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Start date: activate to sort column ascending"
										style="width: 158px;">결제일</th>

								</tr>
							</thead>
							<tbody>
								<c:forEach var="rlist" items="${rlist}" varStatus="rcount">
									<fmt:parseDate value="${rlist.getMrDate()}" var="rdate"
										pattern="yyyy-MM-dd" />

									<tr data-target=${rlist.getONum()}>
										<td class="sorting_1">${rlist.getONum() }</td>
										<td><fmt:formatNumber value="${rlist.getMrMoney() }"
												pattern="#,###" />원</td>
										<td>${rlist.getBName() }</td>
										<td>${rlist.getMrStar() }개</td>
										<td><fmt:formatDate value="${rdate}" pattern="yyyy-MM-dd" />
										</td>
									</tr>

								</c:forEach>


							</tbody>
						</table>
					</div>
				</div>

			</div>

			<!-- bootStarp table end -->


		</div>
		<%@ include file="/WEB-INF/views/Template/mystarbucks_side_tab.jsp"%>
	</div>
</div>

<div class="datepicker"></div>

<div class="modal" id="MyModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">주문 내역</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<p>Modal body text goes here.</p>
			</div>
			
		</div>
	</div>
</div>

<script src="${url}/resources/bootstrap/vendor/jquery/jquery.min.js"></script>
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