jQuery(document).ready(function(){
	$(".phone").mask("(99) 9999-9999");
	$(".cpf").mask("999.999.999-99");
	$(".datepicker").mask("99/99/9999");
	$(".cep").mask("99.999-999");
	$(".cnpj").mask("99.999.999/9999-99");
	$(".password").keyup(function(){
		switch ( passwordStrength($(".password").val())) {
			case 'Péssima':
				$('.password-strength').css('border-color','#F00');
				break;
			case 'Ruim':
				$('.password-strength').css('border-color','#F28C02');
				break;
			case 'Bom':
				$('.password-strength').css('border-color','#C3F202');
				break;
			case 'Forte':
				$('.password-strength').css('border-color','#4FF202');
				break;
		}
		$('.password-strength').html(passwordStrength($(".password").val()))
	});


	$("form.validar").submit(function() {
		validaCnpj($('.cnpj').val());
		validaCpf($('.cpf').val());
		validaEmail($('.email').val());
		validaNascimento($('.birth').val());
		validaConfirm($('.confirm').val());
		validaSenha();
		validaObg();
		errorExplanation();
		return false;
	});

	function validaNascimento(date) {
		er = /(0[0-9]|[12][0-9]|3[01])[-\.\/](0[0-9]|1[012])[-\.\/][0-9]{4}/;
		nascf = date.substring(3, 5) + "/" + date.substring(0, 2) + "/" + date.substring(6);
		nasc = new Date(nascf);
		hoje = new Date();
		nasc.setHours(hoje.getHours());
		nasc.setMinutes(hoje.getMinutes());
		nasc.setSeconds(hoje.getSeconds());
		if(er.exec(date) && nasc.getDate() >= hoje.getDate() && nasc.getMonth() >= hoje.getMonth() && nasc.getFullYear() >= hoje.getFullYear()) {
			$('.birth').parent().parent().addClass('error');
			return false;
		} else {
			$('.birth').parent().parent().removeClass('error');
			return true;
		}
	}

	function validaCpf(cpf) {
		var erro = 0;
		cpf = cpf.substring(0, 3) + cpf.substring(4, 7) + cpf.substring(8, 11) + cpf.substring(12,14);
		if (cpf == "00000000000" || cpf == "11111111111" || cpf == "22222222222" || cpf == "33333333333" || cpf == "44444444444" || cpf == "55555555555" || cpf == "66666666666" || cpf == "77777777777" || cpf == "88888888888" || cpf == "99999999999")
			erro = 1;
		add = 0;
		for (i=0; i < 9; i ++)
			add += parseInt(cpf.charAt(i)) * (10 - i);
		rev = 11 - (add % 11);
		if (rev == 10 || rev == 11)
			rev = 0;
		if (rev != parseInt(cpf.charAt(9)))
			erro = 1;
		add = 0;
		for (i = 0; i < 10; i ++)
			add += parseInt(cpf.charAt(i)) * (11 - i);
		rev = 11 - (add % 11);
		if (rev == 10 || rev == 11)
			rev = 0;
		if (rev != parseInt(cpf.charAt(10)))
			erro = 1;
		if (cpf == "")
			erro = 0;
		if (erro == 1) {
			$('.cpf').parent().parent().addClass('error');
			return false;
		} else {
			$('.cpf').parent().parent().removeClass('error');
			return true;
		}
	}

	function validaEmail(email) {
		er = /^[a-zA-Z0-9][a-zA-Z0-9\._-]+@([a-zA-Z0-9\._-]+\.)[a-zA-Z-0-9]{2}/;
		if(er.exec(email)) {
			$('.email').parent().parent().removeClass('error');
			return true;
		} else {
			$('.email').parent().parent().addClass('error');
			return false;
		}
	}

	function validaCnpj(CNPJ) {
		erro = new String;
		if (CNPJ.length < 18) erro += "É necessario preencher corretamente o número do CNPJ! \n\n";
		if ((CNPJ.charAt(2) != ".") || (CNPJ.charAt(6) != ".") || (CNPJ.charAt(10) != "/") || (CNPJ.charAt(15) != "-")){
			if (erro.length == 0) erro += "É necessário preencher corretamente o número do CNPJ! \n\n";
		}

		if(document.layers && parseInt(navigator.appVersion) == 4){
			x = CNPJ.substring(0,2);
			x += CNPJ. substring (3,6);
			x += CNPJ. substring (7,10);
			x += CNPJ. substring (11,15);
			x += CNPJ. substring (16,18);
			CNPJ = x;
		} else {
			CNPJ = CNPJ. replace (".","");
			CNPJ = CNPJ. replace (".","");
			CNPJ = CNPJ. replace ("-","");
			CNPJ = CNPJ. replace ("/","");
		}
		var nonNumbers = /\D/;
		if (nonNumbers.test(CNPJ)) erro += "A verificação de CNPJ suporta apenas números! \n\n";
		var a = [];
		var b = new Number;
		var c = [6,5,4,3,2,9,8,7,6,5,4,3,2];
		for (i=0; i<12; i++){
			a[i] = CNPJ.charAt(i);
			b += a[i] * c[i+1];
		}
		if ((x = b % 11) < 2) { a[12] = 0 } else { a[12] = 11-x }
		b = 0;
		for (y=0; y<13; y++) {
			b += (a[y] * c[y]);
		}
		if ((x = b % 11) < 2) { a[13] = 0; } else { a[13] = 11-x; }
		if ((CNPJ.charAt(12) != a[12]) || (CNPJ.charAt(13) != a[13])){
			erro +="Dígito verificador com problema!";
		}
		if (erro.length > 0){
			$('.cnpj').parent().parent().addClass('error');
			return false;
		} else {
			$('.cnpj').parent().parent().removeClass('error');
			return true;
		}
		return true;
	}

	function validaConfirm(confirm) {
		if(confirm != $("input[name='txtPass']").val()) {
			$('.confirm').parent().parent().addClass('error');
			return false;
		} else {
			$('.confirm').parent().parent().removeClass('error');
			return true;
		}
	}

	function validaObg() {

		$('.box.fields .field span .obg').each(function(index) {
			if($(this).val() == ''){
				$(this).parent().parent().addClass('error');
			} else {
				$(this).parent().parent().removeClass('error');
			}
		});
	}

	function validaSenha() {
		$(".box.fields .field span input[type='password']").each(function(index) {
			if($(this).val().length < 6){
				$(this).parent().parent().addClass('error');
			} else {
				$(this).parent().parent().removeClass('error');
			}
		});
	}

	function dataAtual() {
		var d = new Date();
		var curr_date = d.getDate();
		if(curr_date < 10)
			curr_date = "0" + curr_date;
		var curr_month = d.getMonth();
		curr_month++;
		if(curr_month < 10)
			curr_month = "0" + curr_month;
		var curr_year = d.getFullYear();
		hoje = curr_date + "/" + curr_month + "/" + curr_year;
		return hoje;
	}


	function errorExplanation() {
		if($('.box.fields').find('.error').length == 0) {
			$('#errorExplanation').remove();
			var campo = '';
		} else {
			$('#errorExplanation').remove();
			$('#sidebar').append('<div class="errorExplanation" id="errorExplanation"><h2></h2></div>');
			var campo = '';
			if ($('.box.fields').find('.error').length == 1) {
				$('#errorExplanation h2').text('1 erro encontrado');
			};
			if ($('.box.fields').find('.error').length > 1){
				$('#errorExplanation h2').text($('.box.fields').find('.error').length + ' erros encontrados');
			};
			mountErrors();

			var offset = $("#errorExplanation").offset();
			var topPadding = 15;
			$(document).scroll(function() {
				if ($(document).scrollTop() > offset.top) {
					$("#errorExplanation").stop().animate({
						marginTop: $(window).scrollTop() - offset.top + topPadding
					});
				} else {
					$("#errorExplanation").stop().animate({
						marginTop: 0
					});
				};
			});
		}

	}

	function mountErrors() {
		$('#errorExplanation').append('<ul></ul>');
		$('.box.fields .error').each(function(index) {
			campo = $(this).find('label').text();
			if($(this).find('label a.showHelp').length > 0) {
				campo = campo.substr(0,($(this).find('label').text().length-26));
			} else {
				campo = campo.substr(0,($(this).find('label').text().length-15));
			}
			if($(this).find('.message').length > 0) {
				$('#errorExplanation ul').append('<li><a href="#' + $(this).find('label').attr('for') +'" title="" rel="errors">Campo ' + campo +': ' + $(this).find('.message').text() + '.</a></li></ul>');
			} else {
				$('#errorExplanation ul').append('<li><a href="#' + $(this).find('label').attr('for') +'" title="" rel="errors">Campo ' + campo +': ' + ($(this).find('.help').text()).slice(1) + '.</a></li></ul>');
			}
		});

	}



});

