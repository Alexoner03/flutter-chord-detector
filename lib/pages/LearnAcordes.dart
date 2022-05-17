import 'package:flutter/material.dart';
import 'package:guitar/pages/TestAudio.dart';

class LearnAcordes extends StatefulWidget {
  const LearnAcordes({Key? key}) : super(key: key);

  @override
  State<LearnAcordes> createState() => _LearnAcordesState();
}

class _LearnAcordesState extends State<LearnAcordes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista de Acordes"),
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

    final acordes = [
      "Do",
      "Re",
      "Mi",
      "Fa",
      "Sol",
      "La",
      "Si",
    ];

    return ListView.builder(
        itemCount: acordes.length,
        itemBuilder: (context, i) {
          return ListTile(
            trailing: const Icon(Icons.music_note),
            title: Text("Tocar " + acordes[i]),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestAudio(2,acordes[i])));
            },
          );
        }
    );
  }
}

