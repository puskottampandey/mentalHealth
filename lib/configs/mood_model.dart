List<SleepHistory> sleepListFromJson(List<dynamic> str) =>
    List<SleepHistory>.from((str).map((x) => SleepHistory.fromJson(x)));
List<MoodTreads> moodListFromJson(List<dynamic> str) =>
    List<MoodTreads>.from((str).map((x) => MoodTreads.fromJson(x)));
List<ExerciseMin> exerciseListFromJson(List<dynamic> str) =>
    List<ExerciseMin>.from((str).map((x) => ExerciseMin.fromJson(x)));

class SleepHistory {
  SleepHistory({
    required this.date,
    required this.sleepHours,
  });

  final String? date;
  final int? sleepHours;

  factory SleepHistory.fromJson(Map<String, dynamic> json) {
    return SleepHistory(
      date: json["date"] ?? "",
      sleepHours: json["sleepHours"] ?? "",
    );
  }
}

class MoodTreads {
  MoodTreads({
    required this.date,
    required this.mood,
    required this.moodIntensity,
  });

  final DateTime? date;
  final String? mood;
  final int? moodIntensity;

  factory MoodTreads.fromJson(Map<String, dynamic> json) {
    return MoodTreads(
      date: DateTime.tryParse(json["date"] ?? ""),
      mood: json["mood"] ?? '',
      moodIntensity: json["moodIntensity"] ?? '',
    );
  }
}

class ExerciseMin {
  ExerciseMin({
    required this.date,
    required this.exerciseMinutes,
  });

  final DateTime? date;
  final int? exerciseMinutes;

  factory ExerciseMin.fromJson(Map<String, dynamic> json) {
    return ExerciseMin(
      date: DateTime.tryParse(json["date"] ?? ""),
      exerciseMinutes: json["exerciseMinutes"] ?? '',
    );
  }
}
