A File Opener Plugin for Cordova
==========================
This plugin will open a file on your device file system with its default application.

Requirements
-------------
- Android 4+ / iOS 6+
- Cordova 3.0 or higher

Installation
-------------
    cordova plugin add [url-of-the-git-repo]

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

