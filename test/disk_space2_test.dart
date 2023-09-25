import 'package:flutter_test/flutter_test.dart';
import 'package:disk_space2/disk_space2.dart';
import 'package:disk_space2/disk_space2_platform_interface.dart';
import 'package:disk_space2/disk_space2_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDiskSpace2Platform
    with MockPlatformInterfaceMixin
    implements DiskSpace2Platform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DiskSpace2Platform initialPlatform = DiskSpace2Platform.instance;

  test('$MethodChannelDiskSpace2 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDiskSpace2>());
  });

  test('getPlatformVersion', () async {
    DiskSpace2 diskSpace2Plugin = DiskSpace2();
    MockDiskSpace2Platform fakePlatform = MockDiskSpace2Platform();
    DiskSpace2Platform.instance = fakePlatform;

    expect(await diskSpace2Plugin.getPlatformVersion(), '42');
  });
}
