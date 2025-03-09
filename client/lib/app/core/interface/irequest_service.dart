import 'package:kronos/app/core/model/response_model.dart';

abstract class IRequestService {
  Future<ResponseModel> get(String endpoint);
  Future<ResponseModel> post(String endpoint, dynamic body);
  Future<ResponseModel> patch(String endpoint, dynamic body);
  Future<ResponseModel> delete(String endpoint);
}
