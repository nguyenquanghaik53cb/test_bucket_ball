class VisitorObserver
  constructor:( @socket, {@user,@pass})->
    @collection = {}
    @socket.on "connect",@connect
    
  connect: ()=>
    @socket.emit "auth",
      user:@user
      password:"password"
    ,(rep)=>
      console.log "auth",rep
      if rep
        @socket.emit "getUsersList","test",(rep)-> console.log "r",rep
    console.log "connect"
    @socket.on "forceDisconnect", (req)=> @socket.disconnect()
    @socket.on "_userList", @user_list
    @socket.on "_open url",  @open_url
    @socket.on "_close url", @close_url
    @socket.on "get_message", @get_message
    @socket.on "change_status", @change_status
    @socket.on "change_page_interest", @change_page_interest
    @socket.on "add_interest_page", @add_interest_page
    @socket.on "chat_log", @chat_log
    @socket.on "get_user_info", @requert_user_infomation
    @socket.emit "echo", "message_testtt", (req)-> console.log req

  user_list:(req)=>
    console.log req
    for u in req.sids
      @open_url u

  open_url:(req)=>
    console.log req
    unless @collection[req.uuid]
      @collection[req.uuid] = new Visitor @socket,req
    @collection[req.uuid].open_url req

  close_url:(req)=>
    @collection[req.uuid] = null unless @collection[req.uuid]?.close_url? req

  get_message:(req)=>
    console.log "get_message",req
    @collection[req.uuid].get_message req

  change_status:(req)=>
    console.log "change_status",req
    @collection[req.uuid].change_status req

  change_page_interest:(req)=>
    console.log "change_page_interest",req
    @collection[req.uuid].change_page_interest req

  add_interest_page:(req)=>
    console.log "add_interest_page event", req  
    @collection[req.uuid].add_interest_page req

  chat_log:(req)=>
    @collection[req.uuid].chat_log(req)

  dns_reverse_lookup:(req)=>
    console.log "dns_reverse_lookup", req
    @collection[req.uuid].dns_reverse_lookup req

  requert_user_infomation:(req)=>
    console.log "requert_user_infomation", req
    @collection[req.uuid].requert_user_infomation req

