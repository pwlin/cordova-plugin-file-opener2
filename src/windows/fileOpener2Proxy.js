
	var cordova = require('cordova'),
		fileOpener2 = require('./FileOpener2');

	var schemes = [
        { protocol: 'ms-app', getFile: getFileFromApplicationUri },
        { protocol: 'file:///', getFile: getFileFromFileUri }
	]

	function getFileFromApplicationUri(uri) {
	    var applicationUri = new Windows.Foundation.Uri(uri);

	    return Windows.Storage.StorageFile.getFileFromApplicationUriAsync(applicationUri);
	}

	function getFileFromFileUri(uri) {
	    var path = Windows.Storage.ApplicationData.current.localFolder.path +
                        uri.substr(8);

	    return getFileFromNativePath(path);
	}

	function getFileFromNativePath(path) {
	    var nativePath = path.split("/").join("\\");

	    return Windows.Storage.StorageFile.getFileFromPathAsync(nativePath);
	}

	function getFileLoaderForScheme(path) {
	    var fileLoader = getFileFromNativePath;

	    schemes.some(function (scheme) {
	        return path.indexOf(scheme.protocol) === 0 ? ((fileLoader = scheme.getFile), true) : false;
	    });

	    return fileLoader;
	}

	module.exports = {

	    open: function (successCallback, errorCallback, args) {
	        var path = args[0];
	        
	        var getFile = getFileLoaderForScheme(path);

	        getFile(path).then(function (file) {
	            var options = new Windows.System.LauncherOptions();

	            Windows.System.Launcher.launchFileAsync(file, options).then(function (success) {
	                if (success) {
	                    successCallback();
	                } else {
	                    errorCallback();
	                }
	            });

	        }, function (errror) {
	            console.log("Error abriendo el archivo");
	        });
		}
		
	};

	require("cordova/exec/proxy").add("FileOpener2", module.exports);

