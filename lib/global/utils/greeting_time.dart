class GreetingUtils {
  final day = DateTime.now();
  int get time => day.hour;

  String greeting() {
    if (time < 12) {
      return "Good Morning";
    } else if (time > 12 && time < 17) {
      return "Good AfterNoon";
    } else
      // ignore: curly_braces_in_flow_control_structures
      return "Good Night";
  }
}
