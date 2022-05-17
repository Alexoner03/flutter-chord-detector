import 'package:flutter/material.dart';
import 'package:guitar/models/Question.dart';
import 'package:audioplayers/audioplayers.dart';

import '../models/QuestionType.dart';

class LearnAudition extends StatefulWidget {
  final List<Question> questions;
  final int level;
  const LearnAudition(
      {
        required this.questions,
        required this.level,
        Key? key
      }
      ) : super(key: key);

  @override
  State<LearnAudition> createState() => _LearnAuditionState();
}

class _LearnAuditionState extends State<LearnAudition> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  List<int> values = [];
  // AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();


  @override
  void initState() {
    setState(() {
      values = widget.questions.map((e) => -1).toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Memoria Auditiva nivel : " + widget.level.toString()),
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
        body: Stepper(
          steps: buildSteps(),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Row(
              children:  [
                TextButton(
                  onPressed: details.onStepContinue,
                  child: Text(_currentStep < widget.questions.length - 1 ? 'Continuar' : 'Finalizar'),
                ),
                _currentStep > 0 ? TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Regresar'),
                ) : Container(),
              ],
            );
          },
          type: stepperType,
          physics: const ScrollPhysics(),
          currentStep: _currentStep,
          onStepTapped: (step) => tapped(step),
          onStepContinue:  continued,
          onStepCancel: cancel,
        )
    );
  }

  List<Step> buildSteps(){
    return widget.questions.map((q) {

      int listIndex = widget.questions.indexWhere((element) => element.name == q.name);
      return Step(
        content: Column(
          children: [
            Text(q.name),
            q.type == QuestionType.image ? Image(
              image: AssetImage('assets/exam/${q.asset}.png'),
              height: 250,
            ) : MaterialButton(
              onPressed: () async {
                await playLocal(q.asset);
              },
              color: Colors.indigo,
              textColor: Colors.white,
              child: const Icon(Icons.play_arrow, size: 50),
              shape: const CircleBorder(),
            ),
            ...q.answers.map((a){
              int nestedListIndex = q.answers.indexWhere((element) => element.name == a.name);
              return ListTile(
                title: Text(a.name),
                leading: Radio(
                  value: nestedListIndex,
                  groupValue: values[listIndex],
                  onChanged: (value) {
                    setState(() {
                      values[listIndex] = value as int;
                    });
                  },
                ),
              );
            })
          ],
        ),
        title: const Text("")
      );
    }).toList();
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < widget.questions.length - 1 ?
    setState(() => _currentStep += 1): sendForm();
  }

  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

  playLocal(String path) async {
    await audioCache.play('exam/${path}.wav');
  }

  sendForm(){

  }
}

