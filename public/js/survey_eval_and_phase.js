
	  jQuery(document).ready(function($) {


  		jQuery("body").prepend('\
	  		<div id="element-example-tooltip" style="width:250px; background-color:#999999; margin-right:auto; z-index: 10000; font-size: 10px; position: fixed;">\
				Please choose your interest level for this page.\
				<form class="my-form-2" method="GET" action="http://gunma.hajimek.com:10005/add_phases/show2">\
				<input type="hidden" class="my-form-uuid" name="uuid" value="">\
				<input type="hidden" class="my-form-url" name="url" value="">\
				<input type="hidden" class="my-form-sid" name="sid" value="">\
				<input type="radio" name="eval" value="5" class="radio3">5   \
				<input type="radio" name="eval" value="4" class="radio3">4   \
				<input type="radio" name="eval" value="3" class="radio3">3   \
				<input type="radio" name="eval" value="2" class="radio3">2   \
				<input type="radio" name="eval" value="1" class="radio3">1   <br/>\
				<input type="radio" name="phase" value="1" class="radio4">search \
				<input type="radio" name="phase" value="2" class="radio4">select \
				<input type="radio" name="phase" value="3" class="radio4">hesitate \
				<input type="hidden" class="my-form-url3" name="url2" value="">\
				</form>\
			</div>\
  		')

	  	var url2
	  	//jQuery("a").addClass("element-example");
	  	jQuery("a").mouseover(function(){
 			url2 = jQuery(this).get(0).href;

 		});

 		var url3
 		url3=document.referrer;
 		jQuery(".my-form-url3").val(url3);
 		//alert(jQuery(document).referrer);

		jQuery("head").prepend('<link rel="stylesheet" type="text/css" href="http://o1.zenclerk.com/assets/tipped/css/tipped.css"/>')

		/*
	  	jQuery("body:last").append('\
	  		<div id="element-example-tooltip" style="display:none">\
				Please choose your interest level for this page.\
				<form class="my-form" method="GET" action="http://localhost:3000/surveys/show2">\
				<input type="hidden" class="my-form-uuid" name="uuid" value="">\
				<input type="hidden" class="my-form-url" name="url" value="">\
				<label><input type="radio" name="eval" value="5">5</label>\
				<label><input type="radio" name="eval" value="4">4</label>\
				<label><input type="radio" name="eval" value="3">3</label>\
				<label><input type="radio" name="eval" value="2">2</label>\
				<label><input type="radio" name="eval" value="1">1</label>\
				<input type="submit" value="submit" class="submit">\
				</form>\
			</div>\
	  	')
		Tipped.create('.element-example', jQuery('#element-example-tooltip')[0]);
		*/

	  	var i=0;
	  	
	  	jQuery("a").each(function() {

	  		//1. divを作る

	  		jQuery("body").append('\
		  		<div id="element-example-tooltip-' + i + '" style="display:none">\
					Please choose your interest level for this page.\
					<form class="my-form" method="GET" action="http://gunma.hajimek.com:10005/add_phases/show2">\
					<input type="hidden" class="my-form-uuid" name="uuid" value="">\
					<input type="hidden" class="my-form-url" name="url" value="">\
					<input type="hidden" class="my-form-sid" name="sid" value="">\
					<input type="radio" name="eval" value="5" class="radio1">5   \
					<input type="radio" name="eval" value="4" class="radio1">4   \
					<input type="radio" name="eval" value="3" class="radio1">3   \
					<input type="radio" name="eval" value="2" class="radio1">2   \
					<input type="radio" name="eval" value="1" class="radio1">1   <br />\
					<input type="radio" name="phase" value="1" class="radio2">search \
					<input type="radio" name="phase" value="2" class="radio2">select \
					<input type="radio" name="phase" value="3" class="radio2">hesitate \
					<input type="hidden" class="my-form-url2" name="url2" value="">\
					</form>\
				</div>\
	  		')
	  		//<input type="submit" value="submit" class="submit">\
					

	  		//2. tagをaddする
	  		jQuery(this).addClass('element-example-' + i);
	  		//jQuery("a").addClass('element-example-' + i);

	  		//3. tag名を作る
      		Tipped.create('.element-example-' + i, jQuery('#element-example-tooltip-' + i)[0],{
      				hook: 'bottommiddle'
      			}
      		);
      		//console.log('.element-example-' + i, jQuery('#element-example-tooltip-' + i)[0]);

	  		//4. i=i+1
 			i = i + 1;
 			//console.log(i);
    	});

		var radio1_flag = 0;
  		var radio2_flag = 0;
  		var radio3_flag = 0;
  		var radio4_flag = 0;

  		jQuery(".radio1").click(function(){
  			//alert('click');
  			radio1_flag = 1;

  			if (radio2_flag === 1){
	 	        jQuery(".my-form-sid").val(jQuery.cookie('znclrksid'));
		        jQuery(".my-form-uuid").val(jQuery.cookie('znclrk'));
		        jQuery(".my-form-url").val(window.location);
		        jQuery(".my-form-url2").val(url2);
		       	jQuery(".my-form").submit();
		    }
  		});

  		
  		jQuery(".radio2").click(function(){
  			//alert('click');
  			radio2_flag = 1

  			if (radio1_flag === 1) {
	 	        jQuery(".my-form-sid").val(jQuery.cookie('znclrksid'));
		        jQuery(".my-form-uuid").val(jQuery.cookie('znclrk'));
		        jQuery(".my-form-url").val(window.location);
		        jQuery(".my-form-url2").val(url2);
		       	jQuery(".my-form").submit();
		    }
  		});

  		
  		jQuery(".radio3").click(function(){
  			//alert('click');
  			radio3_flag = 1

  			if (radio4_flag === 1) {
	 	        jQuery(".my-form-sid").val(jQuery.cookie('znclrksid'));
		        jQuery(".my-form-uuid").val(jQuery.cookie('znclrk'));
		        jQuery(".my-form-url").val(window.location);
		       	jQuery(".my-form-2").submit();
		    }
  		});

  		
  		jQuery(".radio4").click(function(){
  			//alert('click');
  			radio4_flag = 1

  			if (radio3_flag === 1) {
	 	        jQuery(".my-form-sid").val(jQuery.cookie('znclrksid'));
		        jQuery(".my-form-uuid").val(jQuery.cookie('znclrk'));
		        jQuery(".my-form-url").val(window.location);
		       	jQuery(".my-form-2").submit();
		    }
  		});



	    //jQuery(".submit").click(function(){

	        //uuidをget:
	        //alert(jQuery.cookie('s_ria'));
	        //URLをゲット
	        //alert(window.location);
	        //formの値をゲット
	        //alert($('.my-form [name=eval]:checked').val());
	        //jQuery(".my-form-sid").val(jQuery.cookie('znclrksid'));
	        //jQuery(".my-form-uuid").val(jQuery.cookie('znclrk'));
	        //jQuery(".my-form-url").val(window.location);
	       	//jQuery(".my-form-url2").val(url2);
	    //});

	  });


