package com.luckypines.flutter.flutterglow

import android.os.Bundle
import android.util.Log

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import android.view.WindowManager
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    MethodChannel(flutterView, "flutter.luckypines.com/screen_dimmer").setMethodCallHandler { methodCall, result ->
      Log.d(">>>> hoge", result.toString());
      if (methodCall.method == "setDimLevel") {
        val l = methodCall.arguments as? Int
        if (l == null) {
          result.error("InvalidArgument", null, null);
        } else {
          l.let {
            result.success(setDimLevel(it.toFloat()))
          }
        }
      } else {
        result.notImplemented()
      }
    }
  }

  private fun setDimLevel(dimLevel: Float): Float {
    val window = getWindow()
    val params = window.getAttributes()
    params.screenBrightness = dimLevel
    window.setAttributes(params)
    window.addFlags(WindowManager.LayoutParams.FLAGS_CHANGED)
    return dimLevel
  }
}
