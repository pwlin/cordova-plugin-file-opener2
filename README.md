Contributors
------------
[@Gillardo](https://github.com/Gillardo/), [@TankOs](https://github.com/TankOs), [@Rovi23](https://github.com/Rovi23), [@josemanuelbd](https://github.com/josemanuelbd), [@ielcoro](https://github.com/ielcoro), [@keturn](https://github.com/keturn), [@conform](https://github.com/conform), [@guyc](https://github.com/guyc), [@J3r0M3D3V](https://github.com/J3r0M3D3V), [@WuglyakBolgoink](https://github.com/WuglyakBolgoink), [@lincolnthree](https://github.com/lincolnthree), [@rocco](https://github.com/rocco/), [@FrankFenton](https://github.com/FrankFenton)


A File Opener Plugin for Cordova (The Original Version)
==========================
This plugin will open a file on your device file system with its default application.

Current Version: 2.0.7
----------------

Requirements
-------------
- Android 4 or higher / iOS 6 or higher / WP8
- Cordova 3.0 or higher

Installation
-------------
    cordova plugin add cordova-plugin-file-opener2
    
Usage
------
    cordova.plugins.fileOpener2.open(
        filePath, 
        fileMIMEType, 
        {
            error : function(){ }, 
            success : function(){ } 
        } 
    );

Examples
--------
Open an APK install dialog:

    cordova.plugins.fileOpener2.open(
        '/sdcard/Download/gmail.apk', 
        'application/vnd.android.package-archive'
    );
    
Open a PDF document with the default PDF reader and optional callback object:

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

Notes
------

- For properly opening _any_ file, you must already have a suitable reader for that particular file type installed on your device. Otherwise this will not work.


- [It is reported](https://github.com/pwlin/cordova-plugin-file-opener2/issues/2#issuecomment-41295793) that in iOS, you might need to remove `<preference name="iosPersistentFileLocation" value="Library" />` from your `config.xml`

- If you are wondering what MIME-type should you pass as the second argument to `open` function, [here is a list of all known MIME-types](http://svn.apache.org/viewvc/httpd/httpd/trunk/docs/conf/mime.types?view=co)


Additional Android Functions
-----------------------------
####The following functions are available in Android platform

###.uninstall(_packageId, callbackContext_)
Uninstall a package with its id.

    cordova.plugins.fileOpener2.uninstall('com.zynga.FarmVille2CountryEscape', {
        error : function(e) {
            console.log('Error status: ' + e.status + ' - Error message: ' + e.message);    
        },
        success : function() {
            console.log('Uninstall intent activity started.');
        }
    });

###.appIsInstalled(_packageId, callbackContext_)
Check if an app is already installed.

    cordova.plugins.fileOpener2.appIsInstalled('com.adobe.reader', {
        success : function(res) {
            if (res.status === 0) {
                console.log('Adobe Reader is not installed.');
            } else {
                console.log('Adobe Reader is installed.')
            }
        }
    });

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
