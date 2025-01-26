import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../global/constants/colors_text.dart';
import '../../global/reuseable/button.dart';

class PHQ9Screen extends StatefulWidget {
  const PHQ9Screen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
  bool isLoading = false;
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
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "PHQ-9 Questionnaire",
          style: textPoppions.headlineMedium?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Over the last 2 weeks, how often have you been bothered by any of the following problems?",
                  style: textPoppions.headlineMedium?.copyWith(
                    color: AppColors.iconColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      color: AppColors.pureWhiteColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${index + 1}. ${questions[index]}",
                                style: textPoppions.headlineMedium?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            ...List.generate(4, (option) {
                              return Row(
                                children: [
                                  Radio<int>(
                                    splashRadius: 12,
                                    activeColor: AppColors.primaryColor,
                                    visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    value: option,
                                    groupValue: _responses[index],
                                    onChanged: (value) {
                                      setState(() {
                                        _responses[index] = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    [
                                      "Not at all",
                                      "Several days",
                                      "More than half",
                                      "Nearly every day"
                                    ][option],
                                    style:
                                        textPoppions.headlineMedium?.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                ReuseableButton(
                  bgcolor: AppColors.primaryColor,
                  text: "Sign In",
                  textcolor: kvverylightColor,
                  ontap: () async {
                    setState(() {
                      isLoading = true; // Start loading
                    });

                    // Simulate a delay to mimic the fetching process (e.g., API call)
                    // ignore: prefer_const_constructors
                    await Future.delayed(Duration(seconds: 5));

                    // Simulate fetching the recommendation
                    Recommendation recommendation = classifyUser();

                    setState(() {
                      isLoading =
                          false; // Stop loading once the data is fetched
                    });
                    // Show dialog with the recommendation result
                    showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(recommendation.title),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Description: ${recommendation.description}\n",
                                style: textPoppions.headlineMedium?.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "Action: ${recommendation.action}",
                              style: textPoppions.headlineMedium?.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => context.push("/signIn"),
                            child: Text(
                              "Ok",
                              style: textPoppions.headlineMedium?.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        isLoading
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
                child: // Soft black background

                    // Centered loading indicator
                    const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
            : Container()
      ]),
    );
  }
}
