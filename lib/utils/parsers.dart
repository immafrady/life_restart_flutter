/**
 * 将可能是字符串的数字转成数字
 */
int convertToInt(dynamic value, {int defaultValue = 0}) {
  return value is String
      ? int.tryParse(value) ?? defaultValue
      : value is int
          ? value
          : defaultValue;
}
