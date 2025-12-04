package com.github.dhia_bechattaoui.flutter_accessibility_helper

import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Context
import android.content.res.Configuration
import android.os.Build
import android.view.accessibility.AccessibilityManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class FlutterAccessibilityHelperPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var context: Context? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "flutter_accessibility_helper"
        )
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "getAccessibilityDetails" -> {
                try {
                    val details = getAccessibilityDetails()
                    result.success(details)
                } catch (e: Exception) {
                    result.error("ERROR", "Failed to get accessibility details: ${e.message}", null)
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun getAccessibilityDetails(): Map<String, Any?> {
        val details = mutableMapOf<String, Any?>()
        val ctx = context ?: return details

        val accessibilityManager =
            ctx.getSystemService(Context.ACCESSIBILITY_SERVICE) as? AccessibilityManager

        // Check if accessibility services are enabled
        val isAccessibilityEnabled = accessibilityManager?.isEnabled ?: false
        details["isAccessibilityEnabled"] = isAccessibilityEnabled

        // Check for TalkBack (most common screen reader on Android)
        val enabledServices = accessibilityManager?.getEnabledAccessibilityServiceList(
            AccessibilityServiceInfo.FEEDBACK_SPOKEN
        ) ?: emptyList()
        val hasTalkBack = enabledServices.isNotEmpty()
        details["hasTalkBack"] = hasTalkBack
        details["hasScreenReader"] = hasTalkBack

        // Get configuration for font scale and other settings
        val config = ctx.resources.configuration

        // Font scale (text size) - this is accurate!
        val fontScale = config.fontScale
        details["fontScale"] = fontScale.toDouble()
        details["textSizeIncreased"] = fontScale > 1.0f

        // Check for invert colors using Settings.Secure
        var invertColors = false
        try {
            val invertSetting = android.provider.Settings.Secure.getInt(
                ctx.contentResolver,
                android.provider.Settings.Secure.ACCESSIBILITY_DISPLAY_INVERSION_ENABLED,
                0
            )
            invertColors = invertSetting == 1
        } catch (e: Exception) {
            // Some devices may not support this setting
        }
        details["invertColors"] = invertColors

        // Check for high contrast
        var highContrast = false
        try {
            // Some manufacturers have custom high contrast settings
            // Check for common indicators
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                // Try to detect via color correction or other settings
                val colorCorrection = android.provider.Settings.Secure.getInt(
                    ctx.contentResolver,
                    "accessibility_display_daltonizer_enabled",
                    0
                )
                highContrast = colorCorrection == 1
            }
        } catch (e: Exception) {
            // Not all devices support this
        }
        
        // Alternative: Check if font scale is very high (often indicates high contrast needs)
        if (fontScale > 1.3f) {
            highContrast = true
        }
        details["highContrast"] = highContrast

        // Bold text detection
        // On Android 12+ (API 31+), we can use fontWeightAdjustment
        // For older versions, Flutter's AccessibilityFeatures.boldText is more reliable
        var boldText: Boolean? = null
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                // Android 12+ (API 31+) has fontWeightAdjustment in Configuration
                // A positive value indicates bold text is enabled
                val fontWeightAdjustment = config.fontWeightAdjustment
                boldText = fontWeightAdjustment > 0
            }
            // For older Android versions, we don't set boldText here
            // so Flutter's AccessibilityFeatures.boldText will be used instead
        } catch (e: Exception) {
            // If detection fails, let Flutter's API handle it
            boldText = null
        }
        // Only set boldText if we have a reliable detection (Android 12+)
        if (boldText != null) {
            details["boldText"] = boldText
        }

        // Check for reduce motion / animations
        var reduceMotion = false
        var disableAnimations = false
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
                val animatorScale = android.provider.Settings.Global.getFloat(
                    ctx.contentResolver,
                    android.provider.Settings.Global.ANIMATOR_DURATION_SCALE,
                    1.0f
                )
                val transitionScale = android.provider.Settings.Global.getFloat(
                    ctx.contentResolver,
                    android.provider.Settings.Global.TRANSITION_ANIMATION_SCALE,
                    1.0f
                )
                val windowScale = android.provider.Settings.Global.getFloat(
                    ctx.contentResolver,
                    android.provider.Settings.Global.WINDOW_ANIMATION_SCALE,
                    1.0f
                )
                reduceMotion = animatorScale == 0.0f || transitionScale == 0.0f
                disableAnimations = animatorScale == 0.0f && transitionScale == 0.0f && windowScale == 0.0f
            }
        } catch (e: Exception) {
            // Ignore
        }
        details["reduceMotion"] = reduceMotion
        details["disableAnimations"] = disableAnimations

        // Accessible navigation (when using accessibility services for navigation)
        details["accessibleNavigation"] = hasTalkBack || isAccessibilityEnabled

        return details
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        context = null
    }
}
