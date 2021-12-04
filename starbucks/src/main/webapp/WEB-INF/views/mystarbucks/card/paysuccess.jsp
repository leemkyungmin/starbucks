<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Template/header.jsp"%>
<link rel="stylesheet" href="${url}/resources/assets/style/paysuccess.css">
<div class="wrap">
	<header class="header_title_wrap">
		<div class="header_title_content">
			<div class="header_title_inner">
				<h4>카드 충전 성공</h4>
			</div>
		</div>
	</header>
	<div class="wrap_content">
		<div class="pay_success_wrap">
			<section class="pay_result_wrap">
				<div class="result_title">
					<h2>결제 내역</h2>
				</div>
				<div class="result_content">
					<dl>
						<dt>카드 이름</dt>
						<dd>${ucldto.getUclName() }</dd>
						<dt>충전일</dt>
						<dd>${success_date}</dd>
						<dt>충전 금액</dt>
						<dd><fmt:formatNumber value="${amount }" pattern="#,###" />원</dd>
						<dt>카드 잔액</dt>
						<dd><fmt:formatNumber value="${ucldto.getUclMoney() }" pattern="#,###" />원</dd>
					</dl>
				</div>
			</section>
			
			<div class="my_card_btn">
				<a href="${url}/my/card/my_card_list">확인</a>
			</div>
			
		</div>
		<%@ include file="/WEB-INF/views/Template/mystarbucks_side_tab.jsp"%>
	</div>
</div>

<%@ include file="/WEB-INF/views/Template/fotter.jsp"%>
