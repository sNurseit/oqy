import 'package:flutter/material.dart';

class CourseCreatingDrawerWidget extends StatelessWidget {
  final int index;

  const CourseCreatingDrawerWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: theme.cardColor,
      child: Column(
        children: [
          DrawerHeader(
            child: Container(
              width: double.infinity,
              height: 200,
              color: const Color.fromARGB(255, 179, 199, 187),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: const Text('Module1'),
                  onTap: () {
                    Navigator.pop(context); // Закрыть Drawer
                    Navigator.push( // Открыть новый экран
                      context,
                      MaterialPageRoute(builder: (context) => ModulesScreen(index: 1)),
                    );
                  },
                ),
                // Добавьте другие пункты списка здесь
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Действие при нажатии на кнопку "Add module"
              },
              child: const Text('Add module'),
            ),
          ),
        ],
      ),
    );
  }
}


class ModulesScreen extends StatelessWidget {
  final int index;
  const ModulesScreen({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modules'),
      ),
      body: const Center(
        child: Text('Modules Screen'),
      ),
      endDrawer: CourseCreatingDrawerWidget(index: index,),
    );
  }
}
