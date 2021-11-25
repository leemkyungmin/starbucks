<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp"%>

<link rel="stylesheet" href="${url}/resources/assets/style/notice_view.css">

<div class="wrap">
	<div class="notice_wrap">
		<div class="title_wrap">
			<div class="title_inner">
				<h2>공지사항</h2>
			</div>
		</div>

		<section class="notice_wrap_content">
			<header>
				<h3>${ndto.getNTitle() }</h3>
			</header>

			<article class="notice_info">
				<div class="notict_info_inner">${ndto.getNContent() }</div>
			</article>

			<div class="btn_notice_wrap">
				<p class="btn_notice_list">
					<a href="javascript:void(0)">목록</a>
				</p>
			</div>

		</section>

		<table class="other_notice_list">
			<colgroup>
				<col width="18.181818%">
				<col width="89.818182%">
			</colgroup>
			<tbody class="other_list">
				<tr>
					<th class="fth">윗글</th>
					<td class="ftd" data-remote=${next.getNIdx() }>
						<a href="javascript:void(0)">
							${next eq null ? "해당글이 없습니다." : next.getNTitle()}
						</a>
					</td>
				</tr>
				<tr>
					<th class="lth">아랫글</th>
					<td class="ltd" data-remote=${prev.getNIdx() }>
						<a href="javascript:void(0)">
							${prev eq null ? "해당글이 없습니다." : prev.getNTitle()}
						</a>
					</td>
				</tr>
			</tbody>
		</table>

	</div>
</div>



<%@ include file="../Template/fotter.jsp"%>

