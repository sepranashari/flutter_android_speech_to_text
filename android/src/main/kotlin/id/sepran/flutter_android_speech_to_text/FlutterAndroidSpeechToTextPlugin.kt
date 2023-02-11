package id.sepran.flutter_android_speech_to_text

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.speech.RecognizerIntent
import android.widget.Toast
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

class FlutterAndroidSpeechToTextPlugin :
        FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
    var activity: Activity? = null

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var flutterResult: Result

    override fun onAttachedToEngine(
             flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
    ) {
        channel =
                MethodChannel(
                        flutterPluginBinding.binaryMessenger,
                        "flutter_android_speech_to_text"
                )
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method.equals("getSpeechToText", ignoreCase = true)) {
            flutterResult = result
            val language = call.argument<String>("language")
            val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH)
            intent.putExtra(
                RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM
            )
            intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, language)
            intent.putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 1)
            if (intent.resolveActivity(context.packageManager) != null) {
                activity!!.startActivityForResult(intent, 2342)
            } else {
                Toast.makeText(
                    context,
                    "Your Device Don't Support Speech Input",
                    Toast.LENGTH_SHORT
                ).show()
            }
            return
        }
        result.notImplemented()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == 2342) {
            if (resultCode == Activity.RESULT_OK) {
                val resultList = data!!.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS)
                try {
                    flutterResult.success(resultList!![0])
                } catch (e: Exception) {
                }
                return true
            }
        }
        return false
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}
