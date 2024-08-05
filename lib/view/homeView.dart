import 'dart:io';

import 'package:bookpdf/data/fileData.dart';
import 'package:bookpdf/view/pdfView/pdfView.dart';
import 'package:bookpdf/viewModel/homeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<String> titles = <String>[
  '1st Year',
  '2nd Year',
];

class HomePage extends StatelessWidget {
   HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    
final controller=Get.put(HomeViewModel());
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 2;

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Book Ai',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          // The elevation value of the app bar when scroll view has
          // scrolled underneath the app bar.
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.library_books),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.library_books),
                text: titles[1],
              ),
            ],
          ),
        ),
        body: Obx(
          ()=>
           Stack(
            children: [
              TabBarView(
                children: <Widget>[
                  ListView.builder(
                    itemCount: data['11']!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () async {
                          controller.isloading.value=true;
                          var status=await controller.checkKeyExists(data['11']![index]['url']);
                          if(status==true){
                            Get.snackbar('Wait', 'File is opening');
                           String memoryPath=await  controller.getPath(data['11']![index]['url']);
                           final file = File(memoryPath);
                            final path=await file.readAsBytes();
                            controller.isloading.value=false;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PdfViewPage(
                                          subject: data['11']![index]['subject'],
                                          url: path,
                                        )));
                            }
                            else{
                              Get.snackbar('Downloading', 'Please wait, file is downloading');
                             await controller.downloadFile(data['11']![index]['url']);
                            
                            controller.isloading.value=false;
                            }
                        },
                        leading: const Icon(Icons.menu_book),
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text('1st Year ${data['11']![index]['subject']} '),
                        // trailing:
                        //  IconButton(
                        //   icon:controller.checkKeyExists(data['11']![index]['url'])==true?SizedBox(): Icon(Icons.download),
                        //  onPressed: (){},
                        // ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: data['12']!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () async {
                          var status=await controller.checkKeyExists(data['12']![index]['url']);
                          if(status==true){
                             Get.snackbar('Wait', 'File is opening');
                           String memoryPath=await  controller.getPath(data['12']![index]['url']);
                           final file = File(memoryPath);
                            final path=await file.readAsBytes();
                            controller.isloading.value=false;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PdfViewPage(
                                          subject: data['12']![index]['subject'],
                                          url: path,
                                        )));
                            
                            }
                            else{
                              
                              Get.snackbar('Downloading', 'Please wait, file is downloading');
                             await controller.downloadFile(data['11']![index]['url']);
                            
                            controller.isloading.value=false;
                            
                            }
                         
                        },
                        leading: const Icon(Icons.menu_book),
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text('2nd Year ${data['12']![index]['subject']}'),
                        // trailing: IconButton(
                        //   icon:controller.checkKeyExists(data['12']![index]['url'])==true?SizedBox(): Icon(Icons.download),
                        //  onPressed: (){},
                        // ),
                      );
                    },
                  ),
                ],
              ),
                 controller.isloading.value==true?Center(child: CircularProgressIndicator()):SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
