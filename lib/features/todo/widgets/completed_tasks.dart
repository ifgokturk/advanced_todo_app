import 'package:advanced_todo_app/core/resources/colours.dart';
import 'package:advanced_todo_app/features/todo/app/task_provider.dart';
import 'package:advanced_todo_app/features/todo/utils/todo_utils.dart';
import 'package:advanced_todo_app/features/todo/views/add_task_screen.dart';
import 'package:advanced_todo_app/features/todo/widgets/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompletedTasksScreen extends ConsumerWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    return FutureBuilder(
        future: TodoUtils.getCompletedTasksForToday(tasks),
        builder: (_, snapsShot) {
          if (snapsShot.hasData && snapsShot.data != null) {
            if (snapsShot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No Completed tasks',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return ColoredBox(
              color: AppColours.kBackgroundLight,
              child: ListView.builder(
                itemCount: snapsShot.data!.length,
                itemBuilder: (_, index) {
                  final task = snapsShot.data![index];
                  //      final colour=ref.read(taskProvider.notifier).randomColor();
                  final isLast = index == snapsShot.data!.length - 1;
                  return TodoTile(
                    task,
                    bottomMargin: isLast ? null : 11,
                    onDelete: () {
                      ref.read(taskProvider.notifier).deleteTask(task.id!);
                    },
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>  AddOrEditTaskScreen(tasks: task,),
                        ),
                      );
                    },
                    endIcon:const  Icon(AntDesign.checkcircle, color: Colors.green,)
                  );
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
