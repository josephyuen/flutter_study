package com.pym.flutterstudy

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)


    /**
     *   Flutter 调用原生方法，MethodHandler;话说  kotlin还是用得爽哈
     */
    MethodChannel(flutterView, "android_app_retain").apply {
      setMethodCallHandler { method, result ->
        if (method.method == "sendToBackground") {
          moveTaskToBack(true)
        }
      }
    }

  }
}
