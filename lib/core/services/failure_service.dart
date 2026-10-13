typedef Fallback<T> = T Function();

T orFallback<T>(T? value, Fallback<T> fallback) {
  if (value != null) {
    return value;
  }
  return fallback();
}
