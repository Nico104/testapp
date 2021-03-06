import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testsite/views/upload_video/upload_video_data_widget.dart';

class UploadVideoScreen extends StatelessWidget {
  const UploadVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Center(
        child: SizedBox(
          width: 400,
          height: 600,
          child: Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const UploadVideoForm(),
          ),
        ),
      ),
    );
  }
}

class UploadVideoForm extends StatefulWidget {
  const UploadVideoForm({Key? key}) : super(key: key);

  @override
  _UploadVideoFormState createState() => _UploadVideoFormState();
}

class _UploadVideoFormState extends State<UploadVideoForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ButtonTheme(
          height: 100,
          minWidth: 200,
          child: OutlinedButton(
            style: ButtonStyle(
              side: MaterialStateProperty.resolveWith((states) {
                Color _borderColor;
                if (states.contains(MaterialState.disabled)) {
                  _borderColor = Colors.greenAccent;
                } else if (states.contains(MaterialState.pressed)) {
                  _borderColor = Colors.yellow;
                } else {
                  _borderColor = Colors.pinkAccent;
                }

                return BorderSide(color: _borderColor, width: 3);
              }),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
            ),
            // onPressed: () => Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => const UploadVideoDataScreen()),
            //       ),
            onPressed: () => _uploadVideo(),
            child: const Text("Choose Video"),
          ),
        ),
      ],
    );
  }

  Future<void> _uploadVideo() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: false);

    var fileBytes = result!.files.first.bytes;
    var fileName = result.files.first.name;

    // upload file
    // await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);

    // print(String.fromCharCodes(fileBytes!));
    print("FileName: " + fileName);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UploadVideoDataScreen(
                videoBytes: fileBytes!,
              )),
    );

    print("weiter");
  }
}
