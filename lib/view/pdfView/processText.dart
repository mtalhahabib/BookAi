import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookpdf/view/pdfView/pdfWidgets.dart';
import 'package:bookpdf/viewModel/answerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

class ProcessText {
  var controller = Get.put(AnswerViewModel());
  // getMeaning(text, BuildContext context) async {
  //   final gemini = Gemini.instance;

  //   try {
  //     PdfWidgets().answerWidget(
  //       context,
  //       text,
  //     );

  //     var answer = await gemini.text(
  //         "What is the meaning of ${text}, answer in one line, Also provide the answer in Urdu language");
  //     controller.answer.value = answer!.output ?? '-';
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }


Future<void> getMeaning( text, BuildContext context) async {
  const apiKey = 'AIzaSyAN10TLWtEr_wdS41qhHMIxacFlfe8fxko'; // ✅ your API key
  const url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

  final headers = {
    'Content-Type': 'application/json',
  };
PdfWidgets().answerWidget(
        context,
        text,
      );
  final body = jsonEncode({
    "contents": [
      {
        "parts": [
          {
            "text":
                "What is the meaning of '$text'? Answer in one line and also in Urdu language."
          }
        ]
      }
    ]
  });

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final output = jsonData['candidates'][0]['content']['parts'][0]['text'];
      controller.answer.value = output ?? 'No answer found.';
    } else {
      debugPrint("Error ${response.statusCode}: ${response.body}");
      controller.answer.value = "Error ${response.statusCode}";
    }
  } catch (e) {
    debugPrint("Exception: $e");
    controller.answer.value = "Exception occurred.";
  }
}
Future<void> getExplanation( text, BuildContext context) async {
  const apiKey = 'AIzaSyAN10TLWtEr_wdS41qhHMIxacFlfe8fxko'; // ✅ your API key
  const url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

  final headers = {
    'Content-Type': 'application/json',
  };
PdfWidgets().answerWidget(
        context,
        text,
      );
  final body = jsonEncode({
    "contents": [
      {
        "parts": [
          {
            "text":
                "Explain This  '$text'? Answer briefly  and also in Urdu language."
          }
        ]
      }
    ]
  });

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final output = jsonData['candidates'][0]['content']['parts'][0]['text'];
      controller.answer.value = output ?? 'No answer found.';
    } else {
      debugPrint("Error ${response.statusCode}: ${response.body}");
      controller.answer.value = "Error ${response.statusCode}";
    }
  } catch (e) {
    debugPrint("Exception: $e");
    controller.answer.value = "Exception occurred.";
  }
}
Future<void> getSolution( text, BuildContext context) async {
  const apiKey = 'AIzaSyAN10TLWtEr_wdS41qhHMIxacFlfe8fxko'; // ✅ your API key
  const url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

  final headers = {
    'Content-Type': 'application/json',
  };
PdfWidgets().answerWidget(
        context,
        text,
      );
  final body = jsonEncode({
    "contents": [
      {
        "parts": [
          {
            "text":
                "Solve This   '$text'? Explain in two line and also in Urdu language."
          }
        ]
      }
    ]
  });

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final output = jsonData['candidates'][0]['content']['parts'][0]['text'];
      controller.answer.value = output ?? 'No answer found.';
    } else {
      debugPrint("Error ${response.statusCode}: ${response.body}");
      controller.answer.value = "Error ${response.statusCode}";
    }
  } catch (e) {
    debugPrint("Exception: $e");
    controller.answer.value = "Exception occurred.";
  }
}

  // getExplanation(text, BuildContext context) async {
  //   final gemini = Gemini.instance;

  //   try {
  //     PdfWidgets().answerWidget(
  //       context,
  //       text,
  //     );
  //     var answer = await gemini.text(
  //         "Explain this, ${text}, answer briefly, Also translate this answer in Urdu language");
  //     controller.answer.value = answer!.output ?? '-';
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // getSolution(text, BuildContext context) async {
  //   final gemini = Gemini.instance;

  //   try {
  //     PdfWidgets().answerWidget(
  //       context,
  //       text,
  //     );

  //     var answer = await gemini.text(
  //         "Solve this question, ${text}, just write the complete solution steps without any explanation");
  //     controller.answer.value = answer!.output ?? '-';
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

}
