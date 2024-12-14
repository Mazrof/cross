import 'package:flutter/material.dart';

class GeneralImage extends StatelessWidget {
  final String? imageUrl; // Nullable for cases where the image URL isn't set
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
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                width: radius * 2,
                height: radius * 2,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to initials if image fails to load
                  return _buildInitials();
                },
              )
            : _buildInitials(), // Fallback to initials when no image URL
      ),
    );
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
