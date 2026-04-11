import 'dart:ui';

import 'package:myhabits/Core/Images&colors.dart';

enum QuestionType {
  order,
  order2,
  order3,
  order4,
  mcq,
  match,
  findMistake,
  choose,
  choose2,
  theDoor,
  libraryPuzzle,
  libra,
}

class QuestionModel {
  final QuestionType type;
  final String question;
  final List<String> options;
  final dynamic correctAnswer;
  final String background;
  final String hint;
  final Color color;

  QuestionModel({
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.background,
    required this.hint,
    required this.color,
  });
}

class LevelModel {
  final int levelNumber;
  final List<QuestionModel> questions;

  LevelModel({required this.levelNumber, required this.questions});
}

final List<LevelModel> gameLevels = [
  LevelModel(levelNumber: 1, questions: levelOneQuestionsList),
  LevelModel(levelNumber: 2, questions: levelTwoQuestionsList),
  LevelModel(levelNumber: 3, questions: levelThreeQuestionsList),
];

final List<QuestionModel> levelOneQuestionsList = [
  //1
  QuestionModel(
    color: AppColors.blueColor,
    hint: "تذكر : كل حضاره ليها بدايه واضحه",
    type: QuestionType.order,
    question: 'اسحب الاجابة لترتيب العصور',
    options: ['عصر الدولة الوسطى ', 'عصر الدولة القديمة', 'عصر الدولة الحديثة'],
    correctAnswer: null,
    background: AppImages.quiz,
  ),
  //2
  QuestionModel(
    color: AppColors.blueColor,

    type: QuestionType.order2,
    question: "اسحب حجر الملك للمكان الخاص به",
    options: [
      AppImages.crownsenfro,
      AppImages.crownzosar,
      AppImages.crownkhofo,
    ],
    correctAnswer: [
      // زوسر = الهرم المدرج - خوفو =الهرم الأكبر  -  سنفرو= سفينه
      AppImages.crownsenfro,
      AppImages.crownzosar,
      AppImages.crownkhofo,
    ],
    background: AppImages.quiz,
    hint: 'كل ملك ترك آثر مختلف ..... أيهم يناسب العرش؟',
  ),
  //3
  QuestionModel(
    color: AppColors.blueColor,

    type: QuestionType.choose2,
    question: "اسحب اسم الملك الي العمل الخاص به",
    options: ['اوسر كاف', 'سنفرو ', 'اوناس '],
    correctAnswer: {
      'اوسر كاف': "شيد معابد الشمس",
      'سنفرو ': " اول هرم كامل ",
      'اوناس ': "كتب نصوص الاهرام علي الجدران",
    },
    background: AppImages.quiz,
    hint: 'أعظم هرم له صاحب معروف',
  ),
  //4
  QuestionModel(
    color: AppColors.blueColor,

    type: QuestionType.order4,
    question: 'رتّب مراحل بناء المقابر الفرعونية ترتيبًا صحيحًا',
    options: [
      AppImages.oneStep,
      AppImages.templeWithCover,
      AppImages.khofoTemp,
      AppImages.stepPyramidTemple,
    ],
    correctAnswer: 'أوناس',
    background: AppImages.quiz,
    hint: 'البداية كانت بسيطة... ثم تطورت المقابر',
  ),
  //5
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.libraryPuzzle,
    question: 'اسحب الرمز للمكان الخاص به',
    options: [AppImages.papyrus1, AppImages.papyrus2, AppImages.papyrus3],
    correctAnswer: 'No',
    background: AppImages.quiz,
    hint: 'البناء الضخم علامه عصر معين',
  ),
  //6
  QuestionModel(
    color: AppColors.blueColor,

    type: QuestionType.mcq,
    question: 'اختر الملك الذي شيد الهرم الاكبر',
    options: ['خوفو', 'زوسر', 'خفرع'],
    correctAnswer: 'خوفو',
    background: AppImages.quiz2,
    hint: 'فكر في العصر اللي ظهرت فيه الاهرامات أول مره',
  ),

  //7
  QuestionModel(
    color: AppColors.blueColor,

    type: QuestionType.choose,
    question: 'اختر الملك الذي دون النصوص الدينيه علي الجدران',
    options: ['أوناس', 'مينا', 'زوسر'],
    correctAnswer: 'أوناس',
    background: AppImages.quiz3,
    hint: 'لاحظ : أول نصوص دينيه سُجلت لملك مميز',
  ),

  //8
  QuestionModel(
    color: AppColors.blueColor,

    type: QuestionType.findMistake,
    question: "اختر الكلمه الخاطئه في الجملة التي امامك",
    options: ["بونت", "سنفرو", "الارز"],
    correctAnswer: 'بونت',
    background: AppImages.quiz1,
    hint: 'أسال نفسك : الارز كان يُجلب من أي بلد؟',
  ),

  //9
  QuestionModel(
    color: AppColors.blueColor,

    type: QuestionType.order3,
    question: "اضغط علي الحجر الخاص بانجاز بالملك زوسر",
    options: [AppImages.bigPyramid, AppImages.stepPyramid, AppImages.aboAlhawl],
    correctAnswer: "الهرم المدرج",
    background: AppImages.quiz1,
    hint: 'أربط بين الملك و عصره و اثره الشهير',
  ),

  //10
  QuestionModel(
    color: AppColors.blueColor,

    type: QuestionType.theDoor,
    question: 'اختر  الاسره التي انتهت عندها عصر الدوله القديمه',
    options: ['الثالثة', 'الرابعة ', 'السادسة'],
    correctAnswer: 'السادسة',
    background: AppImages.quiz1,
    hint: 'كل رقم وراءه معلومه واضحة من الدرس',
  ),
];

