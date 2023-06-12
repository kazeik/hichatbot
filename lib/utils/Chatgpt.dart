import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

import '../generated/l10n.dart';

class ChatGPT {
  static final ChatGPT _instance = ChatGPT._();

  factory ChatGPT() => _getInstance();

  static ChatGPT get instance => _getInstance();

  ChatGPT._();

  static ChatGPT _getInstance() {
    return _instance;
  }

  static GetStorage storage = GetStorage();

  static String chatGptToken =
      dotenv.env['OPENAI_CHATGPT_TOKEN'] ?? ''; // token
  static String defaultModel = 'gpt-3.5-turbo';
  static List defaultRoles = [
    'system',
    'user',
    'assistant'
  ]; // generating | error

  static List chatModelList = [
    {
      "type": "chat",
      "name": S.current.AIChat,
      // "desc": "Natural language chat, continuous conversation mode",
      "desc": S.current.Naturallanguagechatcontinuousconversationmode,
      "isContinuous": true,
      "content": "\nInstructions:"
          "\nYou are ChatGPT. The answer to each question should be as concise as possible. If you're making a list, don't have too many entries."
          " If possible, please format it in a friendly markdown format."
          '\n',
      "tips": [
        S.current.Writemeawholesomequote,
        S.current.Ineedasarcasticjoke,
        S.current.Helpmeplanatrip,
        S.current.Ineedapickupline,
      ],
    },
    {
      "type": "translationLanguage",
      "name": S.current.hichatbottheTranslator,
      "desc": S.current.TranslateAlanguagetoBlanguage,
      "isContinuous": false,
      "content": '\nnInstructions:\n'
          'I want you to act as a translator. You will recognize the language, translate it into the specified language and answer me. Please do not use an interpreter accent when translating, but to translate naturally, smoothly and authentically, using beautiful and elegant expressions. I will give you the format of "Translate A to B". If the format I gave is wrong, please tell me that the format of "Translate A to B" should be used. Please only answer the translation part, do not write the explanation.'
          " If possible, please format it in a friendly markdown format."
          '\n',
      "tips": [
        S.current.Translatelovetospanish,
        S.current.Translatebeautifultobengali,
        S.current.TranslateHowareyoutogerman,
      ],
    },
    {
      "type": "frontEndHelper",
      "name": S.current.HichatBotasEngineer,
      "desc": S.current.HichatBotthefrontendguide,
      "isContinuous": false,
      "content": '\nnInstructions:\n'
          "I want you to be an expert in front-end development. I'm going to provide some specific information about front-end code issues with Js, Node, etc., and your job is to come up with a strategy to solve the problem for me. This may include suggesting code, strategies for logical thinking about code."
          " If possible, please format it in a friendly markdown format."
          '\n',
      "tips": [
        S.current.JavaScriptrecursivebinarytree,
        S.current.exampleofJavathreadblocking
      ],
    },
    // {
    //   "type": "linuxTerminal",
    //   "name": S.current.HichatbotasLinuxTerminal,
    //   "desc": S.current
    //       .AIlinuxterminalEnterthecommandandtheAIwillreplywithwhattheterminalshoulddisplay,
    //   "isContinuous": false,
    //   "content": "\nInstructions:"
    //       "\nI want you to act as a linux terminal. I will type commands and you will reply with what the terminal should show. I want you to only reply with the terminal output inside one unique code block, and nothing else. do not write explanations. do not type commands unless I instruct you to do so. When I need to tell you something in English, I will do so by putting text inside curly brackets {like this}."
    //       " If possible, please format it in a friendly markdown format."
    //       '\n',
    //   "tips": [
    //     S.current.rmrf,
    //     S.current.lsa,
    //   ],
    // },
    {
      "type": "positionInterviewer",
      "name": S.current.HichatBottheInterviewer,
      "desc": S.current
          .AIinterviewerAsacandidateAIwillaskyouinterviewquestionsfortheposition,
      "isContinuous": false,
      "content": "\nInstructions:"
          "\nI want you to act as an interviewer. I will be the candidate and you will ask me the interview questions for the position position. I want you to only reply as the interviewer. Do not write all the conservation at once. I want you to only do the interview with me. Ask me the questions and wait for my answers. Do not write explanations. Ask me the questions one by one like an interviewer does and wait for my answers."
          " If possible, please format it in a friendly markdown format."
          '\n',
      "tips": [
        S.current.HelloImafullstackjavascriptengineer,
        S.current.HelloImamarketinggenius,
        S.current.HelloImafinancialofficer,
      ],
    },
    // {
    //   "type": "javaScriptConsole",
    //   "name": S.current.HichatBotasJavaScriptConsole,
    //   "desc": S.current
    //       .AsjavascriptconsoleTypethecommandandtheAIwillreplywithwhatthejavascriptconsoleshouldshow,
    //   "isContinuous": false,
    //   "content": "\nInstructions:"
    //       "\nI want you to act as a javascript console. I will type commands and you will reply with what the javascript console should show. I want you to only reply with the terminal output inside one unique code block, and nothing else. do not write explanations. do not type commands unless I instruct you to do so. when I need to tell you something in english, I will do so by putting text inside curly brackets {like this}."
    //       " If possible, please format it in a friendly markdown format."
    //       '\n',
    //   "tips": [
    //     S.current.consolelogHelloWorld,
    //     S.current.windowalertHello,
    //     'window.alert("Hello");',
    //   ],
    // },
    {
      "type": "excelSheet",
      "name": S.current.HichatBottheExcelHero,
      "desc": S.current.ActsasatextbasedexcelYoullonlyrespondtomytextbased,
      "isContinuous": false,
      "content": "\nInstructions:"
          "\nI want you to act as a text based excel. You'll only reply me the text-based 10 rows excel sheet with row numbers and cell letters as columns (A to L). First column header should be empty to reference row number. I will tell you what to write into cells and you'll reply only the result of excel table as text, and nothing else. Do not write explanations. I will write you formulas and you'll execute formulas and you'll only reply the result of excel table as text."
          " If possible, please format it in a friendly markdown format."
          '\n',
      "tips": [
        S.current.Issueanemptysheet,
        S.current.Ineedaweeklyexpensesexcelsheet,
      ],
    },
    {
      "type": "spokenEnglishTeacher",
      "name": S.current.HichatBotasGrammarHero,
      "desc": S.current
          .TalktoAIinEnglishAIwillreplyyouinEnglishtopracticeyourEnglishspeaking,
      "isContinuous": false,
      "content": "\nInstructions:"
          "\nI want you to act as a spoken English teacher and improver. I will speak to you in English and you will reply to me in English to practice my spoken English. I want you to keep your reply neat, limiting the reply to 100 words. I want you to strictly correct my grammar mistakes, typos, and factual errors. I want you to ask me a question in your reply. Remember, I want you to strictly correct my grammar mistakes, typos, and factual errors."
          " If possible, please format it in a friendly markdown format."
          '\n',
      "tips": [S.current.Nowletsstartpracticing],
    },
    {
      "type": "travelGuide",
      "name": S.current.HichatBotonyourVacation,
      "desc":
          S.current.WritedownyourlocationandAIwillrecommendattractionsnearyou,
      "isContinuous": false,
      "content": "\nInstructions:"
          "\nI want you to act as a travel guide. I will write you my location and you will suggest a place to visit near my location. In some cases, I will also give you the type of places I will visit. You will also suggest me places of similar type that are close to my first location."
          " If possible, please format it in a friendly markdown format."
          '\n',
      "tips": [
        S.current.Iaminlasvegasandiwantittobeawesome,
      ],
    },
    {
      "type": "storyteller",
      "name": S.current.HichatBottheStoryteller,
      "desc": S.current
          .AIwillcomeupwithinterestingstoriesthatareengagingimaginativeandcaptivatingtotheaudience,
      "isContinuous": false,
      "content": "\nInstructions:"
          "\nI want you to act as a storyteller. You will come up with entertaining stories that are engaging, imaginative and captivating for the audience. It can be fairy tales, educational stories or any other type of stories which has the potential to capture people's attention and imagination. Depending on the target audience, you may choose specific themes or topics for your storytelling session e.g., if it’s children then you can talk about animals; If it’s adults then history-based tales might engage them better etc. "
          " If possible, please format it in a friendly markdown format."
          '\n',
      "tips": [
        S.current.Ineedanstoryonhowarichmanbecomepoorduetohisbadethics,
      ],
    },
    {
      "type": "novelist",
      "name": S.current.HichatBottheNovelist,
      "desc":
          S.current.AIplaysanovelistYoullcomeupwithcreativeandengagingstories,
      "isContinuous": false,
      "content": "\nInstructions:"
          "\nI want you to act as a novelist. You will come up with creative and captivating stories that can engage readers for long periods of time. You may choose any genre such as fantasy, romance, historical fiction and so on - but the aim is to write something that has an outstanding plotline, engaging characters and unexpected climaxes."
          " If possible, please format it in a friendly markdown format."
          '\n',
      "tips": [
        S.current
            .Ineedtowriteasciencefictionnovelsetinthefuturewithatimetravellingmysteriousambience,
      ],
    },
    {
      "type": "legalAdvisor",
      "name": S.current.HichatBotasLegalAdvisor,
      "desc": S.current
          .AIasyourlegaladvisorYouneedtodescribealegalsituationandtheAIwillprovideadviceonhowtohandleit,
      "isContinuous": false,
      "content": "\nInstructions:"
          "\nI want you to act as my legal advisor. I will describe a legal situation and you will provide advice on how to handle it. You should only reply with your advice, and nothing else. Do not write explanations."
          " If possible, please format it in a friendly markdown format."
          '\n',
      "tips": [
        S.current.legalAdvisortips,
      ],
    },
  ];

