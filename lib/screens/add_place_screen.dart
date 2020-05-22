import 'dart:io';

import 'package:GreatLocations/models/place.dart';
import 'package:GreatLocations/providers/great_places.dart';
import 'package:GreatLocations/widgets/image_input.dart';
import 'package:GreatLocations/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }
  void _selectPlace(double lat, double lng){
    _pickedLocation=PlaceLocation(latitude: lat, longitude: lng);
  }
  Future<void> _savePlace() async {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_pickedImage.path);
    _pickedImage = await _pickedImage.copy('${appDir.path}/$fileName');
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage,_pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add a new Place'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(labelText: 'Title'),
                          controller: _titleController,
                        ),
                        SizedBox(height: 10),
                        ImageInput(_selectImage),
                        SizedBox(height: 10),
                        LocationInput(_selectPlace),
                      ],
                    ),
                  ),
                ),
              ),
              RaisedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Add Place'),
                onPressed: () {
                  _savePlace();
                },
                elevation: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: Theme.of(context).accentColor,
              ),
            ]));
  }
}
