import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final String keyword;
  final int maxLines;
  final TextStyle textStyle;
  final TextStyle highlightStyle;

  const HighlightedText({
    Key? key,
    required this.text,
    required this.maxLines,
    required this.keyword,
    this.textStyle = const TextStyle(color: Colors.black),
    this.highlightStyle = const TextStyle(color: Colors.red),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (keyword.isEmpty) {
      return Text(
        text,
        style: textStyle,
        maxLines: maxLines,
      );
    }
    List<TextSpan> spans = [];

    int start = 0;
    int indexOfKeyword;
    while ((indexOfKeyword = text.indexOf(keyword, start)) != -1) {
      // Aggiungi il testo prima della keyword
      if (indexOfKeyword > start) {
        spans.add(TextSpan(text: text.substring(start, indexOfKeyword)));
      }

      // Aggiungi la keyword con lo stile evidenziato
      spans.add(TextSpan(text: keyword, style: highlightStyle));

      // Aggiorna la posizione di inizio per la prossima ricerca
      start = indexOfKeyword + keyword.length;
    }

    // Aggiungi qualsiasi testo rimanente dopo l'ultima keyword
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start, text.length)));
    }

    return RichText(
      maxLines: maxLines,
      text: TextSpan(
        style: textStyle,
        children: spans,
      ),
    );
  }
}
