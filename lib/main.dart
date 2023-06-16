import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hichatbot/components/HideKeyboard.dart';
import 'package:hichatbot/page/AppOpenPage.dart';
import 'package:hichatbot/page/purchase_page.dart';
import 'package:hichatbot/repo/iap_repo.dart';
import 'package:hichatbot/stores/AIChatStore.dart';
import 'package:hichatbot/stores/PointsNotifier.dart';
import 'package:hichatbot/stores/logic/dash_counter.dart';
import 'package:hichatbot/stores/logic/dash_purchases.dart';
import 'package:hichatbot/stores/logic/dash_upgrades.dart';
import 'package:hichatbot/stores/logic/firebase_notifier.dart';
import 'package:hichatbot/utils/Chatgpt.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';
import 'admob/app_lifecycle_reactor.dart';
import 'admob/app_open_ad_manager.dart';
import 'firebase_options.dart';
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

  // WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AIChatStore>(create: (_) => AIChatStore()),
      ChangeNotifierProvider<PointsNotifier>(create: (_) => PointsNotifier()),
      ChangeNotifierProvider<FirebaseNotifier>(
          create: (_) => FirebaseNotifier()),
      ChangeNotifierProvider<DashCounter>(create: (_) => DashCounter()),
      ChangeNotifierProvider<DashUpgrades>(
        create: (context) => DashUpgrades(
          context.read<DashCounter>(),
          context.read<FirebaseNotifier>(),
        ),
      ),
      ChangeNotifierProvider<IAPRepo>(
        create: (context) => IAPRepo(context.read<FirebaseNotifier>()),
      ),
      ChangeNotifierProvider<DashPurchases>(
        create: (context) => DashPurchases(
          context.read<DashCounter>(),
          context.read<FirebaseNotifier>(),
          context.read<IAPRepo>(),
        ),
        lazy: false,
      ),
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
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(SpUtil.getBool('isPro')==false){
          //开屏广告
          AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
          _appLifecycleReactor =
              AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
          _appLifecycleReactor.listenToAppStateChanges();
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    // 初始化PointsNotifier并赠送积分
    final pointsNotifier = Provider.of<PointsNotifier>(context);
    final store = Provider.of<AIChatStore>(context, listen: true);
    pointsNotifier.init().then((_) {
      pointsNotifier.checkAndGiftPoints();
    });
    return HideKeyboard(
      child: MaterialApp(
        navigatorObservers: <NavigatorObserver>[observer],
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
        // home: const PurchasePage(),
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

// Gives the option to override in tests.
class IAPConnection {
  static InAppPurchase? _instance;

  static set instance(InAppPurchase value) {
    _instance = value;
  }

  static InAppPurchase get instance {
    _instance ??= InAppPurchase.instance;
    return _instance!;
  }
}
