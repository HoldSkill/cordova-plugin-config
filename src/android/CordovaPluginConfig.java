package com.holdskill.CordovaPluginConfig;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.lang.ref.WeakReference;
import java.io.File;
import java.net.URI;
import java.net.URISyntaxException;


import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.content.pm.PackageManager;
import org.apache.cordova.PermissionHelper;
import android.Manifest;

public class CordovaPluginConfig extends CordovaPlugin
{

    private CallbackContext callbackContext = null;
    private CallbackContext getPermissionCallbackContext = null;
	public static String[]  permissions = { Manifest.permission.RECORD_AUDIO, Manifest.permission.WRITE_EXTERNAL_STORAGE};
    public static int RECORD_AUDIO = 0;
    public static int WRITE_EXTERNAL_STORAGE = 1;
	public static final int PERMISSION_DENIED_ERROR = 20;

	@Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if (action.equals("checkAudioPermission")) {
		   if(PermissionHelper.hasPermission(this, permissions[RECORD_AUDIO])) {
				PluginResult result = new PluginResult(PluginResult.Status.OK, Boolean.TRUE);
				callbackContext.sendPluginResult(result);
		   }
		   else {
				PluginResult result = new PluginResult(PluginResult.Status.OK, Boolean.FALSE);
				callbackContext.sendPluginResult(result);
		   }
		   return true;
        }

	    if (action.equals("getAudioPermission")) {
		   if(PermissionHelper.hasPermission(this, permissions[RECORD_AUDIO])) {
				PluginResult result = new PluginResult(PluginResult.Status.OK, Boolean.TRUE);
				callbackContext.sendPluginResult(result);
		   }
		   else {
				getPermissionCallbackContext = callbackContext;
				PluginResult pluginResult = new PluginResult(PluginResult.Status.NO_RESULT);
				pluginResult.setKeepCallback(true);
				callbackContext.sendPluginResult(pluginResult);
				getAudioPermission(RECORD_AUDIO);

		   }
		   return true;
	    }
	    return false;
    }

    protected void getWritePermission(int requestCode)
    {
        PermissionHelper.requestPermission(this, requestCode, permissions[WRITE_EXTERNAL_STORAGE]);
    }
    protected void getAudioPermission(int requestCode) {
        PermissionHelper.requestPermission(this, requestCode, permissions[RECORD_AUDIO]);
    }

	public void onRequestPermissionResult(int requestCode, String[] permissions, int[] grantResults) throws JSONException {
	    for(int r:grantResults) {
	        if(r == PackageManager.PERMISSION_DENIED) {
		       if (this.getPermissionCallbackContext == null) {
					this.callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.ERROR, PERMISSION_DENIED_ERROR));
					return;
		       }
		       else {
			  		PluginResult result = new PluginResult(PluginResult.Status.OK, Boolean.FALSE);
		  			this.getPermissionCallbackContext.sendPluginResult(result);
		       }
	        }
	    }
		promptForRecord();
	}

	private void promptForRecord() {
        if(PermissionHelper.hasPermission(this, permissions[WRITE_EXTERNAL_STORAGE]) && PermissionHelper.hasPermission(this, permissions[RECORD_AUDIO])) {

        }
        else if(PermissionHelper.hasPermission(this, permissions[RECORD_AUDIO]))
        {
            getWritePermission(WRITE_EXTERNAL_STORAGE);
        }
        else
        {
            getAudioPermission(RECORD_AUDIO);
        }

    }
}