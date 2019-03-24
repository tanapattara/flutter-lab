import 'package:flutter/material.dart';
import 'package:navigation_with_arguments/data.dart';

class FourthPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> FourthPageState();
}

class FourthPageState extends State<FourthPage>{
  @override
  Widget build(BuildContext context) {   
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Fourth Page"),
      ),
      body: Container(      
        padding: const EdgeInsets.all(30.0),  
        child: Container(
          child:Center(
            child: new Column(
              children: <Widget>[
                Text("Select a result"),
                RaisedButton(
                  child: Text("Male"),
                  onPressed: () {
                    //close and return 'Mail'
                    Navigator.pop(context, 'Male');
                  },
                ),
                RaisedButton(
                  child: Text("Female"),
                  onPressed: () {
                    //close and return 'Femail'
                    Navigator.pop(context, 'Female');
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}