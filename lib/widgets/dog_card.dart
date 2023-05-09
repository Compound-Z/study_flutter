import 'package:flutter/material.dart';

import '../models/dog.dart';
import '../screens/dog_details_page.dart';

class DogCard extends StatefulWidget {
  late final Dog dog;

  DogCard(this.dog);

  @override
  DogCardState createState() {
    return  DogCardState(dog);
  }
}

class DogCardState extends State<DogCard> {
  late Dog dog;
  String? renderUrl;

  DogCardState(this.dog);

  void initState() {
    super.initState();
    renderDogPic();
  }

  void renderDogPic() async {
    await dog.getImageUrl();
    setState(() {
      renderUrl = dog.imageUrl;
    });
  }

  Widget get dogImage {
    var dogAvatar =  Hero(
      tag: dog,
      child:  Container(
        width: 100.0,
        height: 100.0,
        decoration:  BoxDecoration(
          shape: BoxShape.circle,
          image:  DecorationImage(
            fit: BoxFit.cover,
            image:  NetworkImage(renderUrl ?? ''),
          ),
        ),
      ),
    );

    var placeholder =  Container(
      width: 100.0,
      height: 100.0,
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        gradient:  LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black54, Colors.black, Colors.blueGrey[600]!],
        ),
      ),
      alignment: Alignment.center,
      child:  Text(
        'DOGGO',
        textAlign: TextAlign.center,
      ),
    );

    var crossFade =  AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: dogAvatar,
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration:  Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  Widget get dogCard {
    return  Positioned(
      right: 0.0,
      child:  Container(
        width: 290.0,
        height: 115.0,
        child:  Card(
          color: Colors.black87,
          child:  Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 64.0,
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                 Text(
                  widget.dog.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                 Text(
                  widget.dog.location,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                 Row(
                  children: <Widget>[
                     Icon(
                      Icons.star,
                    ),
                     Text(': ${widget.dog.rating} / 10')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () => showDogDetailPage(),
      child:  Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child:  Container(
          height: 115.0,
          child:  Stack(
            children: <Widget>[
              dogCard,
               Positioned(
                top: 7.5,
                child: dogImage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDogDetailPage() async {
    await Navigator.of(context).push( MaterialPageRoute(
      builder: (context) {
        return  DogDetailPage(dog);
      },
    ));
    setState(() {});
  }
}
