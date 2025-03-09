import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kronos/app/core/constant/log_type_constant.dart';
import 'package:kronos/app/core/model/log/log_response_model.dart';
import 'package:kronos/app/module/home/controller/home_controller.dart';
import 'package:kronos/app/shared/component/custom_indicator.dart';
import 'package:kronos/app/shared/util/date_util.dart';

class HomeLogDetailComponent extends StatelessWidget {
  final LogResponseModel log;
  final HomeController controller;
  const HomeLogDetailComponent({
    required this.log,
    required this.controller,
    super.key,
  });

  String getApplication() {
    return controller.applications
        .firstWhere((x) => x.id == log.applicationId)
        .name;
  }

  String getContent() {
    try {
      var decodedJson = jsonDecode(log.content);

      var encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(decodedJson);
    } catch (_) {
      return log.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Row(
            spacing: 8,
            children: [
              Text(
                getApplication(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CustomIndicator(color: LogTypeConstant.color(log.type)),
              Text(LogTypeConstant.translate(log.type)),
              Text(DateUtil.formatDateTime(log.createdAt)),
            ],
          ),
          TextFormField(
            initialValue: getContent(),
            readOnly: true,
            maxLines: 15,
          ),
        ],
      ),
    );
  }
}
