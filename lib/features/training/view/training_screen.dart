import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/features/training/model/training_model.dart';
import 'package:oqy/features/training/widgets/my_created_list_widget.dart';
import 'package:oqy/features/training/widgets/my_training_list_widget.dart';
import 'package:provider/provider.dart';

@RoutePage()
class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return TrainingWidget.create();
  }
}

class TrainingWidget extends StatelessWidget {
  const TrainingWidget({super.key});
  
  static Widget create() {
    return ChangeNotifierProvider.value(
      value: TrainingModel(),
      child: const TrainingWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<TrainingModel>();
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title:const Text("Training", style: TextStyle(fontSize: 24),),
              actions: [
                IconButton(
                  onPressed: () => model.navigateTeCourseCreating(context, 0),
                  icon: const Icon(Icons.add),
                ),
              ],
              pinned: true,
              floating: true,
              snap: false,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  automaticIndicatorColorAdjustment: false,
                  indicatorColor: theme.primaryColor,
                  unselectedLabelColor: theme.unselectedWidgetColor,
                  tabs: const [
                    Tab(text: "My training"),
                    Tab(text: "My courses"),
                  ],
                ),
              ),
            ),
          ],
          body: const TabBarView(
            children: [
              MyTrainingListWidget(),
              MyCreatedListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
