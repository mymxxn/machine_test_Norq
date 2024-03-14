import 'package:flutter/material.dart';
import 'package:machine_test/Utils/Constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class Components {
  static drawer() {
    return Drawer();
  }

  static productShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 1, // Spacing between columns
          mainAxisSpacing: 5, // Spacing between rows
          childAspectRatio: 0.75, // Aspect ratio (width / height)
        ),
        itemBuilder: (context, index) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
          ));
        },
        itemCount: 4,
      ),
    );
  }
}
