import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hichatbot/components/QuestionInput.dart';
import 'package:hichatbot/page/buy_premiumnew.dart';
import 'package:hichatbot/stores/AIChatStore.dart';
import 'package:hichatbot/utils/Chatgpt.dart';
import 'package:hichatbot/utils/Utils.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vibration/vibration.dart';
import 'package:markdown/markdown.dart' as md;
import '../generated/l10n.dart';
import '../stores/PointsNotifier.dart';
import '../stores/logic/dash_purchases.dart';
import '../utils/MathMarkdownUtil.dart';

class ChatPage extends StatefulWidget {
  final String chatId;
  final bool autofocus;
  final String chatType;

  const ChatPage({
    Key? key,
    required this.chatId,
    required this.autofocus,
    required this.chatType,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

enum TtsState { playing, stopped, paused, continued }

class _ChatPageState extends State<ChatPage> {
  static final LottieBuilder _generatingLottie =
      Lottie.asset("images/loading2.json");

  final ScrollController _listController = ScrollController();

  late FlutterTts _flutterTts;
  TtsState _ttsState = TtsState.stopped;
  String _speakText = '';

  bool _isCopying = false;
  RewardedAd? _rewardedAd;
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-8846782544598831/8355219625'
      : 'ca-app-pub-8846782544598831/4432264408';

  //以下是测试广告
  // ? 'ca-app-pub-3940256099942544/5224354917'
  // : 'ca-app-pub-3940256099942544/1712485313';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> initTts() async {
    _flutterTts = FlutterTts();

    _setAwaitOptions();

    _flutterTts.setStartHandler(() {
      setState(() {
        if (kDebugMode) {
          print("Playing");
        }
        _ttsState = TtsState.playing;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        if (kDebugMode) {
          print("Complete");
        }
        _ttsState = TtsState.stopped;
      });
    });

    _flutterTts.setCancelHandler(() {
      setState(() {
        if (kDebugMode) {
          print("Cancel");
        }
        _ttsState = TtsState.stopped;
      });
    });

    _flutterTts.setPauseHandler(() {
      setState(() {
        if (kDebugMode) {
          print("Paused");
        }
        _ttsState = TtsState.paused;
      });
    });

    _flutterTts.setContinueHandler(() {
      setState(() {
        if (kDebugMode) {
          print("Continued");
        }
        _ttsState = TtsState.continued;
      });
    });

    _flutterTts.setErrorHandler((msg) {
      setState(() {
        if (kDebugMode) {
          print("error: $msg");
        }
        _ttsState = TtsState.stopped;
      });
    });
  }

  Future _setAwaitOptions() async {
    await _flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> _speak(String text) async {
    if (_ttsState == TtsState.playing) {
      await _flutterTts.stop();
    }
    if (_speakText == text) {
      _speakText = '';
      return;
    }
    _speakText = text;
    await _flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    initTts();
    _loadAd();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  void scrollToBottom() {
    _listController.animateTo(
      _listController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    if (_listController.hasClients) {
      _listController.jumpTo(_listController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AIChatStore>(context, listen: true);
    final chat = store.getChatById(widget.chatType, widget.chatId);
    final pointsNotifier = Provider.of<PointsNotifier>(context, listen: true);
    var dashPurchases = context.watch<DashPurchases>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      width: 150,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Image.asset(
                            'images/hypeBard.png',
                            width: 150,
                            height: 35,
                            fit: BoxFit.fill,
                          ),
                          const Center(
                            child: Text(
                              'HichatBot',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                                height: 18 / 16,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .white, // Customize the text color here
                              ),
                            ),
                          ),
                        ],
                      )

                      // Center(
                      //   child: Image.asset(
                      //     'images/hypeBard.png',
                      //     width: 150,
                      //     height: 35,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //积分为0，并且不是专业版提示观看广告和购买
            pointsNotifier.points < 1 && dashPurchases.isPro == false
                ? Container(
                    color: const Color(0xFFF6F1F1),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 6),
                    child: _tipspointNotEnough(),
                  )
                : Container(),
            Expanded(
              child: _renderMessageListWidget(
                chat['messages'],
              ),
            ),
            QuestionInput(
              key: globalQuestionInputKey,
              chat: chat,
              autofocus: widget.autofocus,
              enabled: true,
              scrollToBottom: () {
                Future.delayed(const Duration(milliseconds: 300), () {
                  scrollToBottom();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderMessageListWidget(List messages) {
    if (messages.isEmpty) {
      Map aiData = ChatGPT.getAiInfoByType(widget.chatType);

      List<Widget> tipsWidget = [];
      for (int i = 0; i < aiData['tips'].length; i++) {
        String tip = aiData['tips'][i];
        tipsWidget.add(
          Ink(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(70, 20, 75, 0.9254901960784314),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: InkWell(
              splashColor: const Color(0xFFF6F1F1),
              highlightColor: const Color.fromRGBO(192, 238, 221, 1.0),
              borderRadius: BorderRadius.circular(25.0),
              onTap: () {
                if (globalQuestionInputKey.currentState != null) {
                  final currentState = globalQuestionInputKey.currentState;
                  if (currentState != null) {
                    currentState.myQuestion = tip;
                    currentState.questionController.clear();
                    currentState.questionController.text = tip;
                    currentState.focusNode.requestFocus();
                    currentState.questionController.selection =
                        TextSelection.fromPosition(
                            TextPosition(offset: tip.length));
                    setState(() {});
                  }
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 120,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: Text(
                  tip,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                    fontSize: 14,
                    height: 20 / 14,
                  ),
                ),
              ),
            ),
          ),
        );
        tipsWidget.add(
          const SizedBox(height: 10),
        );
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Image(
              width: 50,
              height: 60,
              image: AssetImage('images/bard.png'),
            ),
            const SizedBox(height: 12),
            // const Text(
            //   'Get started, Made with ❤ by Somrit',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 16,
            //   ),
            // ),
            // const SizedBox(height: 12),
            Column(
              children: tipsWidget,
            ),
            const SizedBox(height: 60),
          ],
        ),
      );
    }

    return _genMessageListWidget(messages);
  }

  Widget _genMessageListWidget(List messages) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 20),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      controller: _listController,
      reverse: false,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        return _genMessageItemWidget(messages[index], index);
      },
    );
  }

  Widget _genMessageItemWidget(Map message, int index) {
    return Container(
      color: const Color(0xFFF6F1F1),
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: _renderMessageItem(message, index),
    );
  }

  Widget _renderMessageItem(Map message, int index) {
    String role = message['role'];
    String defaultAvatar = 'images/bard.png';
    String defaultRoleName = S.current.chatbot;
    Color defaultColor = const Color(0x8B46144B);
    Color defaultTextColor = Colors.black;
    String defaultTextPrefix = '';
    List<Widget> defaultIcons = [
      _renderVoiceWidget(message),
      const SizedBox(width: 8),
      _renderShareWidget(message),
      const SizedBox(width: 8),
      _renderCopyWidget(message),
    ];
    Widget? customContent;

    if (role == 'user') {
      defaultAvatar = 'images/you.png';
      defaultRoleName = S.current.you;
      defaultColor = const Color(0x848A9169);
      defaultIcons = [];
    } else if (role == 'error') {
      defaultTextColor = const Color.fromRGBO(5, 0, 0, 0.796078431372549);
      defaultTextPrefix = 'Error:  ';
      defaultIcons = [
        _renderRegenerateWidget(index),
      ];
    } else if (role == 'generating') {
      defaultIcons = [];
      customContent = Row(
        children: [
          SizedBox(
            height: 60,
            child: _generatingLottie,
          )
        ],
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFF0F2F5), defaultColor],
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        clipBehavior: Clip.antiAlias,
                        child: Image(
                          width: 36,
                          height: 36,
                          image: AssetImage(defaultAvatar),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        defaultRoleName,
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          height: 24 / 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: defaultIcons,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: customContent ??
                MarkdownBody(
                  data: '$defaultTextPrefix${message['content']}',
                  shrinkWrap: true,
                  selectable: true,
                  styleSheet: MarkdownStyleSheet(
                    textScaleFactor: 1.1,
                    textAlign: WrapAlignment.start,
                    p: TextStyle(
                      height: 1.5,
                      color: defaultTextColor,
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _renderShareWidget(Map message) {
    return GestureDetector(
      onTap: () async {
        Vibration.vibrate(duration: 50);
        Share.share(message['content']);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
        child: const Image(
          image: AssetImage('images/share_message_icon.png'),
          width: 22,
        ),
      ),
    );
  }

  Widget _renderVoiceWidget(Map message) {
    return GestureDetector(
      onTap: () async {
        Vibration.vibrate(duration: 50);
        _speak(message['content']);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
        child: const Image(
          image: AssetImage('images/voice_icon.png'),
          width: 26,
        ),
      ),
    );
  }

  Widget _renderCopyWidget(Map message) {
    return GestureDetector(
      onTap: () async {
        Vibration.vibrate(duration: 50);
        if (_isCopying) {
          return;
        }
        _isCopying = true;
        await Clipboard.setData(
          ClipboardData(
            text: message['content'],
          ),
        );
        EasyLoading.showToast(
          'Copied successfully',
          dismissOnTap: true,
        );
        _isCopying = false;
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
        child: const Image(
          image: AssetImage('images/chat_copy_icon.png'),
          width: 26,
        ),
      ),
    );
  }

  Widget _renderRegenerateWidget(int index) {
    return GestureDetector(
      onTap: () {
        Vibration.vibrate(duration: 50);
        globalQuestionInputKey.currentState?.reGenerate(index);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
        child: const Image(
          image: AssetImage('images/refresh_icon.png'),
          width: 26,
        ),
      ),
    );
  }

  //积分不够提示框
  Widget _tipspointNotEnough() {
    final pointsNotifier = Provider.of<PointsNotifier>(context);
    return Card(
      color: Colors.black38,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.current.Reachedthedailylimit,
              style: const TextStyle(
                color: Colors.tealAccent,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              S.current.Reachedthedailylimittips,
              style: const TextStyle(
                color: Colors.tealAccent,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              // overflow: TextOverflow.ellipsis,
              // maxLines: 2, // 设置为1行
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    _rewardedAd?.show(onUserEarnedReward:
                        (AdWithoutView ad, RewardItem rewardItem) {
                      pointsNotifier.addPoints(); //观看完广告奖励观看次数
                    });
                  },
                  child: Text(
                    S.current.Rewardads,
                    style:
                        const TextStyle(fontSize: 18, color: Colors.tealAccent),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Utils.jumpPage(context, BuyPremiumNew());
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    S.current.GetPro,
                    style:
                        const TextStyle(fontSize: 18, color: Colors.tealAccent),
                  ),
                ),

                // IconButton(
                //   icon: const Icon(
                //     Icons.payment,
                //     size: 40,
                //   ),
                //   color: Colors.tealAccent,
                //   onPressed: () {
                //     Vibration.vibrate(duration: 50);
                //     // _showDeleteConfirmationDialog(context, chat['id']);
                //   },
                // ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.ads_click,
                //     size: 40,
                //   ),
                //   color: Colors.tealAccent,
                //   onPressed: () {
                //     Vibration.vibrate(duration: 50);
                //     // _showDeleteConfirmationDialog(context, chat['id']);
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Loads a rewarded ad.
  void _loadAd() {
    RewardedAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {});

          // Keep a reference to the ad so you can show it later.
          _rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          // ignore: avoid_print
          print('RewardedAd failed to load: $error');
        }));
  }
}
