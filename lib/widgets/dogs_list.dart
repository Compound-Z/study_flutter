import 'package:flutter/material.dart';

import '../models/dog.dart';
import 'dog_card.dart';

class DogList extends StatelessWidget {
  final List<Dog> doggos;

  DogList(this.doggos);

  ListView _buildList(context) {
    return  ListView.builder(
      itemCount: doggos.length,
      itemBuilder: (context, idx) {
        return  DogCard(doggos[idx]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}