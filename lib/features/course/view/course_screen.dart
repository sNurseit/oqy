import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oqy/features/course/model/course_model.dart';
import 'package:oqy/features/course/widgets/course_module_list.dart';
import 'package:oqy/features/course/widgets/expandable_text.dart';
import 'package:oqy/features/course/widgets/horizontal_comment.dart';
import 'package:oqy/features/course/widgets/statistic_information.dart';
import 'package:oqy/generated/l10n.dart';
import 'package:oqy/theme/app_colors.dart';
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
      create: (_)=>_model,
      child:  CourseDetails(courseId: widget.courseId),
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
    final scrollController = ScrollController();


    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: course==null? const Center(child: CircularProgressIndicator(),) : NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
              expandedHeight: 350,
              pinned: true,
              floating: true,
              snap: false, 
              leading: IconButton(
                style:ButtonStyle(
                  padding:MaterialStateProperty.all<EdgeInsets?>(EdgeInsets.all(8)),
                  backgroundColor: MaterialStateProperty.all<Color?>(AppLightColors.mainBackground.withOpacity(0.5)),
                ),
                color: Colors.black,
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),                 
              backgroundColor:Colors.white,
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
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(AppLightColors.mainBackground.withOpacity(0.5)),
                        padding:MaterialStateProperty.all<EdgeInsets?>(const EdgeInsets.all(8)),
                      ),
                      color: Colors.black,
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline),
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(95),
                    child:Container(
                      decoration: const BoxDecoration(
                        color: AppLightColors.mainBackground,
                        borderRadius: BorderRadius.only(
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
                                style: theme.textTheme.titleMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Divider(height: 1,),
                          ],
                        ),
                      ),
                    )
                  ),
          ),
        ],
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatisticInformationWidget(
                      text: '${course.language}', 
                      description: 'Language', 
                      icon: Icons.language
                    ),
                    StatisticInformationWidget(
                      text: '${course.reviewCount}', 
                      description: 'Reviews', 
                      icon: Icons.reviews 
                    ),
                    StatisticInformationWidget(
                      text: '${course.enrollmentCount}', 
                      description: 'Enrollments', 
                      icon: Icons.monetization_on 
                    ),
                  ],
                )
              ),
              const SizedBox(height: 20,),

              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ExpandableText(text: course.description, minLength: 5,),
                ),
              ),
              
              const SizedBox(height: 10),
                            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rating'),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: double.parse(course.averageRating.toStringAsFixed(1)),
                          itemBuilder: (context, index) => const Icon(
                          Icons.star,
                            color: AppFontColors.fontLink,
                          ),
                          itemCount: 5,
                          itemSize: 24.0,
                          direction: Axis.horizontal,
                          unratedColor: theme.unselectedWidgetColor,
                        ),
                        const SizedBox(width: 10,),
                        Text("${double.parse(course.averageRating.toStringAsFixed(1))}(${course.reviewCount})", style: theme.textTheme.displaySmall,),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              HorizontalCommentScroll(),
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: theme.secondaryHeaderColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            course != null? 
            Text('${course.price}',style: theme.textTheme.labelMedium)
            :const Text("Free"),
            FilledButton(
              onPressed:() => model.buyCourse(course.id, context),
              child: Text('Buy now', style: theme.textTheme.displayLarge?.copyWith(color: Colors.white),)
            )
          ],
        ),
      ),
    );
  }
}



/*
 NestedScrollView(
        controller: scrollController,
        : <Widget>[

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16), 
            child: Column(
              children: [
                Text(
                  course.title ?? "",
                  maxLines: 3,
                  style: theme.textTheme.titleMedium,
                ),
                Row(
                    children: [
                      RatingBarIndicator(
                        rating: course.averageRating,
                        itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: AppFontColors.fontLink,
                        ),
                        itemCount: 5,
                        itemSize: 24.0,
                        direction: Axis.horizontal,
                        unratedColor: theme.unselectedWidgetColor,
                      ),
                      const SizedBox(width: 10,),
                      Text("${course.averageRating}(${course.reviewCount})", style: theme.textTheme.displaySmall,),
                  
                    ],
                  ),
                
                const SizedBox(
                  height: 20,
                ),
                Text(course.description, maxLines: 5,),
                const SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).studyPlan, style: theme.textTheme.displayLarge,),
                Text("${course.moduleCount} modules, ${course.quizCount ?? 0} quizes, ${course.materialCount ?? 0} materials"),
              ],
            )
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child:  CourseModelList(),
          ),
        ]
      ),
      bottomNavigationBar: BottomAppBar(
        color: theme.secondaryHeaderColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            course != null? 
            Text('${course.price}',style: theme.textTheme.labelMedium) 
            :const Text("Free"),
            FilledButton(
              onPressed:() => model.buyCourse(course.id, context),
              child: Text('Buy now', style: theme.textTheme.displayLarge,)
            )
          ],
        ),
      ),

*/