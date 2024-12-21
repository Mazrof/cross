import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class GeneralImage extends StatelessWidget {
  final String? imageUrl; // Accepts either an image URL or a Base64 string
  final String username;
  final double radius;

  const GeneralImage({
    Key? key,
    required this.username,
    this.imageUrl,
    this.radius = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: _getBackgroundColor(username), // Background color
      child: ClipOval(
        child: _buildImage(),
      ),
    );
  }

  /// Decides whether to display a Base64 image, a network image, or initials
  Widget _buildImage() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      if (_isBase64(imageUrl!)) {
        // Handle Base64 image
        Uint8List? imageBytes = _decodeBase64(imageUrl!);
        if (imageBytes != null) {
          return Image.memory(
            imageBytes,
            fit: BoxFit.cover,
            width: radius * 2,
            height: radius * 2,
          );
        }
      } else {
        // Handle network image
        return Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
          errorBuilder: (context, error, stackTrace) {
            return _buildInitials(); // Fallback to initials if image fails to load
          },
        );
      }
    }
    // Fallback to initials when no valid image is provided
    return _buildInitials();
  }

  /// Helper method to decode Base64 string
  Uint8List? _decodeBase64(String base64String) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      return null;
    }
  }

  /// Helper method to check if a string is a valid Base64 encoded string
  bool _isBase64(String str) {
    final base64Regex = RegExp(r'^[A-Za-z0-9+/]+={0,2}$');
    return base64Regex.hasMatch(str);
  }

  /// Helper method to create initials widget
  Widget _buildInitials() {
    return Center(
      child: Text(
        _getInitials(username),
        style: TextStyle(
          fontSize: radius * 0.5,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Helper method to extract initials from the username
  String _getInitials(String username) {
    return username.isNotEmpty ? username[0].toUpperCase() : '?';
  }

  /// Helper method to get a consistent background color based on the username
  Color _getBackgroundColor(String username) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.brown,
      Colors.teal,
      Colors.amber,
      Colors.cyan,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.indigo,
      Colors.lime,
      Colors.pink,
    ];
    return colors[username.hashCode % colors.length];
  }
}
