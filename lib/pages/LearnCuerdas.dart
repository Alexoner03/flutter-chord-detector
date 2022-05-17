import 'package:flutter/material.dart';
import 'package:guitar/pages/TestAudio.dart';

class LearnCuerdas extends StatefulWidget {
  const LearnCuerdas({Key? key}) : super(key: key);

  @override
  State<LearnCuerdas> createState() => _LearnCuerdasState();
}

class _LearnCuerdasState extends State<LearnCuerdas> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Cuerdas"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                child: const Icon(
                  Icons.home,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _lista()
    );
  }

  Widget _lista(){

    final cuerdas = [
      "A",
      "B",
      "D",
      "E",
      "Egrave",
      "G",
    ];

    return ListView.builder(
        itemCount: cuerdas.length,
        itemBuilder: (context, i) {
          return ListTile(
            trailing: const Icon(Icons.music_note),
            title: Text("Tocar " + cuerdas[i]),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestAudio(1,cuerdas[i])));
            },
          );
        }
    );
  }

}

