import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:us_soccer_flutter/modules/stadium/providers/stadium.provider.dart';

import '../modules/stadium/widgets/stadium_list_tile.widget.dart';

class Stadiums extends ConsumerWidget {
  const Stadiums({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stadiums = ref.watch(stadiumProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stadiums'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: stadiums.isNotEmpty
            ? ListView.builder(
                itemCount: stadiums.length,
                prototypeItem: StadiumListTile(stadium: stadiums.first),
                itemBuilder: (context, index) {
                  return StadiumListTile(stadium: stadiums[index]);
                },
              )
            : const Text('No Stadiums Found'),
      ),
    );
  }
}
