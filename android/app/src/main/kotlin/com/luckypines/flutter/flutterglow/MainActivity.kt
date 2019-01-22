package com.luckypines.flutter.flutterglow

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import android.view.WindowManager
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    MethodChannel(flutterView, "flutter.luckypines.com/screen_dimmer").setMethodCallHandler { methodCall, result ->
      if (methodCall.method == "setDimLevel") {
        val l = methodCall.arguments as? Double
        if (l == null) {
          result.error("InvalidArgument", null, null);
        } else {
          l.let {
            result.success(setDimLevel(it))
          }
        }
      } else {
        result.notImplemented()
      }
    }
  }

  private fun setDimLevel(dimLevel: Double): Double {
    val window = getWindow()
    val params = window.getAttributes()
    params.screenBrightness = dimLevel.toFloat()
    window.setAttributes(params)
    window.addFlags(WindowManager.LayoutParams.FLAGS_CHANGED)
    return dimLevel
  }
}
