import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import '../../../marketplaceConstant/marketplace_arguments_map.dart';

class PolicyScreen extends StatelessWidget {
  final Map<String, dynamic> args;
  const PolicyScreen(this.args, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: commonAppBar(args[titleKey] ?? '', context),
      body:  SingleChildScrollView(
        child: Html(data:args[policyKey], style: {
          "body":Style(fontSize: FontSize.large)
        },),
      ),
    );
  }
}
