import 'package:advanced_todo_app/features/todo/app/task_provider.dart';
import 'package:advanced_todo_app/features/todo/utils/todo_utils.dart';
import 'package:advanced_todo_app/features/todo/views/add_task_screen.dart';
import 'package:advanced_todo_app/features/todo/widgets/task_expansion_tile.dart';
import 'package:advanced_todo_app/features/todo/widgets/todo_tile.dart';
import 'package:flutter/material.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class TasksForTomorrow extends ConsumerWidget {
  const TasksForTomorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return FutureBuilder(
      future: TodoUtils.getTasksForTomorrow(tasks),
      builder: (_, snapsShot) {
        if (snapsShot.hasData && snapsShot.data != null) {
          return TaskExpansionTile(
            title: "Tomorrow 's Tasks",
            subtitle: "Tomorrow's tasks are shown here",
            children: snapsShot.data!.map((task) {
              final isLast = snapsShot.data!
                      .indexWhere((element) => element.id == task.id) ==
                  snapsShot.data!.length - 1;
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
                      builder: (_) => AddOrEditTaskScreen(
                        tasks: task,
                      ),
                    ),
                  );
                },
                endIcon: const Icon(
                  AntDesign.checkcircle,
                  color: Colors.green,
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
