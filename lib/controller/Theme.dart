import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs; // Ensure this is a boolean

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}
