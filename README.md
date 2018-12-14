A File Opener Plugin for Cordova (The Original Version) [![Latest Stable Version](https://img.shields.io/npm/v/cordova-plugin-file-opener2.svg)](https://www.npmjs.com/package/cordova-plugin-file-opener2) [![Total Downloads](https://img.shields.io/npm/dt/cordova-plugin-file-opener2.svg)](https://npm-stat.com/charts.html?package=cordova-plugin-file-opener2)
==========================
This plugin will open a file on your device file system with its default application.


Requirements
-------------
The following platforms and versions are supported by the latest release:

- Android 4.4+ / iOS 9+ / WP8
- Cordova 7.0 or higher

Cordova 6.0 is supported by 2.0.19, but there are a number of issues, particularly with Android builds (see [232](https://github.com/pwlin/cordova-plugin-file-opener2/issues/232) [203](https://github.com/pwlin/cordova-plugin-file-opener2/issues/203) [207](https://github.com/pwlin/cordova-plugin-file-opener2/issues/207)). Using the [cordova-android-support-gradle-release](https://github.com/dpa99c/cordova-android-support-gradle-release) plugin may help.


Installation
-------------
```shell
$ cordova plugin add cordova-plugin-file-opener2
$ cordova plugin add cordova-plugin-file-opener2  --variable ANDROID_SUPPORT_VERSION={required version}
```

Usage
------
```javascript
cordova.plugins.fileOpener2.open(
    filePath,
    fileMIMEType,
    {
        error : function(){ },
        success : function(){ },
        position : [x, y]
    }
);
```
`position` array of coordinates from top-left device screen, use for iOS dialog positioning.

Examples
--------
Open an APK install dialog:

```javascript
cordova.plugins.fileOpener2.open(
    '/sdcard/Download/gmail.apk',
    'application/vnd.android.package-archive'
);
```

Install From Market: to install an APK from a market place, such as Google Play or the App Store, you can use an `<a>` tag in combination with the `market://` protocol:

```html
<a href="market://details?id=xxxx" target="_system">Install from Google Play</a>
<a href="itms-apps://itunes.apple.com/app/my-app/idxxxxxxxx?mt=8" target="_system">Install from App Store</a>
```

or in code:
```javascript
window.open("[market:// or itms-apps:// link]","_system");
```

Open a PDF document with the default PDF reader and optional callback object:
```javascript
cordova.plugins.fileOpener2.open(
    '/sdcard/Download/starwars.pdf', // You can also use a Cordova-style file uri: cdvfile://localhost/persistent/Download/starwars.pdf
    'application/pdf',
    {
        error : function(e) {
            console.log('Error status: ' + e.status + ' - Error message: ' + e.message);
        },
        success : function () {
            console.log('file opened successfully');
        }
    }
);
```
Open a system modal to open PDF document with one of the already installed app and optional callback object:
```javascript
cordova.plugins.fileOpener2.showOpenWithDialog(
    '/sdcard/Download/starwars.pdf', // You can also use a Cordova-style file uri: cdvfile://localhost/persistent/Download/starwars.pdf
    'application/pdf',
    {
        error : function(e) {
            console.log('Error status: ' + e.status + ' - Error message: ' + e.message);
        },
        success : function () {
            console.log('file opened successfully');
        }
    }
);
```

Notes
------

- For properly opening _any_ file, you must already have a suitable reader for that particular file type installed on your device. Otherwise this will not work.

- [It is reported](https://github.com/pwlin/cordova-plugin-file-opener2/issues/2#issuecomment-41295793) that in iOS, you might need to remove `<preference name="iosPersistentFileLocation" value="Library" />` from your `config.xml`

- If you are wondering what MIME-type should you pass as the second argument to `open` function, [here is a list of all known MIME-types](http://svn.apache.org/viewvc/httpd/httpd/trunk/docs/conf/mime.types?view=co)


Android APK installation limitation
---
The following limitations apply when opening an APK file for installation:
- On Android 8+, your application must have the `ACTION_INSTALL_PACKAGE` permission. You can add it by adding this to your app's `config.xml` file:
```xml
<platform name="android">
    <config-file parent="/manifest" target="AndroidManifest.xml" xmlns:android="http://schemas.android.com/apk/res/android">
        <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
    </config-file>
</platform>
```

- Before Android 7, you can only install APKs from the "external" partition. For example, you can install from `cordova.file.externalDataDirectory`, but **not** from `cordova.file.dataDirectory`. Android 7+ does not have this limitation.

Additional Android Functions
---
The following functions are available in Android platform:

`.uninstall(packageId, callbackContext)`
---
Uninstall a package with its id.
```javascript
cordova.plugins.fileOpener2.uninstall('com.zynga.FarmVille2CountryEscape', {
    error : function(e) {
        console.log('Error status: ' + e.status + ' - Error message: ' + e.message);
    },
    success : function() {
        console.log('Uninstall intent activity started.');
    }
});
```
`.appIsInstalled(packageId, callbackContext)`
---
Check if an app is already installed.
```javascript
cordova.plugins.fileOpener2.appIsInstalled('com.adobe.reader', {
    success : function(res) {
        if (res.status === 0) {
            console.log('Adobe Reader is not installed.');
        } else {
            console.log('Adobe Reader is installed.')
        }
    }
});
```
---

Contributors
------------
[@Gillardo](https://github.com/Gillardo/), [@TankOs](https://github.com/TankOs), [@Rovi23](https://github.com/Rovi23), [@josemanuelbd](https://github.com/josemanuelbd), [@ielcoro](https://github.com/ielcoro), [@keturn](https://github.com/keturn), [@conform](https://github.com/conform), [@guyc](https://github.com/guyc), [@J3r0M3D3V](https://github.com/J3r0M3D3V), [@WuglyakBolgoink](https://github.com/WuglyakBolgoink), [@lincolnthree](https://github.com/lincolnthree), [@rocco](https://github.com/rocco/), [@FrankFenton](https://github.com/FrankFenton), [@MHolmes91](https://github.com/MHolmes91), [@souly1](https://github.com/souly1), [@diogodias86](https://github.com/diogodias86), [@Arxi](https://github.com/Arxi), [@vzharkov](https://github.com/vzharkov), [@lp1bp](https://github.com/lp1bp), [@stalniy](https://github.com/stalniy), [@liugogal](https://github.com/liugogal), [@lcaprini](https://github.com/lcaprini), [@jcdickman](https://github.com/jcdickman) [@shnist](https://github.com/shnist) [@Eeems](https://github.com/Eeems)

---

LICENSE
--------
The MIT License (MIT)

Copyright (c) 2013 pwlin - pwlin05@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
