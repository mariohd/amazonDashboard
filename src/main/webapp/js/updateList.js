$(document).ready(function () {
	var updateButton = $("#updateTableInstances");
	updateButton.click(function () {
		$("#currentInstances").empty();
		$("#currentInstances").append("<tr><td colspan='6' style='text-align: center;'>LOADING!</td></tr>");
		$.get("json/list", function (data) {
			$("#currentInstances").html(data);
		});
	});
});