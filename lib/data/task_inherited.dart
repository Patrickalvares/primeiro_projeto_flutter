import 'package:flutter/material.dart';

import '../components/task.dart';

class TaskIncherited extends InheritedWidget {
  TaskIncherited({
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

  static TaskIncherited of(BuildContext context) {
    final TaskIncherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskIncherited>();
    assert(result != null, 'No TaskIncherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskIncherited old) {
    return old.taskList.length != taskList.length;
  }
}
