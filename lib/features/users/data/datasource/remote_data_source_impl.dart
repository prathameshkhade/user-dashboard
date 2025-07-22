import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:userdashboard/core/secrets/app_secrets.dart';
import 'package:userdashboard/features/users/data/datasource/remote_data_source.dart';
import 'package:userdashboard/features/users/data/model/user_model.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl(this.client);

@override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final uri = Uri.parse(AppSecrets.apiUrl);
      final response = await client.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Failed to load users. Status code: ${response.statusCode}');
      }

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (!jsonResponse.containsKey('results')) {
        throw Exception('Invalid response format: missing results field');
      }

      final List<dynamic> dynamicList = jsonResponse['results'];
      final List<UserModel> users = dynamicList
          .map((user) => UserModel.fromJson(user))
          .toList();

      return users;
    }
    on SocketException {
      throw Exception('No internet connection');
    }
    on TimeoutException {
      throw Exception('Request timeout');
    }
    on FormatException {
      throw Exception('Invalid JSON format');
    }
    catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}