import 'package:flutter/material.dart';
import 'package:news_app_ui_setup/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs


// Cached network image
class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.articleModel});

  final ArticleModel articleModel;

  // Function to open the article URL using launchUrl
  void _launchURL(BuildContext context) async {
    final url = articleModel.url;
    final uri = Uri.parse(url); // Parse the URL string into a Uri object
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication); // Open URL in a browser
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch the article')),
      );
    }
    }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchURL(context), // Make the tile clickable
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              articleModel.image ?? 'https://via.placeholder.com/200', // Fallback image
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            articleModel.title ?? 'No Title Available', // Default title if null
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            articleModel.subTitle ?? 'No Subtitle Available', // Default subtitle if null
            maxLines: 2,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
