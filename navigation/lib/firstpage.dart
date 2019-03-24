import 'package:flutter/material.dart';
import 'package:navigation/secoundpage.dart';

class FirstPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> FirstPageState();
}

class FirstPageState extends State<FirstPage>{
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecoundPage()),
              );
          },
          child: Text('Go to secound page'),
        ),
      ),
    );
  }

}