
import 'package:flutter/material.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
            height: 200.0,
            padding: EdgeInsets.symmetric(vertical : 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  width: 100,
                  height: 100,
                  child: const Center(
                    child: Text("asdasd"),
                  ),
                );
              },
            ),
          );;
  }
}