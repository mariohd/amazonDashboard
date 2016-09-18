<%@ include file="/decorators/jstl.jsp" %>
<div class="row">
   <div class="col-lg-12">
       <h1 class="page-header">EC2 Instances</h1>
   </div>
</div>

<div class="col-lg-12">
  <div class="panel panel-default">
  		<div class="panel-heading">
  			Instances of ${regionEndpoint}
  		</div>
      <div class="panel-body">
          <div class="table-responsive">
              <table class="table">
                  <thead>
                      <tr>
                      	<th>#</th>
						<th>Name</th>
						<th>Description</th>
						<th>Instance ID</th>
						<th>Image ID</th>
						<th>Status</th>
						<th></th>
                      </tr>
                  </thead>
                  <tbody>
					<c:forEach var="instance" items="${instances }" varStatus="loop">
						<tr class="${ instance.state.name eq 'running'? 'success' : (instance.state.name eq 'pending'? 'warning' : 'danger') }">
							<td>${loop.index + 1 }</td>
							<td><c:out value="${instance.tags[0].value}"/></td>
							<td><c:out value="${instance.tags[1].value}"/></td>
							<td><c:out value="${instance.instanceId}"/></td>
							<td><c:out value="${instance.imageId}"/></td>
							<td style="text-transform: capitalize"><c:out value="${instance.state.name}"/></td>
							<td>
								
								<c:if test="${'running' eq instance.state.name}">
									<a title="Stop" alt="Stop" href="<c:url value="/instances/stop"/>/${instance.instanceId}">
										<i class="fa fa-power-off fa-fw link">
										</i>
									</a>
								</c:if>
								<c:if test="${'stopped' eq instance.state.name}">
									<a title="Start" alt="Start" href="<c:url value="/instances/start"/>/${instance.instanceId}">
										<i class="fa fa-power-off fa-fw link">
										</i>
									</a>
								</c:if>
								<c:if test="${'terminated' != instance.state.name}">
									<a title="Terminate" alt="Terminate" href="<c:url value="/instances/terminate"/>/${instance.instanceId}">
										<i class="fa fa-times fa-fw link">
										</i>
									</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
                  </tbody>
              </table>
              <a href="<c:url value="/instances/add" />">
	              <button type="button" class="btn btn-success btn-circle btn-lg pull-right">
              		<i class="fa fa-plus"></i>
	              </button>
              </a>
          </div>
      </div>
  </div>
</div>