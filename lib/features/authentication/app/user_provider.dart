
import 'package:advanced_todo_app/core/helper/db_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  @override
  Future<bool> build() async {
    return DBHelper.userExists();
  }
}