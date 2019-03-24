import 'package:flutter/material.dart';
import 'package:navigation_with_arguments/data.dart';

class ThirdPage extends StatefulWidget{
  
  final AppdataArguments argData;
  
  ThirdPage({
    Key key,
    @required this.argData,
  }):super(key:key);
  
  @override
  State<StatefulWidget> createState()=> ThirdPageState(argData);
}

class ThirdPageState extends State<ThirdPage>{
  
  AppdataArguments argData;
  ThirdPageState(this. argData);

  @override
  Widget build(BuildContext context) {   
 
    return Scaffold(
      appBar: AppBar(
        title: Text("Third Page"),
      ),
      body: Center(
        child: Text(argData.message),
      ),
    );
  }

}