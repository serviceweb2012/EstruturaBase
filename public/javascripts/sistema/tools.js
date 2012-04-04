$(document).ready(function(){

   $(document).mouseup(function(e) {
		if($(e.target).parent(".navBar li").length==0) {
			$('.navBar li ul').hide();
			$('.navBar li').removeClass('active');
		}
		if($(e.target).parent(".box.tools li ul").length==0) {
			$('.box.tools li ul').hide();
		}
	});

	$('.navBar li ul').hide();
	$('.navBar li').click( function() {
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



    setTimeout(function() { $('.information').fadeOut('slow'); }, 10000);
    $("a[rel^='prettyPhoto']").prettyPhoto({animationSpeed:'fast',slideshow:10000});
    $('span.ordem').hide();
    $('#actions_by_model').hide();

    //ativar/desativar
    $('#enable_disable').click(function(){
        var selecionados = "";
        var modelo = $("#modelo").val();
        $(".box.results input[type='checkbox']").each(function(i){
            if($(this).is(":checked")){
                if(selecionados == ""){
                    selecionados = $(this).val();
                }else{
                    selecionados += ","+$(this).val();
                }
            }
        })
        $("#ids_").val(selecionados);
        window.location.href = "/admin/home/disabled_all/" + modelo + "/"+ selecionados
    });

    //deletar todos
    $('#destroy_all').click(function(){
        var selecionados = "";
        var modelo = $("#modelo").val();
        $(".box.results input[type='checkbox']").each(function(i){
            if($(this).is(":checked")){
                if(selecionados == ""){
                    selecionados = $(this).val();
                }else{
                    selecionados += ","+$(this).val();
                }
            }
        });
        $("#ids_").val(selecionados);

        if(confirm("Essa ação irá deletar TODOS os registros selecionados, deseja prosseguir?")){
            window.location.href = "/admin/home/delete_all/" + modelo + "/"+ selecionados
        }
    });

    //////////////////
    //order by
     $('#ordenar ul li').click(function(){
            $('span.ordem').show('fast');
            var order = $(this).attr('rel');
            $('#orderby').val(order);
            var urlAtual = window.location.href;

             $.get(urlAtual,
                  {order:order},
                    function(dados){
                      nova_lista = $(dados).find("div#listagem").html();
                      //nova_lista retorna tudo / buscar dentro a lista ul li e jogar na nova...l
                      $("div#listagem").html("");
                      $("div#listagem").html(nova_lista)
                      $("div#listagem").find('ul li:nth-child(even), .options .results li:nth-child(even)').css('background-color','#F3F3F3');
	                  $("div#listagem").find('ul li .options').hide();
	                  //$("div#listagem").find('ul li input:not(:checked)').hide();

	                  $('div#listagem ul li').hover( function() {
		                    $(this).find('ul.options').fadeIn('fast');
		                    if($(this).find('input:checkbox').attr('checked') == false) {
			                    $(this).find('input:checkbox').fadeIn('fast');
		                    }
	                    }, function() {
		                    $(this).find('ul.options').fadeOut('fast');
		                    if($(this).find('input:checkbox').attr('checked') == false) {
			                    $(this).find('input:checkbox').fadeOut('fast');
		                    }

	                  });

	                  $("div#listagem input[type='checkbox']").click(function(){
                        checados = $(".box.results input[type='checkbox']:checked");
                        if(checados.length > 1){
                            $("#acoes_em_massa").show('fast');
                        }else{
                            $("#acoes_em_massa").hide('fast');
                        }
                       })


	                  $('.status').click(function() {
		                    if ($(this).text() == "desativar") {
			                    $(this).parent().parent().parent().removeClass('ativado').addClass('desativado');
			                    $(this).text("ativar");
		                    } else {
			                    $(this).parent().parent().parent().removeClass('desativado').addClass('ativado');
			                    $(this).text("desativar");
		                    }
	                    });

                    },
                  "html");
            return false;
        });

    //ordenar de A..Z / Z..A
    $('ul.show li ul li a').click(function(){
        var ordem = $(this).attr('rel');
        $("#ordem").val(ordem)
        var order = $("#orderby").val();
        var urlAtual = window.location.href;

        $.get(urlAtual,
                  {order:order,ordem:ordem},
                    function(dados){
                      nova_lista = $(dados).find("div#listagem").html();
                      //nova_lista retorna tudo / buscar dentro a lista ul li e jogar na nova...l
                      $("div#listagem").html("");
                      $("div#listagem").html(nova_lista)
                      $("div#listagem").find('ul li:nth-child(even), .options .results li:nth-child(even)').css('background-color','#F3F3F3');
	                  $("div#listagem").find('ul li .options').hide();
	                  //$("div#listagem").find('ul li input:not(:checked)').hide();

	                  $('div#listagem ul li').hover( function() {
		                    $(this).find('ul.options').fadeIn('fast');
		                    if($(this).find('input:checkbox').attr('checked') == false) {
			                    $(this).find('input:checkbox').fadeIn('fast');
		                    }
	                    }, function() {
		                    $(this).find('ul.options').fadeOut('fast');
		                    if($(this).find('input:checkbox').attr('checked') == false) {
			                    $(this).find('input:checkbox').fadeOut('fast');
		                    }

	                  });

	                  $("div#listagem input[type='checkbox']").click(function(){
                        checados = $(".box.results input[type='checkbox']:checked");
                        if(checados.length > 1){
                            $("#acoes_em_massa").show('fast');
                        }else{
                            $("#acoes_em_massa").hide('fast');
                        }
                       })

	                  $('.status').click(function() {
		                    if ($(this).text() == "desativar") {
			                    $(this).parent().parent().parent().removeClass('ativado').addClass('desativado');
			                    $(this).text("ativar");
		                    } else {
			                    $(this).parent().parent().parent().removeClass('desativado').addClass('ativado');
			                    $(this).text("desativar");
		                    }
	                    });

                    },
                  "html");
            return false;
    })

    //itens por página
    $('ul.perpage ul li a').click(function(){
        var order = $("#orderby").val();
        var ordem = $("#ordem").val();
        var per_page = $(this).attr('rel');
        var urlAtual = window.location.href;

        if( order && ordem != "" ){
            $.get(urlAtual,
                {per_page:per_page,order:order,ordem:ordem},
                function(dados){
                      nova_lista = $(dados).find("div#listagem").html();
                      //nova_lista retorna tudo / buscar dentro a lista ul li e jogar na nova...l
                      $("div#listagem").html("");
                      $("div#listagem").html(nova_lista);
                      total_ativados = $("div#listagem ul li.ativado");
                      total_desativados = $("div#listagem ul li.desativado");
                      total = total_desativados.length + total_ativados.length;
                      $('span.filters span p em').text(total);
                      $("div#listagem").find('ul li:nth-child(even), .options .results li:nth-child(even)').css('background-color','#F3F3F3');
	                  $("div#listagem").find('ul li .options').hide();
	                 // $("div#listagem").find('ul li input:not(:checked)').hide();

	                  $('div#listagem ul li').hover( function() {
		                    $(this).find('ul.options').fadeIn('fast');
		                    if($(this).find('input:checkbox').attr('checked') == false) {
			                    $(this).find('input:checkbox').fadeIn('fast');
		                    }
	                    }, function() {
		                    $(this).find('ul.options').fadeOut('fast');
		                    if($(this).find('input:checkbox').attr('checked') == false) {
			                    $(this).find('input:checkbox').fadeOut('fast');
		                    }

	                  });

	                  $("div#listagem input[type='checkbox']").click(function(){
                        checados = $(".box.results input[type='checkbox']:checked");
                        if(checados.length > 1){
                            $("#acoes_em_massa").show('fast');
                        }else{
                            $("#acoes_em_massa").hide('fast');
                        }
                       })

	                  $('.status').click(function() {
		                    if ($(this).text() == "desativar") {
			                    $(this).parent().parent().parent().removeClass('ativado').addClass('desativado');
			                    $(this).text("ativar");
		                    } else {
			                    $(this).parent().parent().parent().removeClass('desativado').addClass('ativado');
			                    $(this).text("desativar");
		                    }
	                    });

                    },
                    "html");//get
                return false;
        }else{
            $.get(urlAtual,
                {per_page:per_page},
                function(dados){
                      nova_lista = $(dados).find("div#listagem").html();

                      //nova_lista retorna tudo / buscar dentro a lista ul li e jogar na nova...l
                      $("div#listagem").html("");
                      $("div#listagem").html(nova_lista)
                      total_ativados = $("div#listagem ul li.ativado");
                      total_desativados = $("div#listagem ul li.desativado");
                      total = total_desativados.length + total_ativados.length;
                      $('span.filters span p em').text(total)
                      $("div#listagem").find('ul li:nth-child(even), .options .results li:nth-child(even)').css('background-color','#F3F3F3');
	                  $("div#listagem").find('ul li .options').hide();
	                  //$("div#listagem").find('ul li input:not(:checked)').hide();

	                  $('div#listagem ul li').hover( function() {
		                    $(this).find('ul.options').fadeIn('fast');
		                    if($(this).find('input:checkbox').attr('checked') == false) {
			                    $(this).find('input:checkbox').fadeIn('fast');
		                    }
	                    }, function() {
		                    $(this).find('ul.options').fadeOut('fast');
		                    if($(this).find('input:checkbox').attr('checked') == false) {
			                    $(this).find('input:checkbox').fadeOut('fast');
		                    }

	                  });

	                  $("div#listagem input[type='checkbox']").click(function(){
                        checados = $(".box.results input[type='checkbox']:checked");
                        if(checados.length > 1){
                            $("#acoes_em_massa").show('fast');
                        }else{
                            $("#acoes_em_massa").hide('fast');
                        }
                       })

	                  $('.status').click(function() {
		                    if ($(this).text() == "desativar") {
			                    $(this).parent().parent().parent().removeClass('ativado').addClass('desativado');
			                    $(this).text("ativar");
		                    } else {
			                    $(this).parent().parent().parent().removeClass('desativado').addClass('ativado');
			                    $(this).text("desativar");
		                    }
	                    });

                    },
                    "html");//get
                return false;
        }//else
    })//funciont


    //deletar
    $('a.deletar').click(function(){
        var id = $(this).attr('rel');
        var urlAtual = window.location.href;

        if(confirm("Deseja realmente excluir o registro?")){
            $.destroy(urlAtual+"/{id}",
            {id:id},
                function(dados){
                      nova_lista = $(dados).find("div#listagem").html();
                      //nova_lista retorna tudo / buscar dentro a lista ul li e jogar na nova...l
                      $("div#listagem").html("");
                      $("div#listagem").html(nova_lista)
                      total_ativados = $("div#listagem ul li.ativado");
                      total_desativados = $("div#listagem ul li.desativado");
                      total = total_desativados.length + total_ativados.length;
                      $('span.filters span p em').text(total)
                      $("div#listagem").find('ul li:nth-child(even), .options .results li:nth-child(even)').css('background-color','#F3F3F3');
	                  $("div#listagem").find('ul li .options').hide();
	                 // $("div#listagem").find('ul li input:not(:checked)').hide();

	                  $('div#listagem ul li').hover( function() {
		                    $(this).find('ul.options').fadeIn('fast');
		                    if($(this).find('input:checkbox').attr('checked') == false) {
			                    $(this).find('input:checkbox').fadeIn('fast');
		                    }
	                    }, function() {
		                    $(this).find('ul.options').fadeOut('fast');
		                    if($(this).find('input:checkbox').attr('checked') == false) {
			                    $(this).find('input:checkbox').fadeOut('fast');
		                    }

	                  });

	                  $("div#listagem input[type='checkbox']").click(function(){
                        checados = $(".box.results input[type='checkbox']:checked");
                        if(checados.length > 1){
                            $("#acoes_em_massa").show('fast');
                        }else{
                            $("#acoes_em_massa").hide('fast');
                        }
                       })

	                  $('.status').click(function() {
		                    if ($(this).text() == "desativar") {
			                    $(this).parent().parent().parent().removeClass('ativado').addClass('desativado');
			                    $(this).text("ativar");
		                    } else {
			                    $(this).parent().parent().parent().removeClass('desativado').addClass('ativado');
			                    $(this).text("desativar");
		                    }
	                    });
                }//function

            )//destroy
        }//if

    });//function


    //ordenar menus
     $('#order_menus_list').sortable({
        axis:'y',
        dropOnEmpty: false,
        handle: '.handle',
        items: 'li',
        update:function(){
            $.get(
               '/admin/menus/sort',
               $(this).sortable('serialize')
            )
        }
    });

    $('#order_menus_list').disableSelection();


    //sub_menus_for_menu
    $('#menu_menu_id').change(function(){
        var id = $('#menu_menu_id :selected').val();
        $.get('/admin/sub_menus/find_sub_menus_by_menu',{menu_id:id});//get
    });//function


    //actions for model
    $('#permission_model_name').change(function(){
        var model_name = $('#permission_model_name :selected').val();
        $.get('/admin/permissions/find_actions_by_model',{model_name:model_name})
    })

    $('.markAllActions').click( function() {
        alert('lol')
		if($(this).attr('checked') == 'checked') {
			$("#actions_by_model span fieldset input:checkbox").attr('checked', 'checked');
		} else {
			$("#actions_by_model span fieldset input:checkbox").removeAttr('checked');
		}

		$('input:checked').parent().css('background-position','center center');
		$('input:not(:checked)').parent().css('background-position','top center');
	});

    $('.markAll').click(function(){
        checados = $(".box.results input[type='checkbox']:checked");
        if(checados.length > 1){
            $("#acoes_em_massa").show('fast');
        }else{
            $("#acoes_em_massa").hide('fast');
        }
    });


    $(".box.results input[type='checkbox']").click(function(){
        checados = $(".box.results input[type='checkbox']:checked");
        if(checados.length > 1){
            $("#acoes_em_massa").show('fast');
        }else{
            $("#acoes_em_massa").hide('fast');
        }
    })



});

function calc() {
	if( navigator.appName == "Microsoft Internet Explorer" ) {
		var wsh = new ActiveXObject('WScript.Shell');
		wsh.Run("calc.exe");
	} else {
		alert('Infelizmente você vai ter que fazer as contas de cabeça =/');
	}
}

