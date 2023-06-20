'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "c479cbf7d75e6deee99c3b920033257e",
"index.html": "74742907479f0fc443eb3f5bf7f0c102",
"/": "74742907479f0fc443eb3f5bf7f0c102",
"main.dart.js": "3b040d89845dde65b13da29678952a75",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "13101d7f119fbf0a8b00081fe46474ed",
"assets/AssetManifest.json": "277d1f8ac6deffb3b59b2bdca5029cea",
"assets/NOTICES": "5470a735874ec08e057ea38a0a103e5d",
"assets/FontManifest.json": "d3aa5e828131a393b81adb3816f2c733",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/packages/timezone/data/latest_all.tzf": "d34414858d4bd4de35c0ef5d94f1d089",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "efc6c90b58d765987f922c95c2031dd2",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "01bb14ae3f14c73ee03eed84f480ded9",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "0db203e8632f03baae0184700f3bda48",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "8f20a25b66d286064f01db805ddc3949",
"assets/fonts/MaterialIcons-Regular.otf": "17c4725f8e6fdc366e3f6b444d39286b",
"assets/assets/images/background4.png": "e0047bac0f493f5b914974c75d7e3c4d",
"assets/assets/images/diagrama.jpg": "a7397581ad3060eebae660079a1e652a",
"assets/assets/images/background2.png": "2b1190c1f4c7c64f8e0a2cac51166792",
"assets/assets/images/background3.png": "770ad0889dd2ec22b29bf3056d6f4ffb",
"assets/assets/images/right_svg.svg": "b8f74b408f17cfbc3aabf799e5621422",
"assets/assets/images/user.png": "7cc7a630624d20f7797cb4c8e93c09c1",
"assets/assets/images/background.png": "8eab8ec855f41ca63b1fe01703a69b53",
"assets/assets/images/avatar.png": "1333a057dd0c9e0bf6eff128a79f0f43",
"assets/assets/images/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/assets/images/default-user-profile-picture.png": "1dc0a8621d429ff440d8f95705fdff7b",
"assets/assets/images/avatar3.png": "5ca4c1a53f56b1dba165b45416a8b4a3",
"assets/assets/images/fadeInAnimation.gif": "96c41b68917219e83ba2cd84870484a5",
"assets/assets/images/avatar2.png": "c4bece8b1f1ac7f896161ead436a22e0",
"assets/assets/images/Cry_Car.png": "76a632c68e8c03302d1b2f43116b3e05",
"assets/assets/images/Odi_car.png": "f3f884e7c47a296422d8cccbe8c55d12",
"assets/assets/images/bottom_svg.svg": "6b91e0469103950ad0111f417d7ee82b",
"assets/assets/images/Smi_car.png": "3ac0f13b94167d0f166b66af94b486b2",
"assets/assets/images/rta_logo.png": "c8a6caaa4139584b7eb7de809120a883",
"assets/assets/rive/reports_icon.riv": "c9e5afc17ff6b42bfb448fce69f078b2",
"assets/assets/rive/inventories_icon.riv": "bbd7a11b2b964b905c9800f3b3694b1a",
"assets/assets/rive/accounts_icon.riv": "b3a676817003bd0cc251a78a5e8ead93",
"assets/assets/rive/networks_icon.riv": "d0123ab71e2a52677a0301f443afedac",
"assets/assets/rive/tickets_icon.riv": "c3c53397031d79f5a8ede564675aa08f",
"assets/assets/rive/users_icon.riv": "a3838de9aa7fe52c83ef6123780f2f2b",
"assets/assets/rive/dashboards_icon.riv": "83bb151f7a2cb552c28214c9a235e259",
"assets/assets/rive/schedulings_icon.riv": "456874345ada3688a35d2ed550470c11",
"assets/assets/fonts/Bicyclette-Thin.ttf": "44f33b3a21e00f74e65604aada104d88",
"assets/assets/fonts/Bicyclette-Black.ttf": "935eb8c0593ebd0f6874cf46a21c36e1",
"assets/assets/fonts/Bicyclette-Bold.ttf": "e9d0f53cb1b3802c9c5674488e4b6931",
"assets/assets/fonts/Gotham-Thin.otf": "4ac7dbb4f9f9f467db596e759b8bf7db",
"assets/assets/fonts/Gotham-Black.otf": "14b3a355f612d6181e891efd2c798b5f",
"assets/assets/fonts/Gotham-Regular.ttf": "77171d8f5b5283f9d47a3434704bf944",
"assets/assets/fonts/Gotham-Bold.otf": "9c35bf87f23c8cca614720126fe0baa0",
"assets/assets/fonts/Bicyclette-Italic.ttf": "85d6542a3f58d99e2b3d4531c5b1bcc7",
"assets/assets/fonts/Gotham-Light.otf": "f76e3adf545b3299f643fd7642800351",
"assets/assets/fonts/Bicyclette-Regular.ttf": "88ff0de7c5c83889f93c010f605a0ca6",
"assets/assets/fonts/Gotham-Italic.ttf": "b1951be38b528a44704a217b9c44ab55",
"assets/assets/fonts/Segoe-Ui.ttf": "c4b43d1fef93c506090c3c9f9a6d9f21",
"assets/assets/fonts/Bicyclette-Light.ttf": "e4a7270e894013517cecb1f32217844a",
"assets/assets/fonts/Bicyclette-Ultra.ttf": "49fde244e01ec0671ab1332f3f786505",
"canvaskit/skwasm.js": "831c0eebc8462d12790b0fadf3ab6a8a",
"canvaskit/skwasm.wasm": "2cb965595f656f0c58ad6bb5988f8280",
"canvaskit/chromium/canvaskit.js": "6bdd0526762a124b0745c05281c8a53e",
"canvaskit/chromium/canvaskit.wasm": "347841c04107bb5a17164bee251d8307",
"canvaskit/canvaskit.js": "45bec3a754fba62b2d8f23c38895f029",
"canvaskit/canvaskit.wasm": "e5b1f72690096075e25fe1f481cb6ce6",
"canvaskit/skwasm.worker.js": "7ec8c65402d6cd2a341a5d66aa3d021f"};
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
