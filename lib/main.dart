import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';
import 'package:mentalhealth/global/routes/router.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

import 'global/services/dio_service.dart';
import 'global/services/token_service.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox<String>('tokenBox');
  await Hive.openBox<bool>('onBoardBox');
  await Hive.openBox<String>('oncomplete');
  await Hive.openBox<String>('expiry');
  await DioService().initialize();
  await TokenService().initializePrefs();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    if (!GetIt.I.isRegistered<ApiRepository>()) {
      GetIt.I.registerSingleton(ApiRepository());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(374, 812),
        minTextAdapt: false,
        fontSizeResolver: FontSizeResolvers.height,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
            ),
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        });
  }
}
