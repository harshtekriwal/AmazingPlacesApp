import 'package:GreatLocations/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLoction;
  final bool isSelecting;
  MapScreen(
      {this.initialLoction =
          const PlaceLocation(latitude: 37.422, longitude: -122.084),
      this.isSelecting = false});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedPosition;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPosition);
                    },
            )
        ],
        title: Text('Your Map'),
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.initialLoction.latitude,
                  widget.initialLoction.longitude),
              zoom: 16),
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: (_pickedPosition == null && widget.isSelecting)
              ? null
              : {Marker(markerId: MarkerId('m1'), position: 
              _pickedPosition?? LatLng(widget.initialLoction.latitude,widget.initialLoction.longitude),
              )}),
    );
  }
}
 