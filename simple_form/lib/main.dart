import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySimpleForm(),      
    );
  }
}

class MySimpleForm extends StatefulWidget {
  @override
  MySimpleFormState createState() => MySimpleFormState();
}
class MySimpleFormState extends State<MySimpleForm> {
  
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  String _type = 'One';

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: 'Name'
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please add some value';
                  }
                },
              ),
              TextFormField(
                controller: myController2,
                decoration: InputDecoration(
                  labelText: 'Major'
                ),
              ),
              yearField(context),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your university (optional)'  
                ),
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(_formKey.currentState.validate()){
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    myController.text + " " + myController2.text
                  ),
                );
              },
            );             
          }
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.save),
      ),
    );
  }
  TextFormField yearField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,        
      validator: (value) {
        if (value.length == 0 ) {
          return ('Enter your year');
        }
        if(int.parse(value) > 2562){
          return ('Wrong number');
        }
      }, 
      decoration: InputDecoration(
        hintText: 'Year',
        icon: Icon(Icons.person_outline),
        fillColor: Colors.white,
      ),
    );
  }  
}
  
