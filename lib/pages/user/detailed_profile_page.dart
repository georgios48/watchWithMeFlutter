import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watch_with_me/components/blurry_alert_dialog.dart';
import 'package:watch_with_me/components/blurry_textfield_dialog.dart';
import 'package:watch_with_me/components/rounded_boardered_button.dart';
import 'package:watch_with_me/models/user_model.dart';
import 'package:watch_with_me/pages/landing_screen.dart';
import 'package:watch_with_me/providers/providers.dart';
import 'package:watch_with_me/servicesAPI/user_service.dart';
import 'package:watch_with_me/sharedPreferences/shared_preferences.dart';
import 'package:watch_with_me/utils/awesome_snackbar.dart';
import 'package:watch_with_me/utils/constants.dart';

class DetailedProfilePage extends ConsumerWidget {
  const DetailedProfilePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final preferences = WatchSharedPreferences();
    final userAccountService = UserAccountService();
    // provider
    final userAccountDataObj = ref.watch(userAccountDataProvider);
    // UI screen size
    final size = MediaQuery.of(context).size;

    double deviceWidth = size.width;
    double deviceHeight = size.height;

    return Scaffold(
        backgroundColor: bluePrimary,
        body: userAccountDataObj.when(
            data: (userAccountData) {
              return SafeArea(
                  child: SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back),
                                iconSize: deviceWidth * 0.09,
                                color: orangePrimary),
                          ]),
                      SizedBox(height: deviceHeight * 0.04),
                      Align(
                        alignment: Alignment.center,
                        child: Text("My Profile",
                            style: TextStyle(
                                fontFamily: 'Chalet',
                                fontSize: deviceWidth * 0.07,
                                color: orangePrimary,
                                fontWeight: FontWeight.w300,
                                height: deviceHeight * 0.001)),
                      ),
                      SizedBox(height: deviceHeight * 0.094),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Account details",
                              style: TextStyle(
                                  fontFamily: "Chalet",
                                  fontSize: deviceWidth * 0.05,
                                  color: whitePrimary,
                                  fontWeight: FontWeight.w300,
                                  height: deviceHeight * 0.001)),
                          Image.asset(
                            "assets/edit.png",
                            color: whitePrimary,
                            height: deviceHeight * 0.027,
                            width: deviceWidth * 0.05,
                          )
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.038,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Username:",
                              style: TextStyle(
                                  color: orangePrimary,
                                  fontFamily: "Chalet",
                                  fontSize: deviceWidth * 0.04),
                            ),
                            Text(
                              userAccountData.username,
                              style: TextStyle(
                                  color: whitePrimary,
                                  fontFamily: "Chalet",
                                  fontSize: deviceWidth * 0.04),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.003,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email:",
                              style: TextStyle(
                                  color: orangePrimary,
                                  fontFamily: "Chalet",
                                  fontSize: deviceWidth * 0.04),
                            ),
                            Text(
                              userAccountData.email,
                              style: TextStyle(
                                  color: whitePrimary,
                                  fontFamily: "Chalet",
                                  fontSize: deviceWidth * 0.04),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.003,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date on creation:",
                              style: TextStyle(
                                  color: orangePrimary,
                                  fontFamily: "Chalet",
                                  fontSize: deviceWidth * 0.04),
                            ),
                            Text(
                              userAccountData.dateOnCreation.substring(0, 10),
                              style: TextStyle(
                                  color: whitePrimary,
                                  fontFamily: "Chalet",
                                  fontSize: deviceWidth * 0.04),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.003,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Last login:",
                              style: TextStyle(
                                  color: orangePrimary,
                                  fontFamily: "Chalet",
                                  fontSize: deviceWidth * 0.04),
                            ),
                            Text(
                              userAccountData.lastLogin.substring(0, 10),
                              style: TextStyle(
                                  color: whitePrimary,
                                  fontFamily: "Chalet",
                                  fontSize: deviceWidth * 0.04),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.003,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Password:",
                              style: TextStyle(
                                  color: orangePrimary,
                                  fontFamily: "Chalet",
                                  fontSize: deviceWidth * 0.04),
                            ),
                            IconButton(
                                onPressed: () {
                                  final passwordTextController =
                                      TextEditingController();
                                  final newUserPasswordTextController =
                                      TextEditingController();
                                  BlurryTwoTextFieldDialog alertTextField =
                                      BlurryTwoTextFieldDialog(
                                          firstHideText: true,
                                          secondHideText: true,
                                          title: "Change password",
                                          firstTextController:
                                              passwordTextController,
                                          secondTextController:
                                              newUserPasswordTextController,
                                          continueCallBack: () async {
                                            try {
                                              ChangeUserPasswordRequest
                                                  changePasswordBody =
                                                  ChangeUserPasswordRequest(
                                                      newPassword:
                                                          passwordTextController
                                                              .text,
                                                      oldPassword:
                                                          newUserPasswordTextController
                                                              .text);
                                              await userAccountService
                                                  .changeUserCredentials(
                                                      changePasswordBody)
                                                  .then((response) {
                                                SnackBar snackBar =
                                                    CustomSnackbar()
                                                        .displaySnacbar(
                                                            response[0],
                                                            response[1]);
                                                ScaffoldMessenger.of(context)
                                                  ..hideCurrentSnackBar()
                                                  ..showSnackBar(snackBar);

                                                if (response[0] == 200) {
                                                  Future.delayed(const Duration(
                                                      seconds: 2));

                                                  // removes all previous pages
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const DetailedProfilePage()),
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
                                                } else {
                                                  Navigator.of(context).pop();
                                                }
                                              });
                                            } on Exception catch (e) {
                                              SnackBar snackBar =
                                                  CustomSnackbar()
                                                      .displaySnacbar(
                                                          0, e.toString());

                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(snackBar);
                                            }
                                          },
                                          firstTextFieldHintText:
                                              "Enter your password",
                                          secondTextFieldHintText:
                                              "Enter your NEW password");

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alertTextField;
                                    },
                                  );
                                },
                                icon: const Icon(Icons.edit),
                                color: whitePrimary)
                          ],
                        ),
                      ),
                      SizedBox(height: deviceHeight * 0.06),
                      // policy button
                      RoundBorderedButton(
                          text: "Privacy Policy",
                          borderColor: whitePrimary,
                          press: () {
                            // TODO: add privacy policy
                          }),
                      SizedBox(height: deviceHeight * 0.017),
                      // delete account button
                      RoundBorderedButton(
                          text: "Delete account",
                          textColor: orangePrimary,
                          borderColor: orangePrimary,
                          press: () {
                            // delete account, clear shared pref, remove all sessions etc, navigate to get started

                            _showDialog(
                                context, userAccountService, preferences);
                          }),
                      SizedBox(height: deviceHeight * 0.017),
                      // logout button
                      RoundBorderedButton(
                          text: "Logout",
                          fillColor: orangePrimary,
                          press: () async {
                            try {
                              await userAccountService
                                  .logoutUser()
                                  .then((response) {
                                if (response == 204) {
                                  preferences.removeAllPreferences();

                                  Future.delayed(const Duration(seconds: 2));

                                  // removes all previous pages
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LandingScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                }
                              });
                            } on Exception catch (e) {
                              SnackBar snackBar = CustomSnackbar()
                                  .displaySnacbar(0, e.toString());

                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                            }
                          })
                    ],
                  ),
                ),
              ));
            },
            error: (err, s) => Text(err.toString()),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}

