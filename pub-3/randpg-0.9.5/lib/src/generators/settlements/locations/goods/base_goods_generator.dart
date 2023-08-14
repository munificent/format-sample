import 'dart:math';

import '../../../../entities/settlements/goods.dart';
import '../../../base/generator.dart';
import '../../../base/list_item_generator.dart';
import '../../../base/seed_generator.dart';

/// A class that generates a good from [_pool] and randomizes its price a bit
///
/// The map needs to be formatted as `{"name": "10 gp"}`, meaning the name of the goods is the key and the price the value
class BaseGoodsGenerator implements IGenerator<Goods> {
  late int _seed;
  final Map<String, String> _pool;

  BaseGoodsGenerator(this._pool) {
    _seed = SeedGenerator.generate();
  }

  @override
  Goods generate() {
    final generator = ListItemGenerator(_pool.keys.toList());
    generator.seed(_seed);
    final name = generator.generate();

    final cost = double.parse(_pool[name]!.split(" ").first);
    final coins = _pool[name]!.split(" ").last;

    return Goods(name: name, price: "${_getCost(cost)} $coins");
  }

  int _getCost(double baseCost) {
    final multiplier = Random(_seed).nextDouble() + 0.5;

    return max((baseCost * multiplier).toInt(), 1);
  }

  @override
  void seed(int seed) {
    _seed = seed;
  }
}
