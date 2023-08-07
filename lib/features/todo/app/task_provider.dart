import 'dart:math';

import 'package:advanced_todo_app/core/helper/db_helper.dart';
import 'package:advanced_todo_app/core/resources/colours.dart';
import 'package:advanced_todo_app/features/todo/app/task_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/task_model.dart';

part 'task_provider.g.dart';

@riverpod
class Task extends _$Task {
  @override
  List<TaskModel> build() => [];

  void refresh() async {
    final data = await DBHelper.getTask();

    /* final tasks = [];

    for (final task in data) {
      tasks.add(
        TaskModel.fromMap(task),
      );
    }*/
    //? Üst taraftaki kodların yerine aşağıdaki şekilde yazılabilir

    state = data.map(
      (taskData) {
        return TaskModel.fromMap(taskData);
      },
    ).toList();
  }

  Future<void> addTask(TaskModel task) async {
    await DBHelper.addTask(task);
    refresh();
  }

  Future<void> deleteTask(int taskId) async {
    await DBHelper.deleteTask(taskId);
    refresh();
  }

  Future<void> updateTask(TaskModel task) async {
    await DBHelper.updateTask(task);
    refresh();
  }

  Future<void> markAsCompleted(TaskModel task) async {
    await updateTask(task);
  }
}
