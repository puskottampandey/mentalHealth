import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentalhealth/configs/news_model.dart';
import 'package:mentalhealth/controllers/news_controller.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';
import 'package:mentalhealth/global/reuseable/buider_class.dart';
import 'package:mentalhealth/global/reuseable/scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsArticles extends ConsumerWidget {
  const NewsArticles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsData = ref.watch(newsListControllerProvider);
    return ReuseableScaffold(
      appbar: true,
      back: true,
      text: "News and Articles",
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
          child: RequestStateWidget<List<NewsModel>>(
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
        ),
      ),
    );
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
      itemCount: data.length,
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
