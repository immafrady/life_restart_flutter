// json 对象
typedef JSONMap = Map<String, dynamic>;

// 属性枚举
enum PropertyKey {
  age(key: 'AGE', desc: '年龄', type: PropertyType.attribute),
  charm(key: 'CHR', desc: '颜值', type: PropertyType.attribute),
  intelligence(key: 'INT', desc: '智力', type: PropertyType.attribute),
  strength(key: 'STR', desc: '体质', type: PropertyType.attribute),
  money(key: 'MNY', desc: '家境', type: PropertyType.attribute),
  spirit(key: 'SPR', desc: '快乐', type: PropertyType.attribute),
  life(key: 'LIF', desc: '生命', type: PropertyType.attribute),
  talent(key: 'TLT', desc: '天赋', type: PropertyType.relation),
  event(key: 'EVT', desc: '事件', type: PropertyType.relation),
  random(key: 'RDM', desc: '更改随机属性', type: PropertyType.special),
  summary(key: 'SUM', desc: '总评', type: PropertyType.special);

  final String key;
  final String desc;
  final PropertyType type;

  const PropertyKey({required this.key, required this.desc, required this.type});

  static PropertyKey? parse(String key) {
    for (var typeKey in PropertyKey.values) {
      if (typeKey.key == key) return typeKey;
    }
    return null;
  }
}

enum PropertyType { attribute, relation, special }

/// ----分割线----

// 权重record （key，对应的权重）
typedef RecordWeight = ({int key, double weight});

// 常用类型
typedef AttributeMap = Map<PropertyKey, int>;
typedef RelationMap = Map<PropertyKey, List<int>>;
