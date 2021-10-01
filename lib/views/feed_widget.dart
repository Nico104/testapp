import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testsite/widgets/feedgrid_widget.dart';
import 'package:testsite/widgets/naviagtionbar_widget.dart';

class FeedWidget extends StatefulWidget{
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<FeedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(),
      body: FeedGridScreen(),
    );
  }

}