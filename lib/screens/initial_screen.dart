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
  int totalNivel = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.check_circle_outline_sharp,
          size: 40,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tarefas'),
            Container(
              child: Text(
                'Nivel total: ${totalNivel}',
                style: TextStyle(
                    fontSize: 18.0, decoration: TextDecoration.underline),
              ),
            ),
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.pinkAccent),
                ),
                onPressed: () {
                  setState(() {
                    totalNivel = TaskIncherited.of(context).totalLevel();
                  });
                },
                child: Icon(Icons.refresh))
          ],
        ),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: const Duration(milliseconds: 1000),
        child: ListView(
          children: TaskIncherited.of(context).taskList/*List<Widget>.from(TaskIncherited.of(context).taskList)
            ..add(
              SizedBox(
                height: 80,
              ),
            )*/,
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
            backgroundColor: Colors.black26,
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
