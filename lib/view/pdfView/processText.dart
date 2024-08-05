import 'package:bookpdf/view/pdfView/pdfWidgets.dart';
import 'package:bookpdf/viewModel/answerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

class ProcessText {
  var controller = Get.put(AnswerViewModel());
  getMeaning(text, BuildContext context) async {
    final gemini = Gemini.instance;

    try {
      PdfWidgets().answerWidget(
        context,
        text,
      );

      var answer = await gemini.text(
          "What is the meaning of ${text}, answer in one line, Also provide the answer in Urdu language");
      controller.answer.value = answer!.output ?? '-';
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getExplanation(text, BuildContext context) async {
    final gemini = Gemini.instance;

    try {
      PdfWidgets().answerWidget(
        context,
        text,
      );
      var answer = await gemini.text(
          "Explain this, ${text}, answer briefly, Also translate this answer in Urdu language");
      controller.answer.value = answer!.output ?? '-';
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getSolution(text, BuildContext context) async {
    final gemini = Gemini.instance;

    try {
      PdfWidgets().answerWidget(
        context,
        text,
      );

      var answer = await gemini.text(
          "Solve this question, ${text}, just write the complete solution steps without any explanation");
      controller.answer.value = answer!.output ?? '-';
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
