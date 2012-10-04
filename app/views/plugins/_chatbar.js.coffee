
$("body").append """<%= javascript_include_tag "http://f1.hajimek.com/assets/bootstrap.js" %>"""
$("body").append """<%= stylesheet_link_tag "http://f1.hajimek.com/assets/bootstrap.css" %>"""
$("body").append """<%= stylesheet_link_tag "http://f1.hajimek.com/assets/common.css" %>""" 
$("body").append """<%= stylesheet_link_tag "http://f1.hajimek.com/assets/tinycarousel.css" %>"""
$("body").append """<%= javascript_include_tag "http://f1.hajimek.com/assets/tinycarousel.js" %>"""

$("body").append """
<div id="zenclerk_helpbox">
  <div class="inbox cf">
    <div class="titlebar cf">
      <div class="selecttitle">
        <p class="title">
          ---"Remember and Compare your favorite items!!"---
        </p>
        <div class="btn btn-mini push push_item" href="#"><i class="icon-plus-sign"></i> Add</div>
      </div>
      <div class="operatortitle">
        <p class="title">
          Operator
        </p>
      </div>
      <div class="chattitle">
        <p class="title">
          Chat Box
        </p>
        <p class="push put" id="peronyan_open_close">
          <a class="btn btn-mini" href="#"><i class="icon-chevron-up"></i></a>
        </p>
      </div>
    </div>
    <div class="closebox">
      <div class="selectbox">
        <div class="itembox cf">
          <div id="slider">
            <a href="#" class="buttons prev element-example-351" style="margin-left: 45px;">left</a>
            <div class="viewport">
              <ul class="overview">
              </ul>
            </div>
            <a href="#" class="buttons next element-example-358 disable" style="margin-right: 45px;">right</a>
          </div>

        </div>
      </div>
      <div class="operatorbox">
        <div class="introbox cf">
          <img src="http://f1.hajimek.com/assets/operator_ui.png">
          <p>
           【ZenClerkショップ】桑田です<br>
           何か分からないことがあれば、 <br>お気軽にご質問ください!!☆
         </p>
        </div>
      </div>

      <div class="chatbox">
        <div class="stream boxshadow_text">
          <div class="stream_inner"></div>
          <div id="stream_bottom">&nbsp;</div>
        </div>
        <div class="textarea">
          <input type="text" class="span3 chat_text boxshadow_text"></input>
          <!--<input type="submit" id="peronyan_submit" value="Submit" />-->
          <div id="savebutton" class="btn btn-mini"><i class="icon-comment"></i>Send</div>
        </div>
      </div>
    </div>
  </div>
</div>
"""

obj = JSON.parse(localStorage.getItem("zenclerk_chatlog"))
if obj?
  i = 0
  while i < obj.length
    DD = new Date(obj[i]["time"])
    HH = DD.getHours()
    MM = DD.getMinutes()
    MM = "0" + MM  if MM < 10
    $(".stream_inner").append "<p>" + HH + ":" + MM + " <b>" + obj[i]["name"] + ":</b> " + obj[i]["message"] + "</p>"
    ++i
obj2 = JSON.parse(localStorage.getItem("zenclerk_itemlog"))
if obj2?
  i = 0
  while i < obj2.length
    str = obj2[i]["str"]
    $("#zenclerk_helpbox .overview").append(str);
    ++i
$("#zenclerk_helpbox .closebox").hide()
$("#zenclerk_helpbox #peronyan_open_close").click ->
  if $(".closebox").css("display") is "none"
    $("#zenclerk_helpbox .closebox").show "Bounce", "", 100, ""
    $("#zenclerk_helpbox #peronyan_open_close i").attr("class", "icon-chevron-down")
    $('#slider').tinycarousel({ display: 1, duration: 300 }); 
    false
  else
    $("#zenclerk_helpbox .closebox").hide "Bounce", "", 100, ""
    $("#zenclerk_helpbox #peronyan_open_close i").attr("class", "icon-chevron-up")
    false
$("#zenclerk_helpbox .span3").keydown (e) =>
  if e.keyCode is 13 #enter key
    send_message()
    false
