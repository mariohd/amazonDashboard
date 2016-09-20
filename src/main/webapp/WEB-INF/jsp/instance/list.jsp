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
 			<span id="updateTableInstances" class="pull-right fa fa-refresh fa-fw link"></span>
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
                  <tbody id="currentInstances">
					<%@ include file="_instances.jsp" %>
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


<div id="loadingBar" class="sk-folding-cube" style="display: none;">
  <div class="sk-cube1 sk-cube"></div>
  <div class="sk-cube2 sk-cube"></div>
  <div class="sk-cube4 sk-cube"></div>
  <div class="sk-cube3 sk-cube"></div>
</div>
<script src="<c:url value="/js/updateList.js" />"></script>