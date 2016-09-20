$(document).ready(function () {
	var updateButton = $("#updateTableInstances");
	var loader = $("#loadingBar");
	updateButton.click(function () {
		$("#currentInstances").fadeOut(function () {
			$(this).empty();
			var loading = loader.clone();
			var td = $("<td colspan=9></td>").wrap("<tr></tr>");
			$(this).append(td.append(loading.show()).parent()).show();
			$.get("json/list", function (data) {
				$("#currentInstances").fadeOut(function () {
					$(this).html(data).fadeIn();
				});
			});
		});
		
	});
});