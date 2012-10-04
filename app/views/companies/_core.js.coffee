
window.console ||= {}
window.console.log ||= ()->

jQuery.ajaxSetup cache: true
jQuery.getScript("//#{server_url}/socket.io/socket.io.js")
.done (script, textStatus) =>
  socket = io.connect "//#{server_url}/#{apikey}"

  sendFreq = 50 
  lastSendTime = Date.now()
  lastStatus   = null
  messagelog = false
  
  socket.on 'connect', (req)->
    uuid = jQuery.cookie uuidkey
    usid = jQuery.cookie usidkey
    socket.emit 'init',
      'apikey'    : apikey
      'uuid'      : uuid
      'usid'      : usid
      'referrer'  : document.referrer
      'userAgent' : navigator.userAgent
      'thumbnail' : thumbnail_collector()
      'content'   : content_analyzer()
    ,(req)->
      d = new Date
      d.setTime Date.now() + 31536000000 # 1year
      jQuery.cookie uuidkey,req.uuid,expires: d,path: '/'
      d.setTime Date.now() + 600000 #10min
      jQuery.cookie usidkey,req.usid,expires: d,path: '/'
      jQuery.cookie uuidkey + "sid",req.sid
      console.log "init setcookie #{uuidkey}=#{req.uuid}"
      console.log "init setcookie #{usidkey}=#{req.usid}"
      messagelog = req.messagelog
      psocket.uuid = req.uuid
      
      socket.on "forceDisconnect", ()-> socket.disconnect()
      socket.on "echo", (req)-> console.log req

      if (jQuery.cookie usidkey) == null or (jQuery.cookie uuidkey + "sid") == null
        socket.emit "error_log", 

      h = jQuery(document)
      lastStatus  =
        mouse:
          screenX: 0
          screenY: 0
          clientX: 0
          clientY: 0
        scroll:
          X: 0
          Y: h.scrollTop()
        time: Date.now()
      
      return if untrack()
      h.click     (e)=> logging(e,click:true)
      h.mousemove (e)=> logging(e,{})
      h.scroll    (e)=> logging(e,{})

      strUA = navigator.userAgent.toLowerCase()
      mobile = strUA.match /mobile/
      ie6 = strUA.match /msie 6.0/
      if mobile == null and ie6 == null
        plugin(psocket)
        particular_event(psocket)
        afk_interval = setInterval checkAFK,1000
        window.psocket = psocket


  
  logging = (e,name)->
    t = Date.now()
    return null unless name.click ||  (t - lastSendTime) > sendFreq 
    h = jQuery(document)
    name.scroll = true if h.scrollTop() != lastStatus.scroll.Y
    name.mouse  = true if e.clientX != lastStatus.mouse.clientX or e.clientY != lastStatus.mouse.clientY
    
    log = 
      mouse:
        screenX: e.pageX
        screenY: e.pageY
        clientX: e.clientX
        clientY: e.clientY
      scroll:
        X: h.scrollLeft()
        Y: h.scrollTop()
        dX: h.scrollLeft() - lastStatus.scroll.X
        dY: h.scrollTop()  - lastStatus.scroll.Y
      window:
        Height: jQuery(window).height()
        Width : jQuery(window).width()
      time: t
      event: name
      height:jQuery(document).height()
    
    socket.emit "user_behavior",log
    lastStatus = log
    lastSendTime = t
    null

  psocket = {}
  psocket.event_receiver = {}
  psocket.init = (ev,fn)->
    @event_receiver[ev] = fn
    @_init()
  
  psocket._init = ()->
    for er,name of @event_receiver
      er()
  
  psocket.on   = ( event, fn ) ->
    socket.on event, fn
  
  psocket.emit = ( event, val) ->
    val.uuid  = psocket.uuid
    val.time ||= Date.now()
    val.apikey = apikey
    socket.emit event, val
  
  afk_interval = null
  afktime = 15000
  checkAFK = ()->
    if Date.now() - lastSendTime > afktime
#      console.log "AFK"
      clearInterval afk_interval
      afk_interval = setInterval checkNAFK,1000
  checkNAFK = ()->
    if Date.now() - lastSendTime < afktime
#      console.log "... and back"
      clearInterval afk_interval
      afk_interval = setInterval checkAFK,1000
  

  

.fail ()-> console.log "load err"
