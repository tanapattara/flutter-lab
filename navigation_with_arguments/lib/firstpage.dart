import 'package:flutter/material.dart';
import 'package:navigation_with_arguments/data.dart';
import 'package:navigation_with_arguments/fourthpage.dart';
import 'package:navigation_with_arguments/secoundpage.dart';
import 'package:navigation_with_arguments/thirdpage.dart';

class FirstPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> FirstPageState();
}

class FirstPageState extends State<FirstPage>{
  final inputTextField = TextEditingController();
  BuildContext scaffoldContext; 
  @override
  Widget build(BuildContext context) {        
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Container (
         padding: const EdgeInsets.all(30.0),
         child: Container(
           child: new Column(
            children: <Widget>[
              TextField(
                controller: inputTextField,
                decoration: InputDecoration(
                  labelText: "Data",
                  hintText: 'Put your data to passing data to next page',
                ),
              ),
              RaisedButton(
                child: Text("Sent this data to Secound page."),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecoundPage(),
                      settings: RouteSettings(
                        arguments: AppdataArguments(
                          'Hello Flutter,',
                          inputTextField.text,
                        ),
                      ),
                    ),
                  );
                },
              ),
              RaisedButton(
                child: Text("Sent this data to Third page"),
                onPressed: (){
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThirdPage(
                        argData: new AppdataArguments(
                          "", inputTextField.text)),
                    ),
                  );
                },
              ),
              RaisedButton(
                child: Text('Receive data from fourth page'),
                onPressed: (){
                  _navigateAndDisplaySelection(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FourthPage()),
    );
    createSnackBar(result.toString());
  }
  void createSnackBar(String message) {                                                                               
    final snackBar = new SnackBar(
      content: new Text(message),                                                         
      backgroundColor: Colors.blue
    );                                                                                      
    
    Scaffold.of(context).showSnackBar(snackBar);                                                              
  }  
}