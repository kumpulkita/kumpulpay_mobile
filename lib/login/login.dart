import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kumpulpay/bottombar/bottombar.dart';
import 'package:kumpulpay/data/shared_prefs.dart';
import 'package:kumpulpay/repository/model/data.dart';
import 'package:kumpulpay/repository/retrofit/api_client.dart';
import 'package:kumpulpay/utils/button.dart';
import 'package:kumpulpay/utils/loading.dart';
import 'package:kumpulpay/utils/media.dart';
import 'package:kumpulpay/utils/string.dart';
import 'package:kumpulpay/utils/textfeilds.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colornotifire.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final _globalKey = GlobalKey();
  final _globalKey = GlobalKey<State>();
  final _formKey = GlobalKey<FormBuilderState>();
  late ColorNotifire notifire;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: notifire.getprimerycolor,
        title: Text(
          CustomStrings.login,
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontFamily: 'Gilroy Bold',
              fontSize: height / 35),
        ),
        centerTitle: true,
      ),
      backgroundColor: notifire.getprimerycolor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  color: Colors.transparent,
                  child:
                      Image.asset("images/background.png", fit: BoxFit.cover),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height / 12.2,
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Center(
                          child: Container(
                            height: height / 1.2,
                            width: width / 1.1,
                            decoration: BoxDecoration(
                              color: notifire.gettabwhitecolor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height / 15,
                                ),
                                FormBuilder(
                                    key: _formKey,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width / 18,
                                            ),
                                            Text(
                                              CustomStrings.email,
                                              style: TextStyle(
                                                color: notifire.getdarkscolor,
                                                fontSize: height / 50,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height / 70,
                                        ),
                                        CustomtextFormBuilderfilds.textField(
                                            notifire.getdarkscolor,
                                            notifire.getdarkgreycolor,
                                            notifire.getbluecolor,
                                            "images/email.png",
                                            CustomStrings.emailhint,
                                            notifire.getdarkwhitecolor,
                                            name: "email",
                                            isEmail: true, initialValue: "bestie@mail.com"),
                                        SizedBox(
                                          height: height / 35,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width / 18,
                                            ),
                                            Text(
                                              CustomStrings.password,
                                              style: TextStyle(
                                                color: notifire.getdarkscolor,
                                                fontSize: height / 50,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height / 70,
                                        ),
                                        CustomtextFormBuilderfilds.textField(
                                            notifire.getdarkscolor,
                                            notifire.getdarkgreycolor,
                                            notifire.getbluecolor,
                                            "images/password.png",
                                            CustomStrings.passwordhint,
                                            notifire.getdarkwhitecolor,
                                            name: "password",
                                            isPassword: true, initialValue: "secret"),
                                        SizedBox(
                                          height: height / 35,
                                        ),
                                        Row(
                                          children: [
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            CustomStrings
                                                                .commingsoon)));
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         const ForgotPassword(),
                                                //   ),
                                                // );
                                              },
                                              child: Container(
                                                height: height / 40,
                                                color: Colors.transparent,
                                                child: Text(
                                                  CustomStrings.forgotpassword,
                                                  style: TextStyle(
                                                      color: notifire
                                                          .getdarkscolor,
                                                      fontSize: height / 60,
                                                      fontFamily:
                                                          'Gilroy Medium'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width / 18,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height / 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // setState(() {
                                            if (_formKey.currentState!.saveAndValidate()) {
                                              final formData = _formKey.currentState?.value;
                                              _handleSubmit(context, formData);
                                            }
                                            // });
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => const Verify(),
                                            //   ),
                                            // );
                                          },
                                          child: Custombutton.button(
                                              notifire.getbluecolor,
                                              CustomStrings.login,
                                              width / 2),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: height / 50,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 18),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: height / 700,
                                        width: width / 3,
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                      Text(
                                        "or",
                                        style: TextStyle(
                                          color: notifire.getdarkgreycolor,
                                          fontSize: height / 50,
                                        ),
                                      ),
                                      Container(
                                        height: height / 700,
                                        width: width / 3,
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height / 20,
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(CustomStrings
                                                    .commingsoon)));
                                      },
                                      child: Container(
                                        height: height / 10,
                                        width: width / 5.1,
                                        decoration: BoxDecoration(
                                          color: notifire.getprimerycolor,
                                          borderRadius:
                                              BorderRadius.circular(19),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xff6C56F9)
                                                  .withOpacity(0.11),
                                              blurRadius: 10.0,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            "images/facebook.png",
                                            height: height / 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 12,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(CustomStrings
                                                    .commingsoon)));
                                      },
                                      child: Container(
                                        height: height / 10,
                                        width: width / 5.1,
                                        decoration: BoxDecoration(
                                          color: notifire.getprimerycolor,
                                          borderRadius:
                                              BorderRadius.circular(19),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xff6C56F9)
                                                  .withOpacity(0.11),
                                              blurRadius: 10.0,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            "images/google.png",
                                            height: height / 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      CustomStrings.account,
                                      style: TextStyle(
                                        color: notifire.getdarkgreycolor
                                            .withOpacity(0.6),
                                        fontSize: height / 50,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 100,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(CustomStrings
                                                    .commingsoon)));
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         const Register(),
                                        //   ),
                                        // );
                                      },
                                      child: Text(
                                        CustomStrings.registerhere,
                                        style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: height / 50,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 50),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: -60,
                          child: Center(
                            child: Image.asset(
                              "images/logo_app/ic_launcher_round.webp",
                              height: height / 7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height / 15,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmit(BuildContext context, dynamic formData) async {
    Loading.showLoadingDialog(context, _globalKey);
    try {
      final client =
          ApiClient(Dio(BaseOptions(contentType: "application/json")));

      AuthRes response;
      response = await client.postAuth(formData);
      if (response.status) {
        SharedPrefs().token = response.data['token'].toString();
        SharedPrefs().userData = jsonEncode(response.data['user']);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Bottombar(),
          ),
        );
      } else {
        Navigator.pop(context);
      }
      // print(response.data);
    } on DioException catch (e) {
      Navigator.pop(context);
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response?.data);
        // print(e.response?.headers);
        // print(e.response?.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
      }
    }
  }
}
