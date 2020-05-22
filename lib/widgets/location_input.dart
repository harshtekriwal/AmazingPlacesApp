import 'package:GreatLocations/helpers/location_helper.dart';
import 'package:GreatLocations/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  void _changeImageUrl(double latitude, double longitude) {
    final staticMapImageUrl = LocationHelper.generateImageLocation(
        latitude: latitude, longitude: longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl; 
    });
    widget.onSelectPlace(latitude,longitude);
  }

  Future<void> _getUserCurrentLocation() async {
    try{
    final locData = await Location().getLocation();
    _changeImageUrl(locData.latitude, locData.longitude);
    }
    catch(error){
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) {
      return;
    }
    _changeImageUrl(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text('No Location Chosen.', textAlign: TextAlign.center)
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: () {
                _getUserCurrentLocation();
              },
              icon: Icon(Icons.location_on),
              label: Text(
                'Current Location',
              ),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: () {
                _selectOnMap();
              },
              icon: Icon(Icons.map),
              label: Text(
                'Select On Map',
              ),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
