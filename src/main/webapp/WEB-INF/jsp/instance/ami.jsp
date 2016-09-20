<%@ include file="/decorators/jstl.jsp" %>
<div class="row">
   <div class="col-lg-12">
       <h1 class="page-header">Customize your Instances</h1>
   </div>
</div>

<form role="form" method="post" action="<c:url value="/instances/create" />">
    <fieldset >
    	<div id="instanceModelTemplate" class="instanceModel panel panel-default">
    		<div id="heading" class="panel-heading">
    			Instance Model #1
 				<span id="addNewInstanceModel" class="pull-right fa fa-plus fa-fw link"></span>
    		</div>
    		<div class="panel-body">
    			<div class="form-group">
					<label>Region</label>
					<div>${regionEndpoint}</div>
    			</div>
	    		<div class="form-group">
					<label>Name</label>
					<input id="instanceName" class="form-control" name="models[0].instanceName" placeholder="Name">
				</div>
				<div class="form-group">
					<label>Description</label>
					<input id="instanceDescription" class="form-control" name="models[0].instanceDescription" placeholder="Description">
				</div>
				<div class="form-group">
					<label># Instances</label>
					<input id="maxInstances" class="form-control" value="1" name="models[0].maxInstances" placeholder="1" type="number">
				</div>
				<div class="form-group">
					<label>Instance type</label>
					<select id="instanceType" name="models[0].instanceType" class="form-control">
						<c:forEach var="type" items="${instanceType }">
							<option value="${type}">${type}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group"> 
					<label>AMI</label>
					<select id="amiId" name="models[0].amiId" class="form-control">
						<c:forEach var="image" items="${images }" varStatus="loop">
							<option value="${image.imageId}">${image.name } - ${image.imageId }</option>
						</c:forEach>
					</select>
				</div>
    		</div>
    	</div>
		<button id="submitModelCreation" type="submit" class="btn btn-success pull-right">Create</button>
    </fieldset>
</form>

<script src="<c:url value="/js/nInstances.js" />"></script>
