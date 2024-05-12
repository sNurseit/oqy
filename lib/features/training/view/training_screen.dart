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
    final theme = Theme.of(context);
    return Scaffold(
      body:DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme.secondaryHeaderColor,
            elevation: 0, 
            title:  TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              automaticIndicatorColorAdjustment:false,
              indicatorColor: theme.primaryColor, 
              unselectedLabelColor: theme.unselectedWidgetColor,
              tabs: const [
                Tab(text: "My training"),
                Tab(text: "My courses"),
              ],
            ),
            titleTextStyle: theme.textTheme.titleMedium,
          ),
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