final List<QuestionModel> levelTwoQuestionsList = [
  

  //1
  QuestionModel(
    color: AppColors.greenColor,
    type: QuestionType.mcq,
    question: 'اضغط علي الحجر الخاص للجملة"',
    options: [
      AppImages.hisHart,
      AppImages.hisSoul,
      AppImages.hisMind,
      AppImages.himSelf,
    ],
    correctAnswer: AppImages.himSelf,
    background: AppImages.quiz2_2,
    hint: 'الحكمه تقول : الثقه تبدأ من الداخل',
  ),
  //2
  QuestionModel(
    color: AppColors.greenColor,
    type: QuestionType.choose,
    question: 'اضغط علي الحجر الذي لا يعبر عن الدولة الوسطى',
    options: [
      AppImages.stone2,
      AppImages.stone1,
      AppImages.stone3,
      AppImages.stone4,
    ],
    correctAnswer: AppImages.stone1,
    background: AppImages.quiz,
    hint: 'انتبه : الغزاة ليسوا من انجازات العصر',
  ),

  //3
  QuestionModel(
    color: AppColors.greenColor,
    type: QuestionType.order2,
    question: "اضغط علي الحجر الذي لا يعبر عن عصر الدولة الوسطي",
    options: [
      AppImages.break0,
      AppImages.break2,
      AppImages.break3,
      AppImages.break1,
      // AppImages.break4,
    ],
    correctAnswer: AppImages.break3,
    background: AppImages.quiz,
    hint: 'أسال نفسك : هل هذا البناء يخص هذا العصر؟',
  ),
  //4
  QuestionModel(
    color: AppColors.greenColor,
    hint: "التوحيد يبدأ بالحكم القوي أولاً",
    type: QuestionType.order,
    question: "اضغط علي جمله الادب المناسبة",
    options: [
      AppImages.ya_bone,
      AppImages.eltarekh,
      AppImages.elasar,
      AppImages.elmadi,
    ],
    correctAnswer: AppImages.ya_bone,
    background: AppImages.quiz2_L4,
  ),

  //5
  QuestionModel(
    color: AppColors.greenColor,
    type: QuestionType.libra,
    question: "اضغط علي الحجر الذي يحمل جملة تعبر عن العصر",
    options: [
      AppImages.elahramat,
      AppImages.eladab,
      AppImages.magdo,
      AppImages.elheksos,
    ],
    correctAnswer: AppImages.eladab,
    background: AppImages.quiz,
    hint: 'هذا العصر تألق بالفكر لا بالاحتلال',
  ),

  //6
  QuestionModel(
    color: AppColors.greenColor,
    type: QuestionType.choose2,
    question: "رتّب الاحداث حسب تأثيرها في اعاده وحدة مصر",
    options: [
      AppImages.banner2,
      AppImages.banner3,
      AppImages.banner1,
      AppImages.banner4,
    ],
    correctAnswer: [
      AppImages.banner2,
      AppImages.banner3,
      AppImages.banner1,

      AppImages.banner4,
    ],
    background: AppImages.quiz,
    hint: 'اي مشروع ناجح له خطوات منطقية',
  ),

  //7
  QuestionModel(
    color: AppColors.greenColor,
    type: QuestionType.theDoor,
    question: "اسحب و طابق خصائص العصر بأنجازاته",
    options: [
      AppImages.wheat,
      AppImages.river,
      AppImages.sword,

      AppImages.pyramid,
      AppImages.axe,
      AppImages.hand,
    ],
    correctAnswer: {
      3: 'النشاط التجاري',
      1: 'المشروعات الزراعية',
      2: 'الادب و الفنون',
      0: "الحدود",
    },

    background: AppImages.quiz,
    hint: 'كل رقم وراءه معلومه واضحة من الدرس',
  ),
  //8
  QuestionModel(
    color: AppColors.greenColor,
    type: QuestionType.order4,
    question: 'اسحب وطابق الاعمال بالرموز الصحيحة ',
    options: [
      AppImages.tawheed,
      AppImages.hemaya,
      AppImages.elzeraaa,
      AppImages.elrai,
    ],
    correctAnswer: AppImages.button1Q28,
    background: AppImages.quiz,
    hint: 'الحكمة تُعلّم الأخلاق لا القتال',
  ),

  //9
  QuestionModel(
    color: AppColors.greenColor,
    type: QuestionType.order3,
    question: 'اسحب ورتب مراحل انشاء المشروع المائي',
    options: [
      AppImages.run_lake,
      AppImages.water_level,
      AppImages.dam_construction,
      AppImages.digging_Canal,
    ],
    correctAnswer: {
      0: AppImages.water_level,
      1: AppImages.digging_Canal,
      2: AppImages.dam_construction,
      3: AppImages.run_lake,
    },
    background: AppImages.quiz,
    hint: 'كل رمز له معني واضح ... ركز',
  ),

//10
  QuestionModel(
    color: AppColors.greenColor,
    type: QuestionType.libraryPuzzle,
    question: "اسحب و طابق الملك بأنجازاته",
    options: [AppImages.door1, AppImages.door2, AppImages.door3],
    correctAnswer: AppImages.door3,
    background: AppImages.quiz,
    hint: 'هذا العصر عُرف بالازدهار المميز',
  ),];
