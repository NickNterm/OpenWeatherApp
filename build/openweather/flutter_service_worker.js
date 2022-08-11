'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "a8c53544db0ca46c7ceedbc86663d9f5",
"index.html": "e80c8292d6458a129077955594f4f734",
"/": "e80c8292d6458a129077955594f4f734",
"favicon.png": "bd25ff79a210f14fbb1b1dc9c67387b9",
"version.json": "7b3df08262c44c78ab54cbb7a4d53119",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.json": "38bc98a424a019468988efd9c99bdd7e",
"assets/assets/app_icons/moon_sun_outline.png": "bd25ff79a210f14fbb1b1dc9c67387b9",
"assets/assets/app_icons/classic_outline.png": "9440f386e4f664fcbd9e9017777db79d",
"assets/assets/app_icons/classic.png": "b9b1c2fb9fe62476648aca0c62cfc43d",
"assets/assets/app_icons/moon_sun.png": "edc61898bc1f52054b59c7c471183786",
"assets/assets/weather_icons/sunset.svg": "b4808ce0b809fadd84a49601438898de",
"assets/assets/weather_icons/snow.svg": "1ed11e5817bcc4bc3ee5d3a4583c334a",
"assets/assets/weather_icons/wind.svg": "745852ce24e004599dc726995bc5683f",
"assets/assets/weather_icons/lightning-rain.svg": "d3500aaeca6554024f7c8b7260c12411",
"assets/assets/weather_icons/cloud.svg": "515ad17975d5bea3806011eef7e7b52c",
"assets/assets/weather_icons/sunrise.svg": "c64d1eb5e5751eae7e1e266883d89e6c",
"assets/assets/weather_icons/sun.svg": "f1355bce27fda54a5554f639db61ef73",
"assets/assets/weather_icons/rain.svg": "bab509eaba805d6c28f059824f92c4ec",
"assets/assets/weather_icons/fog.svg": "412612e9602bbec556b9bb19b5a33b78",
"assets/assets/weather_icons/cloud-wind.svg": "1e3b45664076b1308e7080288e64cc69",
"assets/assets/weather_icons/drizzle.svg": "202223e769e78b1b6b56737666e040c5",
"assets/assets/weather_icons/moon.svg": "926c03c65123301f1be57bab0663829b",
"assets/NOTICES": "5ee1305c4990d99f2eb947e8423d29c1",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"manifest.json": "c9bfef97c14cb94a65f154930d3f6070",
"icons/Icon-maskable-192.png": "bd25ff79a210f14fbb1b1dc9c67387b9",
"icons/Icon-192.png": "bd25ff79a210f14fbb1b1dc9c67387b9",
"icons/Icon-maskable-512.png": "bd25ff79a210f14fbb1b1dc9c67387b9",
"icons/Icon-512.png": "bd25ff79a210f14fbb1b1dc9c67387b9"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
