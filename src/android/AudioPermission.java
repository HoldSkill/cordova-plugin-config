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
	public static String[]  permissions = { Manifest.permission.RECORD_AUDIO };
	public static int       RECORD_AUDIO = 0;

	@Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if (action.equals("checkAudioPermission")) {
		   if(PermissionHelper.hasPermission(this, permissions[RECORD_AUDIO])) {
		      return true;
		   }
		   return false;
	    }

	    if (action.equals("getAudioPermission")) {
		   if(PermissionHelper.hasPermission(this, permissions[RECORD_AUDIO])) {
		      return true;
		   }
		   else {
		   	  getPermissionCallbackContext = callbackContext;
		      getAudioPermission(RECORD_AUDIO);

		   }
		   return true;
	    }
    }

    protected void getAudioPermission(int requestCode) {
        PermissionHelper.requestPermission(this, requestCode, permissions[RECORD_AUDIO]);
    }

	public void onRequestPermissionResult(int requestCode, String[] permissions, int[] grantResults) throws JSONException {
	    for(int r:grantResults) {
	        if(r == PackageManager.PERMISSION_DENIED) {
		       if (this.getPermissionCallbackContext == null) {
					return false;
		       }
		       else {
			  		return true;
		       }
	        }
	    }
		if (this.getPermissionCallbackContext == null) {
		   return false;
		}
		else {
		   return true;
		}
	}
}