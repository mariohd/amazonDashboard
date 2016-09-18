<%@ include file="/decorators/jstl.jsp" %>
<div class="row">
   <div class="col-lg-12">
       <h1 class="page-header">Amazon's Regions</h1>
   </div>
</div>
<form role="form" action="<c:url value="/regions/select" />" method="post">
    <fieldset >
        <div class="form-group"> 
	        <select id="region" name="regionEndpoint" class="form-control">
				<c:forEach var="region" items="${regions }" varStatus="loop">
					<option
					<c:out value="${'ec2.us-west-2' eq selectedRegion.regionName ? 'selected' : ''}"></c:out>
					value="${region.endpoint }">${region.regionName } (${region.endpoint })</option>
				</c:forEach>
			</select>
			<p></p>
       </div>
		<button type="submit" class="btn btn-success pull-right">Select</button>
    </fieldset>
</form>