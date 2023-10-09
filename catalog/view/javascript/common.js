/*
function getURLVar(key) {
	var value = [];

	var query = String(document.location).split('?');

	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');

			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}

		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
}
*/

// SET COLOR ITEM CART
function setColor(){
	var textCart = parseInt($(".header-desktop .cart-total span").text());

	if(textCart == 0){
        $(".cart-total span").css({'color':'#757574 !important'});
    }else{
        $(".cart-total span").css({'color':'#e40c0c'});
    }

    
}

// SET ITEM OR ITEMS
function setItemCart(){
	var textCart = parseInt($(".header-desktop .cart-total span").text());	
	if(textCart <= 1){
    	$('.cart-total em.txt-items').text('item');    	    	
    }else{
    	$('.cart-total em.txt-items').text('items');    	
    }
}




function getURLVar(key) {
    var value = [], 
        url = String(document.location), 
        query;
    
    if (url.indexOf('?') === -1){
        //make sure no whitespace exists and there is no slash at the end of url
        if (url.trim().slice(-1) === '/'){
            url = url.substring(0, url.length - 1);
        }
        return url.split('/').pop();
    } else {
        query = url.split('?');
        if (query[1]) {
            var part = query[1].split('&');
            
            for (i = 0; i < part.length; i++) {
                var data = part[i].split('=');
                if (data[0] && data[1]) {
                    value[data[0]] = data[1];
                }
            }
            
            if (value[key]) {
                return value[key];
            } else {
                return '';
            }
        }
    }
}



