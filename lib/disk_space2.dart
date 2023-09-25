
import 'disk_space2_platform_interface.dart';

class DiskSpace2 {
  static Future<double?> get getFreeInternalDiskSpace async {
    return DiskSpace2Platform.instance.getFreeInternalDiskSpace;
  }

  static Future<double?> get getTotalInternalDiskSpace async {
    return DiskSpace2Platform.instance.getTotalInternalDiskSpace;
  }

  static Future<double?> get getFreeExternalDiskSpace async {
    return DiskSpace2Platform.instance.getFreeExternalDiskSpace;
  }

  static Future<double?> get getTotalExternalDiskSpace async {
    return DiskSpace2Platform.instance.getTotalExternalDiskSpace;
  }

  static Future<Map<String, Map<String, dynamic>>> get getAllDirectoryMap async {
    return DiskSpace2Platform.instance.getAllDirectoryMap;
  }

  static Future<double?> getTotalDiskSpaceForPath(String path) async {
    return DiskSpace2Platform.instance.getTotalDiskSpaceForPath(path);
  }

  static Future<double?> getFreeDiskSpaceForPath(String path) async {
    return DiskSpace2Platform.instance.getFreeDiskSpaceForPath(path);
  }
}
