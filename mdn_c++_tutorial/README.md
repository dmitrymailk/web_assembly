```
emcc hello.c -s WASM=1 -o hello.html
```

```
emcc -o hello2.html hello2.c -O3 -s WASM=1 --shell-file html_template/shell_minimal.html
```

```
emcc -o hello3.html hello3.c -O3 -s WASM=1 --shell-file html_template/shell_minimal.html -s NO_EXIT_RUNTIME=1 -s "EXTRA_EXPORTED_RUNTIME_METHODS=['ccall']"
```

## hello with asm

```
nasm -felf64 calc_numbers.asm && emcc -o my_hello_with_asm.html my_hello_with_asm.c calc_numbers.o -O0 -s WASM=1 --shell-file html_template/shell_minimal.html -s NO_EXIT_RUNTIME=1 -s "EXTRA_EXPORTED_RUNTIME_METHODS=['ccall']"
```

```
emcc my_hello_with_asm.c -s STANDALONE_WASM –o my_hello_with_asm.wasm
emcc –o my_hello_with_asm.wasm my_hello_with_asm.c -s
```