  static Future<void> setOpenAIKey(String key) async {
    await storage.write('OpenAIKey', key);
    await initChatGPT();
  }

  static String getCacheOpenAIKey() {
    String? key = storage.read('OpenAIKey');
    if (key != null && key != '' && key != chatGptToken) {
      return key;
    }
    return '';
  }

  static Future<void> setOpenAIBaseUrl(String url) async {
    await storage.write('OpenAIBaseUrl', url);
    await initChatGPT();
  }

  static String getCacheOpenAIBaseUrl() {
    String? key = storage.read('OpenAIBaseUrl');
    return (key ?? "").isEmpty ? "" : key!;
  }

  static Set chatModelTypeList =
      chatModelList.map((map) => map['type']).toSet();

  static getAiInfoByType(String chatType) {
    return chatModelList.firstWhere(
      (item) => item['type'] == chatType,
      orElse: () => null,
    );
  }

  static Future<void> initChatGPT() async {
    String cacheKey = getCacheOpenAIKey();
    String cacheUrl = getCacheOpenAIBaseUrl();
    var apiKey = cacheKey != '' ? cacheKey : chatGptToken;
    OpenAI.apiKey = apiKey;
    // if (apiKey != chatGptToken) {
    OpenAI.baseUrl =
        // cacheUrl.isNotEmpty ? cacheUrl : "https://api.openai.com";
        cacheUrl.isNotEmpty ? cacheUrl : "https://api.hichatbot.app";
    // }
  }

