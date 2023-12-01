import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:Final_Project_Flutter_MPM\lib\screens\anime_page.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('AnimePage', () {
    test('fetchImages', () async {
      final mockClient = MockClient();
      final animePage = AnimePage();

      // Set up the mock response
      when(mockClient.get(
        Uri.parse(animePage.apiUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async {
        return http.Response(jsonEncode({'images': ['url1', 'url2']}), 200);
      });

      // Use the mock client for the fetchImages call
      animePage.apiClient = mockClient;

      // Call the fetchImages function
      await animePage.fetchImages();

      // Verify that the imageUrls list is updated with the expected values
      expect(animePage.imageUrls, equals(['url1', 'url2']));
    });
  });
}