$(document).ready(function() {
	
	$('.banner-btn-close').click(function(){
        $.ajax({
            url: 'index.php?route=common/header_home/index',
            method: 'post',
            data: {
            	session_data : true
            },
        	cache: false,
        });
    });

    //$('input[name=\'telephone\']').numeric();
	 //called when key is pressed in textbox
  	
	//'#collapse-payment-address select[name=\'country_id\']'

	//var width = $('#video-thumbnail iframe').width();
    //alert(width);
    //$('#video-thumbnail iframe').css({"width":"100px"});
    //$('#video-thumbnail iframe').css({"heigth":"567px"});

	setColor();
	setItemCart();

	$('select').selectpicker();

	var evt = 'ontouchend' in document ? 'touchend' : 'click';

	$(document).on(evt, '.btn-continue-shopping', function () {
        bootbox.hideAll();
    });

	// Adding the clear Fix
	cols1 = $('#column-right, #column-left').length;
	
	if (cols1 == 2) {
		$('#content .product-layout:nth-child(2n+2)').after('<div class="clearfix visible-md visible-sm"></div>');
	} else if (cols1 == 1) {
		$('#content .product-layout:nth-child(3n+3)').after('<div class="clearfix visible-lg"></div>');
	} else {
		$('#content .product-layout:nth-child(4n+4)').after('<div class="clearfix"></div>');
	}
	
	// Highlight any found errors
	$('.text-danger').each(function() {
		var element = $(this).parent().parent();
		
		if (element.hasClass('form-group')) {
			element.addClass('has-error');
		}
	});

	/*NEWS LETTER*/

	var voucher_newsletter_open = $('#sticky .voucher').html();

	$(document).on('click', '#sticky .voucher .minimize, #sticky .voucher .maxim', function(){		
		var parent = $('#sticky .voucher');
		
		if(parent.hasClass('open')) {
			html = '<a href="javascript:void(0)" class="maxim"><i class="fa fa-envelope"></i>Dapatkan Voucher Disini</a>';
			parent.html(html);			
			parent.removeClass('open');
			parent.addClass('minimize');
		} else {
			html = voucher_newsletter_open;
			parent.html(html);			
			parent.removeClass('minimize');
			parent.addClass('open');
		}		
	});

	$(document).on('click', '#sticky .voucher .btn-group .btn', function(){
		var button = $(this);
		var btngroup = button.parent().html();
		if(button.attr('id') == 'wanita') {
			var gender = 2;
		} else {
			var gender = 1;
		}

		$.ajax({
			url: button.parent().data('action'),
			type: 'post',
			data: {newsletter_email:$('#email_newsletter').val(), newsletter_gender: gender},
			dataType: 'json',
			beforeSend: function() {
				button.parent().html('loading');
			},
			success: function(data) {   
				if(data.error) {
					$('#sticky .voucher .right').append('<p class="newsletter_error">'+data.error+'</p>');
					$('#sticky .voucher .btn-group').html(btngroup);										
				} else {
					$('#sticky .voucher .left').html('<p>Terimakasih telah berlangganan</p>');
					$('#sticky .minimize i').removeClass('fa-minus');
					$('#sticky .minimize i').addClass('fa-times');
					$('#sticky .voucher .right').remove();					
				}                        								
			},
			statusCode: {
				404: function() {
					alert( "page not found" );
				}
			}
		});
	});

	$(document).on('click', '#sticky .voucher .minimize i.fa-times', function(){
		$(this).parents('.voucher').remove();
	});
	/* ----- */
		
	// Currency
	$('#currency .currency-select').on('click', function(e) {
		e.preventDefault();

		$('#currency input[name=\'code\']').attr('value', $(this).attr('name'));

		$('#currency').submit();
	});

	// Language
	$('#language a').on('click', function(e) {
		e.preventDefault();

		$('#language input[name=\'code\']').attr('value', $(this).attr('href'));

		$('#language').submit();
	});

	/* Search */
	$('#search input[name=\'search\']').parent().find('button').on('click', function() {
		url = $('base').attr('href') + 'index.php?route=product/search';

		var value = $('header input[name=\'search\']').val();

		if (value) {
			url += '&search=' + encodeURIComponent(value);
		}

		location = url;
	});

	$('#search input[name=\'search\']').on('keydown', function(e) {
		if (e.keyCode == 13) {
			$('header input[name=\'search\']').parent().find('button').trigger('click');
		}
	});

	// Menu
	$('#menu .dropdown-menu').each(function() {
		var menu = $('#menu').offset();
		var dropdown = $(this).parent().offset();

		var i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());

		if (i > 0) {
			$(this).css('margin-left', '-' + (i + 5) + 'px');
		}
	});

	// Product List
	$('#list-view').click(function() {
		$('#content .product-layout > .clearfix').remove();

		$('#content .product-layout').attr('class', 'product-layout product-list col-xs-12');

		localStorage.setItem('display', 'list');
	});

	// Product Grid
	$('#grid-view').click(function() {
		$('#content .product-layout > .clearfix').remove();

		// What a shame bootstrap does not take into account dynamically loaded columns
		cols = $('#column-right, #column-left').length;

		if (cols == 2) {
			$('#content .product-layout').attr('class', 'product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12');
		} else if (cols == 1) {
			$('#content .product-layout').attr('class', 'product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12');
		} else {
			$('#content .product-layout').attr('class', 'product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12');
		}

		 localStorage.setItem('display', 'grid');
	});

	if (localStorage.getItem('display') == 'list') {
		$('#list-view').trigger('click');
	} else {
		$('#grid-view').trigger('click');
	}

	// tooltips on hover
	$('[data-toggle=\'tooltip\']').tooltip({container: 'body'});

	// Makes tooltips work on ajax generated content
	$(document).ajaxStop(function() {
		$('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
	});
});

