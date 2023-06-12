import 'dart:async';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hichatbot/components/HideKeyboard.dart';
import 'package:hichatbot/page/AppOpenPage.dart';
import 'package:hichatbot/stores/AIChatStore.dart';
import 'package:hichatbot/stores/PointsNotifier.dart';
import 'package:hichatbot/utils/Chatgpt.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import 'PointsPage.dart';
import 'admob/app_lifecycle_reactor.dart';
import 'admob/app_open_ad_manager.dart';
import 'generated/l10n.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await dotenv.load(fileName: ".env");

  await GetStorage.init();
  await ChatGPT.initChatGPT();
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  await SpUtil.getInstance();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AIChatStore>(create: (_) => AIChatStore()),
      ChangeNotifierProvider<PointsNotifier>(create: (_) => PointsNotifier()),
    ],
    child: MyApp(),
  ));
  configLoading();
}

void enterFullScreenButKeepBottomOverlay() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
  }

  @override
  @override
  Widget build(BuildContext context) {
    // 初始化PointsNotifier并赠送积分
    final pointsNotifier = Provider.of<PointsNotifier>(context);
    pointsNotifier.init().then((_) {
      pointsNotifier.checkAndGiftPoints();
    });
    print(pointsNotifier.points);
    print(SpUtil.getString('lastGiftDate'));
    print('-------');
    return HideKeyboard(
      child: MaterialApp(
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF6F1F1),
          brightness: Brightness.light,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
          fontFamily: 'Poppins',
        ),
        home: const SplashPage(),
        // home: const PointsPage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return HideKeyboard(
//       child: MaterialApp(
//         supportedLocales: S.delegate.supportedLocales,
//         localizationsDelegates: const [
//           S.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//         ],
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           useMaterial3: true,
//           scaffoldBackgroundColor: const Color(0xFFF6F1F1),
//           brightness: Brightness.light,
//           pageTransitionsTheme: const PageTransitionsTheme(
//             builders: {
//               TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
//               TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
//             },
//           ),
//           fontFamily: 'Poppins',
//         ),
//         home: const SplashPage(),
//         builder: EasyLoading.init(),
//       ),
//     );
//   }
// }

Future<void> configLoading() async {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.none
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..displayDuration = const Duration(milliseconds: 1000)
    ..userInteractions = false;
}
