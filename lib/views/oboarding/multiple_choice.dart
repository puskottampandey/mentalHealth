import 'package:flutter/material.dart';

class PHQ9Screen extends StatefulWidget {
  const PHQ9Screen({super.key});

  @override
  _PHQ9ScreenState createState() => _PHQ9ScreenState();
}

// Data structure for depression severity levels
class SeverityLevel {
  final String label;
  final int minScore;
  final int maxScore;
  final double priorProbability;

  SeverityLevel(
      this.label, this.minScore, this.maxScore, this.priorProbability);
}

// Recommendation class
class Recommendation {
  final String title;
  final String description;
  final String action;

  Recommendation(
      {required this.title, required this.description, required this.action});
}

class _PHQ9ScreenState extends State<PHQ9Screen> {
  final List<int> _responses = List.filled(9, 0);

  final List<String> questions = [
    "Little interest or pleasure in doing things",
    "Feeling down, depressed, or hopeless",
    "Trouble falling or staying asleep, or sleeping too much",
    "Feeling tired or having little energy",
    "Poor appetite or overeating",
    "Feeling bad about yourself or that you are a failure",
    "Trouble concentrating on things",
    "Moving or speaking slowly or being restless",
    "Thoughts of being better off dead or hurting yourself",
  ];

  // Define depression severity levels
  final List<SeverityLevel> severityLevels = [
    SeverityLevel("Minimal Depression", 1, 4, 0.2),
    SeverityLevel("Mild Depression", 5, 9, 0.3),
    SeverityLevel("Moderate Depression", 10, 14, 0.25),
    SeverityLevel("Moderately Severe Depression", 15, 19, 0.15),
    SeverityLevel("Severe Depression", 20, 27, 0.1),
  ];

  // Calculate likelihood for a given class
  double calculateLikelihood(int totalScore, SeverityLevel level) {
    if (totalScore >= level.minScore && totalScore <= level.maxScore) {
      return 1.0; // Max likelihood for being in the range
    }
    return 0.1; // Small likelihood for being out of range
  }

  // Naive Bayes classification
  Recommendation classifyUser() {
    int totalScore = _responses.reduce((value, element) => value + element);
    int selfHarmScore = _responses[8];

    // Emergency help for self-harm
    if (selfHarmScore == 3) {
      return Recommendation(
        title: "Emergency Help Needed",
        description:
            "Frequent thoughts of self-harm detected. Immediate help is required.",
        action: "Contact emergency services or a helpline immediately.",
      );
    }

    // Naive Bayes probability calculation
    SeverityLevel bestMatch = severityLevels[0];
    double highestProbability = 0.0;

    for (var level in severityLevels) {
      double likelihood = calculateLikelihood(totalScore, level);
      double posteriorProbability = likelihood * level.priorProbability;
      if (posteriorProbability > highestProbability) {
        highestProbability = posteriorProbability;
        bestMatch = level;
      }
    }

    // Generate a recommendation based on the best match
    return Recommendation(
      title: bestMatch.label,
      description: "Your score suggests ${bestMatch.label}.",
      action:
          "Follow appropriate steps based on severity. Consult a professional if needed.",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PHQ-9 Questionnaire")),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    questions[index],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (option) {
                    return Row(
                      children: [
                        Radio<int>(
                          value: option,
                          groupValue: _responses[index],
                          onChanged: (value) {
                            setState(() {
                              _responses[index] = value!;
                            });
                          },
                        ),
                        Text([
                          "Not at all",
                          "Several days",
                          "More than half",
                          "Nearly every day"
                        ][option]),
                      ],
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Recommendation recommendation = classifyUser();

            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(recommendation.title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description: ${recommendation.description}\n"),
                    Text("Action: ${recommendation.action}"),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Close"),
                  ),
                ],
              ),
            );
          },
          child: Text("Submit"),
        ),
      ),
    );
  }
}
