import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'disk_space2_method_channel.dart';

abstract class DiskSpace2Platform extends PlatformInterface {
  /// Constructs a DiskSpace2Platform.
  DiskSpace2Platform() : super(token: _token);

  static final Object _token = Object();

  static DiskSpace2Platform _instance = MethodChannelDiskSpace2();

  /// The default instance of [DiskSpace2Platform] to use.
  ///
  /// Defaults to [MethodChannelDiskSpace2].
  static DiskSpace2Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DiskSpace2Platform] when
  /// they register themselves.
  static set instance(DiskSpace2Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<double?> get getFreeInternalDiskSpace;

  Future<double?> get getTotalInternalDiskSpace;

  Future<double?> get getFreeExternalDiskSpace;

  Future<double?> get getTotalExternalDiskSpace;

  Future<Map<String, Map<String, dynamic>>> get getAllDirectoryMap;

  Future<double?> getTotalDiskSpaceForPath(String path);

  Future<double?> getFreeDiskSpaceForPath(String path);
}
