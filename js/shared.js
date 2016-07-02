//found this great little plugin on stackoverflow which stops hidden images from loading before they are intentionally accessed
//http://stackoverflow.com/questions/3818063/dont-load-hidden-images

(function($)
{
	$.fn.reveal = function()
	{
		var args = Array.prototype.slice.call(arguments);
		return this.each(function() {
			var img = $(this),
				src = img.data("src");
			
			src && img.attr("src", src).load(function()
			{
				img[args[0] || "show"].apply(img, args.splice(1));
			});
			
			img.show();
			
			localStorage.setItem("visiblePic", img.attr("class"));
		});
	}
}(jQuery));