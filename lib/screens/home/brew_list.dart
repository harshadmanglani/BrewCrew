import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/screens/home/brew_tile.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/services/database.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];
   // print(brews.documents);
   return ListView.builder(itemBuilder: (context, index){
      return BrewTile(brew: brews[index]);
   }, itemCount: brews.length,);
//    return Container();
  }
}
