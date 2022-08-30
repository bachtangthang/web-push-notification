
obj = {
  endpoint : 'https://fcm.googleapis.com/fcm/send/dCSXVzCvSls:APA91bGs3lz4hSXmdTbEeUbPjWwbOlALkHK_8hs0yhlFvniuN1Sr7oDQYvZZqJifnwZCrjxf5NMIiNWpUBN4ucE3YtqMsIRcP8PSbTjMuOadYeWDsmwPEjxN7CdaaPZsR660g_Wl3p-N',
  keys_p256dh : 'BHnOMqL8XCBnL8lgE0Z7Ecx8HdzSOg2mMCJ3wGZLwMFVxQf6WNLi8euNaksvSK-D3lvG2vs4z6EqI_m4fOLC4aA',
  keys_auth : 'aUoRVySPrlGG_sfRu7LNRA',
  notification_id : 16,
  expirationtime : null,
  userid : null }

{modifyNotificationToPush} =  require "./server/utils/modifyNotificationToPush"

obj2 = modifyNotificationToPush obj
console.log obj2