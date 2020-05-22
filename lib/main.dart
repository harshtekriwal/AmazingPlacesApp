import 'package:GreatLocations/providers/great_places.dart';
import 'package:GreatLocations/screens/add_place_screen.dart';
import 'package:GreatLocations/screens/place_details_screen.dart';
import 'package:GreatLocations/screens/place_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
          value: GreatPlaces(),
          child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName:(ctx)=>AddPlaceScreen(),
          PlaceDetailsScreen.routeName:(ctx)=>PlaceDetailsScreen(),
        },
      ),
    );
  }
}
