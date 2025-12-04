package com.github.dhia_bechattaoui.flutter_accessibility_helper

import io.flutter.embedding.engine.plugins.FlutterPlugin

class FlutterAccessibilityHelperPluginRegistrant {
    companion object {
        @JvmStatic
        fun registerWith(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
            val plugin = FlutterAccessibilityHelperPlugin()
            plugin.onAttachedToEngine(flutterPluginBinding)
        }
    }
}

