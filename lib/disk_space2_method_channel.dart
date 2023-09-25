import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'disk_space2_platform_interface.dart';

/// An implementation of [DiskSpace2Platform] that uses method channels.
class MethodChannelDiskSpace2 extends DiskSpace2Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final _channel = const MethodChannel('disk_space2');

  @override
  Future<double?> get getFreeInternalDiskSpace async {
    final double? freeDiskSpace = await _channel.invokeMethod('getFreeInternalDiskSpace');
    return freeDiskSpace;
  }

  @override
  Future<double?> get getTotalInternalDiskSpace async {
    final double? freeDiskSpace = await _channel.invokeMethod('getTotalInternalDiskSpace');
    return freeDiskSpace;
  }

  @override
  Future<double?> get getFreeExternalDiskSpace async {
    final double? totalDiskSpace = await _channel.invokeMethod('getFreeExternalDiskSpace');
    return totalDiskSpace;
  }

  @override
  Future<double?> get getTotalExternalDiskSpace async {
    final double? totalDiskSpace = await _channel.invokeMethod('getTotalExternalDiskSpace');
    return totalDiskSpace;
  }

  @override
  Future<Map<String, Map<String, dynamic>>> get getAllDirectoryMap async {
    return await _channel.invokeMethod('getAllDirectoryMap');
  }

  @override
  Future<double?> getTotalDiskSpaceForPath(String path) async {
    if (!Directory(path).existsSync()) {
      throw Exception("Specified path does not exist");
    }
    final double? freeDiskSpace = await _channel.invokeMethod('getTotalDiskSpaceForPath', {"path": path});
    return freeDiskSpace;
  }

  @override
  Future<double?> getFreeDiskSpaceForPath(String path) async {
    if (!Directory(path).existsSync()) {
      throw Exception("Specified path does not exist");
    }
    final double? freeDiskSpace = await _channel.invokeMethod('getFreeDiskSpaceForPath', {"path": path});
    return freeDiskSpace;
  }
}
