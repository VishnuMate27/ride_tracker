import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_tracker/controller/homeController.dart';

class MyRideScreen extends StatefulWidget {
  const MyRideScreen({super.key});

  @override
  State<MyRideScreen> createState() => _MyRideScreenState();
}

class _MyRideScreenState extends State<MyRideScreen> {
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            size: 24.sp,
            color: Color(0xFF5E5E5E),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Suggested Routes",
          style: GoogleFonts.workSans(
            textStyle: TextStyle(
              color: Color(0xFF202020),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Color(0xFFF3F3F3),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: homeController.getRouteApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: const CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: homeController.routeList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(top: 8.h, left: 15.w, right: 15.w),
                        child: Card(
                          child: Column(
                            children: [
                              //! Image Container
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    height: 199.h,
                                    width: 335.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      image: DecorationImage(
                                          image: NetworkImage(homeController
                                              .routeList[index].image!),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Container(
                                    height: 71.h,
                                    width: 335.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        boxShadow: [
                                          BoxShadow(blurRadius: 0.25)
                                        ]),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 16.w, right: 16.w, top: 12.w),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                          'assets/icons/map-pin-fill.png'),
                                                      Image.asset(
                                                          'assets/icons/line.png'),
                                                      Image.asset(
                                                          'assets/icons/map-pin-fill-1.png'),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        homeController
                                                            .routeList[index]
                                                            .startLoc!,
                                                        style: GoogleFonts
                                                            .workSans(
                                                          textStyle: TextStyle(
                                                            color: Color(
                                                                0xFF202020),
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        homeController
                                                            .routeList[index]
                                                            .endLoc!,
                                                        style: GoogleFonts
                                                            .workSans(
                                                          textStyle: TextStyle(
                                                            color: Color(
                                                                0xFF202020),
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    homeController.postRouteApi(
                                                        index,
                                                        homeController
                                                            .routeList[index]
                                                            .bookmarked!);
                                                  });
                                                },
                                                icon: Icon(
                                                  CupertinoIcons.heart_fill,
                                                  color: homeController
                                                          .routeList[index]
                                                          .bookmarked!
                                                      ? Colors.red
                                                      : Color(0xFF939393),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
