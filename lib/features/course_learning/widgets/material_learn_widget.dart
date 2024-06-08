import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/material_entity.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class MaterialLearnWidget extends StatefulWidget {

  final MaterialEntity material;

  const MaterialLearnWidget({required this.material, super.key});
  @override
  State<MaterialLearnWidget> createState() => _MaterialLearnWidgetState();
}

class _MaterialLearnWidgetState extends State<MaterialLearnWidget> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: widget.material.content !=null ? HtmlWidget(widget.material.content!) :  Center(child: Text('No data')),
    );
  }
}