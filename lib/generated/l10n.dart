// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Your Rewinds`
  String get yourrewinds {
    return Intl.message(
      'Your Rewinds',
      name: 'yourrewinds',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Your HichatBot assistants`
  String get yourhichatbotassistants {
    return Intl.message(
      'Your HichatBot assistants',
      name: 'yourhichatbotassistants',
      desc: '',
      args: [],
    );
  }

  /// `Let's start`
  String get letusstart {
    return Intl.message(
      'Let`s start',
      name: 'letusstart',
      desc: '',
      args: [],
    );
  }

  /// `you`
  String get you {
    return Intl.message(
      'you',
      name: 'you',
      desc: '',
      args: [],
    );
  }

  /// `ChatBot`
  String get chatbot {
    return Intl.message(
      'ChatBot',
      name: 'chatbot',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Customize OpenAI Api`
  String get customizeopenaiapi {
    return Intl.message(
      'Customize OpenAI Api',
      name: 'customizeopenaiapi',
      desc: '',
      args: [],
    );
  }

  /// `Customize OpenAIURL`
  String get customizeopenaiurl {
    return Intl.message(
      'Customize OpenAIURL',
      name: 'customizeopenaiurl',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacypolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacypolicy',
      desc: '',
      args: [],
    );
  }

  /// `Clear Data`
  String get cleardata {
    return Intl.message(
      'Clear Data',
      name: 'cleardata',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Deletion`
  String get confirmdeletion {
    return Intl.message(
      'Confirm Deletion',
      name: 'confirmdeletion',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Custom OpenAI API Key`
  String get customopenaiapikey {
    return Intl.message(
      'Custom OpenAI API Key',
      name: 'customopenaiapikey',
      desc: '',
      args: [],
    );
  }

  /// `Enter your API key`
  String get enteryourapikey {
    return Intl.message(
      'Enter your API key',
      name: 'enteryourapikey',
      desc: '',
      args: [],
    );
  }

  /// `Copied successfully`
  String get copiedsuccessfully {
    return Intl.message(
      'Copied successfully',
      name: 'copiedsuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `⦿ hichatBot does not collect this key.\n ⦿ In case our API key reports an error, custom keys need to be created at https://platform.openai.com/.\n`
  String get enteryourapikeytips {
    return Intl.message(
      '⦿ hichatBot does not collect this key.\n ⦿ In case our API key reports an error, custom keys need to be created at https://platform.openai.com/.\n',
      name: 'enteryourapikeytips',
      desc: '',
      args: [],
    );
  }

  /// `API key integrated`
  String get apikeyintegrated {
    return Intl.message(
      'API key integrated',
      name: 'apikeyintegrated',
      desc: '',
      args: [],
    );
  }

  /// `Custom OpenAI Base URL`
  String get CustomOpenAIBaseURL {
    return Intl.message(
      'Custom OpenAI Base URL',
      name: 'CustomOpenAIBaseURL',
      desc: '',
      args: [],
    );
  }

  /// `⦿ Custom URL allows you to connect to your own OpenAI instance.\n ⦿ You can set up a local or custom OpenAI deployment.\n`
  String get CustomOpenAIBaseURLtips {
    return Intl.message(
      '⦿ Custom URL allows you to connect to your own OpenAI instance.\n ⦿ You can set up a local or custom OpenAI deployment.\n',
      name: 'CustomOpenAIBaseURLtips',
      desc: '',
      args: [],
    );
  }

  /// `Enter your OpenAI URL`
  String get EnteryourOpenAIURL {
    return Intl.message(
      'Enter your OpenAI URL',
      name: 'EnteryourOpenAIURL',
      desc: '',
      args: [],
    );
  }

  /// `URL updated`
  String get URLupdated {
    return Intl.message(
      'URL updated',
      name: 'URLupdated',
      desc: '',
      args: [],
    );
  }

  /// `AI Chat`
  String get AIChat {
    return Intl.message(
      'AI Chat',
      name: 'AIChat',
      desc: '',
      args: [],
    );
  }

  /// `Natural language chat, continuous conversation mode`
  String get Naturallanguagechatcontinuousconversationmode {
    return Intl.message(
      'Natural language chat, continuous conversation mode',
      name: 'Naturallanguagechatcontinuousconversationmode',
      desc: '',
      args: [],
    );
  }

  /// `Write me a wholesome quote`
  String get Writemeawholesomequote {
    return Intl.message(
      'Write me a wholesome quote',
      name: 'Writemeawholesomequote',
      desc: '',
      args: [],
    );
  }

  /// `I need a sarcastic joke?`
  String get Ineedasarcasticjoke {
    return Intl.message(
      'I need a sarcastic joke?',
      name: 'Ineedasarcasticjoke',
      desc: '',
      args: [],
    );
  }

  /// `Help me plan a trip`
  String get Helpmeplanatrip {
    return Intl.message(
      'Help me plan a trip',
      name: 'Helpmeplanatrip',
      desc: '',
      args: [],
    );
  }

  /// `I need a pickup line!`
  String get Ineedapickupline {
    return Intl.message(
      'I need a pickup line!',
      name: 'Ineedapickupline',
      desc: '',
      args: [],
    );
  }

  /// `Hichatbot, the Translator`
  String get hichatbottheTranslator {
    return Intl.message(
      'Hichatbot, the Translator',
      name: 'hichatbottheTranslator',
      desc: '',
      args: [],
    );
  }

  /// `Translate A language to B language`
  String get TranslateAlanguagetoBlanguage {
    return Intl.message(
      'Translate A language to B language',
      name: 'TranslateAlanguagetoBlanguage',
      desc: '',
      args: [],
    );
  }

  /// `Translate love to spanish`
  String get Translatelovetospanish {
    return Intl.message(
      'Translate love to spanish',
      name: 'Translatelovetospanish',
      desc: '',
      args: [],
    );
  }

  /// `Translate beautiful to bengali`
  String get Translatebeautifultobengali {
    return Intl.message(
      'Translate beautiful to bengali',
      name: 'Translatebeautifultobengali',
      desc: '',
      args: [],
    );
  }

  /// `Translate How are you to german`
  String get TranslateHowareyoutogerman {
    return Intl.message(
      'Translate How are you to german',
      name: 'TranslateHowareyoutogerman',
      desc: '',
      args: [],
    );
  }

  /// `HichatBot, as Engineer`
  String get HichatBotasEngineer {
    return Intl.message(
      'HichatBot, as Engineer',
      name: 'HichatBotasEngineer',
      desc: '',
      args: [],
    );
  }

  /// `HichatBot, the front-end guide`
  String get HichatBotthefrontendguide {
    return Intl.message(
      'HichatBot, the front-end guide',
      name: 'HichatBotthefrontendguide',
      desc: '',
      args: [],
    );
  }

  /// `JavaScript recursive binary tree`
  String get JavaScriptrecursivebinarytree {
    return Intl.message(
      'JavaScript recursive binary tree',
      name: 'JavaScriptrecursivebinarytree',
      desc: '',
      args: [],
    );
  }

  /// `Example of Java thread blocking`
  String get exampleofJavathreadblocking {
    return Intl.message(
      'Example of Java thread blocking',
      name: 'exampleofJavathreadblocking',
      desc: '',
      args: [],
    );
  }

  /// `HichatBot, as Linux Terminal`
  String get HichatbotasLinuxTerminal {
    return Intl.message(
      'HichatBot, as Linux Terminal',
      name: 'HichatbotasLinuxTerminal',
      desc: '',
      args: [],
    );
  }

  /// `AI linux terminal. Enter the command and the AI will reply with what the terminal should display`
  String
      get AIlinuxterminalEnterthecommandandtheAIwillreplywithwhattheterminalshoulddisplay {
    return Intl.message(
      'AI linux terminal. Enter the command and the AI will reply with what the terminal should display',
      name:
          'AIlinuxterminalEnterthecommandandtheAIwillreplywithwhattheterminalshoulddisplay',
      desc: '',
      args: [],
    );
  }

  /// `rm -rf`
  String get rmrf {
    return Intl.message(
      'rm -rf',
      name: 'rmrf',
      desc: '',
      args: [],
    );
  }

  /// `ls -a`
  String get lsa {
    return Intl.message(
      'ls -a',
      name: 'lsa',
      desc: '',
      args: [],
    );
  }

  /// `HichatBot, the Interviewer`
  String get HichatBottheInterviewer {
    return Intl.message(
      'HichatBot, the Interviewer',
      name: 'HichatBottheInterviewer',
      desc: '',
      args: [],
    );
  }

  /// `AI interviewer. As a candidate, AI will ask you interview questions for the position`
  String
      get AIinterviewerAsacandidateAIwillaskyouinterviewquestionsfortheposition {
    return Intl.message(
      'AI interviewer. As a candidate, AI will ask you interview questions for the position',
      name:
          'AIinterviewerAsacandidateAIwillaskyouinterviewquestionsfortheposition',
      desc: '',
      args: [],
    );
  }

  /// `Hello, I'm a full stack javascript engineer`
  String get HelloImafullstackjavascriptengineer {
    return Intl.message(
      'Hello, I\'m a full stack javascript engineer',
      name: 'HelloImafullstackjavascriptengineer',
      desc: '',
      args: [],
    );
  }

  /// `Hello, I'm a marketing genius`
  String get HelloImamarketinggenius {
    return Intl.message(
      'Hello, I\'m a marketing genius',
      name: 'HelloImamarketinggenius',
      desc: '',
      args: [],
    );
  }

  /// `Hello, I'm a financial officer`
  String get HelloImafinancialofficer {
    return Intl.message(
      'Hello, I\'m a financial officer',
      name: 'HelloImafinancialofficer',
      desc: '',
      args: [],
    );
  }

  /// `HichatBot, as JavaScript Console`
  String get HichatBotasJavaScriptConsole {
    return Intl.message(
      'HichatBot, as JavaScript Console',
      name: 'HichatBotasJavaScriptConsole',
      desc: '',
      args: [],
    );
  }

  /// `As javascript console. Type the command and the AI will reply with what the javascript console should show`
  String
      get AsjavascriptconsoleTypethecommandandtheAIwillreplywithwhatthejavascriptconsoleshouldshow {
    return Intl.message(
      'As javascript console. Type the command and the AI will reply with what the javascript console should show',
      name:
          'AsjavascriptconsoleTypethecommandandtheAIwillreplywithwhatthejavascriptconsoleshouldshow',
      desc: '',
      args: [],
    );
  }

  /// `console.log("Hello World");`
  String get consolelogHelloWorld {
    return Intl.message(
      'console.log("Hello World");',
      name: 'consolelogHelloWorld',
      desc: '',
      args: [],
    );
  }

  /// `window.alert("Hello");`
  String get windowalertHello {
    return Intl.message(
      'window.alert("Hello");',
      name: 'windowalertHello',
      desc: '',
      args: [],
    );
  }

  /// `HichatBot, the Excel Hero`
  String get HichatBottheExcelHero {
    return Intl.message(
      'HichatBot, the Excel Hero',
      name: 'HichatBottheExcelHero',
      desc: '',
      args: [],
    );
  }

  /// `Acts as a text-based excel. You'll only respond to my text-based 10-row Excel sheet with row numbers and cell letters as columns (A through L)`
  String get ActsasatextbasedexcelYoullonlyrespondtomytextbased {
    return Intl.message(
      'Acts as a text-based excel. You\'ll only respond to my text-based 10-row Excel sheet with row numbers and cell letters as columns (A through L)',
      name: 'ActsasatextbasedexcelYoullonlyrespondtomytextbased',
      desc: '',
      args: [],
    );
  }

  /// `Issue an empty sheet`
  String get Issueanemptysheet {
    return Intl.message(
      'Issue an empty sheet',
      name: 'Issueanemptysheet',
      desc: '',
      args: [],
    );
  }

  /// `I need a weekly expenses excel sheet`
  String get Ineedaweeklyexpensesexcelsheet {
    return Intl.message(
      'I need a weekly expenses excel sheet',
      name: 'Ineedaweeklyexpensesexcelsheet',
      desc: '',
      args: [],
    );
  }

  /// `HichatBot, as Grammar Hero`
  String get HichatBotasGrammarHero {
    return Intl.message(
      'HichatBot, as Grammar Hero',
      name: 'HichatBotasGrammarHero',
      desc: '',
      args: [],
    );
  }

  /// `Talk to AI in English, AI will reply you in English to practice your English speaking`
  String
      get TalktoAIinEnglishAIwillreplyyouinEnglishtopracticeyourEnglishspeaking {
    return Intl.message(
      'Talk to AI in English, AI will reply you in English to practice your English speaking',
      name:
          'TalktoAIinEnglishAIwillreplyyouinEnglishtopracticeyourEnglishspeaking',
      desc: '',
      args: [],
    );
  }

  /// `Now let's start practicing`
  String get Nowletsstartpracticing {
    return Intl.message(
      'Now let\'s start practicing',
      name: 'Nowletsstartpracticing',
      desc: '',
      args: [],
    );
  }

  /// `HichatBot, on your Vacation`
  String get HichatBotonyourVacation {
    return Intl.message(
      'HichatBot, on your Vacation',
      name: 'HichatBotonyourVacation',
      desc: '',
      args: [],
    );
  }

  /// `Write down your location and AI will recommend attractions near you`
  String get WritedownyourlocationandAIwillrecommendattractionsnearyou {
    return Intl.message(
      'Write down your location and AI will recommend attractions near you',
      name: 'WritedownyourlocationandAIwillrecommendattractionsnearyou',
      desc: '',
      args: [],
    );
  }

  /// `I am in las vegas, and i want it to be awesome.`
  String get Iaminlasvegasandiwantittobeawesome {
    return Intl.message(
      'I am in las vegas, and i want it to be awesome.',
      name: 'Iaminlasvegasandiwantittobeawesome',
      desc: '',
      args: [],
    );
  }

  /// `HichatBot, the Storyteller`
  String get HichatBottheStoryteller {
    return Intl.message(
      'HichatBot, the Storyteller',
      name: 'HichatBottheStoryteller',
      desc: '',
      args: [],
    );
  }

  /// `AI will come up with interesting stories that are engaging, imaginative and captivating to the audience`
  String
      get AIwillcomeupwithinterestingstoriesthatareengagingimaginativeandcaptivatingtotheaudience {
    return Intl.message(
      'AI will come up with interesting stories that are engaging, imaginative and captivating to the audience',
      name:
          'AIwillcomeupwithinterestingstoriesthatareengagingimaginativeandcaptivatingtotheaudience',
      desc: '',
      args: [],
    );
  }

  /// `I need an story on how a rich man become poor due to his bad ethics`
  String get Ineedanstoryonhowarichmanbecomepoorduetohisbadethics {
    return Intl.message(
      'I need an story on how a rich man become poor due to his bad ethics',
      name: 'Ineedanstoryonhowarichmanbecomepoorduetohisbadethics',
      desc: '',
      args: [],
    );
  }

  /// `HichatBot, the Novelist`
  String get HichatBottheNovelist {
    return Intl.message(
      'HichatBot, the Novelist',
      name: 'HichatBottheNovelist',
      desc: '',
      args: [],
    );
  }

  /// `AI plays a novelist. You'll come up with creative and engaging stories`
  String get AIplaysanovelistYoullcomeupwithcreativeandengagingstories {
    return Intl.message(
      'AI plays a novelist. You\'ll come up with creative and engaging stories',
      name: 'AIplaysanovelistYoullcomeupwithcreativeandengagingstories',
      desc: '',
      args: [],
    );
  }

  /// `I need to write a science-fiction novel set in the future with a time travelling mysterious ambience`
  String
      get Ineedtowriteasciencefictionnovelsetinthefuturewithatimetravellingmysteriousambience {
    return Intl.message(
      'I need to write a science-fiction novel set in the future with a time travelling mysterious ambience',
      name:
          'Ineedtowriteasciencefictionnovelsetinthefuturewithatimetravellingmysteriousambience',
      desc: '',
      args: [],
    );
  }

  /// `HichatBot, as Legal Advisor`
  String get HichatBotasLegalAdvisor {
    return Intl.message(
      'HichatBot, as Legal Advisor',
      name: 'HichatBotasLegalAdvisor',
      desc: '',
      args: [],
    );
  }

  /// `AI as your legal advisor. You need to describe a legal situation and the AI will provide advice on how to handle it`
  String
      get AIasyourlegaladvisorYouneedtodescribealegalsituationandtheAIwillprovideadviceonhowtohandleit {
    return Intl.message(
      'AI as your legal advisor. You need to describe a legal situation and the AI will provide advice on how to handle it',
      name:
          'AIasyourlegaladvisorYouneedtodescribealegalsituationandtheAIwillprovideadviceonhowtohandleit',
      desc: '',
      args: [],
    );
  }

  /// `Sentencing for Fraud Crimes`
  String get legalAdvisortips {
    return Intl.message(
      'Sentencing for Fraud Crimes',
      name: 'legalAdvisortips',
      desc: '',
      args: [],
    );
  }

  /// `Purchased`
  String get purchased {
    return Intl.message(
      'Purchased',
      name: 'purchased',
      desc: '',
      args: [],
    );
  }

  /// `buying...`
  String get buying {
    return Intl.message(
      'buying...',
      name: 'buying',
      desc: '',
      args: [],
    );
  }

  /// `Powered by GPT-4`
  String get PoweredbyGPT4 {
    return Intl.message(
      'Powered by GPT-4',
      name: 'PoweredbyGPT4',
      desc: '',
      args: [],
    );
  }

  /// `Experience the latest ChatGPT AI model`
  String get ExperiencethelatestChatGPTAImodel {
    return Intl.message(
      'Experience the latest ChatGPT AI model',
      name: 'ExperiencethelatestChatGPTAImodel',
      desc: '',
      args: [],
    );
  }

  /// `Increased Word Limit`
  String get IncreasedWordLimit {
    return Intl.message(
      'Increased Word Limit',
      name: 'IncreasedWordLimit',
      desc: '',
      args: [],
    );
  }

  /// `Input/receive longer messages`
  String get Inputreceivelongermessages {
    return Intl.message(
      'Input/receive longer messages',
      name: 'Inputreceivelongermessages',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited Conversations`
  String get UnlimitedConversations {
    return Intl.message(
      'Unlimited Conversations',
      name: 'UnlimitedConversations',
      desc: '',
      args: [],
    );
  }

  /// `Have unlimited conversations every day`
  String get Haveunlimitedconversationseveryday {
    return Intl.message(
      'Have unlimited conversations every day',
      name: 'Haveunlimitedconversationseveryday',
      desc: '',
      args: [],
    );
  }

  /// `No Ads`
  String get NoAds {
    return Intl.message(
      'No Ads',
      name: 'NoAds',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy the privilege of ad-free experience`
  String get Enjoytheprivilegeofadfreeexperience {
    return Intl.message(
      'Enjoy the privilege of ad-free experience',
      name: 'Enjoytheprivilegeofadfreeexperience',
      desc: '',
      args: [],
    );
  }

  /// `HiChatBot Pro`
  String get hichatbotpro {
    return Intl.message(
      'HiChatBot Pro',
      name: 'hichatbotpro',
      desc: '',
      args: [],
    );
  }

  /// `Your conversation history is only stored on your device and we do not store it online. Clearing data will result in the loss of your conversation history.`
  String get DataclearConfirmation {
    return Intl.message(
      'Your conversation history is only stored on your device and we do not store it online. Clearing data will result in the loss of your conversation history.',
      name: 'DataclearConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Please Login first.`
  String get Pleaseloginfirst {
    return Intl.message(
      'Please Login first.',
      name: 'Pleaseloginfirst',
      desc: '',
      args: [],
    );
  }

  /// `Restore Purchase`
  String get restorepurchase {
    return Intl.message(
      'Restore Purchase',
      name: 'restorepurchase',
      desc: '',
      args: [],
    );
  }

  /// `Get Products`
  String get getproducts {
    return Intl.message(
      'Get Products',
      name: 'getproducts',
      desc: '',
      args: [],
    );
  }

  /// `Get Pro`
  String get GetPro {
    return Intl.message(
      'Get Pro',
      name: 'GetPro',
      desc: '',
      args: [],
    );
  }

  /// `Reward ads`
  String get Rewardads {
    return Intl.message(
      'Reward ads',
      name: 'Rewardads',
      desc: '',
      args: [],
    );
  }

  /// `Reached the daily limit`
  String get Reachedthedailylimit {
    return Intl.message(
      'Reached the daily limit',
      name: 'Reachedthedailylimit',
      desc: '',
      args: [],
    );
  }

  /// `We are happy to continue answering your questions, but you have reached the daily limit of free usage. You can increase the usage limit by watching rewarded ads or purchasing Pro.`
  String get Reachedthedailylimittips {
    return Intl.message(
      'We are happy to continue answering your questions, but you have reached the daily limit of free usage. You can increase the usage limit by watching rewarded ads or purchasing Pro.',
      name: 'Reachedthedailylimittips',
      desc: '',
      args: [],
    );
  }

  /// `Rate App`
  String get RateApp {
    return Intl.message(
      'Rate App',
      name: 'RateApp',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(
          languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
