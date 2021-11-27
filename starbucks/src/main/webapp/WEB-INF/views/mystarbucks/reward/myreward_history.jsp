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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">


<script>
	$().ready(function(){
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
			
		});
		
		$('.pick_date_each_right').on('click',function(){
			$('.datepicker').datepicker({
				inline: true, 
				sideBySide: true,
			    language: "ko",
			    autoclose: true,
			    todayHighlight: true
			});
			
			
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
<script src="${url}/resources/bootstrap/js/demo/datatables-demo.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


<%@ include file="/WEB-INF/views/Template/fotter.jsp"%>