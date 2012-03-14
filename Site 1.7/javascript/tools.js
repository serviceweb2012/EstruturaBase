jQuery(document).ready(function(){

	$('a[href*=#]').click(function() {
		if( $(this).attr('rel') == 'errors') {
			if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
				var $target = $(this.hash);
				$target = $target.length && $target || $('[for=' + this.hash.slice(1) +']');
				if ($target.length) {
					var targetOffset = $target.offset().top;
					$('html,body').animate({scrollTop: targetOffset}, 1000);
					return false;
				}
			}
		} else {
			if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
            var $target = $(this.hash);
            $target = $target.length && $target || $('[name=' + this.hash.slice(1) +']');
			if ($target.length) {
				var targetOffset = $target.offset().top;
				$('html,body').animate({scrollTop: targetOffset}, 1000);
			return false;
			}
        }
		}
	});
	
	$(document).mouseup(function(e) {
		if($(e.target).parent(".navBar > li").length==0) {
			$('.navBar li ul').hide();
			$('.navBar li').removeClass('active');
		}
		if($(e.target).parent(".box.tools li > ul").length==0) {
			$('.box.tools li > ul').hide();
		}
		/* var input_help = $(e.target).parent('form label');
		if( $(e.target).parent("form label .help").length==0) {
			if( !input_help.find("input[type='text']:nth-child(1)").length==0)
			{
				$('form label .help').parent().find('a').show();
				$('form label .help').hide();
			}
		}	 */
	});
	
	$('.navBar li > ul').hide();
	$('.navBar > li').click( function() {
		if ( $(this).find('ul').css('display') == 'block') {
			$(this).find('ul').hide();
			$(this).removeClass('active');
		} else {
			$('.navBar li ul').hide();
			$('.navBar li').removeClass('active');
			$(this).find('ul').show();
			$(this).toggleClass('active');
		}		
	});
	
	var COOKIE_NAME = 'fonte_cookie';
	var options = { path: '/', expires: 10 };
	
	if ($.cookie(COOKIE_NAME) != 'null' ) {
		$('#container').css('font-size',$.cookie(COOKIE_NAME));	
	}; 
	
	$('.fontBig').click( function() {
		$.cookie(COOKIE_NAME, '103.5%', options);
		$('#container').css('font-size',$.cookie(COOKIE_NAME));
	});
	$('.fontMedium').click( function() {
		$.cookie(COOKIE_NAME, '100%', options);
		$('#container').css('font-size',$.cookie(COOKIE_NAME));	
	});
	$('.fontSmall').click( function() {
		$.cookie(COOKIE_NAME, '96.5%', options);
		$('#container').css('font-size',$.cookie(COOKIE_NAME));	
	});
	
});

function calc() {
	if( navigator.appName == "Microsoft Internet Explorer" ) {
		var wsh = new ActiveXObject('WScript.Shell');
		wsh.Run("calc.exe");
	} else {
		alert('Infelizmente você vai ter que fazer as contas de cabeça =/');
	}
}

