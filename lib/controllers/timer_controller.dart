import 'package:get/get.dart';

class TimerController extends GetxController {
  static TimerController get instance => Get.find();
  late DateTime dialogOpenedAt;
  final int isAllowedTimeInSeconds = 30;

  void startTimer() {
    dialogOpenedAt = DateTime.now();
  }

  bool isAllowedTime() {
    final elapsedTime = DateTime.now().difference(dialogOpenedAt).inSeconds;
    return elapsedTime <= isAllowedTimeInSeconds;
  }
}
