import 'package:bookpdf/view/pdfView/processText.dart';
import 'package:bookpdf/viewModel/answerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfWidgets {
  var controller = Get.put(AnswerViewModel());
  Future<void> answerWidget(BuildContext context, question, ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return Obx(
          () => AlertDialog(
            title: Text('$question'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  controller.answer.value == ''
                      ? Center(child: Container(height: 150,width: 150,child: CircularProgressIndicator()))
                      : Text('${controller.answer.value}'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Exit'),
                onPressed: () {
                  controller.answer.value = '';
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
