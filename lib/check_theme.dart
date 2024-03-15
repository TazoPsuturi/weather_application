bool? checkTheme() {
  DateTime now = DateTime.now();
  return now.hour >= 6 && now.hour < 18;
}
