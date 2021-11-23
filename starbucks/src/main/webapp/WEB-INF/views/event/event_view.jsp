<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp"%>
<fmt:parseDate value="${event.getEStartday()}" var="startday"
	pattern="yyyy-MM-dd" />
<fmt:parseDate value="${event.getEEndday()}" var="endday"
	pattern="yyyy-MM-dd" />
<link rel="stylesheet"
	href="${url}/resources/assets/style/event_view.css">
<script>
	$().ready(function() {
		$('.bxSlider').bxSlider({
			auto : true,
			autoControls : true,
			pager : true,
			slideWidth : 1200,
			minSlides : 1,
			maxSlides : 3,
			moveSlides : 3,
			slideWidth :370,
			slideMargin: 20,
			touchEnabled : (navigator.maxTouchPoints > 0)
		});
		
		
		$('.other_list_bxslider ul li a img').on('click',function(){
			
			var eidx =$(this).parent().data('eidx');
			alert(eidx);
			var f = document.createElement('form');
			f.setAttribute('method','post');
			f.setAttribute('action','${url}/event/event_view');
			document.charset='utf-8';
			
			var data = document.createElement('input');
			data.setAttribute('type','hidden');
			data.setAttribute('name','eidx');
			data.setAttribute('value',eidx);
			f.appendChild(data);
			
			document.body.appendChild(f);
			
			
			f.submit();			
		});
		
		
		
		
	});
	
	
	
</script>

<div class="wrap">
	<div class="wrap_content">
		<div class="title_wrap">
			<div class="title_inner">
				<h2>이벤트</h2>
			</div>
		</div>
		<div class="view_content">
			<section class="event_wrap">
				<header>
					<h3>
						${event.getETitle()} <span class="date"><fmt:formatDate
								value="${startday}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
								value="${endday}" pattern="yyyy-MM-dd" /></span>
					</h3>
				</header>
				<article class="event_wrap_content">
					<div class="event_content_inner">
						<img
							src="${url}/resources/assets/images/event_img_test/${event.getEContent()}">
					</div>
				</article>

				<div class="other_event_btn">
					<div class="other_event_list">
						<a href="javascript:void(0)">목록</a>
					</div>

				</div>

			</section>

			<section class="event_list_wrap">
				<div class="event_list">
					<dl>
						<dt>진행중 이벤트</dt>
						<dd>
							<section class="other_list_bxslider">

								<ul class="bxSlider">
									<c:forEach var="eventlist" items="${eventlist}"
										varStatus="ecount">
										<fmt:parseDate value="${eventlist.getEStartday()}"
											var="ostartday" pattern="yyyy-MM-dd" />
										<fmt:parseDate value="${eventlist.getEEndday()}" var="oendday"
											pattern="yyyy-MM-dd" />
										<li><a href="javascript:void(0)" class="olist"
											data-eidx=${eventlist.getEIdx()}> <img
												src="${url}/resources/assets/images/event_img_test/${eventlist.getESumnail()}" onclick="page_change(this);">
												<p>
													${eventlist.getETitle() } <br /> <span><fmt:formatDate
															value="${ostartday}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
															value="${oendday}" pattern="yyyy-MM-dd" /></span>
												</p>
										</a></li>
									</c:forEach>
								</ul>

							</section>
						</dd>
					</dl>
				</div>
			</section>
		</div>

	</div>
</div>


<%@ include file="../Template/fotter.jsp"%>
