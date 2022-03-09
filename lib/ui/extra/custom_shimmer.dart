import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieListShimmer extends StatelessWidget {
  final Widget child;
  const MovieListShimmer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[700]!,
        child: child);
  }
}
