#include <stdio.h>
#include <inttypes.h>
#include <emscripten/emscripten.h>

// #ifdef __cplusplus
// extern "C"
// {
// #endif
EMSCRIPTEN_KEEPALIVE void calc_two_numbers_expression();

EMSCRIPTEN_KEEPALIVE extern int64_t number_1;
EMSCRIPTEN_KEEPALIVE extern int64_t number_2;
EMSCRIPTEN_KEEPALIVE extern int64_t result;

int main()
{
  int64_t *num_1 = &number_1;
  int64_t *num_2 = &number_2;
  *num_1 = (int64_t)2;
  *num_2 = (int64_t)40;
  calc_two_numbers_expression();
  printf("Output from printf = %lld\n", result);
  return 0;
}