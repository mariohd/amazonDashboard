$(document).ready(function () {
	var template = $("#instanceModelTemplate");
	var submitModelCreation = $('#submitModelCreation');
	
	$('fieldset').on('click', ".deleteNewInstanceModel", function () {
		$(this).parents('.instanceModel').slideUp(function () {
			$(this).remove();
		})
	});
	
	$('#addNewInstanceModel').click(function () {
		var quantity = $(".instanceModel").length;
		var newModel = template.clone();
		newModel.find("#heading").text("Instance Model #" + (quantity + 1)).append('<span class="deleteNewInstanceModel pull-right fa fa-minus fa-fw link"></span>');
		newModel.find("#instanceName").attr('name', 'models['+quantity +'].instanceName');
		newModel.find("#instanceDescription").attr('name', 'models['+quantity +'].instanceDescription');
		newModel.find("#maxInstances").attr('name', 'models['+quantity +'].maxInstances');
		newModel.find("#instanceType").attr('name', 'models['+quantity +'].instanceType');
		newModel.find("#amiId").attr('name', 'models['+quantity +'].amiId');
		submitModelCreation.before(newModel.hide());
		$('html, body').animate({
	        scrollTop: newModel.slideDown().offset().top
	    }, 1000);
	});
});