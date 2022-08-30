
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/service_worker.js', {
    scope: '/'
  }).then(function(registration) {
    console.log("registration: ", registration);
  })
  .catch(function(err) {
    console.log(err);
  });
}

const publicVapidKey = "BPGKwtJwLBlVNUuHoV53GIUg6DzvKji1Aoufjm5ohxqFquBgRfQdubk-VM-mO_paljPrIIuSkdP4zI8MqiZSWuA"
console.log("publicVapidKey: ", publicVapidKey)

const urlBase64ToUint8Array = (base64String) => {
  const padding = '='.repeat((4 - base64String.length % 4) % 4);
  const base64 = (base64String + padding)
    .replace(/\-/g, '+')
    .replace(/_/g, '/');

  const rawData = window.atob(base64);
  const outputArray = new Uint8Array(rawData.length);

  for (let i = 0; i < rawData.length; ++i) {
    outputArray[i] = rawData.charCodeAt(i);
  }
  return outputArray;
};

const getSubscribedElement = () => document.getElementById('subscribed');
const getUnsubscribedElement = () => document.getElementById('unsubscribed');

const setSubscribeMessage = async () => {
  const registration = await navigator.serviceWorker.ready;
  const subscription = await registration.pushManager.getSubscription();
  getSubscribedElement().setAttribute('style', `display: ${subscription ? 'block' : 'none'};`);
  getUnsubscribedElement().setAttribute('style', `display: ${subscription ? 'none' : 'block'};`);
};

window.subscribe = async () => {
  if (!('serviceWorker' in navigator)) return;

  const registration = await navigator.serviceWorker.ready;

  // Subscribe to push notifications
  const subscription = await registration.pushManager.subscribe({
    userVisibleOnly: true,
    applicationServerKey: urlBase64ToUint8Array(publicVapidKey),
  });
  console.log("subscription: ", subscription)
  const response = await fetch('/subscription', {
    method: 'POST',
    body: JSON.stringify(subscription),
    headers: {
      'content-type': 'application/json',
    },
  });

  if (response.ok) {
    setSubscribeMessage();
  }
}

window.unsubscribe = async () => {
  const registration = await navigator.serviceWorker.ready;
  const subscription = await registration.pushManager.getSubscription();
  if (!subscription) return;
  
  const { endpoint } = subscription;
  const response = await fetch(`/subscription?endpoint=${endpoint}`, {
    method: 'DELETE',
    headers: {
      'content-type': 'application/json',
    },
  });

  if (response.ok) {
    await subscription.unsubscribe();
    setSubscribeMessage();
  }
};

window.sendNotification = async () => {
  await fetch('/sendNotification', {
    method: 'GET',
    headers: {
      'content-type': 'application/json',
    },
  });
}
setSubscribeMessage();