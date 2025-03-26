extension RoutePath on String {
  String get path {
    return "/$this";
  }

  String get rootPath {
    return "/";
  }
}

extension UserName on String {
  String get addUserName {
    return "@$this";
  }
}
