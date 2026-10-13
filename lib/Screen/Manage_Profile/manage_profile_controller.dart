import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageProfileController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  RxnString gender = RxnString();
  RxnString state = RxnString();
  RxnString district = RxnString();

  final List<String> genderList = ["Male", "Female", "Other"];

  // Sample data. TODO: load states and districts from api.
  final Map<String, List<String>> stateDistricts = {
    "Tamil Nadu": ["Chennai", "Coimbatore", "Erode", "Madurai", "Salem"],
    "Kerala": ["Ernakulam", "Kozhikode", "Palakkad", "Thiruvananthapuram"],
    "Karnataka": ["Bengaluru Urban", "Mangaluru", "Mysuru"],
  };

  List<String> get stateList => stateDistricts.keys.toList();
  List<String> get districtList => stateDistricts[state.value] ?? [];

  @override
  void onInit() {
    super.onInit();
    // Sample data. TODO: load the saved profile from api.
    fullNameController.text = "Yogesh S";
    mobileController.text = "1234567890";
    emailController.text = "yogesh@chotekisan.com";
    buildingController.text = "123, raja street";
    pinCodeController.text = "638455";
    gender.value = "Male";
    state.value = "Tamil Nadu";
    district.value = "Erode";
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1950),
      lastDate: now,
    );
    if (picked != null) {
      dobController.text =
          "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
    }
  }

  void onStateChanged(String? value) {
    state.value = value;
    district.value = null;
  }

  void onChangePhoto() {
    // TODO: pick a new profile photo from the camera or gallery.
  }

  String? _validate() {
    if (fullNameController.text.trim().isEmpty) {
      return "Please enter your full name";
    }
    if (mobileController.text.length != 10) {
      return "Please enter a valid 10-digit mobile number";
    }
    if (emailController.text.trim().isNotEmpty &&
        !GetUtils.isEmail(emailController.text.trim())) {
      return "Please enter a valid email address";
    }
    if (dobController.text.isEmpty) {
      return "Please select your date of birth";
    }
    if (buildingController.text.trim().isEmpty) {
      return "Please enter your building/floor no";
    }
    if (state.value == null) return "Please select your state";
    if (district.value == null) return "Please select your district";
    if (pinCodeController.text.length != 6) {
      return "Please enter a valid 6-digit PIN code";
    }
    return null;
  }

  void onUpdateProfile(BuildContext context) {
    FocusScope.of(context).unfocus();
    final error = _validate();
    if (error != null) {
      showErrorSnackBar(error, context);
      return;
    }
    // TODO: send the updated profile to api.
    showSuccessSnackBar("Profile updated successfully", context);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    dobController.dispose();
    buildingController.dispose();
    pinCodeController.dispose();
    super.onClose();
  }
}
