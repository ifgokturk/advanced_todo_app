import 'package:advanced_todo_app/core/resources/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common/widgets/white_space.dart';

class TaskExpansionTile extends StatefulWidget {
  const TaskExpansionTile({
    required this.title,
    required this.subtitle,
    required this.children,
    super.key,
  });

  final String title;
  final String subtitle;
  final List<Widget>  children;

  @override
  State<TaskExpansionTile> createState() => _TaskExpansionTileState();
}

class _TaskExpansionTileState extends State<TaskExpansionTile> {
  late Color colour;
  final controller = ExpansionTileController();

  @override
  void initState() {
    colour = AppColours.randomColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColours.randomColor(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          onExpansionChanged: (_) => setState(() {}),
          title: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  height: 80.h,
                  width: 5.w,
                  decoration: BoxDecoration(
                    color: colour,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const WhiteSpace(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tomorrow's Tasks",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          controller: controller,
          trailing: Builder(builder: (secondContext) {
            final innerController = ExpansionTileController.of(secondContext);

            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: innerController.isExpanded ?
              Icon( AntDesign.closecircleo,color: AppColours.randomColor(),)
                  :
                  Icon(  AntDesign.circledown,color: AppColours.randomColor(),)
              );

          }),
      children: widget.children,
        ),
      ),
    );
  }
}
