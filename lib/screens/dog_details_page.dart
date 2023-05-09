import 'dart:async';
import 'package:flutter/material.dart';

import '../models/dog.dart';

class DogDetailPage extends StatefulWidget {
  late final Dog dog;

  DogDetailPage(this.dog);

  @override
  _DogDetailPageState createState() =>  _DogDetailPageState();
}

class _DogDetailPageState extends State<DogDetailPage> {
  double dogAvatarSize = 150.0;
  double _sliderValue = -1;

  @override
  Widget build(BuildContext context) {
    if(_sliderValue == -1) _sliderValue = widget.dog.rating.toDouble();

    return  Scaffold(
      backgroundColor: Colors.black87,
      appBar:  AppBar(
        backgroundColor: Colors.black87,
        title:  Text('Meet ${widget.dog.name}'),
      ),
      body:  ListView(
        children: <Widget>[dogProfile, ratingSlider],
      ),
    );
  }

  Widget get ratingSlider{
    return Column(
      children: [
        ratingSliderItem,
        submitRatingButton
      ],
    );
  }

  Widget get ratingSliderItem{
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Slider(
            min: 0.0,
            max: 15.0,
            activeColor: Colors.red,
            inactiveColor: Colors.grey,
            value: _sliderValue,
            onChanged: (value ) => setState(() {
              print(value);
              _sliderValue = value;
            })
          )),
          Padding(padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text("${_sliderValue.toInt()} / 15"),
          )
        ],
      ),
    );
  }

  Widget get submitRatingButton{
    return OutlinedButton(
        onPressed: () => setState(() {
          widget.dog.rating = _sliderValue.toInt();
        }),
        child: Text("Submit Rating"));
  }

  Widget get dogImage {
    return  Hero(
      tag: widget.dog,
      child:  Container(
        height: dogAvatarSize,
        width: dogAvatarSize,
        constraints:  BoxConstraints(),
        decoration:  BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
                offset: Offset(1.0, 2.0),
                blurRadius: 2.0,
                spreadRadius: -1.0,
                color: Color(0x33000000)),
            BoxShadow(
                offset: Offset(2.0, 1.0),
                blurRadius: 3.0,
                spreadRadius: 0.0,
                color: Color(0x24000000)),
            BoxShadow(
                offset: Offset(3.0, 1.0),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                color: Color(0x1F000000)),
          ],
          image:  DecorationImage(
            fit: BoxFit.cover,
            image:  NetworkImage(widget.dog.imageUrl ?? ''),
          ),
        ),
      ),
    );
  }

  Widget get dogProfile {
    return  Container(
      padding:  EdgeInsets.symmetric(vertical: 32.0),
      decoration:  BoxDecoration(
        gradient:  LinearGradient(
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
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          dogImage,
           Text(
            widget.dog.name + '  🎾',
            style:  TextStyle(fontSize: 32.0),
          ),
           Text(
            widget.dog.location,
            style:  TextStyle(fontSize: 20.0),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child:  Text(widget.dog.description),
          ),
          rating
        ],
      ),
    );
  }

  Widget get rating {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         const Icon(
          Icons.star,
          size: 40.0,
        ),
         Text(' ${widget.dog.rating} / 10', style: Theme.of(context).textTheme.displayMedium),
      ],
    );
  }


}
