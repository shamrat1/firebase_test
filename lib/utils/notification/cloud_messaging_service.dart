import 'dart:convert';
import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis/firestore/v1.dart' as firestore;

class CloudMessagingService {
  final List<String> _scopes = [
    'https://www.googleapis.com/auth/firebase.messaging'
  ];
  final String _host = 'fcm.googleapis.com';
  final String _path = '/v1/projects/testfirestore-e27f0/messages:send';

  Future<String> _getAccessToken() async {
    final key = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "your_project_id",
      "private_key_id": "your private key",
      "private_key": "private ssh key",
      "client_email": "client email address from firebase",
      "client_id": "client id here",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "custom cert url based on your service url",
      "universe_domain": "googleapis.com"
    });

    final client = http.Client();
    final authClient = await clientViaServiceAccount(key, _scopes);

    return authClient.credentials.accessToken.data;
  }

  Future<void> sendFcmMessage(Map<String, dynamic> fcmMessage) async {
    final accessToken = await _getAccessToken();

    final url = Uri.https(_host, _path);
    final headers = {
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final response =
        await http.post(url, headers: headers, body: json.encode(fcmMessage));

    if (response.statusCode == 200) {
      print('Message sent to Firebase for delivery, response:');
      print(response.body);
    } else {
      print('Unable to send message to Firebase');
      print('Status: ${response.statusCode}');
      print(response.body);
    }
  }
}
