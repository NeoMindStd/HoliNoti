package com.neomind.holinoti_customer

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;

class MainActivity: FlutterActivity(), PluginRegistrantCallback {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    FlutterFirebaseMessagingService.setPluginRegistrant(this)
  }

  override fun registerWith(registry: PluginRegistry?) {
    GeneratedPluginRegistrant.registerWith(registry)
  }
}