final List<QuestionModel> levelThreeQuestionsList = [
  QuestionModel(
    color: AppColors.blueColor,
    hint: "القوة و التوسع سر هذا العصر",
    type: QuestionType.order,
    question: 'اي خاصية كانت مميزة لعصر الدولة الحديثة؟ ',
    options: ["بناء الاهرمات", "التوسع العسكري", "الزراعة البدائية"],
    correctAnswer: "التوسع العسكري",
    background: AppImages.quiz3_1,
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.mcq,
    question: 'من الملك الذي حرر مصر من الهكسوس وبدأ عصر الدوله الحديثه؟ ',
    options: ["حتشبسوت", "احمس"],
    correctAnswer: "احمس",
    background: "",
    hint: 'من أنهيِ حكم الغزاة بدأ عصراً جديداً',
  ),
  QuestionModel(
    color: AppColors.mainColor,
    type: QuestionType.choose,
    question: 'أي إنجاز يُنسب لتحتمس الثالث؟',
    options: ["بناء أبو سمبل", "إرسال بعثة بونت", "إقامة إمبراطورية واسعة"],
    correctAnswer: "إقامة إمبراطورية واسعة",
    background: AppImages.quiz3_3,
    hint: 'قائد عسكري لا يُنسي في التاريخ',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.order2,
    question: "اي سلاح اشتهرت به جيوش الدوله الحديثه",
    options: [AppImages.door1Q4L, AppImages.door2Q4L, AppImages.door3Q4L],
    correctAnswer: AppImages.door1Q4L,
    background: AppImages.quiz3_4,
    hint: 'سلاح غيّر شكل المعارك',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.order3,
    question: 'ضع الانشطه التي تنسب لرمسيس التاني',
    options: [
      AppImages.answer3Q6,
      AppImages.answer4Q6,
      AppImages.answer2Q6,
      AppImages.answer5Q6,
      AppImages.answer1Q6,
    ],
    correctAnswer: [
      AppImages.answer3Q6,
      AppImages.answer2Q6,
      AppImages.answer1Q6,
    ],
    background: AppImages.quiz3_6,
    hint: 'بعد الحرب... جاء البناء و التخليد',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.libra,
    question: "اي ملك قاد معركة مجدو الشهيره؟",
    options: [
      AppImages.openAhmoos,
      AppImages.openRamses,
      AppImages.openTohotmos,
    ],
    correctAnswer: AppImages.openTohotmos,
    background: AppImages.quiz3_5,
    hint: 'بطل معركته خالدة في التاريخ',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.choose2,
    question: "من الذين دفنوا في وادي الملوك في عصر الدوله الحديثه",
    options: [AppImages.coffin1, AppImages.coffin2, AppImages.coffin3],
    correctAnswer: AppImages.coffin2,
    background: AppImages.quiz3_7,
    hint: 'هذا المكان خُصص للعظماء فقط',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.order4,
    question: 'اختر سبب سقوط الدولة الحديثة ؟',
    options: [
      " زيادة نفوذ الكهنة",
      "ضعف حكام الأقاليم",
      "انهيار النظام المركزي ",
    ],
    correctAnswer: " زيادة نفوذ الكهنة",
    background: AppImages.quiz3_8,
    hint: 'زيادة نفوذ الكهنة أضعفت الحكم',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.libraryPuzzle,
    question: "أختر العام الذي يبدأ فيه عصر الدولة الحديثة؟",
    options: [" 1780 ق.م", "1069 ق.م", "1550 ق.م"],
    correctAnswer: "1550 ق.م",
    background: AppImages.quiz3_7,
    hint: 'بداية عصر جديد بعد نصر كبير',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.theDoor,
    question: "اختر الحدث الصحيح",
    options: [
      AppImages.papyrus3Q101,
      AppImages.papyrus3Q103,
      AppImages.papyrus3Q102,
    ],
    correctAnswer: AppImages.papyrus3Q103,

    background: AppImages.quiz3_10,
    hint: 'الحدث الصحيح لازم يناسب الزمن',
  ),
];
