import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:milyonada/products/group_detail/model/group.dart';
import 'package:milyonada/products/group_detail/services/interface/i_group_service.dart';

import '../model/group_mmeber.dart';
import '../model/service_result.dart';

class GroupService implements IGroupService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://16.170.81.49:3000'));
  final _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb21wYW55X2lkIjoxMSwiaWF0IjoxNzUxMTk2Mzk1LCJleHAiOjE3NjE1NjQzOTV9.pGrnYXCWuqDiV8845AasA6SvHJ0Ae8d2obkObASo5fA";
  @override
  Future<ServiceResult<bool>> leaveGroup(Group group) async {
    try {
      final response = await _dio.post(
        '/group/leave',
        data: group.toJson(),
        options: Options(headers: {"x-app-version": "2.0.0"}),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return ServiceResult(
          success: true,
          data: true,
          message: response.data['message'],
          statusEnum: response.data['statusEnum'],
        );
      } else {
        return ServiceResult(
          success: false,
          data: false,
          message: response.data['message'],
          statusEnum: response.data['statusEnum'],
        );
      }
    } catch (e) {
      debugPrint('Leave Group Error: $e');
      return ServiceResult(
        success: false,
        data: false,
        message: 'Sunucu hatası',
        statusEnum: 'ERROR',
      );
    }
  }

  @override
  Future<ServiceResult<bool>> joinGroup(Group group) async {
    final grop = group.copyWith(id: 0);
    try {
      final response = await _dio.post(
        '/group/join',
        data: grop.toJson(),
        options: Options(headers: {
          "x-app-version": "2.0.0",
          "Authorization":  "Bearer $_token"
        }),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return ServiceResult(
          success: true,
          data: true,
          message: response.data['message'],
          statusEnum: response.data['statusEnum'],
        );
      } else {
        return ServiceResult(
          success: false,
          data: false,
          message: response.data['message'],
          statusEnum: response.data['statusEnum'],
        );
      }
    } catch (e) {
      debugPrint('Join Group Error: $e');
      return ServiceResult(
        success: false,
        data: false,
        message: 'Sunucu hatası',
        statusEnum: 'ERROR',
      );
    }
  }

  @override
  Future<void> deleteGroup(String groupId) {
    // TODO: implement deleteGroup
    throw UnimplementedError();
  }

  @override
  Future<ServiceResult<List<Group>>> getGroups() async {
    try {
      final response = await _dio.get('/group',
          options: Options(headers: {"x-app-version": "2.0.0"}));
      if (response.statusCode == 200) {
        return ServiceResult.fromJson(
          response.data,
          (jsonData) {
            return (jsonData as List).map((e) => Group.fromJson(e)).toList();
          },
        );
      } else {
        return ServiceResult(
          success: false,
          message: 'Hata oluştu',
          data: null,
          statusEnum: 'ERROR',
        );
      }
    } catch (e) {
      debugPrint('Grup listesi alınırken hata: $e');
      return ServiceResult(
        success: false,
        message: 'Hata oluştu',
        data: null,
        statusEnum: 'ERROR',
      );
    }
  }

  Future<ServiceResult<List<GroupMember>>> getMembersByGroupId(
      int groupId) async {
    try {
      final response = await _dio.get(
        '/group/members/$groupId',
        options: Options(headers: {"x-app-version": "2.0.0"}),
      );

      if (response.statusCode == 200) {
        return ServiceResult.fromJson(
          response.data,
          (jsonData) {
            return (jsonData as List)
                .map((e) => GroupMember.fromJson(e))
                .toList();
          },
        );
      } else {
        return ServiceResult(
          success: false,
          message: 'Hata oluştu',
          data: null,
          statusEnum: 'ERROR',
        );
      }
    } catch (e) {
      debugPrint('Grup üyeleri alınırken hata: $e');
      return ServiceResult(
        success: false,
        message: 'Hata oluştu',
        data: null,
        statusEnum: 'ERROR',
      );
    }
  }
}
