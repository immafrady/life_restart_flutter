// json 对象
typedef JSONMap = Map<String, dynamic>;

// 属性枚举
enum TypeKey {
  age(key: 'AGE', desc: '年龄'),
  charm(key: 'CHR', desc: '颜值'),
  intelligence(key: 'INT', desc: '智力'),
  strength(key: 'STR', desc: '体质'),
  money(key: 'MNY', desc: '家境'),
  spirit(key: 'SPR', desc: '快乐'),
  life(key: 'LIF', desc: '生命'),
  talent(key: 'TLT', desc: '天赋'),
  event(key: 'EVT', desc: '事件'),
  random(key: 'RDM', desc: '更改随机属性'),
  ;

  final String key;
  final String desc;

  const TypeKey({required this.key, required this.desc});

  static TypeKey? parse(String key) {
    for (var typeKey in TypeKey.values) {
      if (typeKey.key == key) return typeKey;
    }
    return null;
  }
}
