import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsCardShimmer extends StatefulWidget {
  const NewsCardShimmer({super.key});

  @override
  State<NewsCardShimmer> createState() => _NewsCardShimmerState();
}

class _NewsCardShimmerState extends State<NewsCardShimmer>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2),
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey[200]!,
              child: Container(
                height: 12,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 6),
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey[200]!,
              child: Container(
                height: 12,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    height: 10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    height: 10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    height: 10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey[200]!,
              child: Container(
                height: 8,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
