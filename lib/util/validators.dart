class Validators {
  static String validateEmail(String value) {
    if (value == null) return 'Password is required';
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim()))
      return 'Enter Valid Email';
    else
      return null;
  }

  static String validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'Password is required';
    } else if (value.length <= 5)
      return 'More than 5 characters required';
    else
      return null;
  }

  static String validateMobile(String value) {
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  static String validateNull(String value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  static String validateUserName(String value) {
    if (value.length < 3)
      return 'More than 3 characters required';
    else
      return null;
  }
}
