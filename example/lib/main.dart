import 'package:disk_space2/disk_space2.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic>? storageStat;


  @override
  void initState() {
    super.initState();
    initDiskSpace();
  }

  Future<void> initDiskSpace() async {
    final directorySpace = {
      "InternalFree": await DiskSpace2.getFreeInternalDiskSpace,
      "InternalTotal": await DiskSpace2.getTotalInternalDiskSpace,
      "ExternalFree": await DiskSpace2.getFreeExternalDiskSpace,
      "ExternalTotal": await DiskSpace2.getTotalExternalDiskSpace,
    };

    setState(() {
      storageStat = directorySpace;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var key = storageStat!.keys.elementAt(index);
                  var value = storageStat![key];
                  return Text('$key: $value');
                },
                itemCount: storageStat?.keys.length??0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
