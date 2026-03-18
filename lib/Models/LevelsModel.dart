import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Levels/LevelOne/LevelOne.dart';
import 'package:myhabits/Levels/LevelThree/LevelThree.dart';
import 'package:myhabits/Levels/LevelTwo/LevelTwo.dart';
import 'package:myhabits/Models/QuestionModel.dart';

final List<StageModel> levelStages = [
  StageModel(
    id: 1,
    requiredStars: 0,
    image: AppImages.mapad1,
    //        space from left, space from top
    position: const Offset(50, 50),
    imageWidth: 225,
    imageHeight: 225,
    levelScreen: const LevelOne(),
  ),
  StageModel(
    id: 2,
    requiredStars: 30,
    image: AppImages.mapad2,
    position: const Offset(1100, 50),
    imageWidth: 225,
    imageHeight: 225,
    levelScreen: const LevelTwo(),
  ),
  StageModel(
    levelScreen: const LevelThree(),
    id: 3,
    requiredStars: 60,
    image: AppImages.mapad3,
    position: const Offset(450, 500),
    imageWidth: 225,
    imageHeight: 225,
  ),
];

class StageModel {
  final int id;
  final int requiredStars;
  final String image;
  final Offset position; // مكان الزر على الخريطة
  final double imageWidth;
  final double imageHeight;
  final Widget levelScreen;

