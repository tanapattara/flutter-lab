import 'package:flutter/material.dart';
import 'package:navigation_with_arguments/data.dart';

class SecoundPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> SecoundPageState();
}

class SecoundPageState extends State<SecoundPage>{
  @override
  Widget build(BuildContext context) {   
    final AppdataArguments args = ModalRoute.of(context).settings.arguments;
 
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Center(
        child: Text(args.title + " " + args.message),
      ),
    );
  }

}