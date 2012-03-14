jQuery(document).ready(function(){
	$('form .field span em').hide();
	$('form .field span.error').find('em').show();

	$('form .field .help').hide();
	$('form .field a.showHelp').click(function() {
		$(this).parent().parent().find('.help').show();
		$(this).hide();
	});
	$('form .field .help').click(function() {
		$(this).parent().find('a').show();
		$(this).hide();
	});

	$('.datepicker').datepicker({
		dateFormat: 'dd/mm/yy',
		dayNames: ['Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado'],
		dayNamesMin: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'],
		dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
		monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
		monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
		changeMonth: true,
		changeYear: true,
		showOn: 'button',
		buttonImage: '/images/calendar.gif',
		buttonImageOnly: true
	});

	$('.datepicker').parent().find('img').addClass('calendar');

	if(navigator.appName == "Microsoft Internet Explorer") {
		$('#main form .field fieldset').css('width','715px');
		$('.searchBtn a.filter').css('height','16px');
	}

	$('#login.recovery').hide();
	$('#recovery').click(function() {
		$('#login').hide();
		$('#login.recovery').show();
	});

	$('#login.recovery a').click(function() {
		$('#login.recovery').hide();
		$('#login').show();
	});


});

tinyMCE.init({
	//opções gerais
	language : "pt",
	mode : "textareas",
	plugins : "fullpage,paste,advlink,fullscreen",
	theme : "advanced",
	skin : "o2k7",
	skin_variant : "silver",

	//opções de tema
	theme_advanced_buttons1 : "bold,italic,underline,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,blockquote,|,undo,redo,|,link,unlink,cleanup,|,removeformat,fullscreen",
	theme_advanced_buttons2 : "",
	theme_advanced_buttons3 : "",
	theme_advanced_toolbar_location : "top",
	theme_advanced_toolbar_align : "left",
	theme_advanced_statusbar_location : "bottom",
});

function createSearchPopup(route, largura, altura) {
  var winl = (screen.width - largura) / 2;
  var wint = (screen.height - altura) / 2;
  var winprops = 'height=' + altura + ', width=' + largura + ', top=' + wint + ', left=' + winl + ', scrollbars=yes, location=no, status=no';
  var search_form = window.open(route, "", winprops);
  if (parseInt(navigator.appVersion)  >= 4) {
      search_form.window.focus();
  }
}

