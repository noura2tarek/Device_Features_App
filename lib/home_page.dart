import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  //------- Cairo position -------//
  static CameraPosition _kCairo(bool isZoom) {
    return CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(30.033333, 31.233334),
        tilt: 59.440717697143555,
        zoom: isZoom ? 13.151926040649414 : 8.151926040649414,
      );
  }

  bool isZoomed = false;

  //----  Toggle Zoom Cairo Position Method -----//
  Future<void> _zoomCairoEgypt() async {
    setState(() {
      isZoomed = !isZoomed;
    });
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_kCairo(isZoomed)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // google maps title
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: CustomGoogleMapWidget(
          initialPosition: _kCairo(false),
          isZoomed: isZoomed,
          zoomFunction: _zoomCairoEgypt,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }),
    );
  }
}

////////////////////////////////
//---- Custom Google Map Widget -----//
class CustomGoogleMapWidget extends StatelessWidget {
  const CustomGoogleMapWidget({
    super.key,
    this.onMapCreated,
    required this.isZoomed,
    required this.initialPosition,
    this.zoomFunction,
  });

  final CameraPosition initialPosition;
  final void Function(GoogleMapController)? onMapCreated;
  final bool isZoomed;
  final void Function()? zoomFunction;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      // initial camera position to cairo
      initialCameraPosition: initialPosition,
      zoomControlsEnabled: false,
      markers: {
        // Add red marker on Cairo
        Marker(
          markerId: const MarkerId('Cairo'),
          infoWindow: InfoWindow(
            title: isZoomed ? 'Cairo' : 'Cairo - Egypt',
            snippet: isZoomed ? 'Egypt' : ' Zooming.. ',
          ),
          // toggle camera zoom
          onTap: zoomFunction,
          // Cairo position:  lat 30.033333 lng 31.233334
          position: const LatLng(30.033333, 31.233334),
        ),
      },
      onMapCreated: onMapCreated,
    );
  }
}
