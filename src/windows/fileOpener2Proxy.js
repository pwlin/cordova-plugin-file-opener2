
	var cordova = require('cordova'),
		fileOpener2 = require('./FileOpener2');

	module.exports = {

	    open: function (successCallback, errorCallback, args) {
	        Windows.Storage.StorageFile.getFileFromPathAsync(args[0]).then(function (file) {
	            var options = new Windows.System.LauncherOptions();
	            options.displayApplicationPicker = true;

	            Windows.System.Launcher.launchFileAsync(file, options).then(function (success) {
	                if (success) {
	                    successCallback();
	                } else {
	                    errorCallback();
	                }
	            });

	        });
		}
		
	};

	require("cordova/exec/proxy").add("FileOpener2", module.exports);

