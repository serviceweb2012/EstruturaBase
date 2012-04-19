// Password strength meter
// This jQuery plugin is written by firas kassem [2007.04.05]
// Firas Kassem  phiras.wordpress.com || phiras at gmail {dot} com
// for more information : http://phiras.wordpress.com/2007/04/08/password-strength-meter-a-jquery-plugin/

var shortPass = 'Péssima'
var badPass = 'Ruim'
var goodPass = 'Bom'
var strongPass = 'Forte'

function passwordStrength(password,username)
{
    score = 0 
    if (password.length < 6 ) return shortPass
    score += password.length * 6
    score += ( checkRepetition(1,password).length - password.length ) * 1
    score += ( checkRepetition(2,password).length - password.length ) * 1
    score += ( checkRepetition(3,password).length - password.length ) * 1
    score += ( checkRepetition(4,password).length - password.length ) * 1
    if (password.match(/(.*[0-9].*[0-9].*[0-9])/))  score += 5 
    if (password.match(/(.*[!,@,#,$,%,^,&,*,?,_,~].*[!,@,#,$,%,^,&,*,?,_,~])/)) score += 5 
    if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))  score += 10 
    if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/))  score += 15 
    if (password.match(/([!,@,#,$,%,^,&,*,?,_,~])/) && password.match(/([0-9])/))  score += 15 
    if (password.match(/([!,@,#,$,%,^,&,*,?,_,~])/) && password.match(/([a-zA-Z])/))  score += 15 
    if (password.match(/^\w+$/) || password.match(/^\d+$/) )  score -= 10 
    if ( score < 0 )  score = 0 
    if ( score > 100 )  score = 100 
    if (score < 34 ) return badPass
    if (score < 68 ) return goodPass
    return strongPass
}

function checkRepetition(pLen,str) {
    res = ""
    for ( i=0; i<str.length ; i++ ) {
        repeated=true
        for (j=0;j < pLen && (j+i+pLen) < str.length;j++)
            repeated=repeated && (str.charAt(j+i)==str.charAt(j+i+pLen))
        if (j<pLen) repeated=false
        if (repeated) {
            i+=pLen-1
            repeated=false
        }
        else {
            res+=str.charAt(i)
        }
    }
    return res
}