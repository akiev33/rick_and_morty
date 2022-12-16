import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../cubit/cubit.dart';

class AppBarDetail extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  AppBarDetail({
    required this.index,
    required this.state,
    required this.expandedHeight,
  });

  final UserState state;
  final int index;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.color0B1E2D.withOpacity(0.75),
                  AppColors.colorFFFFFF.withOpacity(0.65),
                ],
                stops: const [
                  0.4,
                  0.75
                ]).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('${state.user?.results?[index].image}'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 3.7,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: SizedBox(
              height: expandedHeight,
              width: 200,
              child: CircleAvatar(
                backgroundColor: AppColors.color0B1E2D,
                radius: 70,
                child: CircleAvatar(
                  foregroundImage:
                      NetworkImage('${state.user?.results?[index].image}'),
                  radius: 88,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}