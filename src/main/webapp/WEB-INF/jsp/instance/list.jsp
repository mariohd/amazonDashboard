<%@ include file="/decorators/jstl.jsp" %>
<div class="row">
   <div class="col-lg-12">
       <h1 class="page-header">Instances</h1>
   </div>
</div>

<div class="col-lg-12">
  <div class="panel panel-default">
  		<div class="panel-heading">
  			${regionEndpoint }
  		</div>
      <div class="panel-body">
          <div class="table-responsive">
              <table class="table">
                  <thead>
                      <tr>
                      	<th>#</th>
						<th>Name</th>
						<th>Descrição</th>
						<th>Instance ID</th>
						<th>Image ID</th>
						<th>Estado</th>
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
								<span class="fa fa-power-off fa-fw link" title="Stop" alt="Stop"></span>
								<span class="fa fa-trash-o fa-fw link" alt="Terminate" title="Terminate"></span>
							</td>
						</tr>
					</c:forEach>
                  </tbody>
              </table>
              <a href="<c:url value="/instances/add/region" />">
	              <button type="button" class="btn btn-success btn-circle btn-lg pull-right">
	              		<i class="fa fa-plus">
	              		</i>
	              </button>
              </a>
          </div>
      </div>
  </div>
</div>