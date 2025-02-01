import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mentalhealth/configs/mood_model.dart';
import 'package:mentalhealth/configs/news_model.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/configs/user_model.dart';
import 'package:mentalhealth/controllers/mood_controller.dart';
import 'package:mentalhealth/controllers/news_controller.dart';
import 'package:mentalhealth/controllers/theraplist.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/reuseable/buider_class.dart';

import 'package:mentalhealth/views/home/home/therapist_data.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../global/constants/colors_text.dart';

final indexTap = StateProvider((ref) => 0);

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final List<String> _list = [
    "Mood Test",
    "PHQ9 Test",
  ];
  final List<String> list = [
    "Sleep History",
    "Mood Trends",
    "Exercise Min.",
  ];

  final List<Map<String, dynamic>> _listHealth = [
    {
      "image": "assets/images/image1.jpg",
      "title": "The Importance of Mental Health Awareness",
      "url":
          "https://www.pinerest.org/newsroom/articles/mental-health-awareness-blog/",
      "subtitle":
          "Mental illnesses affect 19% of the adult population, 46% of teenagers and 13% of children each year. People struggling with their mental health may be in your family, live next door, teach your children, work in the next cubicle or sit in the same church pew.",
    },
    {
      "image": "assets/images/image2.jpg",
      "title":
          "Young people’s mental health is finally getting the attention it needs",
      "url": "https://www.nature.com/articles/d41586-021-02690-5/",
      "subtitle":
          "The COVID-19 pandemic, a UNICEF report and a review of the latest research all highlight the urgent need for better prevention and treatment of youth anxiety and depression.",
    },
    {
      "image": "assets/images/image3.jpg",
      "title":
          "Kids’ mental health is in crisis. Here’s what psychologists are doing to help",
      "url":
          "https://www.apa.org/monitor/2023/01/trends-improving-youth-mental-health/",
      "subtitle":
          "Research is focused on child and teen mental health, exploring why they are struggling and what can be done to help them",
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(therapistListControllerProvider);
    final chart = ref.watch(moodControllerProvider);
    final chartmood = ref.watch(moodTrendsControllerProvider);
    final min = ref.watch(exerciseControllerProvider);
    final tapIndex = ref.watch(indexTap);
    final newsData = ref.watch(newsListControllerProvider);
    final roles = ref.watch(userDataControllerProvider);
    final UserData? data = roles.data;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Personal History",
                style: textPoppions.titleMedium?.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 30.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, int index) {
                      final item = list[index];
                      return GestureDetector(
                        onTap: () {
                          ref.read(indexTap.notifier).state = index;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: tapIndex == index
                                  ? AppColors.primaryColor
                                  : AppColors.greyColor,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Center(
                            child: Text(
                              item,
                              style: textPoppions.titleMedium?.copyWith(
                                  fontSize: 12.sp,
                                  color: tapIndex == index
                                      ? AppColors.whiteColor
                                      : AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10.h,
              ),
              tapIndex == 0
                  ? Builder(builder: (context) {
                      switch (chart.requestStatus) {
                        case RequestStatus.initial:
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ));
                        case RequestStatus.progress:
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ));
                        case RequestStatus.success:
                          return ChartLine(data: chart.data);
                        case RequestStatus.failure:
                          return Center(
                            child: Text(
                              "Something went wrong",
                              style: textPoppions.titleMedium?.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        case RequestStatus.fetchingMore:
                          return Container();
                      }
                    })
                  : Container(),
              tapIndex == 1
                  ? Builder(builder: (context) {
                      switch (chartmood.requestStatus) {
                        case RequestStatus.initial:
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ));
                        case RequestStatus.progress:
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ));
                        case RequestStatus.success:
                          return MoodChartLine(data: chartmood.data);
                        case RequestStatus.failure:
                          return Center(
                            child: Text(
                              "Something went wrong",
                              style: textPoppions.titleMedium?.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        case RequestStatus.fetchingMore:
                          return Container();
                      }
                    })
                  : Container(),
              tapIndex == 2
                  ? Builder(builder: (context) {
                      switch (min.requestStatus) {
                        case RequestStatus.initial:
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ));
                        case RequestStatus.progress:
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ));
                        case RequestStatus.success:
                          return ExerciseChartLine(data: min.data);
                        case RequestStatus.failure:
                          return Center(
                            child: Text(
                              "Something went wrong",
                              style: textPoppions.titleMedium?.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        case RequestStatus.fetchingMore:
                          return Container();
                      }
                    })
                  : Container(),
              SizedBox(
                height: 10.h,
              ),

              data!.roles.isEmpty || data.roles.contains("User")
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Specialist",
                          style: textPoppions.headlineMedium?.copyWith(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                        Builder(builder: (context) {
                          switch (details.requestStatus) {
                            case RequestStatus.initial:
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ));
                            case RequestStatus.progress:
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ));
                            case RequestStatus.success:
                              return TherapistData(data: details.data);
                            case RequestStatus.failure:
                              return Center(
                                child: Text(
                                  "Something went wrong",
                                  style: textPoppions.titleMedium?.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            case RequestStatus.fetchingMore:
                              return Container();
                          }
                        }),
                      ],
                    )
                  : Container(),
              // : Container(),
              Text(
                "Services",
                style: textPoppions.headlineMedium
                    ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 90.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = _list[index];
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          context.push("/postMood");
                        }
                        if (index == 1) {
                          context.push("/multipleChoice");
                        }
                      },
                      child: Container(
                        width: 150.w,
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.pureWhiteColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 8.w),
                                child: Column(
                                  children: [
                                    Text(
                                      item,
                                      style:
                                          textPoppions.headlineMedium?.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColors.iconColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "News and Articles",
                    style: textPoppions.headlineMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push("/newsDetails");
                    },
                    child: Text(
                      "View All",
                      style: textPoppions.headlineMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              RequestStateWidget<List<NewsModel>>(
                status: newsData.requestStatus,
                data: newsData.data,
                onSuccess: (data) => NewsDetails(data: data),
                errorMessage: "Something went wrong",
                errorStyle: textPoppions.titleMedium?.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartLine extends StatelessWidget {
  final List<SleepHistory> data;
  const ChartLine({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200.h,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LineChart(LineChartData(
            minX: 0,
            maxX: data.length.toDouble() - 1,
            minY: 5,
            maxY: 20,
            borderData: FlBorderData(
              show: true,
              border: const Border(
                top: BorderSide(color: Colors.red, width: 2),
                bottom: BorderSide(color: Colors.blue, width: 3),
                left: BorderSide(color: Colors.green, width: 2),
                right: BorderSide(color: Colors.orange, width: 3),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  data.length,
                  (index) => FlSpot(
                    index
                        .toDouble(), // X-axis: index (or you can use timestamps)
                    data[index].sleepHours!.toDouble(), // Y-axis: Sleep hours
                  ),
                ),
                isCurved: true,
                barWidth: 4,
                belowBarData: BarAreaData(
                  show: true,
                ),
                isStrokeCapRound: true,
                dotData: const FlDotData(show: true),
              ),
            ],
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 30,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    DateTime parsedDate =
                        DateTime.parse(data[index].date.toString())
                            .toLocal(); // Convert to local time
                    String formattedDate =
                        DateFormat("dd MMM").format(parsedDate);
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                ),
              ),
            ),
          )),
        ));
  }
}

