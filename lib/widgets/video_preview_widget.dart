import 'package:flutter/material.dart';

class VideoPreview extends StatelessWidget {

  final String thumbnailPath;

  const VideoPreview({Key? key, 
    required this.thumbnailPath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              //alignment: Alignment.center,
              //height: MediaQuery.of(context).size.height * 0.2,
              //margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.black),
              // ),
              color: Colors.pinkAccent,
              child: Column(
                children: [
                  Image.network("https://picsum.photos/1280/720"),
                  Text("Item ${thumbnailPath}"),
                ],
              ),
            );
  }
}