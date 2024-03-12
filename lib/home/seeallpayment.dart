import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kumpulpay/data/shared_prefs.dart';
import 'package:kumpulpay/home/scanpay/scan.dart';
import 'package:kumpulpay/repository/model/data.dart';
import 'package:kumpulpay/repository/retrofit/api_client.dart';
import 'package:kumpulpay/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/string.dart';

class Seeallpayment extends StatefulWidget {
  const Seeallpayment({Key? key}) : super(key: key);

  @override
  State<Seeallpayment> createState() => _SeeallpaymentState();
}

class _SeeallpaymentState extends State<Seeallpayment> {
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

  List insuranceimg = [
    "images/health.png",
    "images/mobile.png",
    "images/water.png",
    "images/ticket.png",
  ];

  List insurancename = [
    CustomStrings.health,
    CustomStrings.mobile,
    CustomStrings.motor,
    CustomStrings.car,
  ];

  List optionimg = [
    "images/assurance.png",
    "images/shopping.png",
    "images/deals.png",
    "images/install.png",
  ];

  List optionname = [
    CustomStrings.assurance,
    CustomStrings.shopping,
    CustomStrings.deals,
    CustomStrings.install,
  ];

  List img = [
    "images/bill.png",
    "images/wifi.png",
    "images/water.png",
    "images/wallet1.png",
    "images/game.png",
    "images/television.png",
    "images/merchant.png",
    "images/install.png",
  ];

