class Validator {

  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Please Enter your name';
    }
    Pattern pattern = r'^[a-z A-Z]+$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value) == false) {
    } else {
      return 'Please enter a valid Name';
    }
    return null;
  }

  static bool validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-z\-0-9]+\.)+[a-z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(value!)) ? false : true;
  }

  static String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your phone number';
    } else if (value.startsWith("0")) {
      return "Phone number cannot start with 0";
    } else if (value.length <= 9) {
      return 'Phone number must have minimum 11 digit';
    } else if (value.length > 10) {
      return 'Phone number cannot exceed 11 digits';
    }
    return null;
  }

}
