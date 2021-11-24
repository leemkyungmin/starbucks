<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp"%>
<link rel="stylesheet"
	href="${url}/resources/assets/style/notcie_list.css">

<script>
	$().ready(function(){
		$('.pageControll ul #pager_controll a').on('click',function(){
			
			if(!$(this).parent().hasClass('active')){
				
				var page_num = $(this).text().trim();
				
				location.href="${url}/notice/noticeList?page="+page_num;
			}
			
		});
		
		$('#prev a').on('click',function(){
			
			var page_num = Number($('.pageControll ul .active a').text().trim()) -10;
			
			location.href="${url}/notice/noticeList?page="+page_num;
			
			
		});
		$('#next a').on('click',function(){
			
			var page_num = Number($('.pageControll ul .active a').text().trim()) +10;
			
			location.href="${url}/notice/noticeList?page="+page_num;
			
			
		});
		
		$('.notice_body tr .left a').on('click',function(){
			
			var nidx = $(this).parent().parent().data('remote');
			
			var f = document.createElement('form');
			f.setAttribute('method','post');
			f.setAttribute('action','${url}/notice/notice_view');
			document.charset='utf-8';
			
			var data = document.createElement('input');
			data.setAttribute('type','hidden');
			data.setAttribute('name','nidx');
			data.setAttribute('value',nidx);
			f.appendChild(data);
			
			document.body.appendChild(f);
			
			
			f.submit();
			
		});
		
	});
</script>
	
<div class="wrap">
	<div class="notice_wrap">
		<div class="title_wrap">
			<div class="title_wrap_inner">
				<h2>공지사항</h2>
			</div>
		</div>

		<div class="search_wrap">
			<div class="search_wrap_inner">
				<p>
					<input type="text" name="search_notice" id="search_notice"
						placeholder="검색어를 입력해주세요"> <a href="javascript:void(0)">검색</a>
				</p>
			</div>
		</div>

		<table class="notice_table">
			<colgroup>
				<col width="5.45454%">
				<col width="74.5454%">
				<col width="10.90909%">
				<col width="*">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
			</thead>

			<tbody class="notice_body">
				<c:forEach var="nlist" items="${nlist}">
					<fmt:parseDate value="${nlist.getNDate()}" var="ndate" pattern="yyyy-MM-dd" />
					<tr data-remote="${nlist.getNIdx()}">
						<td>${nlist.getNIdx() }</td>
						<td class="left">
							<a href="javascript:void(0)">${nlist.getNTitle() }</a>
						</td>
						<td><fmt:formatDate value="${ndate}" pattern="yyyy-MM-dd" /></td>
						<td>${nlist.getNHit() }</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>

		<div class="pageControll">${pagemaker }</div>
	</div>
</div>



<%@ include file="../Template/fotter.jsp"%>
