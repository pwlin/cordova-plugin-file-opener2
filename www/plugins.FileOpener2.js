var exec = require("cordova/exec");

function FileOpener2() {};

FileOpener2.prototype.open = function(fileName, contentType, callbackContext) {
	callbackContext = callbackContext || {};
	exec(callbackContext.success || null, callbackContext.error || null, "FileOpener2", "open", [fileName, contentType]);
};

var fileOpener2 = new FileOpener2();
module.exports = fileOpener2;
