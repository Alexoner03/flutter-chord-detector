import 'package:flutter/material.dart';
import 'LearnAudition.dart';
import 'package:guitar/models/QAS.dart';

class SelectLevelAudition extends StatefulWidget {
  const SelectLevelAudition(
      {
        Key? key
      }
      ) : super(key: key);

  @override
  State<SelectLevelAudition> createState() => _SelectLevelAuditionState();
}

class _SelectLevelAuditionState extends State<SelectLevelAudition> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Selecciona un nivel"),
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

    final niveles = [
      "1",
      "2",
      "3",
    ];

    return ListView.builder(
        itemCount: niveles.length,
        itemBuilder: (context, i) {
          return ListTile(
            trailing: const Icon(Icons.music_note),
            title: Text("Nivel " + niveles[i]),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LearnAudition(
                          questions : QAS.getQuestions(i+1),
                          level: i + 1,
                      )
                  )
              );
            },
          );
        }
    );
  }

}

