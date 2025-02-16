class Validators {
  static final RegExp _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final RegExp _passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  static final RegExp _nameRegex = RegExp(r'^[a-zA-Z\s]+$');

  static String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_emailRegex.hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Password cannot be empty';
    } else if (!_passwordRegex.hasMatch(password)) {
      return 'Password must be at least 8 characters long and contain both letters and numbers';
    }
    return null;
  }

  static String? validateName(String? name) {
    if (name!.isEmpty) {
      return 'Name cannot be empty';
    } else if (!_nameRegex.hasMatch(name)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }
}
