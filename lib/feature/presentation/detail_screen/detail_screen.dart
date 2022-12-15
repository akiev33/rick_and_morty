import 'package:flutter/material.dart';
import 'package:rick_and_morty/feature/cubit/cubit.dart';
import 'package:rick_and_morty/feature/presentation/appbar_in_detail/appBar_detail.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.index, required this.state});

  final int index;
  final UserState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: AppBarDetail(
              index: index,
              state: state,
              expandedHeight: 200,
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([]),
          ),
        ],
      ),
    );
  }
}
