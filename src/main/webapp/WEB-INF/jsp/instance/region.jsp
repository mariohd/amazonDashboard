<%@ include file="/decorators/jstl.jsp" %>
<div class="row">
   <div class="col-lg-12">
       <h1 class="page-header">1. Choose Region</h1>
   </div>
</div>
<form role="form" action="<c:url value="ami" />" method="post">
    <fieldset >
        <div class="form-group"> 
            <label for="amiId">Amazon's Regions</label>
	        <select id="regionEndpoint" name="regionEndpoint" class="form-control">
				<c:forEach var="region" items="${regions }" varStatus="loop">
					<option value="${region.endpoint }">${region.regionName }  (${region.endpoint })</option>
				</c:forEach>
			</select>
       </div>
		<button type="submit" class="btn btn-success pull-right">Select</button>
    </fieldset>
</form>