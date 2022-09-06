import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peeplDapp/Widgets/customText.dart';
import 'package:peeplDapp/Widgets/snackbar.dart';
import 'package:peeplDapp/constants/style.dart';
import 'package:peeplDapp/controllers/contract_controller.dart';
import 'package:peeplDapp/controllers/home_controller.dart';
import 'package:peeplDapp/helpers/responsiveness.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/0.png',
          width: 150,
          height: 150,
        ),
        SizedBox(
          width: !ResponsiveWidget.isSmallScreen(context) ? itemPadding + 80 : itemPadding - 80,
        ),
        ConnectWallet(),
      ],
    );
  }
}

class ConnectWallet extends StatefulWidget {
  ConnectWallet({Key? key}) : super(key: key);

  @override
  State<ConnectWallet> createState() => _ConnectWalletState();
}

class _ConnectWalletState extends State<ConnectWallet> {
  final HomeController homeController = Get.put(HomeController());

  final ContractController contractController = Get.put(ContractController());

  @override
  void initState() {
    if (homeController.isConnected) {
      if (homeController.isInOperatingChain) {
        final hasVested = contractController.getUserVestingCount(homeController.currentAddress.value);
        if (hasVested != BigInt.zero) {
          contractController.getScheduleByAddressAndIndex(
              index: 0, beneficaryAddress: homeController.currentAddress.value);
        }
      } else {
        showErrorSnack(context: context, title: 'Wrong Chain! Please connect to FUSE Network \nAnd Refresh');
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await homeController.connect().then((value) async {
          if (!homeController.isInOperatingChain) {
            homeController.switchChain();
          }
          if (homeController.isLoggedOut) showErrorSnack(context: context, title: 'Please log in to metamask');

          if (homeController.isInOperatingChain) {
            final hasVested = await contractController.getUserVestingCount(homeController.currentAddress.value);
            if (hasVested != BigInt.zero) {
              contractController.getScheduleByAddressAndIndex(
                  index: 0, beneficaryAddress: homeController.currentAddress.value);
            }
          } else {
            showErrorSnack(context: context, title: 'Wrong Chain! Please connect to FUSE Network \nAnd Refresh');
          }
        });
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(defaultPadding * 0.75),
          decoration: BoxDecoration(
            color: homeController.isLoading.value ? textColorBlack : callToAction,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: homeController.isLoading.value
              ? const CircularProgressIndicator(
                  color: callToAction,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                  child: Obx(() {
                    return CustomText(
                      text: homeController.displayAddress.value.isEmpty
                          ? "Connect Wallet"
                          : homeController.displayAddress.value,
                      color: Colors.white,
                      size: 18,
                    );
                  }),
                ),
        ),
      ),
    );
  }
}
