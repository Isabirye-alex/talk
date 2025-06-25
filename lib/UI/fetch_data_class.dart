import 'package:flutter/material.dart';

class FetchDataClass extends StatefulWidget {
  const FetchDataClass({super.key});

  @override
  State<FetchDataClass> createState() => _FetchDataClassState();
}

class _FetchDataClassState extends State<FetchDataClass> {
  @override
  Widget build(BuildContext context) {
    return Center(child: FloatingActionButton(onPressed: () {}, child: Icon(Icons.send),
    ),
    );
  }
}
