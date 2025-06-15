import 'dart:async';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PlayTurnController extends GetxController {
  final maxTurns = 10;
  final restoreInterval = Duration(minutes: 20);

  RxInt currentTurns = 10.obs;
  Rx<DateTime?> lastUsedTurnTime = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void useTurn() {
    if (currentTurns.value > 0) {
      currentTurns.value--;
      lastUsedTurnTime.value = DateTime.now();
    }
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (currentTurns.value < maxTurns) {
        final now = DateTime.now();
        final lastTime = lastUsedTurnTime.value;
        if (lastTime != null) {
          final passed = now.difference(lastTime);
          final restoreCount = passed.inMinutes ~/ restoreInterval.inMinutes;
          if (restoreCount > 0) {
            currentTurns.value = (currentTurns.value + restoreCount).clamp(0, maxTurns);
            lastUsedTurnTime.value = lastTime.add(Duration(minutes: restoreCount * 20));
          }
        }
      }
    });
  }

  Duration? get timeUntilNextRestore {
    if (currentTurns.value >= maxTurns || lastUsedTurnTime.value == null) return null;
    final nextTime = lastUsedTurnTime.value!.add(restoreInterval);
    return nextTime.difference(DateTime.now());
  }
}
