<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp"%>
<link rel="stylesheet"
	href="${url}/resources/assets/style/eventpage.css">

<script>
	$().ready(function(){
		
		if(${type ne null}){
			$('.event_content_wrap h3 a').removeClass('on');
			if(${type eq 'CARD'}){
				$('.card_event a').addClass('on');
				$('.event_content_wrap article').css({'display':'none'});
				$('.card_event a').parent().next().css({'display':'block'});
			} else{
				$('.reward_event a').addClass('on');
				$('.event_content_wrap article').css({'display':'none'});
				$('.reward_event a').parent().next().css({'display':'block'});
			}
			
		}
		
		$('.event_content_wrap h3 a').on('click',function(){
			
			//선택된 메뉴 클래스 추가 
			$('.event_content_wrap h3 a').removeClass('on');
			$(this).addClass('on');
			
			//선택된 메뉴의 article보여주기
			
			$('.event_content_wrap article').css({'display':'none'});
			$(this).parent().next().css({'display':'block'});
			
		});
		
		$('.event_list a img').on('click',function(){
			var eidx =$(this).parent().data('eidx');

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

	<div class="event_wrap">
		<div class="title_wrap">
			<div class="title_inner">
				<h2>이벤트</h2>
			</div>
		</div>
		<div class="event_content">
			<section class="event_content_wrap">
				<div class="empty_box"></div>
				<h3 class="all_event">
					<a class="on" href="javascript:void(0)">전체</a>
				</h3>
				<article class="all">
					<div class="event_list">
						<dl>
							<dt>진행중 이벤트</dt>
							<dd>
								<ul>
									<c:forEach var="pevent" items="${pEvent}">
										<fmt:parseDate value="${pevent.getEStartday()}" var="startday"
											pattern="yyyy-MM-dd" />
										<fmt:parseDate value="${pevent.getEEndday()}" var="endday"
											pattern="yyyy-MM-dd" />
										<li>
											<dl>
												<dt>
													<a href="javascript:void(0)" data-eidx=${pevent.getEIdx() }>
														<img
														src="${url}/resources/assets/images/event_img_test/${pevent.getESumnail()}">
													</a>
												</dt>
												<dd>
													<h4>${pevent.getETitle() }</h4>
													<p class="date">
														<fmt:formatDate value="${startday}" pattern="yyyy-MM-dd" />
														~
														<fmt:formatDate value="${endday}" pattern="yyyy-MM-dd" />
													</p>
												</dd>
											</dl>
										</li>
									</c:forEach>
								</ul>
							</dd>
							<dt>종료된 이벤트</dt>
							<dd>
								<ul>
									<c:forEach var="endevent" items="${endEvent}">
										<fmt:parseDate value="${endevent.getEStartday()}"
											var="startday" pattern="yyyy-MM-dd" />
										<fmt:parseDate value="${endevent.getEEndday()}" var="endday"
											pattern="yyyy-MM-dd" />
										<li>
											<dl>
												<dt>
													<a href="javascript:void(0)"
														data-eidx=${endevent.getEIdx() }> <span
														class="event_close"> <i> <img
																src="${url}/resources/assets/images/commom/event_close.png">
														</i>
													</span> <img
														src="${url}/resources/assets/images/event_img_test/${endevent.getESumnail()}">
													</a>
												</dt>
												<dd>
													<h4>${endevent.getETitle() }</h4>
													<p class="date">
														<fmt:formatDate value="${startday}" pattern="yyyy-MM-dd" />
														~
														<fmt:formatDate value="${endday}" pattern="yyyy-MM-dd" />
													</p>
												</dd>
											</dl>
										</li>

									</c:forEach>
								</ul>
							</dd>
						</dl>
					</div>
				</article>

				<h3 class="card_event">
					<a href="javascript:void(0)">스타벅스 카드</a>
				</h3>
				<article class="card" style="display: none">
					<div class="event_list">
						<dl>
							<dt>진행중 이벤트</dt>
							<dd>
								<ul>
									<c:forEach var="pevent" items="${pEvent}">
										<c:if test="${pevent.getEType() eq 'CARD' }">
											<fmt:parseDate value="${pevent.getEStartday()}"
												var="startday" pattern="yyyy-MM-dd" />
											<fmt:parseDate value="${pevent.getEEndday()}" var="endday"
												pattern="yyyy-MM-dd" />
											<li>
												<dl>
													<dt>
														<a href="javascript:void(0)"
															data-eidx=${pevent.getEIdx() }> <img
															src="${url}/resources/assets/images/event_img_test/${pevent.getESumnail()}">
														</a>
													</dt>
													<dd>
														<h4>${pevent.getETitle() }</h4>
														<p class="date">
															<fmt:formatDate value="${startday}" pattern="yyyy-MM-dd" />
															~
															<fmt:formatDate value="${endday}" pattern="yyyy-MM-dd" />
														</p>
													</dd>
												</dl>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</dd>
							<dt>종료된 이벤트</dt>
							<dd>
								<ul>
									<c:forEach var="endevent" items="${endEvent}">
										<c:if test="${endevent.getEType() eq 'CARD' }">
											<fmt:parseDate value="${endevent.getEStartday()}"
												var="startday" pattern="yyyy-MM-dd" />
											<fmt:parseDate value="${endevent.getEEndday()}" var="endday"
												pattern="yyyy-MM-dd" />
											<li>
												<dl>
													<dt>
														<a href="javascript:void(0)"
															data-eidx=${endevent.getEIdx() }> <img
															src="${url}/resources/assets/images/event_img_test/${endevent.getESumnail()}">
														</a>
													</dt>
													<dd>
														<h4>${endevent.getETitle() }</h4>
														<p class="date">
															<fmt:formatDate value="${startday}" pattern="yyyy-MM-dd" />
															~
															<fmt:formatDate value="${endday}" pattern="yyyy-MM-dd" />
														</p>
													</dd>
												</dl>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</dd>
						</dl>
					</div>
				</article>
				<h3 class="reward_event">
					<a href="javascript:void(0)">스타벅스 리워드</a>
				</h3>
				<article class="reward" style="display: none">
					<div class="event_list">
						<dl>
							<dt>진행중 이벤트</dt>
							<dd>
								<ul>
									<c:forEach var="pevent" items="${pEvent}">
										<c:if test="${pevent.getEType() eq 'REWARD' }">
											<fmt:parseDate value="${pevent.getEStartday()}"
												var="startday" pattern="yyyy-MM-dd" />
											<fmt:parseDate value="${pevent.getEEndday()}" var="endday"
												pattern="yyyy-MM-dd" />
											<li>
												<dl>
													<dt>
														<a href="javascript:void(0)"
															data-eidx=${pevent.getEIdx() }> <img
															src="${url}/resources/assets/images/event_img_test/${pevent.getESumnail()}">
														</a>
													</dt>
													<dd>
														<h4>${pevent.getETitle() }</h4>
														<p class="date">
															<fmt:formatDate value="${startday}" pattern="yyyy-MM-dd" />
															~
															<fmt:formatDate value="${endday}" pattern="yyyy-MM-dd" />
														</p>
													</dd>
												</dl>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</dd>
							<dt>종료된 이벤트</dt>
							<dd>
								<ul>
									<c:forEach var="endevent" items="${endEvent}">
										<c:if test="${endevent.getEType() eq 'REWARD' }">
											<fmt:parseDate value="${endevent.getEStartday()}"
												var="startday" pattern="yyyy-MM-dd" />
											<fmt:parseDate value="${endevent.getEEndday()}" var="endday"
												pattern="yyyy-MM-dd" />
											<li>
												<dl>
													<dt>
														<a href="javascript:void(0)"
															data-eidx=${endevent.getEIdx() }> <img
															src="${url}/resources/assets/images/event_img_test/${endevent.getESumnail()}">
														</a>
													</dt>
													<dd>
														<h4>${endevent.getETitle() }</h4>
														<p class="date">
															<fmt:formatDate value="${startday}" pattern="yyyy-MM-dd" />
															~
															<fmt:formatDate value="${endday}" pattern="yyyy-MM-dd" />
														</p>
													</dd>
												</dl>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</dd>
						</dl>
					</div>
				</article>
			</section>
		</div>
	</div>
</div>

<%@ include file="../Template/fotter.jsp"%>

