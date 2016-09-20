$(document).ready(function () {
	var updateButton = $("#updateTableInstances");
	updateButton.click(function () {
		$("#currentInstances").empty();
		var loading = $("#loadingBar").clone().show();
		var td = $("<td colspan=6></td>").wrap("<tr></tr>");
		$("#currentInstances").append(td.append(loading).parent());
		$.get("json/list", function (data) {
			$("#currentInstances").html(data);
		});
	});
});