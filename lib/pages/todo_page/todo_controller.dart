import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/todo/task.dart';

class TodoController extends GetxController {
  void completeTask(RxList<Task> taskList, Task task) {
    final int taskIndex = taskList.indexOf(task);
    taskList[taskIndex].completed();
    Controller.to.setData();
  }
}