  List paymentname = [
    CustomStrings.electricity,
    CustomStrings.internet,
    CustomStrings.water,
    CustomStrings.wallet,
    CustomStrings.games,
    CustomStrings.television,
    CustomStrings.merchant,
    CustomStrings.install,
  ];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifire.getprimerycolor,
        title: Text(
          CustomStrings.allservices,
          style: TextStyle(
              fontFamily: "Gilroy Bold",
              color: notifire.getdarkscolor,
              fontSize: height / 40),
        ),
        actions: [
          Icon(
            Icons.more_horiz_outlined,
            color: notifire.getdarkscolor,
            size: 35,
          ),
          const SizedBox(
            width: 10,
          )
        ],
        iconTheme: IconThemeData(color: notifire.getdarkscolor),
      ),
      backgroundColor: notifire.getprimerycolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 50,
            ),

            _buildBody(context),
            // start prepaid
            Row(
              children: [
                SizedBox(
                  width: width / 20,
                ),
                Text(
                  CustomStrings.bill,
                  style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontSize: height / 50,
                      fontFamily: 'Gilroy Bold'),
                ),
              ],
            ),
            SizedBox(
              height: height / 60,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Container(
                color: Colors.transparent,
                height: height / 4,
                width: width,
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: height / 15),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: height / 10,
                      mainAxisExtent: height / 9,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: height / 50,
                      mainAxisSpacing: height / 50,
                    ),
                    itemCount: img.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Scan(),
                                  ),
                                );
                              },
                              child: Container(
                                height: height / 15,
                                width: width / 7,
                                decoration: BoxDecoration(
                                  color: notifire.gettabwhitecolor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    img[index],
                                    height: height / 30,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height / 60,
                            ),
                            Text(
                              paymentname[index],
                              style: TextStyle(
                                  fontFamily: "Gilroy Bold",
                                  color: notifire.getdarkscolor,
                                  fontSize: height / 60),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            // end prepaid

            // start postpaid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Divider(
                color: notifire.getdarkgreycolor.withOpacity(0.4),
              ),
            ),
            SizedBox(
              height: height / 100,
            ),
            Row(
              children: [
                SizedBox(
                  width: width / 20,
                ),
                Text(
                  CustomStrings.insurance,
                  style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontSize: height / 50,
                      fontFamily: 'Gilroy Bold'),
                ),
              ],
            ),
            SizedBox(
              height: height / 60,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Container(
                color: Colors.transparent,
                height: height / 8,
                width: width,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: height / 15),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: height / 10,
                    mainAxisExtent: height / 9,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: height / 50,
                    mainAxisSpacing: height / 50,
                  ),
                  itemCount: insuranceimg.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            height: height / 15,
                            width: width / 7,
                            decoration: BoxDecoration(
                              color: notifire.gettabwhitecolor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                insuranceimg[index],
                                height: height / 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height / 60,
                          ),
                          Text(
                            insurancename[index],
                            style: TextStyle(
                                fontFamily: "Gilroy Bold",
                                color: notifire.getdarkscolor,
                                fontSize: height / 55),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            // end postpaid

            // start
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Divider(
                color: notifire.getdarkgreycolor.withOpacity(0.4),
              ),
            ),
            SizedBox(
              height: height / 100,
            ),
            Row(
              children: [
                SizedBox(
                  width: width / 20,
                ),
                Text(
                  CustomStrings.option,
                  style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontSize: height / 50,
                      fontFamily: 'Gilroy Bold'),
                ),
              ],
            ),
            SizedBox(
              height: height / 60,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Container(
                color: Colors.transparent,
                height: height / 8,
                width: width,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: height / 15),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: height / 10,
                    mainAxisExtent: height / 9,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: height / 50,
                    mainAxisSpacing: height / 50,
                  ),
                  itemCount: insuranceimg.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            height: height / 15,
                            width: width / 7,
                            decoration: BoxDecoration(
                              color: notifire.gettabwhitecolor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                optionimg[index],
                                height: height / 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height / 60,
                          ),
                          Text(
                            optionname[index],
                            style: TextStyle(
                                fontFamily: "Gilroy Bold",
                                color: notifire.getdarkscolor,
                                fontSize: height / 55),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Divider(
                color: notifire.getdarkgreycolor.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _getProductCategory(BuildContext context) async {
  //   try {
  //     final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));

  //     AuthRes response;
  //     response = await client.postAuth(formData);
  //     if (response.status) {
  //         SharedPrefs().username = "ajasas";
  //         SharedPrefs().token = response.data['token'].toString();
  //         SharedPrefs().userData = jsonEncode(response.data['user']);

  //         print(response.data['token']);

  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const Bottombar(),
  //           ),
  //         );
  //     }
  //     // print(response.data);
  //   } on DioException catch (e) {
  //     // The request was made and the server responded with a status code
  //     // that falls out of the range of 2xx and is also not 304.
  //     if (e.response != null) {
  //       print(e.response?.data);
  //       print(e.response?.headers);
  //       print(e.response?.requestOptions);
  //     } else {
  //       // Something happened in setting up or sending the request that triggered an Error
  //       print(e.requestOptions);
  //       print(e.message);
  //     }
  //   }
  // }

  FutureBuilder<dynamic> _buildBody(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<dynamic>(
      future: client.getProductCategory('Bearer ${SharedPrefs().token}'),
      builder: (context, snapshot) {
        try {
          // print(snapshot);
          if (snapshot.connectionState == ConnectionState.done) {
            // final Map<String,dynamic> parsed = snapshot;
            // print(snapshot.data["data"]);
            List<dynamic> list = snapshot.data["data"];

            return Column(
              children: <Widget>[
                for (var item in list)... [
                  Row(
                    children: [
                      SizedBox(
                        width: width / 20,
                      ),
                      Text(
                        item['name'],
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontSize: height / 50,
                            fontFamily: 'Gilroy Bold'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 20),
                    child: Container(
                      color: Colors.transparent,
                      height: height / 4,
                      width: width,
                      child:Builder(
                        builder: (context) {
                          // any logic needed...
                          List<dynamic> child2 = item["child"];
                          print(child2);
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: height / 15),
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: height / 10,
                              mainAxisExtent: height / 9,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: height / 50,
                              mainAxisSpacing: height / 50,
                            ),
                            itemCount: child2.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Scan(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: height / 15,
                                        width: width / 7,
                                        decoration: BoxDecoration(
                                          color: notifire.gettabwhitecolor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            img[index],
                                            height: height / 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height / 60,
                                    ),
                                    Text(
                                      child2[index]["name"],
                                      style: TextStyle(
                                          fontFamily: "Gilroy Bold",
                                          color: notifire.getdarkscolor,
                                          fontSize: height / 60),
                                    ),
                                  ],
                                ),
                              );
                            });
                        }
                      ),
                      
                    ),
                  ),
                ],  
              ],
            );

            // list.forEach((obj) {//group1
            //   print(obj);
            //   return ListView.builder(
            //       itemCount: ,
            //       itemBuilder: (context, index) {
            //         return Text("aa");
            //       }
            //   );
            // });

            // return Text("aa");
          } else {
            return Text("bb");
          }
          // return Text("vv");
        } on DioException catch (e) {
          if (e.response != null) {
            print(e.response?.data);
            print(e.response?.headers);
            print(e.response?.requestOptions);
          } else {
            // Something happened in setting up or sending the request that triggered an Error
            print(e.requestOptions);
            print(e.message);
          }
        }

        return Text("aa");
      },
    );
  }
}