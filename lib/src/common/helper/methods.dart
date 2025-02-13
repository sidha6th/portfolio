double normalize({
  required double value,
  required double end,
  double start = 0,
}) {
  if (start == end || value < 0) return 0;
  return (value - start) / (end - start);
}