// Cart add remove functions
var cart = {
	'add': function(product_id, quantity, product_option_id, product_option_value_id) {
		//console.log(product_option_id);
		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1) + '&option['+product_option_id+']=' + product_option_value_id,
			dataType: 'json',
			beforeSend: function() {

				//added by Wian
				$('#cart').css({'text-align' : 'center','width':'auto'});
				$('#cart button').css({
					float: "none",
					display: "inline-block",
				});

				$('#cart > button').animate({							
					padding: "5px",
				},200); 
				//added by Wian
				
				$('#cart > button').button('loading');				
			},
			success: function(json) {
				console.log(json);
				$('.alert, .text-danger').remove();

				$('#cart > button, .cart > button').button('reset');


				//added by Wian
				$('#cart > button, .cart > button').animate({
					padding: '5px 10px'
				},200);
				//added by Wian

				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {					
                    if(json['successCustom']['special'] == '&nbsp;') {
                    	html = '<div class="row addToCartPopUp"><div class="col-xs-12"><img class="img-responsive" src="'+json['successCustom']['image']+'" alt=""><p class="name">'+json['successCustom']['text_item']+'<\/p><p class="price"><span>'+json['successCustom']['price']+'<\/span><\/p><div class="order-subtotal-success"><div class="btn-group">'+json['successCustom']['button_continue']+''+json['successCustom']['button_cart']+'<\/div><\/div><\/div><\/div>';                    	
                    } else {
                    	html = '<div class="row addToCartPopUp"><div class="col-xs-12"><img class="img-responsive" src="'+json['successCustom']['image']+'" alt=""><p class="name">'+json['successCustom']['text_item']+'<\/p><p class="priceOld"><span>'+json['successCustom']['price']+'<\/span><\/p><p class="priceNew">'+json['successCustom']['special']+'<\/p><div class="order-subtotal-success"><div class="btn-group">'+json['successCustom']['button_continue']+''+json['successCustom']['button_cart']+'<\/div><\/div><\/div><\/div>';                    	
                    }
                                                                                                           
                    /*bootbox.dialog({
                      message: html,
                      title: json['successCustom']['message_heading'],                              
                    });*/

					$('#cart-total, .cart-total').html(json['total']);
					
					$('#cart > ul, .cart > ul').load('index.php?route=common/cart/info ul li');

					setColor();
					setItemCart();

					//added by Wian
					$('#cart').addClass('open');
					//added by Wian
				}
			}
		});
	},
	'update': function(key, quantity) {
		$.ajax({
			url: 'index.php?route=checkout/cart/edit',
			type: 'post',
			data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			success: function(json) {
				$('#cart > button').button('reset');

				$('#cart-total, .cart-total').html(json['total']);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout' || getURLVar('route') == 'cart' || getURLVar('route') == 'checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul, .cart > ul').load('index.php?route=common/cart/info ul li');
				}
			}
		});
	},
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			success: function(json) {
				$('#cart > button').button('reset');

				$('#cart-total, .cart-total').html(json['total']);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout' || getURLVar('route') == 'cart' || getURLVar('route') == 'checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul, .cart > ul').load('index.php?route=common/cart/info ul li');
				}

				setColor();
				setItemCart();
			}
		});
	}
}

var voucher = {
	'add': function() {

	},
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				$('#cart-total').html(json['total']);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			}
		});
	}
}

var wishlist = {
	'add': function(product_id) {
		$.ajax({
			url: 'index.php?route=account/wishlist/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();

				if (json['success']) {
					//$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				if (json['info']) {
					//$('#content').parent().before('<div class="alert alert-info"><i class="fa fa-info-circle"></i> ' + json['info'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				html = '<div class="row addToCartPopUp addToWishlist"><div class="col-xs-12"><img class="img-responsive" src="'+json['successCustom']['image']+'" alt=""><p class="name">'+json['successCustom']['text_item']+'<\/p><div class="order-subtotal-success"><div class="btn-group">'+json['successCustom']['button_continue']+''+json['successCustom']['button_wishlist']+'<\/div><\/div><\/div><\/div>';
                                                                                                           
                bootbox.dialog({
                  message: html,
                  title: json['successCustom']['message_heading'],                              
                });

				$('#wishlist-total').html(json['total']);

				//$('html, body').animate({ scrollTop: 0 }, 'slow');
			}
		});
	},
	'remove': function() {

	}
}

var compare = {
	'add': function(product_id) {
		$.ajax({
			url: 'index.php?route=product/compare/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();

				if (json['success']) {
					//$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

					$('#compare-total').html(json['total']);

					//$('html, body').animate({ scrollTop: 0 }, 'slow');

					html = '<div class="row addToCartPopUp"><div class="col-xs-12"><img class="img-responsive" src="'+json['successCustom']['image']+'" alt=""><p class="name">'+json['successCustom']['text_item']+'<\/p><div class="order-subtotal-success"><div class="btn-group">'+json['successCustom']['button_continue']+''+json['successCustom']['button_comparison']+'<\/div><\/div><\/div><\/div>';
                                                                                                           
                    bootbox.dialog({
                      message: html,
                      title: json['successCustom']['message_heading'],                              
                    });
				}
			}
		});
	},
	'remove': function() {

	}
}

