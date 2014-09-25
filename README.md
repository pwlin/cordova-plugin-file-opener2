A File Opener Plugin for Cordova (The Original Version)
==========================
This plugin will open a file on your device file system with its default application.

Requirements
-------------
- Android 4 or higher / iOS 6 or higher
- Cordova 3.0 or higher

Installation
-------------
    cordova plugin add [url-of-the-git-repo]
    
PhoneGap Build
---------------
This Plugin is also available in PhoneGap Build Repository. Go to [https://build.phonegap.com/](https://build.phonegap.com/)
And search for `io.github.pwlin.cordova.plugins.fileopener2`
(There are a couple of other forks out there which are mostly out of date. Make sure to download the one with the exact same id as mentioned above) 


Usage
------
Open an APK install dialog:
    
    <script>
        cordova.plugins.fileOpener2.open(
            '/sdcard/Download/gmail.apk', 
            'application/vnd.android.package-archive'
        );
    </script>
    
Open a PDF document with the default PDF reader and optional callback object:

    <script>
        cordova.plugins.fileOpener2.open(
    	    '/sdcard/Download/starwars.pdf', 
    	    'application/pdf', 
    	    { 
    		    error : function(errorObj) { 
    			    alert('Error status: ' + errorObj.status + ' - Error message: ' + errorObj.message); 
    		    },
    		    success : function () {
    			    alert('file opened successfully'); 				
    		    }
    	    }
        );
    </script>
    
Notes
------

- For properly opening a PDF file, you must already have a PDF reader (Acrobat Reader, Foxit Mobile PDF, etc. ) installed on your mobile device. Otherwise this will not work


- [It is reported](https://github.com/pwlin/cordova-plugin-file-opener2/issues/2#issuecomment-41295793) that in iOS, you might need to remove `<preference name="iosPersistentFileLocation" value="Library" />` from your `config.xml`

