
	  jQuery(document).ready(function($) {
  		jQuery("body").prepend('\
	  		<div id="element-example-tooltip" style="width:280px; background-color:#999999; margin-right:auto; z-index: 10000; font-size: 10px; position: fixed;">\
				(戻る用)今見ていたページへの興味を入れて下さい。\
				<form class="my-form-2" method="GET" action="http://gunma.hajimek.com:10005/add_phases/show2">\
				<input type="hidden" class="my-form-uuid" name="uuid" value="">\
				<input type="hidden" class="my-form-url" name="url" value="">\
				<input type="hidden" class="my-form-sid" name="sid" value="">\
				<table border="1">\
				<tr>\
				<td><input type="radio" name="eval" value="4" class="radio3">良い！◎　空室かどうか気になる  </input></td>\
				<td><input type="radio" name="eval" value="3" class="radio3">なんかいいかも〜  </input></td>\
				</tr>\
				<tr>\
				<td><input type="radio" name="eval" value="2" class="radio3">なんとなくやだ〜  </input></td>\
                                <td><input type="radio" name="eval" value="1" class="radio3">絶対やだ！×　ゆずれない嫌なポイントがある（風呂/トイレ別とか） </input></td>\
				<input type="hidden" class="my-form-url3" name="url2" value="">\
				</tr>\
				</table>\
				<input type="radio" name="eval" value="0" class="radio3">どちらでもない  </input>\
				</form>\
			</div>\
  		')

	  	var url2
	  	jQuery("a").mouseover(function(){
 			url2 = jQuery(this).get(0).href;
 		});

 		var url3
 		url3=document.referrer;
 		jQuery(".my-form-url3").val(url3);

 		$("body").append('<%= stylesheet_link_tag "http://f1.hajimek.com/assets/tipped.css" %>')

	  	var i=0;
/*	  	
	  	jQuery("a").each(function() {
	  		jQuery("body").append(
'		  		<div id="element-example-tooltip-' + i + '" style="display:none">'+
'					今見ていたページへの興味を入れて下さい。'+
'					<form class="my-form" id="my-form' + i + '" method="GET" action="http://gunma.hajimek.com:10005/add_phases/show2">'+
'					<table border="1">'+
'					<tr>'+
'					<input type="hidden" class="my-form-uuid" name="uuid" value="">'+
'					<input type="hidden" class="my-form-url" name="url" value="">'+
'					<input type="hidden" class="my-form-sid" name="sid" value="">'+
'					<td><input type="radio" name="eval" value="4" class="radio1">良い！◎　空室かどうか気になる  </input></td>'+
'					<td><input type="radio" name="eval" value="3" class="radio1">なんかいいかも〜  </input></td>'+
'					</tr>'+
'					<tr>'+
'	                                <td><input type="radio" name="eval" value="2" class="radio3">なんとなくやだ〜  </input></td>'+
'	                                <td><input type="radio" name="eval" value="1" class="radio3">絶対やだ！×　ゆずれない嫌なポイントがある（風呂/トイレ別とか） </input></td>'+
'					</tr>'+
'					<input type="hidden" class="my-form-url2" name="url2" value="">'+
'					</table>'+
'					<input type="radio" name="eval" value="0" class="radio3">どちらでもない  </input>'+
'					</form>'+
'				</div>')

	  		jQuery(this).addClass('element-example-' + i);

      			Tipped.create('.element-example-' + i, jQuery('#element-example-tooltip-' + i)[0],{
      				hook: 'bottommiddle'
      			}
      		);
 			i = i + 1;
    	});
*/
  		jQuery(".radio1").click(function(){
			if (jQuery.cookie('znclrksid')) {
	 	        	jQuery(".my-form-sid").val(jQuery.cookie('znclrksid'));
		        	jQuery(".my-form-uuid").val(jQuery.cookie('znclrk'));
		        	jQuery(".my-form-url").val(window.location);
		        	jQuery(".my-form-url2").val(url2);
				console.log(jQuery(this).parents("form"));
		       		jQuery(this).parents("form").submit();
			}else{
				confirm("大当たり。音田090-5697-8198もしくは桑山090-6921-4275まで一度お電話ください。"); 
			}
  		});

  		
  		jQuery(".radio3").click(function(){
			if (jQuery.cookie('znclrksid')) {
	 	        	jQuery(".my-form-sid").val(jQuery.cookie('znclrksid'));
		        	jQuery(".my-form-uuid").val(jQuery.cookie('znclrk'));
		        	jQuery(".my-form-url").val(window.location);
		       		jQuery(".my-form-2").submit();
			}else{
				confirm("大当たり。音田090-5697-8198もしくは桑山090-6921-4275まで一度お電話ください。");
			}
  		});
	  });


