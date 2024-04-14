import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oqy/features/search/model/search_model.dart';
import 'package:oqy/theme/app_colors.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SearchWidget.create();
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider.value(
      value: SearchModel(),
      child: const SearchWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = context.read<SearchModel>();
    return Scaffold(

      appBar: AppBar(
        title: TextField(
          controller: model.searchTextController,
          style: theme.textTheme.displayLarge,
        ),
        actions: [
          IconButton(icon: Icon(Icons.filter_1_outlined), onPressed: () {  },)
        ],
      ),
      body: const SearchResult(),
    );
  }
}



class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = context.select((SearchModel model) => model.courses);
    final model = context.read<SearchModel>();

    final theme = Theme.of(context);
    return courses.isNotEmpty ? ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context,index){
        final course = courses[index];
        final Uint8List imageBytes = Uint8List.fromList(course.imageBytes!);
        return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: GestureDetector(
            onTap: () =>model.navigateToCourseDetails(context,course.id),
            child: Container(
              width: double.infinity,
              color: theme.cardColor,
              child: Row(
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 180,
                    ),
                    decoration: const BoxDecoration(
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12),),
                      child: Image.memory(
                        imageBytes,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title ?? "Unnamed Course", 
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.displayMedium,
                    
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBarIndicator(
                                rating: course.averageRating?? 0.0,
                                itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                  color: AppFontColors.fontLink,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                                unratedColor: theme.unselectedWidgetColor,
                              ),
                              Text('${course.price}',
                                style: theme.textTheme.labelMedium
                              ),
                            ],
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    ):  Container();
  }
}