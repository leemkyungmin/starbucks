<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<c:forEach var="cktlist" items="${cktlist}" varStatus="cktcount">
		<c:if test="${cktcount.count eq 1 }">
			<div class="coffee_list_wrap coffee coffee_list_wrap${Category}" >
				<div class="product_list">
					<dl>
		</c:if>
					<dt>${cktlist.getCktName()}</dt>
					<dd>
						<ul>
							<c:forEach var="cklist" items="${cklist}">
								<c:if test="${cktlist.getCktIdx() eq cklist.getCktIdx() }"  var="a">
									<li class="coffeeData">
										<dl>
											<dt>
												<a href="javascript:void(0)" data-target="${cklist.getCkIdx() }" class="coffee_img">
													<img alt="${cklist.getCkName()}" src="${url}/resources/assets/images/coffee_img_test/${cklist.getCkImg()}">
												</a>
											</dt>
											<dd>${cklist.getCkName()}</dd>
										</dl>
									</li>
							</c:if>
							</c:forEach>
						</ul> 
					</dd>
		</c:forEach>
				</dl>
			</div>
		</div>			