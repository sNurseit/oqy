
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/router/router.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
        routes:  const [
          HomeRoute(),
          SearchRoute(),
          TrainingRoute(),
          ProfileRoute(),
        ],
    builder: (context, child){
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              currentIndex: tabsRouter.activeIndex,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor:  Theme.of(context).unselectedWidgetColor,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              elevation: 0,
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              
              items:  const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home, weight: 0.01,),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                  activeIcon: Icon(Icons.search_rounded),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book_outlined),
                    activeIcon: Icon(Icons.menu_book_rounded),
                    label: 'My Training'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    activeIcon: Icon(Icons.account_circle),
                    label: 'Account'
                )
              ],
              onTap: (index) => onSelectTab(index, tabsRouter),
            ),
          );
      }
    );
  }

  void onSelectTab(int index, TabsRouter tabsRouter){
    tabsRouter.setActiveIndex(index);
  }
}