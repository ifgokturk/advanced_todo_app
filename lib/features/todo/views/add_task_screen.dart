import 'package:advanced_todo_app/core/common/widgets/filled_field.dart';
import 'package:advanced_todo_app/core/common/widgets/round_button.dart';
import 'package:advanced_todo_app/core/common/widgets/white_space.dart';
import 'package:advanced_todo_app/core/resources/colours.dart';
import 'package:advanced_todo_app/core/utils/core_utils.dart';
import 'package:advanced_todo_app/features/todo/app/task_date_provider.dart';
import 'package:advanced_todo_app/features/todo/app/task_provider.dart';
import 'package:advanced_todo_app/features/todo/models/task_model.dart';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:intl/intl.dart';

class AddOrEditTaskScreen extends StatefulHookConsumerWidget {
  const AddOrEditTaskScreen({super.key, this.tasks});
  final TaskModel? tasks;

  @override
  ConsumerState<AddOrEditTaskScreen> createState() =>
      _AddOrEditTaskScreenState();
}

class _AddOrEditTaskScreenState extends ConsumerState<AddOrEditTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.tasks != null) {
        ref.read(taskDateProvider.notifier).changeData(widget.tasks!.date!);
        ref
            .read(taskStartTimeProvider.notifier)
            .changeTime(widget.tasks!.startTime!);
        ref
            .read(taskEndTimeProvider.notifier)
            .changeTime(widget.tasks!.endTime!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController(text: widget.tasks?.title);
    final descriptionController =
        useTextEditingController(text: widget.tasks?.description);
    final hintStyle = GoogleFonts.poppins(
      fontSize: 16,
      color: AppColours.kLightGrey,
      fontWeight: FontWeight.bold,
    );
    final dateNotifier = ref.read(taskDateProvider.notifier);
    final startTimeNotifier = ref.read(taskStartTimeProvider.notifier);
    final endTimeNotifier = ref.read(taskEndTimeProvider.notifier);
    final dateProvider = ref.watch(taskDateProvider);
    final startProvider = ref.watch(taskStartTimeProvider);
    final endProvider = ref.watch(taskEndTimeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColours.kLight,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            const WhiteSpace(
              height: 20,
            ),
            FilledField(
              controller: titleController,
              hintText: 'Add Title',
              hintStyle: hintStyle,
            ),
            const WhiteSpace(
              height: 20,
            ),
            FilledField(
              controller: descriptionController,
              hintText: 'Add Description',
              hintStyle: hintStyle,
            ),
            const WhiteSpace(
              height: 20,
            ),
            RoundButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    minTime: DateTime.now(),
                    maxTime: DateTime(DateTime.now().year + 1),
                    theme: DatePickerTheme(
                      doneStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.pink,
                      ),
                    ), onConfirm: (date) {
                  dateNotifier.changeData(date);
                });
              },
              text: dateProvider == null ? 'Set Date' : dateNotifier.date()!,
              backgroundColour: AppColours.kBlueLight,
              borderColour: AppColours.kRed,
            ),
            const WhiteSpace(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: RoundButton(
                    onPressed: () {
                      if (dateProvider == null) {
                        CoreUtils.showSnackBar(
                            context: context,
                            message: 'Please pick a Date first');
                        return;
                      }
                      DatePicker.showDateTimePicker(
                        context,
                        currentTime: dateProvider,
                        onConfirm: (time) {
                          startTimeNotifier.changeTime(time);
                        },
                      );
                    },
                    text: startProvider == null
                        ? 'Start Time'
                        : startTimeNotifier.time()!,
                    backgroundColour: AppColours.kGreen,
                    borderColour: AppColours.kRed,
                  ),
                ),
                const WhiteSpace(width: 20),
                Expanded(
                  child: RoundButton(
                    onPressed: () {
                      if (startProvider == null) {
                        CoreUtils.showSnackBar(
                            context: context,
                            message: 'Please pick a Start Time first');
                        return;
                      }
                      DatePicker.showDateTimePicker(
                        context,
                        currentTime: dateProvider,
                        onConfirm: (time) {
                          endTimeNotifier.changeTime(time);
                        },
                      );
                    },
                    text: endProvider == null
                        ? 'End Time'
                        : endTimeNotifier.time()!,
                    backgroundColour: AppColours.kYellow,
                    borderColour: AppColours.kRed,
                  ),
                ),
              ],
            ),
            const WhiteSpace(
              height: 20,
            ),
            RoundButton(
              onPressed: () async {
                if (titleController.text.trim().isNotEmpty &&
                    descriptionController.text.trim().isNotEmpty &&
                    dateProvider != null &&
                    startProvider != null &&
                    endProvider != null)
                // TODO : Add Task To Database
                {
                  final title = titleController.text.trim();
                  final description = descriptionController.text.trim();
                  final date = dateProvider;
                  final startTime = startProvider;
                  final endTime = endProvider;
                  final navigator = Navigator.of(context);
                  CoreUtils.showLoader(context);
                  final task = TaskModel(
                    id: widget.tasks?.id,
                    repeat: widget.tasks == null ? true : widget.tasks!.repeat,
                    remind: widget.tasks == null ? true : widget.tasks!.repeat,
                    title: title,
                    description: description,
                    startTime: startTime,
                    endTime: endTime,
                    date: date,
                  );

                  if (widget.tasks != null) {
                    await ref.read(taskProvider.notifier).updateTask(task);
                  } else {
                    await ref.read(taskProvider.notifier).addTask(task);
                  }

                  navigator
                    ..pop()
                    ..pop();
                } else {
                  CoreUtils.showSnackBar(
                      context: context, message: "All fields are required...");
                }
              },
              text: 'Submit',
              backgroundColour: AppColours.kLight,
              borderColour: AppColours.kRed,
            ),
          ],
        ),
      ),
    );
  }
}
