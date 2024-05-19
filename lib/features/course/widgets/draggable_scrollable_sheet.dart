
import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/review.dart';

class DraggableScrollableWidget extends StatefulWidget {

  List<Review> reviews;
  DraggableScrollableWidget({super.key, required this.reviews});

  @override
  State<DraggableScrollableWidget> createState() => _DraggableScrollableWidgetState();
}

class _DraggableScrollableWidgetState extends State<DraggableScrollableWidget> {
  
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onChange);
  }


  void onChange(){
    final currentSize = controller.size;
    if(currentSize <= 0.05) collapse();
  }

  void collapse() => animateSheet(getSheet.snapSizes!.first);
  void anchor() => animateSheet(getSheet.snapSizes!.last);
  void expand() => animateSheet(getSheet.maxChildSize);
  void hide() => animateSheet(getSheet.minChildSize);

  void animateSheet(double size){
    controller.animateTo(size, duration: const Duration(microseconds: 50), curve: Curves.easeInOut);
  }

  DraggableScrollableSheet get getSheet =>(sheet.currentWidget as DraggableScrollableSheet);
  @override
  Widget build(BuildContext context) {
    final reviews = widget.reviews;
    return LayoutBuilder(builder: (builder, constraints){
      return DraggableScrollableSheet(
        key: sheet,
        initialChildSize: 0.5,
        maxChildSize: 0.95,
        minChildSize: 0.4,
        expand: true,
        snap: true,
        snapSizes: [
          0.9,
          0.5
        ],
        builder: (BuildContext myContext, ScrollController scrollController) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0,1),
                )
              ],
              borderRadius:BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22)),

            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: 
                reviews.map((review){
                  return SliverToBoxAdapter(
                    child: Container( 
                      height: 200,
                      child: Text(review.fullName!),
                    )
                  );
                }).toList(),
            ),
          );
        },
      );
    });
  }
}