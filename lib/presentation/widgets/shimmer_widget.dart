import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount:3, // Show 10 shimmer items when loading
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: ListTile(
              title: Container(
                width: double.infinity,
                height: 16.0,
                color: Colors.grey,
              ),
              leading: Container(
                width: 48.0,
                height: 48.0,
                color: Colors.grey,
              ),
              trailing: Container(
                width: 24.0,
                height: 24.0,
                color: Colors.grey,
              ),
            ),
          );});
  }
}
