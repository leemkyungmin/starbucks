<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp" %>

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
							<a href="javascript:void(0)" data-target="coffee01_content" class="coffee01 selected">스타벅스 원두</a>
						</dt>
						<dt class="dt1">
							<a href="javascript:void(0)" class="coffee02">스타벅스 비아</a>
						</dt>
						<dt class="dt1">
							<a href="javascript:void(0)" class="coffee03">스타벅스앳홈 by 캡슐</a>
						</dt>
					</dl>
				</div>
			</section>
			
			<section class="coffee01_content">
				
			</section>
			
		</div>
	</div>

<%@ include file="../Template/fotter.jsp" %>
