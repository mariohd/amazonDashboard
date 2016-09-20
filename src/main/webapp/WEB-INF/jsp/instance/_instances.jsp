<%@ include file="/decorators/jstl.jsp" %>

<c:forEach var="instance" items="${instances }" varStatus="loop">
	<tr class="${ instance.state.name eq 'running'? 'success' : (instance.state.name eq 'pending'? 'warning' : 'danger') }">
		<td>${loop.index + 1 }</td>
		<td><c:out value="${instance.tags[0].value}"/></td>
		<td><c:out value="${instance.tags[1].value}"/></td>
		<td><c:out value="${instance.instanceId}"/></td>
		<td><c:out value="${instance.imageId}"/></td>
		<td><c:out value="${instance.instanceType}"/></td>
		<td>
			<fmt:formatDate type="both" 
            	dateStyle="short" timeStyle="medium" 
            	value="${instance.launchTime}" />
		</td>
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