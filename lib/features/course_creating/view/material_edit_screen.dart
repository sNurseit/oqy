import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oqy/features/course_creating/bloc/material_edit_bloc/material_edit_bloc.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class MaterialEditScreen extends StatefulWidget {
  final int materialStep;
  final int moduleStep;

  const MaterialEditScreen({
    Key? key,
    required this.materialStep,
    required this.moduleStep,
  }) : super(key: key);

  @override
  State<MaterialEditScreen> createState() => _MaterialEditScreenState();
}

class _MaterialEditScreenState extends State<MaterialEditScreen> {
  late QuillController quillController;
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  String? videoPath;

  @override
  void initState() {
    super.initState();
    context.read<MaterialEditBloc>().add(
        LoadMaterialEdit(id: widget.materialStep, moduleId: widget.moduleStep));
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      try {
        final file = File(pickedFile.path);
        final controller = VideoPlayerController.file(file);
        await controller.initialize();
        setState(() {
          videoPath = pickedFile.path;
          _videoController = controller;
          _chewieController = ChewieController(
            videoPlayerController: _videoController!,
            aspectRatio: _videoController!.value.aspectRatio,
            autoPlay: true,
            looping: false,
            materialProgressColors: ChewieProgressColors(
              playedColor: Colors.white,
              handleColor: Colors.white,
              backgroundColor: Colors.grey,
              bufferedColor: Colors.white54,
            ),
            placeholder: Container(
              color: Colors.grey,
            ),
            autoInitialize: true,
          );
        });
      } catch (e) {
        print("Error initializing video player: $e");
        // Handle error appropriately
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final materialBloc = context.read<MaterialEditBloc>();
    final theme = Theme.of(context);

    return BlocBuilder<MaterialEditBloc, MaterialEditState>(
      builder: (context, state) {
        if (state is MaterialEditLoaded) {
          final material = state.material;
          quillController = QuillController.basic();
          return Scaffold(
            appBar: AppBar(
              title: Text(material.title!, style: theme.textTheme.labelMedium),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    child: Text('save', style: theme.textTheme.labelMedium),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            body: ListView(
              children: [
                if (material.type == 'text') ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuillToolbar.simple(
                      configurations: QuillSimpleToolbarConfigurations(
                        controller: quillController,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('ru'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                        controller: quillController,
                        readOnly: false,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('ru'),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Select Image'),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: _pickVideo,
                          child: const Text('Select Video'),
                        ),
                        if (videoPath != null) ...[
                          const SizedBox(height: 10),
                          _chewieController != null &&
                                  _chewieController!.videoPlayerController.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio: _chewieController!.aspectRatio!,
                                  child: Chewie(controller: _chewieController!),
                                )
                              : Container(
                                  height: 200,
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        } else if (state is MaterialLoadingError) {
          return Scaffold(appBar: AppBar(), body: Text(state.message));
        }
        return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
