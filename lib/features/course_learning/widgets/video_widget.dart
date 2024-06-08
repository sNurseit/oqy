import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:oqy/domain/entity/material_entity.dart';

class VideoWidget extends StatefulWidget {
  final String video;
  final MaterialEntity material;

  const VideoWidget({required this.material, required this.video, Key? key}) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  String? videoPath;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      Uint8List bytes = base64Decode(widget.video);
      Directory tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/video.mp4').writeAsBytes(bytes);

      _videoController = VideoPlayerController.file(file);

      await _videoController!.initialize();

      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoController!,
          aspectRatio: _videoController!.value.aspectRatio,
          autoPlay: true,
          looping: false,
          materialProgressColors: ChewieProgressColors(
            playedColor: Colors.blueAccent,
            handleColor: Colors.blueAccent,
            backgroundColor: Colors.white10,
            bufferedColor: Colors.white10,
          ),
          placeholder: Container(
            color: Colors.black,
          ),
          autoInitialize: true,
        );
      });
    } catch (e) {
      print('Error initializing video player: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (_chewieController != null && _videoController!.value.isInitialized)
            AspectRatio(
              aspectRatio: _chewieController!.aspectRatio!,
              child: Chewie(controller: _chewieController!),
            )
          else
            Container(
              height: 200,
              child: const Center(child: CircularProgressIndicator()),
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