$("#zenclerk_helpbox .zenclerk_btn_close").click ->
  $(this).parent(".item").remove()
  $('#slider').tinycarousel({ display: 1, duration: 300 });
  obj3 = JSON.parse(localStorage.getItem("zenclerk_itemlog"))
  if obj3?
    i = 0
    while i < obj3.length
      if obj3[i]["url"] == $(this).parent(".item").children("a").attr("href")
        obj3.splice i, 1
      ++i
    localStorage.setItem "zenclerk_itemlog", JSON.stringify(obj3)
a = -> $(this).children(".zenclerk_btn_close").html('<i class="icon-remove-sign"></i>')
b = -> $(this).children(".zenclerk_btn_close").html('<i class="icon-remove-circle"></i>')
$("#zenclerk_helpbox .item").hover a,b
$("#zenclerk_helpbox .closebox").hide()

$("#zenclerk_helpbox .push_item").click ->
  if window.location.hostname == "www.amazon.co.jp"
    price = $("#actualPriceValue .priceLarge").text()
    price = price.replace("￥ ", "") 
    pic_path = $("#prodImage").attr("src")
    count_item = $("#zenclerk_helpbox .item").size() + 1
    url = document.URL
  else if window.location.hostname == "www.beauty-box.jp"
    price = $("#main .element-example-24").text() + " " + $("#main .element-example-23").text()
    price = price.substring(0, 7)
    pic_path = $("#main .attachment-375x500").attr("src")
    count_item = $("#zenclerk_helpbox .item").size() + 1
    url = document.URL
  else
    price = null
    pic_path = null
    count_item = $("#zenclerk_helpbox .item").size() + 1
    url = document.URL
  str = """
  <li id="item#{count_item}" class="item">
    <p class="zenclerk_btn_close"><i class="icon-remove-circle"></i> </p>
    <a href="#{url}">
      <img src="#{pic_path}" />
     <p id="price#{count_item}" class="price"> #{price} 円 </p>
    </a>
  </li>
  """
  $("#zenclerk_helpbox .overview").append(str)
  $('#slider').tinycarousel({ start: count_item + 1, display: 1 , duration: 300});
  $("#item#{count_item} .zenclerk_btn_close").click ->
    $(this).parent(".item").remove()
  $("#item#{count_item}").hover ->
    $(this).children(".zenclerk_btn_close").html('<i class="icon-remove-sign"></i>')
  ,->
    $(this).children(".zenclerk_btn_close").html('<i class="icon-remove-circle"></i>')
  obj = JSON.parse(localStorage.getItem("zenclerk_itemlog"))
  obj = []  unless obj?
  obj.push
    url: url
    pic_path: pic_path
    price: price
    str: str
  localStorage.setItem "zenclerk_itemlog", JSON.stringify(obj)
  socket.emit "add_interest_page",
    url: url
    price: price
    gazou_link: pic_path

send_message = ()->
  socket.emit "send_chat_message"
    message: jQuery("#zenclerk_helpbox .span3").val()
  DD = new Date()
  HH = DD.getHours()
  MM = DD.getMinutes()
  MM = "0" + MM  if MM < 10
  jQuery(".stream_inner").append "<p>" + HH + ":" + MM + " <b>User:</b> " + jQuery(".span3").val() + "</p>"
  obj = JSON.parse(localStorage.getItem("zenclerk_chatlog"))
  obj = []  unless obj?
  obj.push
    name: "User"
    time: Date.now()
    message: jQuery("#zenclerk_helpbox .span3").val()
  localStorage.setItem "zenclerk_chatlog", JSON.stringify(obj)
  jQuery(".span3").val ""
  document.getElementById("stream_bottom").scrollIntoView()

jQuery("#savebutton").click send_message

socket.on "message", (msg) ->
  DD = new Date()
  HH = DD.getHours()
  MM = DD.getMinutes()
  MM = "0" + MM  if MM < 10
  jQuery(".stream_inner").append "<p>#{HH}:#{MM} <b>Operator: </b>#{msg}</p>"
  $("#zenclerk_helpbox .closebox").show "Bounce", "", 100, ""
  $("#zenclerk_helpbox .inbox .titlebar .chattitle .put a").text "Close"
  obj = JSON.parse(localStorage.getItem("zenclerk_chatlog"))
  obj = []  unless obj?
  obj.push
    name: "Operator"
    time: Date.now()
    message: msg
  localStorage.setItem "zenclerk_chatlog", JSON.stringify(obj)
  document.getElementById("stream_bottom").scrollIntoView()

socket.on "change_page_interest", (req) ->
  console.log req