class MoodChartLine extends StatelessWidget {
  final List<MoodTreads> data;
  const MoodChartLine({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200.h,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LineChart(LineChartData(
            minX: 0,
            maxX: data.length.toDouble() - 1,
            minY: 0,
            maxY: 20,
            borderData: FlBorderData(
              show: true,
              border: const Border(
                top: BorderSide(color: Colors.red, width: 2),
                bottom: BorderSide(color: Colors.blue, width: 3),
                left: BorderSide(color: Colors.green, width: 2),
                right: BorderSide(color: Colors.orange, width: 3),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  data.length,
                  (index) => FlSpot(
                    index
                        .toDouble(), // X-axis: index (or you can use timestamps)
                    data[index]
                        .moodIntensity!
                        .toDouble(), // Y-axis: Sleep hours
                  ),
                ),
                isCurved: true,
                barWidth: 4,
                belowBarData: BarAreaData(
                  show: true,
                ),
                isStrokeCapRound: true,
                dotData: const FlDotData(show: true),
              ),
            ],
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 30,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    DateTime parsedDate =
                        DateTime.parse(data[index].date.toString())
                            .toLocal(); // Convert to local time
                    String formattedDate =
                        DateFormat("dd MMM").format(parsedDate);
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                ),
              ),
            ),
          )),
        ));
  }
}

