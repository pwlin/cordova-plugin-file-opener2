package io.github.pwlin.cordova.plugins.fileopener2;

import java.io.File;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Intent;
import android.net.Uri;
//import android.util.Log;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.apache.cordova.CordovaResourceApi;

public class FileOpener2 extends CordovaPlugin {

	/**
	 * Executes the request and returns a boolean.
	 * 
	 * @param action
	 *            The action to execute.
	 * @param args
	 *            JSONArry of arguments for the plugin.
	 * @param callbackContext
	 *            The callback context used when calling back into JavaScript.
	 * @return boolean.
	 */
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

		if (action.equals("open")) {

			try {

				return this._open(args.getString(0), args.getString(1), callbackContext);

			} catch (JSONException e) {

				JSONObject errorObj = new JSONObject();
				errorObj.put("status", PluginResult.Status.JSON_EXCEPTION.ordinal());
				errorObj.put("message", e.getMessage());
				callbackContext.error(errorObj);
				return false;
			}

		} else {

			JSONObject errorObj = new JSONObject();
			errorObj.put("status", PluginResult.Status.INVALID_ACTION.ordinal());
			errorObj.put("message", "Invalid action");
			callbackContext.error(errorObj);
			return false;

		}

	}

	/**
	 * Identifies if action to be executed returns a value and should be run
	 * synchronously.
	 * 
	 * @param action
	 *            The action to execute
	 * @return T=returns value
	 */
	public boolean isSynch(String action) {
		return false;
	}

	/**
	 * Called by AccelBroker when listener is to be shut down. Stop listener.
	 */
	public void onDestroy() {
	}

	private boolean _open(String fileArg, String contentType, CallbackContext callbackContext) throws JSONException {
		String fileName = "";
		try {
	        CordovaResourceApi resourceApi = webView.getResourceApi();
	        Uri fileUri = resourceApi.remapUri(Uri.parse(fileArg));
	        fileName = org.apache.cordova.FileHelper.stripFileProtocol(fileUri.toString());
		} catch (Exception e) {
			fileName = fileArg;
		}		
        
		File file = new File(fileName);

		if (file.exists()) {

			try {

				Uri path = Uri.fromFile(file);
				Intent intent = new Intent(Intent.ACTION_VIEW);
				intent.setDataAndType(path, contentType);
				intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
				/*
				 * @see  http://stackoverflow.com/questions/14321376/open-an-activity-from-a-cordovaplugin
				 */
				cordova.getActivity().startActivity(Intent.createChooser(intent,"Open File in..."));
				callbackContext.success();
				return true;

			} catch (android.content.ActivityNotFoundException e) {

				JSONObject errorObj = new JSONObject();
				errorObj.put("status", PluginResult.Status.ERROR.ordinal());
				errorObj.put("message", "Activity not found: " + e.getMessage());
				callbackContext.error(errorObj);
				return false;
			}

		} else {

			JSONObject errorObj = new JSONObject();
			errorObj.put("status", PluginResult.Status.ERROR.ordinal());
			errorObj.put("message", "File not found");
			callbackContext.error(errorObj);
			return false;

		}
	}

}
