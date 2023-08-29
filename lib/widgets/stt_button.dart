import 'package:flutter/material.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// A button that listens to the user's voice input and returns the text
class SttButton extends StatefulWidget {
  final String localeId;
  final Function(String text) onVoiceInput;
  final Function(bool isListening)? onStateChange;
  final int listeningTime;
  final double size;
  final Color? color;
  final String tooltip;

  const SttButton({
    Key? key,
    required this.localeId,
    required this.onVoiceInput,
    this.onStateChange,
    this.listeningTime = 15,
    this.size = 48,
    this.tooltip = "Activate Speech To Text",
    this.color,
  }) : super(key: key);

  @override
  State<SttButton> createState() => _SttButtonState();
}

class _SttButtonState extends State<SttButton> {
  SpeechToText speechToText = SpeechToText();
  bool isListening = false;
  String stt_result = '';

  @override
  void initState() {
    super.initState();
    speechToText = SpeechToText();
  }

  void listen() async {
    if (!isListening) {
      bool available = await speechToText.initialize(
        onStatus: (status) {
          if (status == "notListening") {
            if (widget.onStateChange != null) widget.onStateChange!(false);
            isListening = false;
          }
        },
      );
      if (available) {
        setState(() {
          isListening = true;
        });
        if (widget.onStateChange != null) widget.onStateChange!(true);
        speechToText.listen(
          localeId: widget.localeId,
          listenMode: ListenMode.dictation,
          //listenFor: Duration(seconds: widget.listeningTime),
          pauseFor: Duration(seconds: widget.listeningTime),
          onResult: (result) {
            setState(() {
              stt_result = "";
              for (SpeechRecognitionWords speechRecognitionWords in result.alternates) {
                stt_result += speechRecognitionWords.recognizedWords;
              }
              if (speechToText.isListening) {
                widget.onVoiceInput(stt_result.toLowerCase());
              }
            });
          },
        );
      }
    } else {
      setState(() {
        isListening = false;
      });
      speechToText.stop();
      if (widget.onStateChange != null) widget.onStateChange!(false);
      widget.onVoiceInput("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return /* AvatarGlow(
        animate: isListening,
        repeat: true,
        endRadius: widget.size,
        duration: const Duration(milliseconds: 1200),
        glowColor: widget.color ?? Theme.of(context).primaryColor,
        child: CustomTextIconButton(
          isLoading: false,
          icon: Icon(isListening ? Icons.mic : Icons.mic_none, color: AppTheme.of(context).primaryBackground),
          text: 'Speech',
          onTap: listen,
        )
        /* FloatingActionButton(
        onPressed: listen,
        tooltip: widget.tooltip,
        child: Icon(isListening ? Icons.mic : Icons.mic_none),
      ), */
        ); */
        CustomTextIconButton(
      isLoading: false,
      height: widget.size,
      icon: Icon(isListening ? Icons.mic : Icons.mic_none, color: AppTheme.of(context).primaryBackground),
      text: 'Speech',
      onTap: listen,
    );
  }
}
