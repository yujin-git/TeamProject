
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>


.modal {
        text-align: center;
}
 
@media screen and (min-width: 768px) { 
        .modal:before {
                display: inline-block;
                vertical-align: middle;
                content: " ";
                height: 100%;
        }
}
 
.modal-dialog {
        display: inline-block;
        text-align: left;
        vertical-align: middle;
}

</style>

<div class="page-wrapper">
			<!-- ============================================================== -->
			<!-- Bread crumb and right sidebar toggle -->
			<!-- ============================================================== -->
			 <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-7 align-self-center">
                        <h4 class="page-title text-truncate text-dark font-weight-medium mb-1">���δ������ �ݵ����</h4>
                    </div>
                </div>
            </div>
			<div class="container-fluid">
				<div class="page-breadcrumb">
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									
									<div class="table-responsive">
                                    <table id="zero_config" class="table table-striped table-bordered no-wrap">
                                        <thead>
                                            <tr>
                                            	<th>��ȣ</th>
                                                <th>���Ӹ�</th>
                                                <th>Ȱ��ȭ</th>
                                            </tr>
                                        </thead>
                                        <tbody>
											<c:if test="${empty list }" var="isEmpty">
												<tr>
													<td colspan="3">��ϵ� �Խù��� �����</td>
												</tr>
											</c:if>
                                            <c:if test="${!isEmpty}">
										<c:forEach var="item" items="${list }" varStatus="loop">
											<tr>
												<td>${totalRecordCount - (((nowPage - 1) * pageSize) + loop.index)}</td>
												<td class="text-left"><a href="<c:url value='#'/>">${item['meetingName']}</a></td>
												<td>
												
														<a href="<c:url value='/FundingUpdate.do?message=����&meetingNo=${item["meetingNo"]} '/>"><button class="btn btn-success">����</button></a>
													
													
												</td>
										
										</c:forEach>
									</c:if>
                                        </tbody>
                                    </table>
                                    <ul class="pagination float-right">
                                        ${pagingString}
                                    </ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>



</script>