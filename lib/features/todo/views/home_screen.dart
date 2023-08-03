import 'package:advanced_todo_app/core/common/widgets/filled_field.dart';
import 'package:advanced_todo_app/core/common/widgets/white_space.dart';
import 'package:advanced_todo_app/core/helper/db_helper.dart';
import 'package:advanced_todo_app/features/authentication/views/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/colours.dart';
import 'add_task_screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final tabController = useTabController(initialLength: 2);
    final tabTextStyle = GoogleFonts.poppins(
      fontSize: 16,
      color: AppColours.kGreyBackground,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: IconButton(
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          await DBHelper.deleteUser();
                          navigator.pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => const SignInScreen()),
                              (route) => false);
                        },
                        icon: const Icon(
                          AntDesign.logout,
                          color: AppColours.kLight,
                        ),
                      ),
                    ),
                    Text(
                      'Task MAnagement',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: AppColours.kLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        backgroundColor: AppColours.kLight,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>const AddTaskScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        color: AppColours.kGreen,
                        Icons.add,
                      ),
                    )
                  ],
                ),
                const WhiteSpace(
                  height: 20,
                ),
                const FilledField(
                  prefixIcon: Icon(
                    AntDesign.search1,
                    color: AppColours.kLightGrey,
                  ),
                  hintText: 'Search',
                  suffixIcon: Icon(
                    FontAwesome.sliders,
                    color: AppColours.kLightGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          children: [
            Row(
              children: [
                const Icon(
                  FontAwesome.tasks,
                  size: 20,
                  color: AppColours.kLightGrey,
                ),
                const WhiteSpace(
                  width: 10,
                ),
                Text("Today's Text",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColours.kLight,
                    )),
              ],
            ),
            const WhiteSpace(
              height: 25,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ColoredBox(
                color: AppColours.kLight,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: AppColours.kGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  isScrollable: false,
                  labelPadding: EdgeInsets.zero,
                  labelColor: AppColours.kBlueLight,
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 24,
                    color: AppColours.kBlueLight,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelColor: AppColours.kLight,
                  controller: tabController,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: screenWidth * .5,
                        child: Center(
                          child: Text(
                            'Pending',
                            style: tabTextStyle,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: screenWidth * .5,
                        child: Center(
                          child: Text(
                            'Completed',
                            style: tabTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const WhiteSpace(
              height: 20,
            ),
            SizedBox(
              height: screenHeight * .26,
              child: TabBarView(
                controller: tabController,
                children: [
                  ColoredBox(
                    color: Colors.yellow,
                  ),
                  ColoredBox(
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
