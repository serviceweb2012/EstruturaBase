$(document).ready(function(){
	$('.results ul li:nth-child(even), .options .results li:nth-child(even)').css('background-color','#F3F3F3');
	$('.results ul li .options').hide();
    $("#acoes_em_massa").hide();

    //ação de ocultar opções de 'editar-visualizar-ativar-destruir quando mouse estive fora do item, e mstrar quando mouse estiver sobre'
	$('.results ul li').hover( function() {
		$(this).find('.options').fadeIn('fast');
	}, function() {
		$(this).find('.options').fadeOut('fast');
	});

	$('input:checked').parent().css('background-position','bottom center');

    //marcar todos ao clicar em marcar todos
	$('.markAll').click( function() {
		if($(this).attr('checked') == 'checked') {
			$(".results ul li input:checkbox").attr('checked', 'checked');
		} else {
			$(".results ul li input:checkbox").removeAttr('checked');
		}

		$('input:checked').parent().css('background-position','center center');
		$('input:not(:checked)').parent().css('background-position','top center');
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

    $('ul.show li ul, .box.search ul.perpage li ul').hide();
    $('ul.show li ul li').click(function(){
        if($('ul.show li ul li').css('display') == 'none'){
            $(this).find('ul').show();
        }else if($('ul.show li ul li').css('display') == 'block') {
            $(this).find('ul').css('display','none')
        }
    })

    $('.box.search ul.perpage li').click(function(){
        if($('.box.search ul.perpage li ul').css('display') == 'none'){
            $(this).find('ul').show();
        }else if($('.box.search ul.perpage li ul').css('display') == 'block') {
            $(this).find('ul').css('display','none')
        }
    })

    //clicar no itens por pagina do search ele faz a busca
    $('.box.search ul.perpage li ul li a').click(function(){
        var per_page = $(this).attr('rel');
        var url = window.location.href;
        $.get(url,
              {per_page:per_page},
              function(dados){
                  var nova_tabela = $(dados).find("table[name='list'] tbody").html();
                  var nova_paginate = $(dados).find('div.pagination')

                  $("table[name='list'] tbody").html('');
                  $("table[name='list'] tbody").html(nova_tabela);
                  $('div.pagination').html(nova_paginate)
              }
        )//get
    })



	$('.box.tools').hide();
	$('.triggerAction').click(function() {
		$('.box.tools').slideToggle();
	});

	$('.status').click(function() {
		if ($(this).text() == "desativar") {
			$(this).parent().parent().parent().removeClass('ativado').addClass('desativado');
			$(this).text("ativar");
		} else {
			$(this).parent().parent().parent().removeClass('desativado').addClass('ativado');
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

