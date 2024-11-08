import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

@GenerateMocks([Dio])
void main() {
  late Dio dio;

  setUp(() {
    dio = Dio();
  });

  test('should return data on successful GET request', () async {
    // Arrange
    when(dio.get('${AppStrings.serverUrl}/messages')).thenAnswer(
      (_) async => Response(
        data: {
          'messages': [
            [
              {
                "messageId": "msg-6789",
                "content": "Hello, how are you?",
                "senderId": "user-1234",
                "timestamp": "2023-10-23T10:00:00Z"
              },
              {
                "messageId": "msg-6789",
                "content": "Hello, how are you?",
                "senderId": "user-1234",
                "timestamp": "2023-10-23T10:00:00Z"
              }
            ]
          ]
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    // Act
    final response =
        await dio.get('${AppStrings.serverUrl}/api/v1/chats/my-chats');

    // Assert
    expect(response.data, {'chats': []});
  });

  test('should throw an error on failed GET request', () async {
    // Arrange
    when(dio.get('${AppStrings.serverUrl}/api/v1/chats/my-chats'))
        .thenThrow(DioException(
      requestOptions: RequestOptions(path: ''),
      error: 'Failed to load data',
    ));

    // Act & Assert
    expect(() => dio.get('${AppStrings.serverUrl}/api/v1/chats/my-chats'),
        throwsA(isA<DioException>()));
  });
}
