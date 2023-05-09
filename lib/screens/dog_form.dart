import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/dog.dart';

class DogForm extends StatefulWidget{
  Dog? dog;

  @override
  _DogFormState createState() {
    return _DogFormState();
  }
}

class _DogFormState extends State<DogForm>{
  TextEditingController txtNameCtrl = TextEditingController();
  TextEditingController txtLocationCtrl = TextEditingController();
  TextEditingController txtDescriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new pup"),
        actions: [
        ],
      ),
      body: dogForm,
    );
  }

  Widget get dogForm{
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 8),
              child: TextField(
                controller: txtNameCtrl,
                onChanged: (value) => {
                  txtNameCtrl.text = value,
                  txtNameCtrl.selection = TextSelection.collapsed(offset: txtNameCtrl.text.length)
                },
                decoration: InputDecoration( hintText: "Pub's name:"),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 8),
              child: TextField(
                controller: txtLocationCtrl,
                onChanged: (value) => {
                  txtLocationCtrl.text = value,
                  txtLocationCtrl.selection = TextSelection.collapsed(offset: txtLocationCtrl.text.length)
                },
                decoration: InputDecoration( hintText: "Pub's location:"),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 8),
              child: TextField(
                controller: txtDescriptionCtrl,
                onChanged: (value) => {
                  txtDescriptionCtrl.text = value,
                  txtDescriptionCtrl.selection = TextSelection.collapsed(offset: txtDescriptionCtrl.text.length)
                },
                decoration: InputDecoration( hintText: "All about the pup:"),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 8),
              child: Builder(
                  builder: (context) {
                    return FilledButton(
                        onPressed: handleAddPup,
                        child: const Text("Add pup"),
                    );
                  }
              )
            ),
          ],
        ));
  }

  handleAddPup() {
    if(txtNameCtrl.text.isEmpty){
      print("Pup's name is empty!!!");
      return;
    }

    Dog newDog = Dog(txtNameCtrl.text, txtLocationCtrl.text, txtDescriptionCtrl.text);
    Navigator.of(context).pop(newDog);
  }
}