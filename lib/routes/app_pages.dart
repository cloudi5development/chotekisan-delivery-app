import 'package:chotekisan_delivery_app/Screen/Home/home_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Home/home_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: '/home',
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
