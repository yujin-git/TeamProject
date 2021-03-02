<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>

table{
 
  {table-layout:fixed;word-break:break-all;}
 
}





</style>

<!-- ============================================================== -->
<!-- Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->
<div class="page-wrapper">
	<div class="container-fluid">
		<div class="page-breadcrumb">
			<div class="row">
				<div class="col-md-12">

					<table
						class="table table-bordered table-hover table-condensed text-center "
						style="margin-left: auto; margin-right: auto;  ��height: 20px;">
						<!-- ���̺� �÷����� col-*-*�迭�� ���� -->

						<tr>
							<th style="width: 9%;" class="col-md-1 text-center">��ȣ</th>
							<th style="width: 50%;" class="text-center">����</th>
							<th style="width: 9%;" class="col-md-1 text-center">�ۼ���</th>
							<th style="width:9%;" class="col-md-1 text-center">���̵�</th>
							<th style="width: 9%;" class="col-md-2 text-center">�ۼ���</th>
							<th style="width: 8%;" class="col-md-2 text-center">�亯����</th>
						</tr>
						<c:if test="${empty list }" var="isEmpty">
							<tr>
								<td colspan="4">��ϵ� �Խù��� �����</td>
							</tr>
						</c:if>
						<c:if test="${!isEmpty}">
							<c:forEach var="item" items="${list}" varStatus="loop">
								<tr style="font-size: 13px">
									<td>${totalRecordCount - (((nowPage - 1) * pageSize) + loop.index)}</td>
									<td class="text-left"><a ${item.none}
										href="<c:url value='/QuestionsAdminlistOne.do?bbsNo=${item.BBSNO}&nowPage='/><c:out value='${param.nowPage}' default='1'/>">${item["TITLE"]}</a>
									</td>
									<td>${item.NAME}</td>
									<td>${item.ID}</td>
									<td>${item.BBSPOSTDATE}</td>						
									<td style="font-weight: bolder; color:${item.color};">${item.success} </td>
								</tr>
							</c:forEach>
						</c:if>



					</table>

					</div>

					
			
			</div>
			
			<div class="row">
						<div class="col-md-12 text-center">${pagingString}</div>
			</div>
			
		</div>
	</div>
</div>

