import 'types.dart';

typedef EffectMap = Map<PropertyKey, int>;

extension Parser on EffectMap {
  parse(JSONMap? json) {
    if (json != null) {
      for (var MapEntry(:key, :value) in json.entries) {
        final propertyKey = PropertyKey.parse(key);
        assert(propertyKey != null);
        if (propertyKey != null) {
          this[propertyKey] = value ?? 0;
        } else {
          print('[parse]invalid key: $propertyKey');
        }
      }
    }
  }
}
