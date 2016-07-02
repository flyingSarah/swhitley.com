jQuery(document).ready(function()
{
	$('img').on('click', function()
	{
		var imgID = "img." + $(this).attr('id');
		jQuery('#picSpace', window.parent.document).show();
		jQuery(imgID, window.parent.document).reveal('fadeIn', 300);
	});
});