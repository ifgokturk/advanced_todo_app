import 'package:advanced_todo_app/core/common/widgets/fading_text.dart';
import 'package:advanced_todo_app/core/common/widgets/white_space.dart';
import 'package:advanced_todo_app/core/extensions/date_extensions.dart';
import 'package:advanced_todo_app/core/resources/colours.dart';
import 'package:advanced_todo_app/features/todo/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
    this.task, {
    required this.endIcon,
    super.key,
    this.onDelete,
    this.onEdit,
    this.bottomMargin,
        this.colour,
  });

  final TaskModel task;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Widget endIcon;
  final double? bottomMargin;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: bottomMargin == null
          ? null
          : EdgeInsets.only(
              bottom: bottomMargin!.h,
            ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColours.kLightGrey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 80.h,
                width: 5.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: colour ?? AppColours.randomColor(),
                ),
              ),
              const WhiteSpace(
                width: 15,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadingText(
                      task.title!,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    const WhiteSpace(
                      height: 3,
                    ),
                    FadingText(
                      task.description!,
                      fontSize: 12,
                    ),
                    const WhiteSpace(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColours.kBackgroundBlack,
                            border: Border.all(
                                width: .3, color: AppColours.kGreyDark),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              ' ${task.startTime!.timeOnly} | ${task.endTime!.timeOnly} ',
                              style: GoogleFonts.poppins(
                                  color: AppColours.kLight, fontSize: 12),
                            ),
                          ),
                        ),
                        if (!task.isCompleted)
                          IconButton(
                              onPressed: onEdit,
                              icon: const Icon(
                                MaterialCommunityIcons.circle_edit_outline,
                                color: AppColours.kLight,
                              )),
                        IconButton(
                          onPressed: onDelete,
                          icon: const Icon(
                            MaterialCommunityIcons.delete_circle,
                            color: AppColours.kLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          endIcon,
        ],
      ),
    );
  }
}
