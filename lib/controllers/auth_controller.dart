import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class AuthController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  final ApiService apiService = ApiService();

  Future<void> register(User user) async {
    isLoading.value = true;
    try {
      final response = await apiService.registerUser(user);
      isLoading.value = false;
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'User registered successfully');
      } else {
        Get.snackbar('Error', 'Failed to register user');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> login() async {
    isLoading.value = true;
    try {
      final response = await apiService.login(email.value, password.value);
      isLoading.value = false;
      Get.snackbar('Success', 'Login successful');
      // Handle successful login response
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
