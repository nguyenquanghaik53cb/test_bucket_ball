template = {}
template.left_user_box = (nickname,uuid,url,visitFrequency,phase)->
  nickname = uuid.slice(-2)
  nickname = nickname.replace(/1/g, "か")
  nickname = nickname.replace(/2/g, "な")
  nickname = nickname.replace(/3/g, "え")
  nickname = nickname.replace(/4/g, "り")
  nickname = nickname.replace(/5/g, "ね")
  nickname = nickname.replace(/6/g, "さ")
  nickname = nickname.replace(/7/g, "き")
  nickname = nickname.replace(/8/g, "こ")
  nickname = nickname.replace(/9/g, "み")
  nickname = nickname.replace(/0/g, "ほ")
  return """
  <div class="case #{phase}" id="user_left_#{uuid}">
    <div class='name_hd cf'>
      <p class='name'>#{nickname}<span class="name_title">さん</span></p>
      <p class='url'>#{url}</p>
    </div>
    <p class='visit'>#{visitFrequency}回</p>
    <p class='time'>1分未満</p>
    <button class='lock'>ロック</button>
    <button class='unlock'>アンロック</button>

  </div>
  """

template.middle_user_box = (uuid)->
  return """
  <div class="inner active" id="user_middle_#{uuid}">
    <p class="btn_close"><a href="#">×</a></p>
      <div class="open">
        <p><a href="#" class="past">過去のやり取りをすべて見る</a></p>
      </div>
      <div class="message_histories">
      </div>
      <div class="postbox">
      <p class="phase"><img src="/assets/img_operator.jpg"></p>
      <p>
        <select class="select">
          <option>アクションを選択</option>
          <option>テキスト</option>
        </select>
      </p>
      <p class="textbox">
        <input type="text" class="span3 message_box">　<input type="submit" class="btn" value="トーク">
      </p>
    </div>
  </div>
  """

template.message_histories = (message, logtime, addclas="")->
  if logtime
    DD = new Date(logtime)
  else
    DD = new Date()
  HH = DD.getHours()
  MM = DD.getMinutes() 
  if MM < 10
    MM = "0" + MM
  """  
  <div class="case operator #{addclas}">
    <p class="name">オペレーター <span>#{HH}:#{MM}</span></p>
    <p>#{message}</p>
  </div>
  """

template.message_histories_user = (req, addclas="", phase)->
  if req.time
    DD = new Date(req.time)
  else
    DD = new Date()
  HH = DD.getHours()
  MM = DD.getMinutes() 
  if MM < 10
    MM = "0" + MM
  nickname = req.uuid.slice(-2)
  return """
  <div class="case user_chat_box #{phase} #{addclas}">
    <p class="name">#{nickname}<span class="name_title">さん </span></span> <span>#{HH}:#{MM}</span></p>
    <p>#{req.message}</p>
  </div>
  """

template.add_thumbnail_in_dashboard = (req) ->
  return """
    <td class="lower_imgbox" id="#{req.uuid}_#{req.sid}">
      <a href="#{req.url}" target="_blank">
        <img src="#{req.thumbnail}">
      </a>
    </td>
  """

template.add_face_in_dashboard = (req) ->
  """
  """

template.view_history = (req) ->
  short_url = req.url.replace(/(http:\/\/|https:\/\/)([a-zA-Z0-9.])+/, "")
  DD = new Date()
  HH = DD.getHours()
  MM = DD.getMinutes()  
  if MM < 10
    MM = "0" + MM
  return  """
  <p class="now_url usually">#{HH}:#{MM} <a href="#{req.url}">#{short_url}</a></p>
  """


template.add_interest = (req)->
  short_url=req.url.replace(/(http:\/\/|https:\/\/)([a-zA-Z0-9.])+/, "")
  DD = new Date()
  HH = DD.getHours()
  MM = DD.getMinutes()
  if MM < 10
    MM = "0" + MM
  return  """
    <li class="usually">#{HH}:#{MM} <a href="#{req.url}" target="_blank">#{short_url}</a></li>
  """

template.right_user_box = (uuid, url, phase)->
  short_url=url.replace(/(http:\/\/|https:\/\/)([a-zA-Z0-9.])+/, "")
  DD = new Date()
  HH = DD.getHours()
  MM = DD.getMinutes()
  if MM < 10
    MM = "0" + MM
  return """
  <div class="right_box" id="user_right_#{uuid}">
    <div class="datebox gs">
      <ul class="tabnav nav nav-tabs"  id="myTab_#{uuid}">
        <li><a href="#dashboard_#{uuid}" class="on" data-toggle="tab">ダッシュボード</a></li>
        <li><a href="#behave_history_#{uuid}" data-toggle="tab">行動履歴</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="dashboard_#{uuid}">
          <p class="title">タイムライン</p>
          <div class="imgbox">
            <table class="timeline">
              <tr class="timeline_upper">
                <td class="upper_imgbox #{phase}"><br></td>
              </tr>
              <tr class="timeline_lower">
                <td class="lower_imgbox">
                  <br>
                </td> 
              </tr>
            </table>
          </div>
          <p class="title">現在のページ</p>
            <p class="now_url usually now_url1"><a href="#{url}" target="_blank">#{short_url}</a></p>
          <p class="title">メモ</p>
          <pre class="memobox">test
          </pre>
          <button class="memo_submit">submit</button>
        </div>
        <div class="tab-pane" id="behave_history_#{uuid}">
          <p class="title">閲覧履歴</p>
          <div class="view_history">
            <p class="now_url usually">#{HH}:#{MM} <a href="#{url}" target="_blank">#{short_url}</a></p>
          </div>
          <p class="title">興味のあるページ</p>
          <ul class="acv_url cf">
          </ul>
        </div>
        <div class="tab-pane" id="settings_#{uuid}">...</div>
      </div>
    </div>
  </div>
  """




@template = template
