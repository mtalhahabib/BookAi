import 'dart:typed_data';

import 'package:bookpdf/view/pdfView/pdfWidgets.dart';
import 'package:bookpdf/view/pdfView/processText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewPage extends StatefulWidget {
  
  PdfViewPage({
    required  this.subject,
    required this.url,
    super.key});
 dynamic subject;
  Uint8List url;
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<PdfViewPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  OverlayEntry? overlayEntry;

  final PdfViewerController pdfViewerController = PdfViewerController();
  @override
  void initState() {
    super.initState();
  }
 void selectionOptions(
      BuildContext context,
      PdfTextSelectionChangedDetails details,
      PdfViewerController pdfViewerController,
      ) {
    final OverlayState overlayState = Overlay.of(context);
    final Size screenSize = MediaQuery.of(context).size;
    final Rect selectedRect = details.globalSelectedRegion!;
    const double buttonHeight = 40; // Approximate height of each button
    const double buttonWidth = 100; // Approximate width of each button
    const double margin = 85; // Space between the selected text and the menu

    // Determine where to place the context menu
    double top = selectedRect.top - buttonHeight - margin;
    double left = selectedRect.left - margin;
    double right = screenSize.width - selectedRect.right - margin;

    // If the menu is going off the top of the screen, place it below the selection
    if (top < 0) {
      top = selectedRect.bottom + margin;
    }

    // Adjust left and right to ensure the menu is within the screen
    if (left + buttonWidth > screenSize.width) {
      left = screenSize.width - buttonWidth - margin;
    } else if (left < 0) {
      left = margin;
    }

    // Remove any existing overlay entry before adding a new one

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: top,
        left: left,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  // Clipboard.setData(ClipboardData(text: details.selectedText));
                  ProcessText().getMeaning(details.selectedText, context);
                  pdfViewerController.clearSelection();
                },
                child: Text('Meaning',
                    style: TextStyle(fontSize: 17, color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  // Clipboard.setData(ClipboardData(text: details.selectedText));
                  ProcessText().getExplanation(details.selectedText, context);
                  pdfViewerController.clearSelection();
                },
                child: Text('Explain',
                    style: TextStyle(fontSize: 17, color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  // Clipboard.setData(ClipboardData(text: details.selectedText));
                  ProcessText().getSolution(details.selectedText, context);
                  pdfViewerController.clearSelection();
                },
                child: Text('Solve',
                    style: TextStyle(fontSize: 17, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('${widget.subject.toString()}'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.memory(
        widget.url,
        canShowTextSelectionMenu: false,
        onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
          if (details.selectedText == null && overlayEntry != null) {
            overlayEntry!.remove();
            overlayEntry = null;
          } else if (details.selectedText != null && overlayEntry == null) {
            selectionOptions(
                context, details, pdfViewerController, );
          }
        },
        controller: pdfViewerController,
        key: _pdfViewerKey,
      ),
    );
  }
}
