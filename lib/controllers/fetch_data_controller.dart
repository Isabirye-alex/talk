import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk/controllers/timer_controller.dart';
import 'package:talk/models/ussd_view_object.dart';
import 'package:http/http.dart' as http;

class FetchDataController extends StatefulWidget {
  const FetchDataController({super.key});

  @override
  State<FetchDataController> createState() => _FetchDataControllerState();
}

class _FetchDataControllerState extends State<FetchDataController> {
  String sessionText = '';
  final String currentInput = '';
  late Future<UssdViewObject> _futureResults;
  final inputController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    sessionText = inputController.text.trim();
    _loadInitialData();
  }

  void _loadInitialData() {
    isLoading = true;
    _futureResults = sendUssdRequestWithResponse(sessionText);
  }

  Future<UssdViewObject> sendUssdRequestWithResponse(String userInput) async {
    try {
      final respone = await http.post(
        Uri.parse('https://newtest.mcash.ug/wallet/api/client/ussd'),
      );

      if (respone.statusCode == 200 || respone.statusCode == 201) {
        return UssdViewObject.fromUssdString(
          respone.body,
          phoneNumber: '256706432259',
        );
      } else {
        throw Exception('Failed to connect : ${respone.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: Here is the error code $e');
    } finally {
      isLoading = false;
    }
  }

  FutureBuilder<UssdViewObject> buildFutureBuilder(BuildContext context) {
    final timerController = Get.put(TimerController());
    timerController.startTimer();

    return FutureBuilder<UssdViewObject>(
      future: _futureResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox();
        } else if (snapshot.hasError) {
          return Text(
            'Unkown error occurred with error code: ${snapshot.error}',
          );
        } else if (snapshot.hasData) {
          final ussdObject = snapshot.data!;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: ListView.builder(
                  itemCount: ussdObject.options!.length,
                  itemBuilder: (context, index) {
                    if (ussdObject.options == null ||
                        index >= ussdObject.options!.length) {
                      return ListTile(title: Text('No options available'));
                    }
                    final option = ussdObject.options![index];
                    return ListTile(
                      title: Text(option),
                      visualDensity: VisualDensity(vertical: -4),
                    );
                    
                  },
                ),
              ),
            ],
          );
        }
        // Default return if none of the above conditions are met
        return SizedBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
