import 'package:flutter/material.dart';

class SecoundPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> SecoundPageState();
}

class SecoundPageState extends State<SecoundPage>{
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
              Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }

}