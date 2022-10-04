import 'package:flutter/material.dart';
import 'package:repos/components/task.dart';

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
        leading: Container(),
        title: const Text('Tarefas'),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: const Duration(milliseconds: 1000),
        child: ListView(children: const [
          Task('Aprender Flutter', 'assets/images/dash.png', 4),
          Task('Andar de bike', 'assets/images/bike.webp', 2),
          Task('Meditar', 'assets/images/meditar.jpeg', 5),
          Task('Jogar video-game', 'assets/images/jogar.jpg', 1),
          Task('Ler', 'assets/images/livro.jpg', 2),
          SizedBox(
            height: 80,
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black45,
        child: const Icon(Icons.remove_red_eye),
        onPressed: () {
          setState(() {
            opacidade = !opacidade;
          });
        },
      ),
    );
  }
}
