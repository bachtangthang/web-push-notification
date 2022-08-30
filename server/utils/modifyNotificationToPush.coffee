
modifyNotificationToPush = (noti) ->
  noti.keys =
    p256dh: noti.keys_p256dh
    auth: noti.keys_auth
  delete noti.keys_p256dh
  delete noti.keys_auth
  return noti

module.exports = modifyNotificationToPush: modifyNotificationToPush