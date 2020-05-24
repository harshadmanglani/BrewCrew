import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  final CollectionReference brew = Firestore.instance.collection('brews');
  final String uid;
  Database({this.uid});
  Future updateUserData(String sugars, String name, int strength) async{
    return await brew.document(uid).setData({
      'sugars': sugars,
      'name' : name,
      'strength' : strength,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Brew(name: doc.data["name"] ?? "",
      strength: doc.data["strength"] ?? 0,
      sugars: doc.data["sugars"] ?? "");
    }).toList();
  }

  UserData _userDatafromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data["name"],
        sugars: snapshot.data["sugars"],
        strength: snapshot.data["strength"],
    );
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brew.snapshots()
        .map(_brewListfromSnapshot);
  }
  //get user doc stream
    Stream<UserData> get userData{
      return brew.document(uid).snapshots()
          .map(_userDatafromSnapshot);
  }
}