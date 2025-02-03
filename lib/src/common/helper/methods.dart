double normalize({
  required double value,
  required double end,
  double start = 0,
}) {
  if (start == end) return 0;
  return (value - start) / (end - start);
}
