
console ||= {}
console.log ||= ()->


check = {}
jQuery = ()->
  typeof jQuery == "function"

jQueryCookie = ()->
  typeof jQuery.cookie == "function"

Cookie = ()->
  (jQuery.cookie "znclrk") != null and (jQuery.cookie "znclrk_usid") != null

