import 'package:flutter/material.dart';
import 'package:flutter_study_2/screens/dog_form.dart';
import 'package:flutter_study_2/widgets/dogs_list.dart';

import 'models/dog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Rate Dogs',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(title: 'We Rate Dogs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title}) : super();

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var initialDoggos = <Dog>[]
    ..add(Dog('Ruby', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Dogs who get on furniture.'))
    ..add(Dog('Rex', 'Seattle, WA, USA', 'A Very Good Boy'))
    ..add(Dog('Rod Stewart', 'Prague, CZ', 'A Very Good Boy'))
    ..add(Dog('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'))
    ..add(Dog('Buddy', 'North Pole, Earth', 'A Very Good Boy'));

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: navigateToDogForm, icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.indigo[800]!,
              Colors.indigo[700]!,
              Colors.indigo[600]!,
              Colors.indigo[400]!,
            ],
          ),
        ),
        child: Center(
          child: DogList(initialDoggos),
        ),
      ),
    );
  }

  navigateToDogForm() async {
    Dog? newDog  = await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context){
            return DogForm();
          }
      )
    );

    if(newDog != null){
      initialDoggos.add(newDog);
      setState(() {
      });
    }
  }
}
