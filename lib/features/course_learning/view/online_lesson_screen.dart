import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/features/course_learning/bloc/online_lesson_bloc/online_lesson_bloc.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

@RoutePage()
class OnlineLessonScreen extends StatefulWidget {
  final int courseId;
  final int roomId;

  const OnlineLessonScreen({required this.courseId, required this.roomId, Key? key})
      : super(key: key);

  @override
  _OnlineLessonScreenState createState() => _OnlineLessonScreenState();
}

class _OnlineLessonScreenState extends State<OnlineLessonScreen> {
  final controller = ZegoUIKitPrebuiltVideoConferenceController();

  @override
  void initState() {
    super.initState();
    context.read<OnlineLessonBloc>().add(LoadOnlineLesson(lessonId: widget.courseId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Lesson'),
      ),
      body: Center(
        child: BlocBuilder<OnlineLessonBloc, OnlineLessonState>(
          builder: (context, state) {
            if (state is OnlineLessonLoaded) {
              return SafeArea(
                child: ZegoUIKitPrebuiltVideoConference(
                  appID: ApiConstants.appID,
                  appSign: ApiConstants.serverSecret,
                  userID: '${state.userId}',
                  userName: state.userName,
                  conferenceID: '${widget.roomId}',
                  controller: controller,
                  config: ZegoUIKitPrebuiltVideoConferenceConfig(),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
