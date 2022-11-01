import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:repos/data/task_dao.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  Task(this.nome, this.foto, this.dificuldade, {Key? key}) : super(key: key);

  int nivel = 0;

  @override
  State<Task> createState() => _TaskState();
}
class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }
    return true;
  }

  double valor = 0.01;
  int i = 0;
  List<Color> corBarra = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.deepOrange
  ];

  verificarValor() {
    if (valor > 0 && valor <= 1) {
      valor = (valor + (0.25 / widget.dificuldade));
    } else {
      if (i < corBarra.length - 1) {
        i++;
      } else {
        i = 0;
      }
      valor = 0.01;
    }
  }

  @override
  Widget build(BuildContext context) {

    showDeleteAlert(BuildContext context) {
      Widget cancelaButton = FloatingActionButton(
        child: Text("Não"),
        onPressed:  () {Navigator.pop(context);},
      );
      Widget continuaButton = FloatingActionButton(
        child: Text("Sim"),
        onPressed:  () {Navigator.pop(context);
          TaskDao().delete(widget.nome);},
      );
      //configura o AlertDialog
      //configura o AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Confirmar"),
        content: Text("Deseja deletar a tarefa?"),
        actions: [
          cancelaButton,
          continuaButton,
        ],
      );
      //exibe o diálogo
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: corBarra[i],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black26),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: assetOrNetwork()
                            ? Image.asset(
                                widget.foto,
                                fit: BoxFit.cover,
                              )
                            : Image.network(widget.foto, fit: BoxFit.cover),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.nome,
                            style: const TextStyle(fontSize: 24),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Difficulty(difficultyLevel: widget.dificuldade),
                      ],
                    ),

                    SizedBox(
                      height: 52,
                      width: 72,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: ElevatedButton(
                          onLongPress: (){showDeleteAlert(context);},
                            onPressed: () {
                              setState(() {
                                verificarValor();
                                widget.nivel++;
                              });
                              if (kDebugMode) {
                                print(widget.nivel);
                              }
                            },
                            child: (Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(Icons.arrow_drop_up),
                                Text(
                                  'UP',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ))),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: valor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nivel : ${widget.nivel}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
