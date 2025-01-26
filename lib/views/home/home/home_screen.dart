import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/global/reuseable/formfield.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../global/constants/colors_text.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<String> _list = [
    "Doctor",
    "Appointment",
    "Medicine",
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableFormField(
                onTap: () {
                  context.push("/search");
                },
                readonly: true,
                controller: TextEditingController(),
                prefix: Icons.search,
                hint: "Search .........",
                sufixIcon: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Specialist",
                style: textPoppions.headlineMedium
                    ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 160.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.push('/doctorDetails');
                          },
                          child: Container(
                            width: 100.w,
                            margin: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: AppColors.pureWhiteColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Image.asset(
                                    "assets/images/docotors.png",
                                    height: 80.h,
                                    width: 100.w,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.h, horizontal: 8.w),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Dr.Pandey Puskottam ",
                                        style: textPoppions.headlineMedium
                                            ?.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "Psychiatrist",
                                        style: textPoppions.headlineMedium
                                            ?.copyWith(
                                                color: AppColors.iconColor,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
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
                    return Column(
                      children: [
                        Container(
                          width: 100.w,
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
                                        style: textPoppions.headlineMedium
                                            ?.copyWith(
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
                      ],
                    );
                  },
                ),
              ),
              Text(
                "Available Doctors",
                style: textPoppions.headlineMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        context.push('/chat', extra: "Puskottam Pandey");
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Looking For your\nMental Health",
                                    style:
                                        textPoppions.headlineMedium?.copyWith(
                                      color: AppColors.whiteColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Specialist Doctor ",
                                    style:
                                        textPoppions.headlineMedium?.copyWith(
                                      color: AppColors.whiteColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "Dr.Pandey",
                                    style:
                                        textPoppions.headlineMedium?.copyWith(
                                      color: AppColors.whiteColor,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "May 25 -May 27",
                                    style:
                                        textPoppions.headlineMedium?.copyWith(
                                      color: AppColors.whiteColor,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6.h, horizontal: 6.w),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 49, 157, 245),
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: Text(
                                      "Chat now",
                                      style:
                                          textPoppions.headlineMedium?.copyWith(
                                        color: AppColors.whiteColor,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Image.asset(
                                "assets/images/docotors.png",
                                height: 200.h,
                                width: 100.w,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text(
                "News and Articles",
                style: textPoppions.headlineMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _listHealth.length,
                itemBuilder: (BuildContext context, int index) {
                  final iteam = _listHealth[index];
                  return GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse(iteam["url"]);
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
                          child: Image.asset(
                            iteam["image"],
                            height: 80.h,
                            width: 80.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                        title: Text(
                          iteam["title"].toString(),
                          maxLines: 2,
                          style: textPoppions.headlineMedium?.copyWith(
                            color: AppColors.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          iteam["subtitle"].toString(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:fl_chart/fl_chart.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final List<Map<String, dynamic>> _dataset = [];
//   final _formKey = GlobalKey<FormState>();
//   String _selectedMetric = 'mood';
//   // Controllers for input fields
//   final _dateController = TextEditingController();
//   final _moodController = TextEditingController();
//   final _sleepController = TextEditingController();
//   final _stressController = TextEditingController();
//   final _activityController = TextEditingController();
//   final _meditationController = TextEditingController();

//   void _addDataPoint() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _dataset.add({
//           'date': _dateController.text,
//           'mood': double.parse(_moodController.text),
//           'sleep': double.parse(_sleepController.text),
//           'stress': double.parse(_stressController.text),
//           'activity': double.parse(_activityController.text),
//           'meditation': double.parse(_meditationController.text),
//         });
//       });

//       // Clear the input fields
//       _dateController.clear();
//       _moodController.clear();
//       _sleepController.clear();
//       _stressController.clear();
//       _activityController.clear();
//       _meditationController.clear();
//     }
//   }

//   List<FlSpot> _getSpots(String key) {
//     return _dataset
//         .asMap()
//         .entries
//         .map((entry) => FlSpot(entry.key.toDouble(), entry.value[key]))
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _dateController,
//                     decoration:
//                         InputDecoration(labelText: 'Date (e.g., Jan 10)'),
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter a date' : null,
//                   ),
//                   TextFormField(
//                     controller: _moodController,
//                     decoration: InputDecoration(labelText: 'Mood (1-10)'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter a mood score' : null,
//                   ),
//                   TextFormField(
//                     controller: _sleepController,
//                     decoration: InputDecoration(labelText: 'Sleep (hrs)'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter sleep hours' : null,
//                   ),
//                   TextFormField(
//                     controller: _stressController,
//                     decoration: InputDecoration(labelText: 'Stress (1-10)'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter a stress score' : null,
//                   ),
//                   TextFormField(
//                     controller: _activityController,
//                     decoration: InputDecoration(labelText: 'Activity (mins)'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter activity minutes' : null,
//                   ),
//                   TextFormField(
//                     controller: _meditationController,
//                     decoration: InputDecoration(labelText: 'Meditation (mins)'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter meditation minutes' : null,
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _addDataPoint,
//                     child: Text('Add Data Point'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (_dataset.isNotEmpty)
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildMetricButton('Mood', 'mood'),
//                     _buildMetricButton('Sleep', 'sleep'),
//                     _buildMetricButton('Stress', 'stress'),
//                     _buildMetricButton('Activity', 'activity'),
//                     _buildMetricButton('Meditation', 'meditation'),
//                   ],
//                 ),
//                 Container(
//                   height: 300,
//                   padding: const EdgeInsets.all(16.0),
//                   child: LineChart(
//                     LineChartData(
//                       gridData: const FlGridData(show: true),
//                       borderData: FlBorderData(show: true),
//                       titlesData: const FlTitlesData(
//                         leftTitles: AxisTitles(
//                           sideTitles: SideTitles(showTitles: true),
//                         ),
//                         bottomTitles: AxisTitles(
//                           sideTitles: SideTitles(showTitles: true),
//                         ),
//                       ),
//                       lineBarsData: [
//                         LineChartBarData(
//                           spots: _getSpots(_selectedMetric),
//                           isCurved: true,
//                           barWidth: 2,
//                           color: ,
//                           belowBarData: BarAreaData(show: false),
//                         ),
//                         LineChartBarData(
//                           spots: _getSpots(_selectedMetric),
//                           isCurved: true,
//                           barWidth: 2,
//                           color: Colors.green,
//                           belowBarData: BarAreaData(show: false),
//                         ),
//                         LineChartBarData(
//                           spots: _getSpots(_selectedMetric),
//                           isCurved: true,
//                           barWidth: 2,
//                           color: Colors.red,
//                           belowBarData: BarAreaData(show: false),
//                         ),
//                         LineChartBarData(
//                           spots: _getSpots(_selectedMetric),
//                           isCurved: true,
//                           barWidth: 2,
//                           color: Colors.orange,
//                           belowBarData: BarAreaData(show: false),
//                         ),
//                         LineChartBarData(
//                           spots: _getSpots(_selectedMetric),
//                           isCurved: true,
//                           barWidth: 2,
//                           color: Colors.purple,
//                           belowBarData: BarAreaData(show: false),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMetricButton(String label, String metricKey) {
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           _selectedMetric = metricKey;
//         });
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor:
//             _selectedMetric == metricKey ? Colors.blue : Colors.grey,
//       ),
//       child: Text(label),
//     );
//   }
// }
