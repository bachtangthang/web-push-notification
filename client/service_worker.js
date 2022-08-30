console.log("Service Worker is loaded");

self.addEventListener('push', (e) => {
  const data = e.data.json();
  console.log(data);
  console.log('Push received');
  self.registration.showNotification(data.title, {
    body: data.title,
    icon: data.icon,
  });
});

// self.addEventListener('push', function(event) {
//   var message = '[empty payload]';
//   console.log()
//   if (event.data)
//     message = 'payload: ' + event.data.text();

//   event.waitUntil(
//     registration.showNotification('Push Generator', {
//       body: message
//     })
//   );
// });
// self.addEventListener('push', function(event) {

//   var myNotif = event.data.json();
//   const promiseChain = self.registration.showNotification(myNotif.title);

//   event.waitUntil(promiseChain);
// });