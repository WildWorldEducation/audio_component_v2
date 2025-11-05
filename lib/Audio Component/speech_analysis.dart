import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechAnalysis extends StatefulWidget {
  const SpeechAnalysis({Key? key}) : super(key: key);

  @override
  _SpeechAnalysisState createState() => _SpeechAnalysisState();
}

class _SpeechAnalysisState extends State<SpeechAnalysis> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String _pronounciationResult = '';
  int _symbolNumber = 0;
  var symbolNames = ['cat', 'dog', 'pig'];

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;

      if (result.finalResult) {
        if (_lastWords == symbolNames[_symbolNumber]) {
          _pronounciationResult = '';
          _nextQuestion();
        } else {
          _pronounciationResult = 'try again';
        }
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _symbolNumber = _symbolNumber + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _speechToText.isNotListening
                          ? _startListening
                          : _stopListening,

                      // child: Icon(_speechToText.isNotListening
                      //     ? Icons.mic_off
                      //     : Icons.mic),
                      child: Text(_speechToText.isNotListening
                          ? 'press to speak'
                          : 'try again'),
                    ))),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(_speechToText.isListening ? _lastWords : '',
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                      _speechEnabled
                          ? '(Speech is available)'
                          : '(Speech not available)',
                      style: const TextStyle(color: Colors.grey, fontSize: 16)),
                )),
            // Text(
            //   _pronounciationResult,
            //   style: const TextStyle(color: Colors.white, fontSize: 50),
            // ),
          ],
        ));
  }
}