/* Agree to Terms */
$(document).delegate('.agree', 'click', function(e) {
	e.preventDefault();

	$('#modal-agree').remove();

	var element = this;

	$.ajax({
		url: $(element).attr('href'),
		type: 'get',
		dataType: 'html',
		success: function(data) {
			html  = '<div id="modal-agree" class="modal">';
			html += '  <div class="modal-dialog">';
			html += '    <div class="modal-content">';
			html += '      <div class="modal-header">';
			html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
			html += '        <h4 class="modal-title">' + $(element).text() + '</h4>';
			html += '      </div>';
			html += '      <div class="modal-body">' + data + '</div>';
			html += '    </div';
			html += '  </div>';
			html += '</div>';

			$('body').append(html);

			$('#modal-agree').modal('show');
		}
	});
});

// Autocomplete */
(function($) {
	$.fn.autocomplete = function(option) {
		return this.each(function() {
			this.timer = null;
			this.items = new Array();
	
			$.extend(this, option);
	
			$(this).attr('autocomplete', 'off');
			
			// Focus
			$(this).on('focus', function() {
				this.request();
			});
			
			// Blur
			$(this).on('blur', function() {
				setTimeout(function(object) {
					object.hide();
				}, 200, this);				
			});
			
			// Keydown
			$(this).on('keydown', function(event) {
				switch(event.keyCode) {
					case 27: // escape
						this.hide();
						break;
					default:
						this.request();
						break;
				}				
			});
			
			// Click
			this.click = function(event) {
				event.preventDefault();
	
				value = $(event.target).parent().attr('data-value');
	
				if (value && this.items[value]) {
					this.select(this.items[value]);
				}
			}
			
			// Show
			this.show = function() {
				var pos = $(this).position();
	
				$(this).siblings('ul.dropdown-menu').css({
					top: pos.top + $(this).outerHeight(),
					left: pos.left
				});
	
				$(this).siblings('ul.dropdown-menu').show();
			}
			
			// Hide
			this.hide = function() {
				$(this).siblings('ul.dropdown-menu').hide();
			}		
			
			// Request
			this.request = function() {
				clearTimeout(this.timer);
		
				this.timer = setTimeout(function(object) {
					object.source($(object).val(), $.proxy(object.response, object));
				}, 200, this);
			}
			
			// Response
			this.response = function(json) {
				html = '';
	
				if (json.length) {
					for (i = 0; i < json.length; i++) {
						this.items[json[i]['value']] = json[i];
					}
	
					for (i = 0; i < json.length; i++) {
						if (!json[i]['category']) {
							html += '<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>';
						}
					}
	
					// Get all the ones with a categories
					var category = new Array();
	
					for (i = 0; i < json.length; i++) {
						if (json[i]['category']) {
							if (!category[json[i]['category']]) {
								category[json[i]['category']] = new Array();
								category[json[i]['category']]['name'] = json[i]['category'];
								category[json[i]['category']]['item'] = new Array();
							}
	
							category[json[i]['category']]['item'].push(json[i]);
						}
					}
	
					for (i in category) {
						html += '<li class="dropdown-header">' + category[i]['name'] + '</li>';
	
						for (j = 0; j < category[i]['item'].length; j++) {
							html += '<li data-value="' + category[i]['item'][j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + category[i]['item'][j]['label'] + '</a></li>';
						}
					}
				}
	
				if (html) {
					this.show();
				} else {
					this.hide();
				}
	
				$(this).siblings('ul.dropdown-menu').html(html);
			}
			
			$(this).after('<ul class="dropdown-menu"></ul>');
			$(this).siblings('ul.dropdown-menu').delegate('a', 'click', $.proxy(this.click, this));	
			
		});
	}
})(window.jQuery);