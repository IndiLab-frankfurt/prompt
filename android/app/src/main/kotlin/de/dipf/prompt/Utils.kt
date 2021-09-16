package de.dipf.prompt

import android.Manifest
import android.app.AppOpsManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Process
import android.provider.Settings
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat


// Taken directly from https://github.com/tadashiokoshi/usage_stats/blob/master/android/src/main/kotlin/io/github/parassharmaa/usage_stats/Utils.kt
object Utils {

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun isUsagePermission(context: Context): Boolean {
        val appOps = context.getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager?
        val mode = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.Q) {
            appOps!!.unsafeCheckOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS, Process.myUid(), context.packageName)
        } else {
            appOps!!.checkOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS, Process.myUid(), context.packageName)
        }
        if (mode == AppOpsManager.MODE_ALLOWED) {
            Log.d("UTILS", "Usage permission is granted")
            return true
        }
        Log.d("UTILS", "Usage permission is not granted")
        return false
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun grantUsagePermission(context: Context) {
        if (!isUsagePermission(context)) {
            val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            context.startActivity(intent)
        }
    }
}