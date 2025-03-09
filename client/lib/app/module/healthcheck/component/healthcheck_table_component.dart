import 'package:flutter/material.dart';
import 'package:kronos/app/core/model/application/application_response.dart';
import 'package:kronos/app/core/model/healthcheck/healthcheck_response_model.dart';
import 'package:kronos/app/shared/component/custom_indicator.dart';
import 'package:kronos/app/shared/component/item_table_row.dart';
import 'package:kronos/app/shared/util/date_util.dart';

class HealthCheckTableComponent {
  final List<ApplicationResponse> applications;
  final HealthCheckResponseModel healthCheck;
  HealthCheckTableComponent(this.healthCheck, this.applications);

  TableRow build() {
    var application = applications.firstWhere(
      (x) => x.id == healthCheck.applicationId,
    );
    return TableRow(
      children: [
        ItemTableRow(child: Text(application.name)),
        ItemTableRow(
          child: Row(
            spacing: 16,
            children: [
              CustomIndicator(
                color: healthCheck.success ? Colors.green : Colors.red,
              ),
              Text(healthCheck.success ? 'Sucesso' : 'Falha'),
            ],
          ),
        ),
        ItemTableRow(
          child: Text(DateUtil.formatDateTime(healthCheck.createdAt)),
        ),
      ],
    );
  }
}
