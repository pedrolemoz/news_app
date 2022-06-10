import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../domain/entities/news.dart';

class NewsCard extends StatefulWidget {
  final News news;

  const NewsCard({super.key, required this.news});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late String timeAgo;

  @override
  void initState() {
    super.initState();

    calculateTimeAgo();

    Timer.periodic(Duration(minutes: 1), (_) => calculateTimeAgo());
  }

  void calculateTimeAgo() => setState(
        () => timeAgo = timeago.format(widget.news.timestamp),
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.news.title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 8),
              Text(
                widget.news.subtitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8),
              Text(
                timeAgo,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
