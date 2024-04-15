// ignore_for_file: library_private_types_in_public_api

import 'package:daamn/constant/constant_functions.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class VieoPlayerWidget extends StatefulWidget {
  final String url;

  const VieoPlayerWidget({
    super.key,
    required this.url,
  });

  @override
  _VieoPlayerWidgetState createState() => _VieoPlayerWidgetState();
}

class _VieoPlayerWidgetState extends State<VieoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
          _controller.setLooping(false);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      height: screenHieght,
      child: _controller.value.isInitialized
          ? VideoPlayer(
              _controller,
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