class Visitor
  constructor:( @socket, {@uuid,@url,@visitFrequency,@time,sid})->
    # Add new Visitor Tab\
    @phase = "phase01"
    @sids = []
    @sids[sid] = new Sid _arg
    short_url = @url.replace(/(http:\/\/|https:\/\/)([a-zA-Z0-9.])+/, "")
    $(".users").append template.left_user_box(@nickname, @uuid, short_url, @visitFrequency, @phase)
    $("#user_left_#{@uuid}").click @tab_open
    @interval = setInterval ()=>
      t = Date.now() - @time
      h = Math.floor(t / (1000 * 60 * 60))
      m = Math.floor((t - h * 3600000) / (1000 * 60))
      if h > 0
        str = "#{h}時間#{m}分"
      else
        str = "#{m}分"
      $("#user_left_#{@uuid} .time").text(str)
    ,60000
    $("#user_left_#{@uuid} .lock").click ()=>
      socket.emit "lock"
        uuid: @uuid
      , (rep)=>
        if rep
          console.log "it locked"
          $("#user_left_#{@uuid} .lock").hide()
          $("#user_left_#{@uuid} .unlock").show()          
          #do something
        else
          console.log "somebody have key"
          #do something

    $("#user_left_#{@uuid} .unlock").click ()=>
      socket.emit "unlock", uuid: @uuid, (rep)=>
        if rep
          console.log "it unlocked"
          $("#user_left_#{@uuid} .lock").show()
          $("#user_left_#{@uuid} .unlock").hide()          
          #do something
        else
          console.log "you don't have key"
          #do something

    $("#user_left_#{@uuid} .name").click ()=>
      socket.emit "name_change" 
        uuid: @uuid
        name: $("#user_left_#{@uuid} .name").val()


  # Event handers form Socket
  open_url:( data )=>
    @open_tab ||= 0
    @open_tab++
    data.short_url = @url.replace(/(http:\/\/|https:\/\/)([a-zA-Z0-9.])+/, "")
    $("#user_right_#{@uuid} .now_url1").text ""
    $("#user_right_#{@uuid} .now_url1").append "<a href='#{data.url}' target='_blank'>#{data.short_url}</a>"
    $("#user_right_#{@uuid} .view_history").append template.view_history(data)

  close_url:( data )=>
    @open_tab--
    if @open_tab <= 0
      $("#user_left_#{@uuid}").remove()
      clearInterval @interval
      return false
    else
      return true

  get_message:(req)=>
    $("#user_middle_#{req.uuid} > .message_histories").append template.message_histories_user(req, @phase) 
 
  # Event handers form UI
  tab_open:()=>
    unless $("#user_middle_#{@uuid}").length != 0
      $(".chatbox").append template.middle_user_box @uuid 
      $(".thirdbox").append template.right_user_box @uuid, @url, @phase
      $(".open p").click @open_histoies
      $("#user_middle_#{@uuid} > .postbox > .textbox > .btn").click @send_message
      $("#user_middle_#{@uuid} > .postbox > .textbox > .message_box").keydown (e) =>
        if e.keyCode is 13 #enter key
          @send_message()
          $("#user_middle_#{@uuid} > .postbox > .textbox > .btn").click
          false
      @socket.emit "request_chat_log",
        uuid:@uuid
      @socket.emit "requert_user_infomation",
        uuid:@uuid
      $("#user_middle_#{@uuid}").click ()=> 
        $(".thirdbox .right_box").hide()
        $("#user_right_#{@uuid}").show()
    @is_active = true
    $(".thirdbox .right_box").hide()
    $("#user_right_#{@uuid}").show()
    $("#user_middle_#{@uuid} > .btn_close").click @tab_close
    $(".open .past").click ()->
      $(this).parents(".inner").find(".case").show() 
      $(this).parents(".open").remove()
    document.getElementById("user_middle_#{@uuid}").scrollIntoView()
    $("#user_right_#{@uuid} .memo_submit").click ()=>
      socket.emit "memo_submit"
        uuid: @uuid
        memo: $("#user_right_#{@uuid} .memobox").val()

  tab_close:()=>
    $("#user_middle_#{@uuid}").remove()
    $("#user_right_#{@uuid}").remove()
    @is_active = false
  
  chat_log:(req)=>
    console.log req
    for log in req.logs
      log = JSON.parse(log)
      if log.speaker
        $("#user_middle_#{@uuid} > .message_histories").append template.message_histories( log.message, log.time, "hide")
      else
        $("#user_middle_#{@uuid} > .message_histories").append template.message_histories_user( uuid:req.uuid, message:log.message, time:log.time, "hide", @phase) 
    a = $("#user_middle_#{@uuid} .case")
    a = a.toArray()
    if a.length < 6
      $("#user_middle_#{@uuid} .open").remove()       
    for i in [0..4]
      $(a.pop())?.show()

  requert_user_infomation:(req)=>
    console.log req

  activate:()=>
    $(".right_box").hidden()
    $("#user_right_#{uuid}").show()

  send_message:(e)=> 
    message = $("#user_middle_#{@uuid} > .postbox > .textbox > .message_box").val()
    $("#user_middle_#{@uuid} > .message_histories").append template.message_histories( message, "" , @phase)
    @socket.emit "sendMessage",
      message:message
      uuid:@uuid
      speaker: "operator"
    $("#user_middle_#{@uuid} > .postbox > .textbox > .message_box").val("")

  open_histoies :()=>

  close_histoies:()=>

  change_status:(req)=>
    console.log req
    $("#user_middle_#{req.uuid} .user_chat_box").removeClass("phase01 phase02 phase03")
    $("#user_left_#{req.uuid}").removeClass("phase01 phase02 phase03")
    $("#dashboard_#{req.uuid} .upper_imgbox:last").removeClass("phase01 phase02 phase03") 
    if req.status == "search"
      @phase = "phase01"
    else if req.status == "select"
      @phase = "phase02"
    else if req.status == "hesitate"
      @phase = "phase03"
    console.log "@phase = " + @phase
    $("#user_middle_#{req.uuid} .user_chat_box").addClass(@phase)
    $("#user_left_#{req.uuid}").addClass(@phase)
    $("#dashboard_#{req.uuid} .upper_imgbox:last").addClass(@phase)

  change_page_interest:(req)=>
    if req.status >= 3 and $("##{req.uuid}_#{req.sid}").length < 1
      $("#user_right_#{req.uuid} .acv_url").append template.add_interest(req)
      if $("#user_right_#{req.uuid} .timeline .timeline_lower img").size() == 0
        $("#user_right_#{req.uuid} .timeline .timeline_lower").text ""
        $("#user_right_#{req.uuid} .timeline .timeline_lower").append template.add_thumbnail_in_dashboard(req)
      else 
        $("#user_right_#{req.uuid} .timeline .timeline_lower").append template.add_thumbnail_in_dashboard(req) 
        $("#user_right_#{req.uuid} .timeline .timeline_upper").append '<td class="upper_imgbox"><br></td>'  

  add_interest_page:(req)=>
    console.log req
    $("#user_right_#{req.uuid} .acv_url").append template.add_interest(req) 
    if $("#user_right_#{req.uuid} .timeline .timeline_lower img").size() == 0 
      $("#user_right_#{req.uuid} .timeline .timeline_lower").text "" 
      $("#user_right_#{req.uuid} .timeline .timeline_lower").append template.add_thumbnail_in_dashboard(req) 
    else 
      $("#user_right_#{req.uuid} .timeline .timeline_lower").append template.add_thumbnail_in_dashboard(req) 
      $("#user_right_#{req.uuid} .timeline .timeline_upper").append '<td class="upper_imgbox"><br></td>' 

  dns_reverse_lookup:(req)=>
    console.log req


class Sid
  constructor:( {@uuid,@sid,@url,@publisher_id,@time} )->


start = ({server,port,user,pass})->
  console.log "try to connect //#{server}:#{port}"
  socket = io.connect("//#{server}:#{port}")
  observer = new VisitorObserver socket,{user,pass}
  
@start = start
{@Visitor,@VisitorObserver} = {Visitor,VisitorObserver}
