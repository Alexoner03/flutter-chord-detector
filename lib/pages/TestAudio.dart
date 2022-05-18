import 'package:flutter/material.dart';
import 'package:guitar/models/BackendModels.dart';
import 'package:tflite_audio/tflite_audio.dart';
import 'package:guitar/providers/BackendProvider.dart';
import 'package:provider/provider.dart';

class TestAudio extends StatefulWidget {
  final int type;
  final String arg;
  const TestAudio(this.type, this.arg, {Key? key}) : super(key: key);

  @override
  State<TestAudio> createState() => _TestAudioState();
}

class _TestAudioState extends State<TestAudio> {

  final types = [
    "Cuerda",
    "Acorde"
  ];

  final folders = [
    "notes",
    "chords"
  ];

  String _sound = "Presiona para empezar a escucharte";
  bool _recording = false;
  bool isOk = false;
  late Stream<Map<dynamic, dynamic>> result;

  @override
  void initState() {
    super.initState();
    TfliteAudio.loadModel(
      model: widget.type == 1 ? 'assets/soundclassifier_with_metadata.tflite' : 'assets/soundclassifier_with_metadata_chords.tflite',
      label: widget.type == 1 ?  'assets/labels.txt' : 'assets/labels_chords.txt',
      numThreads: 2,
      isAsset: true,
      inputType: 'rawAudio',
    );

  }

  void _recorder() {
    String recognition = "";
    if (!_recording) {
      setState(() => _recording = true);

      result = TfliteAudio.startAudioRecognition(
        numOfInferences: widget.type == 1 ? 5 : 8,
        sampleRate: 44100,
        audioLength: 44032,
        bufferSize: 22016,
        detectionThreshold: 0.7
      );
      result.listen((event) {
        setState(() {
          _sound = "Escuchando...";
        });
        recognition = event["recognitionResult"];
        if(recognition.split(" ")[1] == widget.arg){
          TfliteAudio.stopAudioRecognition();
          setState(() {
            _sound = "Excelente! Regresa para continuar";
            isOk = true;
          });
        }else{
          isOk = false;
        }
      }).onDone(() {
        if(!isOk){
          setState(() => _sound = "Intentalo de nuevo..");
        }

        setState(() => _recording = false);
      });
    }
  }

  void _stop() {
    TfliteAudio.stopAudioRecognition();
    setState(() {
      _recording = false;
      isOk = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    String image = 'assets/${folders[widget.type - 1]}/${widget.arg.toUpperCase()}.png';


    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Tocar " + types[widget.type - 1] + " " + widget.arg),
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image(
                image: AssetImage(image),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
              MaterialButton(
                onPressed: _recorder,
                color: _recording ? Colors.grey : Colors.pink,
                textColor: Colors.white,
                child: const Icon(Icons.mic, size: 50),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(25),
              ),
              Text(
                _sound,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    TfliteAudio.stopAudioRecognition();
    setState(() {
      _recording = false;
      isOk = true;
    });

    super.dispose();

  }


  sendToBackend(double score) async {
    UserInfo _userInfo = Provider.of<BackendProvider>(context).userInfo!;


    if(widget.type == 1) {
      List<Sound> notes = _userInfo.notes.map((e) {
        if(e.name == widget.arg){
          e.score = score;
        }
        return e;
      }).toList();
      await Provider.of<BackendProvider>(context).updateNotes(notes);
    }else {
      List<Sound> chords = _userInfo.chords.map((e) {
        if(e.name == widget.arg){
          e.score = score;
        }
        return e;
      }).toList();
      await Provider.of<BackendProvider>(context).updateChords(chords);
    }

  }
}
