- [source](https://surma.dev/things/c-to-webassembly/)

## Setup

```
apt install llvm wabt lld-8
```

## Step 1

```
clang \
  --target=wasm32 \ # Target WebAssembly
  -emit-llvm \ # Emit LLVM IR (instead of host machine code)
  -c \ # Only compile, no linking just yet
  -S \ # Emit human-readable assembly rather than binary
  add.c
```

```
clang --target=wasm32 -emit-llvm -c -S add.c
```

## Step 2

```
llc \
  -march=wasm32 \ # Target WebAssembly
  -filetype=obj \ # Output an object file
  add.ll
```

```
llc -march=wasm32 -filetype=obj add.ll
```

## Step 3

```
wasm-objdump -x add.o
```

## Step 4

```
wasm-ld-8 \
  --no-entry \ # We don’t have an entry function
  --export-all \ # Export everything (for now)
  -o add.wasm \
  add.o
```

```
wasm-ld-8 --no-entry --export-all -o add.wasm add.o
```

## Another way to do the same

```
clang \
  --target=wasm32 \
  -nostdlib \ # Don’t try and link against a standard library
  -Wl,--no-entry \ # Flags passed to the linker
  -Wl,--export-all \
  -o add.wasm \
  add.c
```

```
clang --target=wasm32 -nostdlib -Wl,--no-entry -Wl,--export-all -o add.wasm add.c
```
