'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.json": "34da11f8062e93539022cf85b4c3ce9b",
"assets/AssetManifest.smcbin": "e16783e4aca92179c28fbd920431266d",
"assets/assets/fonts/Bicyclette-Black.ttf": "935eb8c0593ebd0f6874cf46a21c36e1",
"assets/assets/fonts/Bicyclette-Bold.ttf": "e9d0f53cb1b3802c9c5674488e4b6931",
"assets/assets/fonts/Bicyclette-Italic.ttf": "85d6542a3f58d99e2b3d4531c5b1bcc7",
"assets/assets/fonts/Bicyclette-Light.ttf": "e4a7270e894013517cecb1f32217844a",
"assets/assets/fonts/Bicyclette-Regular.ttf": "88ff0de7c5c83889f93c010f605a0ca6",
"assets/assets/fonts/Bicyclette-Thin.ttf": "44f33b3a21e00f74e65604aada104d88",
"assets/assets/fonts/Bicyclette-Ultra.ttf": "49fde244e01ec0671ab1332f3f786505",
"assets/assets/fonts/Gotham-Black.otf": "14b3a355f612d6181e891efd2c798b5f",
"assets/assets/fonts/Gotham-Bold.otf": "9c35bf87f23c8cca614720126fe0baa0",
"assets/assets/fonts/Gotham-Italic.ttf": "b1951be38b528a44704a217b9c44ab55",
"assets/assets/fonts/Gotham-Light.otf": "f76e3adf545b3299f643fd7642800351",
"assets/assets/fonts/Gotham-Regular.ttf": "77171d8f5b5283f9d47a3434704bf944",
"assets/assets/fonts/Gotham-Thin.otf": "4ac7dbb4f9f9f467db596e759b8bf7db",
"assets/assets/fonts/Segoe-Ui.ttf": "c4b43d1fef93c506090c3c9f9a6d9f21",
"assets/assets/fonts/UniNeue-Black.otf": "acd3b49744755e66208dcc3ea2486b51",
"assets/assets/fonts/UniNeue-Bold.otf": "7b99adece88b53f147f2bb7aea4762d0",
"assets/assets/fonts/UniNeue-Light.otf": "c1f9a40f18261acc0afdac5dc258d374",
"assets/assets/fonts/UniNeue-Regular.otf": "7e4e5ddbef12dcf02118f78af51da82e",
"assets/assets/fonts/UniNeue-Thin.otf": "46927b78561c62e17935a271533332cb",
"assets/assets/images/avatar.png": "1333a057dd0c9e0bf6eff128a79f0f43",
"assets/assets/images/avatar2.png": "c4bece8b1f1ac7f896161ead436a22e0",
"assets/assets/images/avatar3.png": "5ca4c1a53f56b1dba165b45416a8b4a3",
"assets/assets/images/background.png": "8eab8ec855f41ca63b1fe01703a69b53",
"assets/assets/images/background2.png": "2b1190c1f4c7c64f8e0a2cac51166792",
"assets/assets/images/background3.png": "770ad0889dd2ec22b29bf3056d6f4ffb",
"assets/assets/images/background4.png": "e0047bac0f493f5b914974c75d7e3c4d",
"assets/assets/images/bottom_svg.svg": "9612f448e61181d7fd18bcd0c71cd40c",
"assets/assets/images/Cry_Car.png": "76a632c68e8c03302d1b2f43116b3e05",
"assets/assets/images/default-user-profile-picture.png": "1dc0a8621d429ff440d8f95705fdff7b",
"assets/assets/images/diagrama.jpg": "a7397581ad3060eebae660079a1e652a",
"assets/assets/images/fadeInAnimation.gif": "96c41b68917219e83ba2cd84870484a5",
"assets/assets/images/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/assets/images/Odi_car.png": "f3f884e7c47a296422d8cccbe8c55d12",
"assets/assets/images/right_svg.svg": "0baaaaf0bfe6796a77c28a17e3a33434",
"assets/assets/images/rta_logo.png": "c8a6caaa4139584b7eb7de809120a883",
"assets/assets/images/Smi_car.png": "3ac0f13b94167d0f166b66af94b486b2",
"assets/assets/images/user.png": "7cc7a630624d20f7797cb4c8e93c09c1",
"assets/assets/rive/accounts_icon.riv": "b3a676817003bd0cc251a78a5e8ead93",
"assets/assets/rive/dashboards_icon.riv": "83bb151f7a2cb552c28214c9a235e259",
"assets/assets/rive/inventories_icon.riv": "bbd7a11b2b964b905c9800f3b3694b1a",
"assets/assets/rive/networks_icon.riv": "d0123ab71e2a52677a0301f443afedac",
"assets/assets/rive/reports_icon.riv": "c9e5afc17ff6b42bfb448fce69f078b2",
"assets/assets/rive/schedulings_icon.riv": "456874345ada3688a35d2ed550470c11",
"assets/assets/rive/tickets_icon.riv": "c3c53397031d79f5a8ede564675aa08f",
"assets/assets/rive/users_icon.riv": "a3838de9aa7fe52c83ef6123780f2f2b",
"assets/FontManifest.json": "5ed9ba8c3d20b6e23cce071a310ea7e4",
"assets/fonts/MaterialIcons-Regular.otf": "d7c8681ee4419680811d3f9d1d8312c1",
"assets/NOTICES": "efbba7ae92646e3142a119271e7d420d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "0db203e8632f03baae0184700f3bda48",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "01bb14ae3f14c73ee03eed84f480ded9",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "efc6c90b58d765987f922c95c2031dd2",
"assets/packages/timezone/data/latest_all.tzf": "d34414858d4bd4de35c0ef5d94f1d089",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "9f3af7f16aa89846e1da8218cb69a36b",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f4291794d86c5f193bc3ee21ea3f0677",
"/": "f4291794d86c5f193bc3ee21ea3f0677",
"main.dart.js": "c6dd8a27555e3e6f16de499b6b7f58dd",
"manifest.json": "87360f2da4807db2d38e2ff764c9295c",
"version.json": "c479cbf7d75e6deee99c3b920033257e"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
