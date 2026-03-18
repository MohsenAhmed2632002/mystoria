// تعريف بسيط للعصر ومحتوياته
import 'package:myhabits/Core/Images&colors.dart';

class EraModel {
  final String name;
  final String imagePath;

  EraModel({
    required this.name,
    required this.imagePath,
  });
}

// البيانات المطلوبة
final eras = [
  EraModel(
    name: "القديمة",
    imagePath: AppImages.bigPyramid,
  ),
  EraModel(
    name: "الوسطى",
    imagePath: AppImages.knife,
  ),
  EraModel(
    name: "الحديثة",
    imagePath: AppImages.flower,
  ),
];
