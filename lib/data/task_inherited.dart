import 'package:flutter/material.dart';

import '../components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/dash.png', 4),
    Task('Andar de bike', 'assets/images/bike.webp', 2),
    Task('Meditar', 'assets/images/meditar.jpeg', 5),
    Task('Jogar video-game', 'assets/images/jogar.jpg', 1),
    Task('Ler', 'assets/images/livro.jpg', 2),
  ];


  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(name, photo, difficulty));
  }

  int totalLevel() {
    int total = 0;
    for (int i = 0; i < (taskList.length); i++) {
      total += taskList[i].nivel;
    }
    return total;
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != taskList.length;
  }
}
