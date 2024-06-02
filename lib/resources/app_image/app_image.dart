class Images{
  static String appLogo = "logo".png;
}

extension on String {
  String get png => 'assets/images/$this.png';
}