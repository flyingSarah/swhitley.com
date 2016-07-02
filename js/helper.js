jQuery(document).ready(function()
{
	$('a#aboutme').click(function()
	{
		$(this).toggleClass('down');
		jQuery('#softwareSpace').hide();
		jQuery('#videoSpace').hide();
		jQuery('#aboutmeSpace').toggle('show');
	});
	
	$('a#softwareProj').click(function()
	{
		$(this).toggleClass('down');
		jQuery('#aboutmeSpace').hide();
		jQuery('#videoSpace').hide();
		jQuery('#softwareSpace').toggle('show');
	});
	
	$('a#videoProj').click(function()
	{
		$(this).toggleClass('down');
		jQuery('#aboutmeSpace').hide();
		jQuery('#softwareSpace').hide();
		jQuery('#videoSpace').toggle('show');
	});
	
	jQuery('#clickawaySpace').on('click', hideSpaces);
	jQuery('#canvasSketch').on('click', hideSpaces);
	jQuery('#footer').on('click', hideSpaces);
	
	function hideSpaces()
	{
		jQuery('#aboutmeSpace').hide();
		jQuery('#softwareSpace').hide();
		jQuery('#videoSpace').hide();
	}
	
	$('#nextPic').on('click',function()
	{
		var storageItem = localStorage.getItem('visiblePic');
		var visiblePic = "." + storageItem;
		var nextPic;
		var picNumStr = storageItem.replace(/[^\d.]/g, "");
		var picNum = parseInt(picNumStr, 10);
		
		if(picNum == 22)
		{
			nextPic = ".pic_" + 1;
		}
		else
		{
			nextPic = ".pic_" + (picNum+1);
		}
		
		jQuery(visiblePic).hide();
		$(nextPic).reveal('fadeIn', 300);
		jQuery(nextPic).show();
	});
	
	$('#prevPic').on('click',function()
	{
		var storageItem = localStorage.getItem('visiblePic');
		var visiblePic = "." + storageItem;
		var prevPic;
		var picNumStr = storageItem.replace(/[^\d.]/g, "");
		var picNum = parseInt(picNumStr, 10);
		
		if(picNum == 1)
		{
			prevPic = ".pic_" + 22;
		}
		else
		{
			prevPic = ".pic_" + (picNum-1);
		}
		
		jQuery(visiblePic).hide();
		$(prevPic).reveal('fadeIn', 300);
		jQuery(prevPic).show();
	});
	
	$('#closePicSpace').on('click',function()
	{
		for(var i = 1; i < 23; i++)
		{
			var pic = ".pic_" + i;
			jQuery(pic).hide();
		}
		
		jQuery('#picSpace').hide();
	});
});