_showDialog(BuildContext context, UserAccountService userAccountService,
    WatchSharedPreferences preferences) async {
  // Shows dialog for conformation of deleting the current user

  continueCallBack() {
    final passwordConformation = TextEditingController();
    BlurryTextFieldDialog textFieldDialog = BlurryTextFieldDialog(
        title: "Confirm deleting the account",
        textController: passwordConformation,
        hideText: true,
        continueCallBack: () async {
          try {
            await userAccountService
                .deleteUser(passwordConformation.text)
                .then((response) {
              if (response[0] == 200) {
                preferences.removeAllPreferences();

                Future.delayed(const Duration(seconds: 2));

                // removes all previous pages
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LandingScreen()),
                  (Route<dynamic> route) => false,
                );
              } else if (response[0] == 400 || response[0] == 404) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                SnackBar snackBar =
                    CustomSnackbar().displaySnacbar(0, response[1].toString());

                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            });
          } on Exception catch (e) {
            SnackBar snackBar =
                CustomSnackbar().displaySnacbar(0, e.toString());

            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          }
        },
        textFieldHintText: "Enter your account password");

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return textFieldDialog;
        });
  }

  BlurryDialog alert = BlurryDialog(
      title: "DELETE USER ACCOUNT",
      content: "Are you sure you want to delete your account?",
      continueCallBack: continueCallBack);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
