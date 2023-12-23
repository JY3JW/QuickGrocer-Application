import 'dart:io';
import 'package:open_file_plus/open_file_plus.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    //final dir = await getApplicationDocumentsDirectory();
    //final file = File('${dir.path}/$name');
    final file = File('/storage/emulated/0/Download/$name');

    await file.writeAsBytes(bytes);

    OpenFile.open(file.path);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    print(url);

    await OpenFile.open(url);
  }
}
