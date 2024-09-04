typedef Conditions = List<Object>;

Conditions parseConditions(String condition) {
  final Conditions conditions = [];
  final len = condition.length;
  final Conditions stack = [conditions];

  var cursor = 0;

  void catchString(int index) {
    final str = condition.substring(cursor, index).trim();
    cursor = index;
    if (str != '') {
      (stack[0] as Conditions).add(str);
    }
  }

  for (var i = 0; i < len; i++) {
    switch (condition[i]) {
      case '(':
        catchString(i);
        cursor++;
        final Conditions sub = [];
        (stack[0] as Conditions).add(sub);
        stack.insert(0, sub);
      case ')':
        catchString(i);
        cursor++;
        stack.removeAt(0);
      case '|':
      case '&':
        catchString(i);
        catchString(i + 1);
      case ' ':
      default:
        continue;
    }
  }
  catchString(len);
  return conditions;
}
