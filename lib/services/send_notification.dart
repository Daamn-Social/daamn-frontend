import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendChatNotification(
    String deviceToken, String senderName, String senderImage) async {
  // FCM endpoint
  Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  // FCM server key from Firebase console
  String serverKey = 'YOUR_SERVER_KEY';

  // Create the notification message
  Map<String, dynamic> notification = {
    'title': 'New Message',
    'body': 'You received a message from $senderName',
  };

  // Create the message data
  Map<String, dynamic> message = {
    'notification': notification,
    'data': {
      'senderName': senderName,
      'senderImage': senderImage,
    },
    'to': deviceToken,
  };

  // Convert the message to JSON
  String jsonMessage = jsonEncode(message);

  // Send the POST request
  try {
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonMessage,
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Failed to send notification: $e');
  }
}
