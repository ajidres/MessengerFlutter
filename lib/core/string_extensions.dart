extension StringExtensions on String {
  bool validateEmail() {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );
    return  emailRegExp.hasMatch(this);
  }
  bool validatePassword() {
    final RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
    return  passwordRegex.hasMatch(this);
  }
}
