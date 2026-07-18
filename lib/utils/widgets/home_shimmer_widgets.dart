import 'package:flutter/material.dart';
import '../extension/sized_box_extension.dart';
import 'shimmer_widget.dart';

class NoticeShimmer extends StatelessWidget {
  const NoticeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ShimmerWidget(width: 60, height: 60, borderRadius: BorderRadius.all(Radius.circular(8))),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget(width: double.infinity, height: 16, borderRadius: BorderRadius.circular(4)),
                    8.height,
                    ShimmerWidget(width: 150, height: 14, borderRadius: BorderRadius.circular(4)),
                  ],
                ),
              ),
            ],
          ),
          12.height,
          ShimmerWidget(width: double.infinity, height: 12, borderRadius: BorderRadius.circular(4)),
          6.height,
          ShimmerWidget(width: 200, height: 12, borderRadius: BorderRadius.circular(4)),
        ],
      ),
    );
  }
}

class ComplaintShimmer extends StatelessWidget {
  const ComplaintShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const ShimmerWidget(width: 40, height: 40, borderRadius: BorderRadius.all(Radius.circular(20))),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget(width: double.infinity, height: 14, borderRadius: BorderRadius.circular(4)),
                8.height,
                ShimmerWidget(width: 100, height: 12, borderRadius: BorderRadius.circular(4)),
              ],
            ),
          ),
          ShimmerWidget(width: 80, height: 24, borderRadius: BorderRadius.circular(12)),
        ],
      ),
    );
  }
}

class ProjectShimmer extends StatelessWidget {
  const ProjectShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget(width: double.infinity, height: 120, borderRadius: BorderRadius.circular(8)),
          12.height,
          ShimmerWidget(width: double.infinity, height: 16, borderRadius: BorderRadius.circular(4)),
          8.height,
          ShimmerWidget(width: 150, height: 14, borderRadius: BorderRadius.circular(4)),
        ],
      ),
    );
  }
}

class SuggestionShimmer extends StatelessWidget {
  const SuggestionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ShimmerWidget(width: 40, height: 40, borderRadius: BorderRadius.all(Radius.circular(20))),
              12.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(width: 120, height: 14, borderRadius: BorderRadius.circular(4)),
                  4.height,
                  ShimmerWidget(width: 80, height: 10, borderRadius: BorderRadius.circular(4)),
                ],
              ),
            ],
          ),
          16.height,
          ShimmerWidget(width: 100, height: 16, borderRadius: BorderRadius.circular(4)),
         8.height,
          ShimmerWidget(width: double.infinity, height: 14, borderRadius: BorderRadius.circular(4)),
          4.height,
          ShimmerWidget(width: 250, height: 14, borderRadius: BorderRadius.circular(4)),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerWidget(width: 50, height: 20, borderRadius: BorderRadius.circular(4)),
              ShimmerWidget(width: 50, height: 20, borderRadius: BorderRadius.circular(4)),
              ShimmerWidget(width: 50, height: 20, borderRadius: BorderRadius.circular(4)),
            ],
          ),
        ],
      ),
    );
  }
}

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: ShimmerWidget(
        width: double.infinity,
        height: 220,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}

class SchemeShimmer extends StatelessWidget {
  const SchemeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget(width: 100, height: 18, borderRadius: BorderRadius.circular(4)),
          10.height,
          ShimmerWidget(width: double.infinity, height: 350, borderRadius: BorderRadius.circular(12)),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ShimmerWidget(width: index == 0 ? 24 : 8, height: 8, borderRadius: BorderRadius.circular(4)),
            )),
          ),
        ],
      ),
    );
  }
}

class CommentShimmer extends StatelessWidget {
  const CommentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerWidget(
              width: 36,
              height: 36,
              borderRadius: BorderRadius.all(Radius.circular(18))),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerWidget(
                        width: 120, height: 14, borderRadius: BorderRadius.circular(4)),
                    ShimmerWidget(
                        width: 60, height: 10, borderRadius: BorderRadius.circular(4)),
                  ],
                ),
                8.height,
                ShimmerWidget(
                    width: double.infinity,
                    height: 12,
                    borderRadius: BorderRadius.circular(4)),
                4.height,
                ShimmerWidget(
                    width: 200, height: 12, borderRadius: BorderRadius.circular(4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
