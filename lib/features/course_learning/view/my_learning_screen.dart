import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@immutable
@RoutePage()
class MyLearningScreen extends StatefulWidget {
  final int courseId;
  const MyLearningScreen({
    Key? key,
    @PathParam() required this.courseId,
  }) : super(key: key);

  @override
  State<MyLearningScreen> createState() => _MyLearningScreenState();
}

class _MyLearningScreenState extends State<MyLearningScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryHeaderColor,
        title: Text(
          "Title",
          maxLines: 2,
          style: theme.textTheme.displayLarge,
        ),
      ),
    
      backgroundColor: theme.scaffoldBackgroundColor,
      body: ListView(
        children:const [
          SizedBox(height: 200,),
          Text('teas'),
          SizedBox(height: 200,),
          Text('teas'),          
          SizedBox(height: 200,),
          Text('teas'),          
          SizedBox(height: 200,),
          Text('teas'),          
          SizedBox(height: 200,),
          Text('teas'),          
        ]
      ),
    );
  }
}