import 'dart:ui';

import 'package:mystoria/Core/Images&colors.dart';

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
  ),
];

final List<QuestionModel> levelThreeQuestionsList = [
  //1
  QuestionModel(
    color: AppColors.brownColor,
    hint:
        "يسمى عصر المجد الحربي، فالاختيار دائمًا هو الصورة اللي فيها جيش ومعارك.",
    type: QuestionType.order,
    question: 'اضغط علي الخاصيه المميزه لعصر الدولة الحديثه',
    options: [AppImages.choice2, AppImages.choice3, AppImages.choice1],
    correctAnswer: AppImages.choice3,
    background: AppImages.quiz,
  ),
  //2
  QuestionModel(
    color: AppColors.brownColor,
    type: QuestionType.order2,
    question: "اضغط علي السلاح التي اشتهرت به جيوش الدولة الحديثة",
    options: [AppImages.door1Q4L, AppImages.door2Q4L, AppImages.door3Q4L],
    correctAnswer: AppImages.door1Q4L,
    background: AppImages.quiz,
    hint: 'السلاح المشهور: التي نقلناها عن الهكسوس وطورناها لنهزمهم بها',
  ),
  //3
  QuestionModel(
    color: AppColors.brownColor,
    type: QuestionType.libra,
    question: "اضغط علي الباب الخاص بالملك الذي قاد معركة مجدو الشهيرة",
    options: [
      AppImages.openAhmoos,
      AppImages.openRamses,
      AppImages.openTohotmos,
    ],
    correctAnswer: AppImages.openAhmoos,
    background: AppImages.quiz,
    hint:
        'قائد معركة مجدو:* هو الملك ، صاحب الـ 16 حملة عسكرية وأول إمبراطورية.',
  ),
  //4
  QuestionModel(
    color: AppColors.brownColor,
    type: QuestionType.choose2,
    question: "اضغط علي التابوت الذي يعبر عن تابوت الملوك",
    options: [AppImages.coffin1, AppImages.coffin2, AppImages.coffin3],
    correctAnswer: AppImages.coffin2,
    background: AppImages.quiz,
    hint: 'الملك يُعرف من شئ  يرمز للحكم والسلطة.',
  ),
  //5
  QuestionModel(
    color: AppColors.brownColor,
    type: QuestionType.mcq,
    question: 'اختر الحدث الصحيح',
    options: [
      AppImages.choice3L3Q5,
      AppImages.choice1L3Q5,
      AppImages.choice2L3Q5,
    ],
    correctAnswer: AppImages.choice2L3Q5,
    background: AppImages.quiz,
    hint: 'المعلومة الصح هي وصول جيوش *تحتمس الثالث* لبلاد الشام (حدود سوريا).',
  ),
  //6
  QuestionModel(
    color: AppColors.brownColor,
    type: QuestionType.choose,
    question: 'رتب الأحداث التاريخية من الأقدم إلى الأحدث',
    options: [
      AppImages.magedo,
      AppImages.hoksos,
      AppImages.hatshpsot,
      AppImages.kadesh,
    ],
    correctAnswer: {0: "1", 1: "3", 2: "4", 3: "2"},
    background: AppImages.quiz,
    hint:
        'عشان ترتب صح، افتكر إن "البداية كانت طرد العدو، والنهاية كانت ازدهار التجارة."',
  ),
  //7
  QuestionModel(
    color: AppColors.brownColor,
    type: QuestionType.choose,
    question: "اي سلاح اشتهرت به جيوش الدوله الحديثه",
    options: [
      AppImages.king1,
      AppImages.king2,
      AppImages.king3,
      AppImages.king4,
    ],
    correctAnswer: {0: "2", 1: "3", 2: "1", 3: "4"},
    background: AppImages.quiz,
    hint:
        'ترتيب الملوك والأحداث:* ابدأ بـ *(الطارد)، ثم * (التجارة)، ثم  (الإمبراطور)، واختم بـ  (السلام).',
  ),
  //8
  QuestionModel(
    color: AppColors.brownColor,
    type: QuestionType.order4,
    question: 'اختر سبب سقوط الدولة الحديثة ؟',
    options: [
      AppImages.sign1,
      AppImages.sign3,
      AppImages.sign2,
      AppImages.sign4,
    ],
    correctAnswer: {0: "3", 1: "2", 2: "4", 3: "1"},
    background: AppImages.quiz,
    hint:
        'عشان ترتب صح، افتكر إن "البداية كانت طرد العدو، والنهاية كانت ازدهار التجارة."',
  ),
  //9
  QuestionModel(
    color: AppColors.brownColor,
    type: QuestionType.libraryPuzzle,
    question: "أختر العام الذي يبدأ فيه عصر الدولة الحديثة؟",
    options: [AppImages.Q91, AppImages.Q92, AppImages.Q93, AppImages.Q94],

    correctAnswer: {
      0: "التوسع خارج مصر",
      1: "تأمين الحدود",
      2: "استخدام العجلات الحربية",
      3: "تكوين جيش قوي",
    },
    background: AppImages.quiz,
    hint: 'ترتيب القوة:* تبدأ دائمًا من *الداخل لتصل إلى *الخارج',
  ),
  //10
  QuestionModel(
    color: AppColors.brownColor,
    type: QuestionType.theDoor,
    question: "اختر الحدث الصحيح",
    options: [AppImages.q101, AppImages.q102, AppImages.q103, AppImages.q104],

    correctAnswer: {
      0: "ازدهار التجارة",
      1: "تكوين إمبراطورية",
      2: "زيادة قوة مصر العسكرية",
      3: "طرد الهكسوس",
    },
    background: AppImages.quiz,
    hint: 'بداية عصر جديد بعد نصر كبير',
  ),
];
