import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peeplDapp/Widgets/customText.dart';
import 'package:peeplDapp/Widgets/large_home_page.dart';
import 'package:peeplDapp/Widgets/small_home_page.dart';
import 'package:peeplDapp/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:peeplDapp/helpers/responsiveness.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (h) => Scaffold(
        body: Builder(
          builder: (_) {
            if (h.isEnabled) {
              if (h.isConnected && !h.isInOperatingChain) {
                return const Center(
                    child: CustomText(text: 'Wrong Chain! Please connect to FUSE Network \nAnd Refresh'));
              }
              return SingleChildScrollView(
                  child: ResponsiveWidget.isSmallScreen(context) ? SmallHomePage() : LargeHomePage());
            } else {
              return Center(
                child: InkWell(
                    child: const Text(
                      'Click here to find out more about our Dapp',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                      ),
                    ),
                    onTap: () {
                      launchUrl(Uri.parse('https://itsaboutpeepl.com/dapp/'));
                    }),
              );
            }
          },
        ),
      ),
    );
  }
}