  static getRoleFromString(String role) {
    if (role == "system") return OpenAIChatMessageRole.system;
    if (role == "user") return OpenAIChatMessageRole.user;
    if (role == "assistant") return OpenAIChatMessageRole.assistant;
    return "unknown";
  }

  static convertListToModel(List messages) {
    List<OpenAIChatCompletionChoiceMessageModel> modelMessages = [];
    for (var element in messages) {
      modelMessages.add(OpenAIChatCompletionChoiceMessageModel(
        role: getRoleFromString(element["role"]),
        content: element["content"],
      ));
    }
    return modelMessages;
  }

  static List filterMessageParams(List messages) {
    List newMessages = [];
    for (var v in messages) {
      if (defaultRoles.contains(v['role'])) {
        newMessages.add({
          "role": v["role"],
          "content": v["content"],
        });
      }
    }
    return newMessages;
  }

  static Future<bool> checkRelation(
    List beforeMessages,
    Map message, {
    String model = '',
  }) async {
    beforeMessages = filterMessageParams(beforeMessages);
    String text = "\nInstructions:"
        "\nCheck whether the problem is related to the given conversation. If yes, return true. If no, return false. Please return only true or false. The answer length is 5."
        "\nquestion：$message}"
        "\nconversation：$beforeMessages"
        "\n";
    OpenAIChatCompletionModel chatCompletion = await sendMessage(
      [
        {
          "role": 'user',
          "content": text,
        }
      ],
      model: model,
    );
    debugPrint('---text $text---');
    String content = chatCompletion.choices.first.message.content ?? '';
    bool hasRelation = content.toLowerCase().contains('true');
    debugPrint('--- $hasRelation---');
    return hasRelation;
  }

  static Future<OpenAIChatCompletionModel> sendMessage(
    List messages, {
    String model = '',
  }) async {
    messages = filterMessageParams(messages);
    List<OpenAIChatCompletionChoiceMessageModel> modelMessages =
        convertListToModel(messages);
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: model != '' ? model : defaultModel,
      messages: modelMessages,
    );
    return chatCompletion;
  }

  static Future sendMessageOnStream(
    List messages, {
    String model = '',
    Function? onProgress,
  }) async {
    messages = filterMessageParams(messages);
    List<OpenAIChatCompletionChoiceMessageModel> modelMessages =
        convertListToModel(messages);

    Stream<OpenAIStreamChatCompletionModel> chatStream =
        OpenAI.instance.chat.createStream(
      model: defaultModel,
      messages: modelMessages,
    );
    print(chatStream);

    chatStream.listen((chatStreamEvent) {

      print('---chatStreamEvent---');
      print(chatStreamEvent.choices.first.delta.content);
      print('$chatStreamEvent.');
      print('---chatStreamEvent end---');
      if (onProgress != null) {
        onProgress(chatStreamEvent);
      }
    });
  }

  static Future<OpenAIImageModel> genImage(String imageDesc) async {
    debugPrint('---genImage starting: $imageDesc---');
    OpenAIImageModel image = await OpenAI.instance.image.create(
      prompt: imageDesc,
      n: 1,
      size: OpenAIImageSize.size1024,
      responseFormat: OpenAIImageResponseFormat.url,
    );
    debugPrint('---genImage success: $image---');
    return image;
  }
}
