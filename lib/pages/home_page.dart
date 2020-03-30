import 'package:doyinapplication/provider/DouYin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  HomePage(this.assetsUrl);

  final String assetsUrl;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoPlayerController _controller;


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetsUrl);
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.redAccent,
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            // 重写这个会影响pageview 滚动
//              onHorizontalDragUpdate: (DragUpdateDetails details){},
//              onHorizontalDragEnd: (DragEndDetails details){},
            onTap: (){
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
              setState(() {});
            },
              child: VideoPlayer(_controller)),
          GestureDetector(
              onTap: () {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
                setState(() {});
              },
              child: _PlayPauseOverLay(_controller)),
        ],
      ),
    );
  }

//  Widget _videoWidget() {
//    return Stack(
//      children: <Widget>[
//        Positioned.fill(
//            child: GestureDetector(
//              onHorizontalDragUpdate: (DragUpdateDetails details){},
//              onHorizontalDragEnd: (DragEndDetails details){},
//              child: Container(
//
//                width: double.infinity,
//                height: double.infinity,
//                child: VideoPlayer(_controller),
//              ),
//            )),
//
////          Center(child: VideoProgressIndicator(_controller, allowScrubbing: true)),
//      ],
//    );
//  }
}

class _PlayPauseOverLay extends StatelessWidget {
  _PlayPauseOverLay(this.controller);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 200),
      child: controller.value.isPlaying
          ? SizedBox.shrink()
          : Container(
              child: Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 100.0,
                ),
              ),
            ),
    );
  }
}
