import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Score',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Score')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    //return _buildList(context, dummySnapshot);
    //get actual snapshot from Cloud Firestore
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('students').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot  data) {
    final record = Student.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.score.toString()),
          //onTap: () => print(record),
          //onTap: () => record.reference.updateData({'Score': record.score + 1}),
//          onTap: () => Firestore.instance.runTransaction((transaction) async {
//            final freshSnapshot = await transaction.get(record.reference);
//            final fresh = Record.fromSnapshot(freshSnapshot);
//            await transaction.update(record.reference, {'Score': fresh.score + 1});
//          }),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>Profile(),
                    settings: RouteSettings(
                      arguments: record
                    )
                )
            );
          },
          //onLongPress: () => record.reference.updateData({'Score': record.score - 1}),
        ),
      ),
    );
  }
}

class Profile extends StatefulWidget{
  @override
  _ProfileState createState(){
    return _ProfileState();
  }
}
class _ProfileState extends State<Profile> {
  Student student;
  @override
  Widget build(BuildContext context) {
    student = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Student Profile')),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ProfilePic(context),
              NameLabel(context),
              ButtonScore(context),
            ],
          )
      ),
    );
  }

  Text NameLabel(BuildContext contex){
    return Text(
      student.name,
      style: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }

  Container ProfilePic(BuildContext context) {
    return new Container(
        padding: const EdgeInsets.only(top: 40.0),
        width: 190.0,
        height: 190.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: new NetworkImage(student.img)
          )
        )
    );
  }

  ButtonBar ButtonScore(BuildContext context) {
    return new ButtonBar(
      mainAxisSize: MainAxisSize.min,
      // this will take space as minimum as posible(to center)
      children: <Widget>[
        new RaisedButton(
          child: new Text('-'),
          color: Colors.red,
          textColor: Colors.white,
          onPressed: (){
            Firestore.instance.runTransaction((transaction) async {
              final freshSnapshot = await transaction.get(student.reference);
              final fresh = Student.fromSnapshot(freshSnapshot);
              await transaction.update(student.reference, {'Score': fresh.score - 1});
            });
          },
        ),
        new RaisedButton(
          child: new Text('+'),
          textColor: Colors.white,
          color: Colors.green,
          onPressed: (){
            Firestore.instance.runTransaction((transaction) async {
              final freshSnapshot = await transaction.get(student.reference);
              final fresh = Student.fromSnapshot(freshSnapshot);
              await transaction.update(student.reference, {'Score': fresh.score + 1});
            });
          },
        ),
      ],
    );
  }
}

class Student {
  final String name;
  final int score;
  final String img;
  final DocumentReference reference;

  Student.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Name'] != null),
        assert(map['Score'] != null),
        assert(map['img'] != null),
        name = map['Name'], score = map['Score'], img = map['img'];

  Student.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$score:$img>";
}