  StageModel({
    required this.id,
    required this.requiredStars,
    required this.image,
    required this.position,
    required this.imageWidth,
    required this.imageHeight,
    required this.levelScreen,
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
  // LevelModel(levelNumber: 4, questions: levelFourQuestionsList),
  // LevelModel(levelNumber: 5, questions: levelFiveQuestionsList),
];

final List<QuestionModel> levelOneQuestionsList = [
  QuestionModel(
    color: AppColors.backgroundColor,

    hint: "تذكر : كل حضاره ليها بدايه واضحه",
    type: QuestionType.order,
    question: 'رتب العصور من الأقدم إلى الأحدث',
    options: ['عصر الدولة الوسطى ', 'عصر الدولة القديمة', 'عصر الدولة الحديثة'],
    correctAnswer: [
      'عصر الدولة القديمة',
      'عصر الدولة الوسطى',
      'عصر الدولة الحديثة',
    ],
    background: AppImages.quiz1,
  ),
  QuestionModel(
    color: AppColors.backgroundColor,

    type: QuestionType.mcq,
    question: 'ما اسم العصر الذي لقب بعصر بناة الأهرام؟',
    options: ['الدولة الحديثة', 'الدولة القديمة', 'الدولة الوسطى'],
    correctAnswer: 'الدولة القديمة',
    background: AppImages.quiz2,
    hint: 'فكر في العصر اللي ظهرت فيه الاهرامات أول مره',
  ),
  QuestionModel(
    color: AppColors.backgroundColor,

    type: QuestionType.choose,
    question: 'انا اول  ملك دونت النصوص الدينيه علي الجدران ؟',
    options: ['أوناس', 'مينا', 'أمنمحات الرابع'],
    correctAnswer: 'أوناس',
    background: AppImages.quiz3,
    hint: 'لاحظ : أول نصوص دينيه سُجلت لملك مميز',
  ),
  QuestionModel(
    color: AppColors.backgroundColor,

    type: QuestionType.order2,
    question: "ضع  تاج كل ملك علي العرش الخاص بإنجزاته",
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
    background: AppImages.quiz4,
    hint: 'كل ملك ترك آثر مختلف ..... أيهم يناسب العرش؟',
  ),
  QuestionModel(
    color: AppColors.backgroundColor,

    type: QuestionType.findMistake,
    question: "أوجد الخطاً في الجمله الاتيه",
    options: [
      "بونت",
      "بلاد ",
      "من ",
      "الأرز ",
      "لإحضار  ",
      "بحريا ",
      "اسطولاً  ",
      "سنفرو ",
      "الملك",
      "ارسل ",
    ],
    correctAnswer: 'بونت',
    background: AppImages.quiz5,
    hint: 'أسال نفسك : الارز كان يُجلب من أي بلد؟',
  ),
  QuestionModel(
    color: AppColors.backgroundColor,

    type: QuestionType.order3,
    question: 'أكمل الشبكه الثلاثيه التي امامك',
    options: [AppImages.khafraa, AppImages.zosar, AppImages.khofo],
    correctAnswer: null,
    background: AppImages.quiz6,
    hint: 'أربط بين الملك و عصره و اثره الشهير',
  ),
  QuestionModel(
    color: AppColors.backgroundColor,

    type: QuestionType.choose2,
    question: "طابق كل اسم من أسماء الملوك مع إنجازته",
    options: ['اوسر كاف', 'سنفرو ', 'اوناس '],
    correctAnswer: {
      'اوسر كاف': "شيد معابد الشمس",
      'سنفرو ': " اول هرم كامل ",
      'اوناس ': "كتب نصوص الاهرام علي الجدران",
    },
    background: AppImages.quiz7,
    hint: 'أعظم هرم له صاحب معروف',
  ),
  QuestionModel(
    color: AppColors.backgroundColor,

    type: QuestionType.order4,
    question: 'رتب مراحل تطور المقابر من الصور اللتي امامك',
    options: [
      AppImages.oneStep,
      AppImages.templeWithCover,
      AppImages.khofoTemp,
      AppImages.stepPyramidTemple,
    ],
    correctAnswer: 'أوناس',
    background: AppImages.quiz8,
    hint: 'البداية كانت بسيطة... ثم تطورت المقابر',
  ),
  QuestionModel(
    color: AppColors.backgroundColor,

    type: QuestionType.libraryPuzzle,
    question: 'ضع كل ختم في مكانه …فكل عصر لا يعيش الا بخصائصه',
    options: [AppImages.papyrus1, AppImages.papyrus2, AppImages.papyrus3],
    correctAnswer: 'No',
    background: AppImages.quiz9,
    hint: 'البناء الضخم علامه عصر معين',
  ),
  QuestionModel(
    color: AppColors.backgroundColor,

    type: QuestionType.theDoor,
    question: 'اكتب رمز البوابة',
    options: [
      ' ترتيب الدولة القديمة بين العصور',
      'عدد اهرامات سنفرو ',
      'الأسرة التى انتهت معاها عصر الدولة القديمة',
      "عدد عصور مصر القديمة الأساسية",
    ],
    correctAnswer: 'NoAnswer',
    background: AppImages.quiz10,
    hint: 'كل رقم وراءه معلومه واضحة من الدرس',
  ),
];
final List<QuestionModel> levelTwoQuestionsList = [
  QuestionModel(
    color: AppColors.blueColor,
    hint: "التوحيد يبدأ بالحكم القوي أولاً",
    type: QuestionType.order,
    question: 'رتّب الأحداث داخل المربع  حسب تأثيرها في “إعادة وحدة مصر."',
    options: [AppImages.q2_1, AppImages.q2_0, AppImages.q2_2, AppImages.q2_3],
    correctAnswer: {
      0: AppImages.q2_3,
      1: AppImages.q2_1,
      2: AppImages.q2_0,
      3: AppImages.q2_2,
    },
    background: AppImages.quiz1,
  ),

  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.mcq,
    question: 'اختار الكلمه اللي تكمل حكمه من "تعاليم امنمحات"',
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

  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.choose,
    question: 'ايّ حجر من الثلاثة لا يعبّر عن خصائص “عصر الدولة الوسطى”؟',
    options: [AppImages.stone2, AppImages.stone1, AppImages.stone3],
    correctAnswer: AppImages.stone1,
    background: AppImages.quiz2_3,
    hint: 'انتبه : الغزاة ليسوا من انجازات العصر',
  ),

  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.order2,
    question: "استخرج الشظيه الخاطئه",
    options: [
      AppImages.break0,
      AppImages.break2,
      AppImages.break3,
      AppImages.break1,
      AppImages.break4,
    ],
    correctAnswer: AppImages.break3,
    background: AppImages.quiz2_4,
    hint: 'أسال نفسك : هل هذا البناء يخص هذا العصر؟',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.libra,
    question: "أيّ من الكفّتين تحمل عبارة صحيحة عن “عصر الدولة الوسطى”؟",
    options: [AppImages.rightHand, AppImages.leftHand],
    correctAnswer: AppImages.leftHand,
    background: AppImages.quiz1,
    hint: 'هذا العصر تألق بالفكر لا بالاحتلال',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.order3,
    question: '_',
    options: [AppImages.answer1, AppImages.answer2, AppImages.answer3],
    correctAnswer: {
      AppImages.answer1: AppImages.fund2,
      AppImages.answer2: AppImages.fund4,
      AppImages.answer3: AppImages.fund1,
    },
    background: AppImages.quiz6,
    hint: 'كل رمز له معني واضح ... ركز',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.choose2,
    question: "اسحب اللوحات ورتّب مراحل إنشاء المشروع المائي",
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
    background: AppImages.quiz2_7,
    hint: 'اي مشروع ناجح له خطوات منطقية',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.order4,
    question: 'اختر الجمله التي من" ادب الحكمه " في الدولة الوسطى',
    options: [AppImages.button2Q28, AppImages.button1Q28],
    correctAnswer: AppImages.button1Q28,
    background: AppImages.quiz8,
    hint: 'الحكمة تُعلّم الأخلاق لا القتال',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.libraryPuzzle,
    question: "اختر الباب الذي يعبر عن “أبرز ازدهار” في الدولة الوسطى",
    options: [AppImages.door1, AppImages.door2, AppImages.door3],
    correctAnswer: AppImages.door3,
    background: AppImages.quiz1,
    hint: 'هذا العصر عُرف بالازدهار المميز',
  ),
  QuestionModel(
    color: AppColors.blueColor,
    type: QuestionType.theDoor,
    question: "الصق الايقونات المناسبه علي الباب الذي يميز عصر سنوسرت التالت ",
    options: [
      AppImages.wheat,
      AppImages.river,
      AppImages.sword,

      AppImages.pyramid,
      AppImages.axe,
      AppImages.hand,
    ],
    correctAnswer: {
      AppImages.door1Q10: [AppImages.sword, AppImages.pyramid],
      AppImages.door2Q10: [AppImages.axe, AppImages.hand],
      AppImages.door3Q10: [AppImages.river, AppImages.wheat],
    },

    background: AppImages.quiz2_10,
    hint: 'كل رقم وراءه معلومه واضحة من الدرس',
  ),
];
final List<QuestionModel> levelThreeQuestionsList = [
  QuestionModel(
    color: AppColors.backgroundColor,
    hint: "القوة و التوسع سر هذا العصر",
    type: QuestionType.order,
    question: 'اي خاصية كانت مميزة لعصر الدولة الحديثة؟ ',
    options: ["بناء الاهرمات", "التوسع العسكري", "الزراعة البدائية"],
    correctAnswer: "التوسع العسكري",
    background: AppImages.quiz3_1,
  ),
  QuestionModel(
    color: AppColors.backgroundColor,
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
    color: AppColors.backgroundColor,
    type: QuestionType.order2,
    question: "اي سلاح اشتهرت به جيوش الدوله الحديثه",
    options: [AppImages.door1Q4L, AppImages.door2Q4L, AppImages.door3Q4L],
    correctAnswer: AppImages.door1Q4L,
    background: AppImages.quiz3_4,
    hint: 'سلاح غيّر شكل المعارك',
  ),
  QuestionModel(
    color: AppColors.backgroundColor,
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
    color: AppColors.backgroundColor,
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
    color: AppColors.backgroundColor,
    type: QuestionType.choose2,
    question: "من الذين دفنوا في وادي الملوك في عصر الدوله الحديثه",
    options: [AppImages.coffin1, AppImages.coffin2, AppImages.coffin3],
    correctAnswer: AppImages.coffin2,
    background: AppImages.quiz3_7,
    hint: 'هذا المكان خُصص للعظماء فقط',
  ),
  QuestionModel(
    color: AppColors.backgroundColor,
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
    color: AppColors.backgroundColor,
    type: QuestionType.libraryPuzzle,
    question: "أختر العام الذي يبدأ فيه عصر الدولة الحديثة؟",
    options: [" 1780 ق.م", "1069 ق.م", "1550 ق.م"],
    correctAnswer: "1550 ق.م",
    background: AppImages.quiz3_7,
    hint: 'بداية عصر جديد بعد نصر كبير',
  ),
  QuestionModel(
    color: AppColors.backgroundColor,
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
