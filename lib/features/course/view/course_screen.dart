import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/features/course/model/course_model.dart';
import 'package:oqy/features/course/widgets/comment_bottom_sheet.dart';
import 'package:oqy/features/course/widgets/course_module_list.dart';
import 'package:oqy/features/course/widgets/expandable_text.dart';
import 'package:oqy/features/course/widgets/horizontal_comment.dart';
import 'package:oqy/widgets/information_container.dart';
import 'package:oqy/features/course/widgets/statistic_information.dart';
import 'package:provider/provider.dart';

@immutable
@RoutePage()  
class CourseScreen extends StatefulWidget {
  final int courseId;

  const CourseScreen({
    Key? key,
    @PathParam() required this.courseId,
  }) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final CourseModel _model;

  @override
  void initState() {
    super.initState();
     _model = CourseModel(courseId: widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _model,
      child: CourseDetails(courseId: widget.courseId),
    );
  }
}

class CourseDetails extends StatefulWidget {
  final int courseId;

  const CourseDetails({Key? key, required this.courseId}) : super(key: key);

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final course = context.watch<CourseModel>().course;
    final model = context.read<CourseModel>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: course == null
          ? const Center(child: CircularProgressIndicator())
          : NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 350,
                  pinned: true,
                  floating: true,
                  snap: false,
                  leading: IconButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets?>(
                          const EdgeInsets.all(8)),
                      backgroundColor: MaterialStateProperty.all<Color?>(
                          theme.secondaryHeaderColor.withOpacity(0.5)),
                    ),
                    color: theme.focusColor,
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: theme.cardColor,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                    background: Hero(
                      tag: 'course_image_${widget.courseId}',
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: InteractiveViewer(
                          child: Image.memory(
                            Uint8List.fromList(course.imageBytes ?? []),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            theme.secondaryHeaderColor.withOpacity(0.5)),
                        padding: MaterialStateProperty.all<EdgeInsets?>(
                            const EdgeInsets.all(8)),
                      ),
                      color: theme.focusColor,
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline),
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(64),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                course.title ?? "",
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(fontSize: 20),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatisticInformationWidget(
                              text: '${course.language}',
                              description: 'Language',
                              icon: Icons.language),
                          StatisticInformationWidget(
                              text:
                                  '${double.parse(course.averageRating.toStringAsFixed(1))}(${course.reviewCount})',
                              description: 'Rating',
                              icon: Icons.reviews),
                          StatisticInformationWidget(
                              text: '${course.enrollmentCount}',
                              description: 'Enrollments',
                              icon: Icons.monetization_on),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InformationContaierWidget(
                      informationWidget: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: theme.focusColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Information',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      child: ExpandableText(
                        text: course.description,
                        minLength: 5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      child: const HorizontalCommentScroll(),
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => ChangeNotifierProvider.value(
                            value: model,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.85,
                              child: const CommentBottomSheet(),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    InformationContaierWidget(
                      informationWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Modules',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Modules: ${course.modules.length} ',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                ' Quizes: ${course.quizzes.length} ',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                ' Online lessons: ${course.onlineLessons.length} ',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      child: CourseModelList(stepItems: model.stepItems),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        color: theme.secondaryHeaderColor.withOpacity(0.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            course != null
                ? Text('${course.price}', style: theme.textTheme.labelMedium)
                : const Text("Free"),
            FilledButton(
              onPressed: () => model.buyCourse(course.id, context),
              child: Text(
                'Buy now',
                style:
                    theme.textTheme.displayLarge?.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
