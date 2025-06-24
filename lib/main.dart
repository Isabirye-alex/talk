import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk/UI/fetch_data_class.dart';

void main() async {
  runApp(Talk());
}
 class Talk extends StatelessWidget {
  const Talk({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: FetchDataClass(),
    );
  }
}