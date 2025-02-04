import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String modelName = '';
  String version = '';

  // current operating system
  String currentOs = '';

  //-- Get Device info method --//
  _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // Determine the current platform using dart:io library
    if (Platform.isAndroid) {
      currentOs = 'Android';
      // get device info
      AndroidDeviceInfo Info = await deviceInfo.androidInfo;
      modelName = Info.model;
      version = Info.version.release;
    } else if (Platform.isIOS) {
      currentOs = 'IOS';
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      modelName = iosInfo.model;
      version = iosInfo.systemVersion;
    }

    setState(() {});
  }

  @override
  void initState() {
    _getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Current operating system
            Text(
              'Running on $currentOs',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 6),
            // Device model and operation system version
            Text(
              'This Device model is $modelName and version is $version',
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
