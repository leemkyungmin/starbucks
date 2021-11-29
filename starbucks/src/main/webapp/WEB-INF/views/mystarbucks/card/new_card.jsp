<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Template/header.jsp"%>
<link rel="stylesheet" href="${url}/resources/assets/style/new_card.css">

<script>
	$().ready(function(){
		$('.card_list img').on('click',function(){
			var target =  $(this).parent().data('target');
			 
			
			var form =document.createElement('form');
			form.setAttribute('method','post');
			form.setAttribute('action','${url}/my/card/new_card_view');
			document.charset='utf-8';
			
			var data = document.createElement('input');
			data.setAttribute('type','hidden');
			data.setAttribute('name','clidx');
			data.setAttribute('value',target);
			form.appendChild(data);
			
			document.body.appendChild(form);
			
			form.submit();
			
			
		});
	});
</script>

<div class="wrap">
	<div class="title_wrap">
		<div class="title_inner">
			<h2>카드</h2>
		</div>
	</div>
	<div class="wrap_content">
		<div class="new_card_wrap">
			<dl class="card_list">
				<dt>
					<a href="javascript:void(0)">실물카드</a>
					
				</dt>
				<dd>
					<ul>
						<c:forEach var="clist" items="${clist}">
							<li>
								<dl>
									<dt>
										<a href="javascript:void(0)" data-target=${clist.getClIdx() }>
											<img  src="${url}/resources/assets/images/card_img_test/${clist.getClImg()}">
										</a>
									</dt>
									<dd>${clist.getClName() }</dd>
								</dl>
							</li>
						</c:forEach>
					</ul>
				</dd>
			</dl>
		</div>
		<%@ include file="/WEB-INF/views/Template/mystarbucks_side_tab.jsp"%>
	</div>
</div>


<%@ include file="/WEB-INF/views/Template/fotter.jsp"%>
