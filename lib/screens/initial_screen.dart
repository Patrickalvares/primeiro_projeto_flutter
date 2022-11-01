import 'package:flutter/material.dart';
import 'package:repos/data/task_dao.dart';
import 'package:repos/data/task_inherited.dart';
import 'package:repos/screens/form_screen.dart';

import '../components/task.dart';

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
            const Text(
              'Tarefas',
              style: TextStyle(fontSize: 25),
            ),
            Row(
              children: [
                Column(
                  children: const [
                    Text(
                      'Nivel',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Text(
                  " : ${totalNivel}",
                  style: const TextStyle(fontSize: 35),
                ),
              ],
            ),
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.pinkAccent),
                ),
                onPressed: () {
                  setState(() {
                    totalNivel = TaskInherited.of(context).totalLevel();
                  });
                },
                child: const Icon(Icons.refresh))
          ],
        ),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: const Duration(milliseconds: 1000),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 80),
          child: FutureBuilder<List<Task>>(
              future: TaskDao().findAll(),
              builder: (context, snapshot) {
                List<Task>? itens = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text('Carregando...')
                        ],
                      ),
                    );
                    break;
                  case ConnectionState.waiting:
                    return Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text('Carregando...')
                        ],
                      ),
                    );
                    break;
                  case ConnectionState.active:
                    return Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text('Carregando...')
                        ],
                      ),
                    );
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData && itens != null) {
                      if (itens.isNotEmpty) {
                        return ListView.builder(
                            itemCount: itens.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Task tarefa = itens[index];
                              return tarefa;
                            });
                      }
                      return Center(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.error_outline,
                              size: 128,
                            ),
                            Text(
                              'Não há nenhuma Tarefa',
                              style: TextStyle(fontSize: 32),
                            )
                          ],
                        ),
                      );
                    }
                    return const Text(' Erro ao carregar Tarefas');
                    break;
                }
                return Text('Erro desconhecido');
              }),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: FloatingActionButton(
              backgroundColor: Colors.black26,
              child: const Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  opacidade = !opacidade;
                });
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contextNew) => FormScreen(
                    taskContext: context,
                  ),
                ),
              ).then((value) => setState(() {
                print('Recarregando a tela inicial');
              }));
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
