import 'package:flutter/material.dart';
import 'package:kronos/app/core/constant/log_type_constant.dart';
import 'package:kronos/app/core/model/statistic/statistic_response_model.dart';
import 'package:kronos/app/shared/component/custom_indicator.dart';
import 'package:kronos/app/shared/util/number_util.dart';

class StatisticItemComponent extends StatelessWidget {
  final StatisticResponseModel statistic;
  const StatisticItemComponent({required this.statistic, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        width: 400,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              statistic.applicationName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              spacing: 8,
              children: [
                CustomIndicator(color: Colors.blue),
                Text('Total'),
                Expanded(child: Divider()),
                Text(NumberUtil.formatNumber(statistic.total)),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                CustomIndicator(
                  color: LogTypeConstant.color(LogTypeConstant.success),
                ),
                Text('Sucesso'),
                Expanded(child: Divider()),
                Text(NumberUtil.formatNumber(statistic.countSuccess)),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                CustomIndicator(
                  color: LogTypeConstant.color(LogTypeConstant.info),
                ),
                Text('Informação'),
                Expanded(child: Divider()),
                Text(NumberUtil.formatNumber(statistic.countInfo)),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                CustomIndicator(
                  color: LogTypeConstant.color(LogTypeConstant.error),
                ),
                Text('Erro'),
                Expanded(child: Divider()),
                Text(NumberUtil.formatNumber(statistic.countError)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
