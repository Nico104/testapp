import 'package:flutter/material.dart';
import 'package:testsite/widgets/video_preview_widget.dart';

class FeedGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(150, 10, 150, 0),
          child: FeedGrid(),
        )
      ),
    );
  }
}

class FeedGrid extends StatefulWidget {
  @override
  _FeedGridState createState() => _FeedGridState();
}

class _FeedGridState extends State<FeedGrid> {

  //https://picsum.photos/1280/720
  List dataList = <int>[];
  bool isLoading = false;
  int pageCount = 1;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    ////LOADING FIRST  DATA
    addItemIntoLisT(1);

    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: (1280 / 820),
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 3,
      // Generate 100 widgets that display their index in the List.
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      children: dataList.map((value) {
        return VideoPreview(thumbnailPath: value.toString(),);
      }).toList(),
    );
  }


  //// ADDING THE SCROLL LISTINER
  _scrollListener() {

    print("Wert 1: " + (_scrollController.offset >=
            _scrollController.position.maxScrollExtent).toString());

    print("Wert 2: " + (!_scrollController.position.outOfRange).toString());

    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        print("comes to bottom $isLoading");
        isLoading = true;

        if (isLoading) {
          print("RUNNING LOAD MORE");

          pageCount = pageCount + 1;

          addItemIntoLisT(pageCount);
        }
      });
    }
  }

  ////ADDING DATA INTO ARRAYLIST
  void addItemIntoLisT(var pageCount) {
    for (int i = (pageCount * 10) - 10; i < pageCount * 10; i++) {
      dataList.add(i);
      isLoading = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


}