jQuery(document).ready(function(){
	$('.results ul li:nth-child(even), .options .results li:nth-child(even)').css('background-color','#F3F3F3');
	$('.results ul li .options').hide();
	$('.results ul li input:not(:checked)').hide();


	$('.results ul li').hover( function() {
		$(this).find('.options').fadeIn('fast');
		if($(this).find('input:checkbox').attr('checked') == false) {
			$(this).find('input:checkbox').fadeIn('fast');
		}
	}, function() {
		$(this).find('.options').fadeOut('fast');
		if($(this).find('input:checkbox').attr('checked') == false) {
			$(this).find('input:checkbox').fadeOut('fast');
		}

	});

	$('input:checked').parent().css('background-position','bottom center');

	$('.tools input.markAll:checkbox').click( function() {
		if($(this).attr('checked') == true) {
			$(".results ul li input:checkbox").attr('checked', true);
			$('input:checked').show();
		} else {
			$(".results ul li input:checkbox").attr('checked', false);
			$('.results ul li input:not(:checked)').fadeOut('fast');
		}
		$('input:checked').parent().css('background-position','center center');
		$('input:not(:checked)').parent().css('background-position','top center');
	});

	$('.tools .filter input:checkbox').click( function() {
		if($(this).attr('checked') == true) {
			$('.filters ul').append("<li><a href='javascript: void(0);' title=''>" + $(this).val() + "</a></li>");
			$('.filters ul li a').hover( function(){
			$(this).css('background-position','bottom left');
				$(this).parent().css('background-position','bottom right')
			}, function() {
				$(this).css('background-position','top left');
				$(this).parent().css('background-position','top right')
			});

			$('.filters ul li').click( function() {
				var text = $(this).find('a').text();
				$(this).remove();
				$('.tools .filter input:checkbox').each(function() {
					if ($(this).val() == text) {
						$(this).attr('checked', false);
					}
				})

			});
		} else {
			var text = $(this).val();
			$('.filters ul li a').each(function() {
				if ($(this).text() == text) {
					$(this).parent().remove();
				}
			})
		}
	});


	$('.results ul li input:checkbox').click( function() {
		$(".tools input:checkbox").attr('checked', false);
		if($(this).parent().find('.options .status').text() == "desativar") {
			$('input:checked').parent().css('background-position','center center');
			$('input:not(:checked)').parent().css('background-position','top center');
		}
	});


    $('.box.tools ul li').click(function(){
        if($('.box.tools ul li ul').css('display') == 'none'){
            $(this).find('ul').show();
        }else if($('.box.tools ul li ul').css('display') == 'block') {
            $(this).find('ul').css('display','none')
        }
    })
	/*$('.box.tools li ul').hide();
	$('.box.tools ul li').click( function() {
		if ( $(this).find('ul').css('display') == 'block') {
			$(this).find('ul').hide();
		} else {
			$('.box.tools li ul').hide();
			$(this).find('ul').show();
		}
	});

	$('.box.search li ul').hide();
	$('.box.search ul li').click( function() {
		if ( $(this).find('ul').css('display') == 'block') {
			$(this).find('ul').hide();
		} else {
			$('.box.tools li ul').hide();
			$(this).find('ul').show();
		}
	});*/

	$('.box.tools').hide();
	$('.triggerAction').click(function() {
		$('.box.tools').slideToggle();
	});

	$('.status').click(function() {
		if ($(this).text() == "desativar") {
			//$(this).parent().parent().parent().css('background-position','bottom center');
			$(this).text("ativar");
		} else {
			//$(this).parent().parent().parent().css('background-position','top center');
			$(this).text("desativar");
		}
	});



});

function closeSearchPopup(id_field, value, id){
  if(window.opener != null){
	window.opener.document.getElementById(id_field).value = value;
	window.opener.document.getElementById('txtId').value = id;
  	window.close();
  }else{
	alert("Houve um erro ao tentar selecionar um item.\nFeche a janela de pequisa e tente selecionar novamente.\nCaso o erro persista entre em contato conosco!");
  }

}

