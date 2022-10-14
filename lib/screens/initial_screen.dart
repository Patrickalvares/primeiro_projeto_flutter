import 'package:flutter/material.dart';
import 'package:repos/data/task_inherited.dart';
import 'package:repos/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.check_circle_outline_sharp,
          size: 40,
        ),
        title: const Text('Tarefas'),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: const Duration(milliseconds: 1000),
        child: ListView(
          children: TaskIncherited.of(context).taskList,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: FloatingActionButton(
              backgroundColor: Colors.black45,
              child: const Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  opacidade = !opacidade;
                });
              },
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contextNew) => FormScreen(taskContext: context),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
