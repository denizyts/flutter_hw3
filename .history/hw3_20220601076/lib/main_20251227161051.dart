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
      home: const MyHomePage(title: 'HW3 - 2022061076'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  bool _IsChecked = false;
  bool _DropDownValue = false;
  final _textEditingController = TextEditingController();
  List _sendedValues = [];

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
            ),
            Checkbox(
              value: _IsChecked, 
              onChanged: (value){
                setState(() {
                  _IsChecked = value!;
                });
              }
            ),
            DropdownButton<bool>(
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
            ),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _sendedValues.add(_textEditingController.text);
                });
              }, 
              child: 
                Text(
                  "Send",
                  selectionColor: Colors.blue,
                )
            ),
            Column(
              children: [
                for(const e: _sendedValues)
              ],
            )
          ],
        ),
      ),
    );
  }
}
