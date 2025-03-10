import 'package:flutter/material.dart';
import 'package:kronos/app/core/constant/log_type_constant.dart';
import 'package:kronos/app/core/model/log_model/log_response_model.dart';
import 'package:kronos/app/core/provider/navigator_provider.dart';
import 'package:kronos/app/module/home/component/home_log_detail_component.dart';
import 'package:kronos/app/module/home/controller/home_controller.dart';
import 'package:kronos/app/shared/component/custom_indicator.dart';
import 'package:kronos/app/shared/util/date_util.dart';

class HomeLogComponent extends StatelessWidget {
  final LogResponseModel log;
  final HomeController controller;
  const HomeLogComponent({
    required this.log,
    required this.controller,
    super.key,
  });

  void onTapLog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Detalhes'),
              IconButton(
                onPressed: NavigatorProvider.pop,
                icon: Icon(Icons.close),
              ),
            ],
          ),
          content: HomeLogDetailComponent(log: log, controller: controller),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapLog(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Row(
              spacing: 8,
              children: [
                CustomIndicator(color: LogTypeConstant.color(log.type)),
                Text(LogTypeConstant.translate(log.type)),
                Text(DateUtil.formatDateTime(log.createdAt)),
              ],
            ),
            Text(log.content, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
