'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "fb8d4678888024cd5f83d8522bb3a722",
"scraper.py": "dca0252ac53c5208a7f31a8a8234bc4b",
"index.html": "7c65b73ddded17155775dd5e4a9c98d1",
"/": "7c65b73ddded17155775dd5e4a9c98d1",
"main.dart.js": "e22c88db1dd4e00706458c4b5e6ae9fc",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "45c6b6cfd70cd829096bde0f924a7364",
"icons/Icon-192.png": "45c6b6cfd70cd829096bde0f924a7364",
"icons/Icon-512.png": "45c6b6cfd70cd829096bde0f924a7364",
"manifest.json": "d0c269c8254e09b5ecbf701c36d06bdf",
"assets/AssetManifest.json": "65d1f21018b8cfdb32c493376a949ff6",
"assets/NOTICES": "0652fbecdb5a51f906c5bbd4ee253121",
"assets/FontManifest.json": "8c8d6b13a597773255a4c4dcd3b94e4f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "26c75458375dfdde18e8238c059180df",
"assets/fonts/SamsungSharp/SamsungOne-800_v1.0.ttf": "08cc3f6d562069e67a806beae7572728",
"assets/fonts/SamsungSharp/SamsungSharpSans-Regular.ttf": "fa6f9a3445c6b98e8acba1379ea1fad3",
"assets/fonts/SamsungSharp/SamsungOne-700_v1.0.ttf": "e7aeba8519c249576ad9e225d4a5a98a",
"assets/fonts/SamsungSharp/SamsungSharpSans-Medium.ttf": "63bce755b8e968296e1a048939056364",
"assets/fonts/SamsungSharp/SamsungSharpSans-Bold.ttf": "8036464060fe818a6f5e01ed0e97a574",
"assets/fonts/MaterialIcons-Regular.otf": "02e38aee40de5a56e534c6840451ac97",
"assets/assets/images/logoBlk.png": "38be57d83846e88ef68d87ee2b5aa76a",
"assets/assets/images/talent.png": "4b872f7ce95fb7ce28c06cc6593a26c6",
"assets/assets/images/fb.png": "08287cfd5a202c9d498b0baa8391305d",
"assets/assets/images/photography/1000031090%2520(1).jpg": "5a46b3027be44ef01e6e3140dbb271c5",
"assets/assets/images/photography/_IGP1451(1)(1).jpg": "16b12664198b65fbf29ae7df0200333c",
"assets/assets/images/photography/1000031102.jpg": "a591f4ecd265b8ba25ea4e6739272844",
"assets/assets/images/photography/20250515_120304(2).jpg": "d65a20b749beed1055eaeb850bebc7cc",
"assets/assets/images/photography/1000039409.jpg": "a73ee8862fdf81987c5123d988f120fc",
"assets/assets/images/photography/20250612_233907.jpg": "1ec722286441067f5e21d6143f3a35e5",
"assets/assets/images/about/_DSC5820(1).jpg": "23e660bb5c29c8a5a2879110e66dd886",
"assets/assets/images/about/20240226_110112.jpg": "fba1d3c262c451b1e47ff3beacbbba32",
"assets/assets/images/about/20240923_143520.jpg": "d4ddba8ff398a7d96932cad38897d269",
"assets/assets/images/about/_DSC0444.jpg": "b4f866825873c1228faa4bb23da9f5c3",
"assets/assets/images/about/received_1019732753198638.jpeg": "d82e54decb77765183cf12a89d6dc4a0",
"assets/assets/images/cont.png": "7f12dd26fc4ec7ad0d55947385687268",
"assets/assets/images/logo.png": "45c6b6cfd70cd829096bde0f924a7364",
"assets/assets/images/hello.png": "11e4a3fef73e706df65441d29f36ed94",
"assets/assets/images/insta.png": "3d8ea53f413b2accdc69998d3e13f26b",
"assets/assets/images/profile.jpg": "4f1a01387444b8f918332eeb2dde70b6",
"assets/assets/images/education.png": "9678d327ca0275f1a8e097f1eb5d5148",
"assets/assets/pdf/MISTULA_CV.pdf": "7e70171d85282758e1306e72f13fe937",
"assets/assets/fonts/SFUIText-Light.otf": "433cdd63339cb887e50d1201fdd84afd",
"assets/assets/fonts/SFUIText-Heavy.otf": "25ab2b97443fec973dfa6c8d2bc6df04",
"assets/assets/data/instagram_posts.json": "6ecc55a63470370c9e0636632c620195",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
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
