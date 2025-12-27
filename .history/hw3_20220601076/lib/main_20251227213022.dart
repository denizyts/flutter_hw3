import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hw3_20220601076',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'HW4444 - 2022061076'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum big_drop_selection {all, text, check, drop}

class _MyHomePageState extends State<MyHomePage> {
  
  bool _IsChecked = false;
  bool _DropDownValue = false;
  final _textEditingController = TextEditingController();
  List _sendedValues = [];
  final _formKey = GlobalKey<FormState>();
  var _bigDropSelection = big_drop_selection.all;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: .start,
          children: [
            DropdownButton<big_drop_selection>(
              value: 
              items: [
                  DropdownMenuItem(
                    value: big_drop_selection.all,
                    child: Text('all')
                  ),
                  DropdownMenuItem(
                    value: big_drop_selection.text,
                    child: Text('text')
                  ),
                  DropdownMenuItem(
                    value: big_drop_selection.check,
                    child: Text('check')
                  ),
                  DropdownMenuItem(
                    value: big_drop_selection.drop,
                    child: Text('drop')
                  )
                ],
              onChanged: (value) {
                _bigDropSelection = value!;
              },
            ),
            
            ...switch (_bigDropSelection) {
              big_drop_selection.text => [_getTextForm()],
              big_drop_selection.check => [_getCheckBox()],
              big_drop_selection.drop => [_getDropdown()],
              big_drop_selection.all => [_getTextForm(), _getCheckBox(), _getDropdown()]
            },
            _getElevatedButton(),
            _getResultColumn()
          ],
        ),
      ),
    );
  }

  Checkbox _getCheckBox() {
    return Checkbox(
              value: _IsChecked, 
              onChanged: (value){
                setState(() {
                  _IsChecked = value!;
                });
              }
            );
  }

  DropdownButton<bool> _getDropdown() {
    return DropdownButton<bool>(
              value: _DropDownValue,
                items: [
                  DropdownMenuItem(
                    value: true,
                    child: Text('Yes')
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text('No')
                    )
                ],
                onChanged: (value){
                  setState(() {
                    _DropDownValue = value!;
                  });
                }
              );
  }

  ElevatedButton _getElevatedButton() {
    return ElevatedButton(
              onPressed: (){
                setState(() {
                  if(_formKey.currentState!.validate()){
                  _sendedValues.add(_textEditingController.text);
                  }
                });
              }, 
              child: 
                Text(
                  "Send",
                  selectionColor: Colors.blue,
                )
            );
  }

  Column _getResultColumn () {
    return Column(
              children: [
                for(String e in _sendedValues)
                  Text(e)
              ],
            );
  }

    Form _getTextForm () {
      return Form(
              key:_formKey,
              child: 
                TextFormField(
                  decoration: 
                    const InputDecoration(
                      labelText: 'Text'
                  ),
                  controller: _textEditingController,
                  validator: (value) {
                    if(value == "" || value == null){
                      return "INPUTCANNOT BE EMPTY";
                    } 
                    if(value!.length < 3){
                      return "INPUT SIZE MUST BE GREATER THAN 3";
                    }

                    return null;
                  },
                  // key: _formKey
                ),
              );
    }
}