class ExerciseChartLine extends StatelessWidget {
  final List<ExerciseMin> data;
  const ExerciseChartLine({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200.h,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LineChart(LineChartData(
            minX: 0,
            maxX: data.length.toDouble() - 1,
            minY: 5,
            maxY: 200,
            borderData: FlBorderData(
              show: true,
              border: const Border(
                top: BorderSide(color: Colors.red, width: 2),
                bottom: BorderSide(color: Colors.blue, width: 3),
                left: BorderSide(color: Colors.green, width: 2),
                right: BorderSide(color: Colors.orange, width: 3),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  data.length,
                  (index) => FlSpot(
                    index
                        .toDouble(), // X-axis: index (or you can use timestamps)
                    data[index]
                        .exerciseMinutes!
                        .toDouble(), // Y-axis: Sleep hours
                  ),
                ),
                isCurved: true,
                barWidth: 4,
                belowBarData: BarAreaData(
                  show: true,
                ),
                isStrokeCapRound: true,
                dotData: const FlDotData(show: true),
              ),
            ],
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 30,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    DateTime parsedDate =
                        DateTime.parse(data[index].date.toString())
                            .toLocal(); // Convert to local time
                    String formattedDate =
                        DateFormat("dd MMM").format(parsedDate);
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                ),
              ),
            ),
          )),
        ));
  }
}

class NewsDetails extends StatelessWidget {
  final List<NewsModel> data;
  const NewsDetails({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: min(5, data.length),
      itemBuilder: (BuildContext context, int index) {
        final item = data[index];
        return GestureDetector(
          onTap: () async {
            final Uri url = Uri.parse(item.url.toString());
            if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }
          },
          child: Card(
            color: AppColors.pureWhiteColor,
            elevation: 0,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  item.urlToImage.toString(),
                  height: 100.h,
                  width: 80.w,
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(
                item.title.toString(),
                maxLines: 2,
                style: textPoppions.headlineMedium?.copyWith(
                  color: AppColors.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                item.description.toString(),
                maxLines: 3,
                style: textPoppions.headlineMedium?.copyWith(
                  color: AppColors.iconColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
// Text(
              //   "Available Doctors",
              //   style: textPoppions.headlineMedium?.copyWith(
              //     fontSize: 16.sp,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // SizedBox(
              //   height: 200.h,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 6,
              //     itemBuilder: (BuildContext context, int index) {
              //       return GestureDetector(
              //         onTap: () {
              //           context.push('/chat', extra: "Puskottam Pandey");
              //         },
              //         child: Container(
              //           margin: EdgeInsets.symmetric(
              //               horizontal: 8.w, vertical: 8.h),
              //           decoration: BoxDecoration(
              //             color: AppColors.primaryColor,
              //             borderRadius: BorderRadius.circular(8.r),
              //           ),
              //           child: Padding(
              //             padding: EdgeInsets.symmetric(
              //                 vertical: 10.h, horizontal: 10.w),
              //             child: Row(
              //               children: [
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       "Looking For your\nMental Health",
              //                       style:
              //                           textPoppions.headlineMedium?.copyWith(
              //                         color: AppColors.whiteColor,
              //                         fontSize: 12.sp,
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //                     ),
              //                     Text(
              //                       "Specialist Doctor ",
              //                       style:
              //                           textPoppions.headlineMedium?.copyWith(
              //                         color: AppColors.whiteColor,
              //                         fontSize: 12.sp,
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 10.h,
              //                     ),
              //                     Text(
              //                       "Dr.Pandey",
              //                       style:
              //                           textPoppions.headlineMedium?.copyWith(
              //                         color: AppColors.whiteColor,
              //                         fontSize: 10.sp,
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //                     ),
              //                     Text(
              //                       "May 25 -May 27",
              //                       style:
              //                           textPoppions.headlineMedium?.copyWith(
              //                         color: AppColors.whiteColor,
              //                         fontSize: 10.sp,
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 20.h,
              //                     ),
              //                     Container(
              //                       padding: EdgeInsets.symmetric(
              //                           vertical: 6.h, horizontal: 6.w),
              //                       decoration: BoxDecoration(
              //                           color: const Color.fromARGB(
              //                               255, 9, 133, 233),
              //                           borderRadius:
              //                               BorderRadius.circular(8.r)),
              //                       child: Text(
              //                         "Chat now",
              //                         style:
              //                             textPoppions.headlineMedium?.copyWith(
              //                           color: AppColors.whiteColor,
              //                           fontSize: 10.sp,
              //                           fontWeight: FontWeight.w600,
              //                         ),
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //                 Image.asset(
              //                   "assets/images/docotors.png",
              //                   height: 200.h,
              //                   width: 100.w,
              //                   fit: BoxFit.contain,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),