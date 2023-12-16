package com.agentslx.flutter.disk_space2

import android.os.Build
import android.os.Environment
import android.os.StatFs
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject
import java.io.File

/** DiskSpace2Plugin */
class DiskSpace2Plugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "disk_space2")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "getFreeInternalDiskSpace" -> result.success(getFreeDiskSpaceForPath(Environment.getRootDirectory().path))
      "getTotalInternalDiskSpace" -> result.success(getTotalDiskSpaceForPath(Environment.getRootDirectory().path))
      "getFreeExternalDiskSpace" -> result.success(getFreeDiskSpaceForPath(Environment.getExternalStorageDirectory().path))
      "getTotalExternalDiskSpace" -> result.success(getTotalDiskSpaceForPath(Environment.getExternalStorageDirectory().path))
      "getAllDirectoryMap" -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
        result.success(getAllDirectoryMap())
      } else {
        result.success(JSONObject())
      }
      "getFreeDiskSpaceForPath" -> result.success(getFreeDiskSpaceForPath(call.argument<String>("path")!!))
      "getTotalDiskSpaceForPath" -> result.success(getFreeDiskSpaceForPath(call.argument<String>("path")!!))
      else -> result.notImplemented()
    }
  }

  private fun getFreeDiskSpaceForPath(path: String): Double {
    val stat = StatFs(path)

    val bytesAvailable: Long = stat.blockSizeLong * stat.availableBlocksLong
    return bytesAvailable.toDouble()
  }

  private fun getTotalDiskSpaceForPath(path: String): Double {
    val stat = StatFs(path)

    val bytesAvailable: Long = stat.blockSizeLong * stat.blockCountLong
    return bytesAvailable.toDouble()
  }

  @RequiresApi(Build.VERSION_CODES.R)
  private fun getAllDirectoryMap(): JSONObject {
    val path = Environment.getStorageDirectory().path
    val stat = StatFs(path)

    // Loop through all directories
    val root = File(path)
    val dirs = root.listFiles()
    val map = JSONObject()
    Log.i("DiskSpace", "dirs: $dirs")
    if (dirs != null) {
      for (dir in dirs) {
        val dirStat = JSONObject()
        val bytesAvailable: Long = stat.blockSizeLong * stat.availableBlocksLong
        dirStat.put("free", bytesAvailable.toDouble())
        val bytesTotal: Long = stat.blockSizeLong * stat.blockCountLong
        dirStat.put("total", bytesTotal.toDouble())
        map.put(dir.name, dirStat)
      }
    }
    return map
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
