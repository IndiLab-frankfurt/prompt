package de.dipf.prompt

import android.app.usage.NetworkStats
import android.content.Intent
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.IntentFilter
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import androidx.annotation.RequiresApi
import de.dipf.prompt.NetworkStats.queryNetworkUsageStats
import io.flutter.plugin.common.MethodCall

class MainActivity: FlutterActivity() {
    private val CHANNEL = "prompt.dipf.de/usage";

    @RequiresApi(VERSION_CODES.LOLLIPOP)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            this.onMethodCall(call, result)
        }
    }

    @RequiresApi(VERSION_CODES.LOLLIPOP)
    fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method) {
            "getBatteryLevel" -> {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            }
            "queryUsageStats" -> {
                val start: Long = call.argument<Long>("start") as Long
                val end: Long = call.argument<Long>("end") as Long
                result.success(UsageStats.queryUsageStats(this.context, start, end))
            }
            "grantUsagePermission" -> {
                Utils.grantUsagePermission(this.context)
            }
            "queryNetworkUsageStats" -> {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    val start: Long = call.argument<Long>("start") as Long
                    val end: Long = call.argument<Long>("end") as Long
                    /*
                    GlobalScope.launch(Dispatchers.Main) {
                        val netResult = withContext(Dispatchers.IO) {
                            NetworkStats.queryNetworkUsageStats(
                                    context = this.context!!,
                                    startDate = start,
                                    endDate = end
                            )
                        }
                        result.success(netResult)
                    }

                     */
                } else {
                    result.error(
                            "API Error",
                            "Requires API Level 23",
                            "Target should be set to 23 to use this API"
                    )
                }

            }
            else -> {
                result.notImplemented()
            }
        }
    }


    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }


}
