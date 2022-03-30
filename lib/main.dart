import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nftapp/controllers/menu_controller.dart';
import 'package:nftapp/controllers/navigation_controller.dart';
import 'package:nftapp/pages/404/error_page.dart';
import 'package:nftapp/pages/dashboard/dashboard_screen.dart';
import 'package:nftapp/routing/routes.dart';

import 'pages/layout.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: timerPageRoute,
      unknownRoute: GetPage(
        name: "/not-found",
        page: () => PageNotFound(),
        transition: Transition.fadeIn,
      ),
      getPages: [
        GetPage(name: RootRoute, page: () => SiteLayout()),
      ],
      title: 'Normi',
      theme: ThemeData(
        primaryColor: const Color(0xFF292B5E),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFB21EC1),
        ),
        textTheme:
            GoogleFonts.rubikTextTheme(Theme.of(context).textTheme.copyWith(
                  bodyText1: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .apply(color: Colors.white),
                  bodyText2: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(color: Colors.white),
                )).apply(),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: const FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: const FadeUpwardsPageTransitionsBuilder(),
        }),
        scaffoldBackgroundColor: const Color(0xFF131028),
        canvasColor: const Color(0xFF1b162d),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
