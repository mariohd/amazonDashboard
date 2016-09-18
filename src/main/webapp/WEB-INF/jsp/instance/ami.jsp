<%@ include file="/decorators/jstl.jsp" %>
<div class="row">
   <div class="col-lg-12">
       <h1 class="page-header">2. Choose AMI</h1>
   </div>
</div>

<form role="form" method="post" action="<c:url value="/instances/create" />">
    <fieldset >
    	<div class="panel panel-default">
    		<div class="panel-heading">Instance #1</div>
    		<div class="panel-body">
    			<input type="hidden" value="${regionEndpoint }" name="regionEndpoint">
	    		<div class="form-group">
					<label>Name</label>
					<input class="form-control" name="instanceName" placeholder="Name">
				</div>
				<div class="form-group">
					<label>Description</label>
					<input class="form-control" name="instanceDescription" placeholder="Description">
				</div>
				<div class="form-group"> 
					<label for="amiID">AMI</label>
					<select name="amiID" id="amiID" class="form-control">
						<c:forEach var="image" items="${images }" varStatus="loop">
							<option value="${image.imageId }">${image.name } - ${image.imageId }</option>
						</c:forEach>
					</select>
				</div>
    		</div>
    	</div>
		<button type="submit" class="btn btn-success pull-right">Create</button>
    </fieldset>
</form>
