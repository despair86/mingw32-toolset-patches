# patches for various components of mingw-w64 toolset

`fix-static-libg++-clang.patch`, `pick-libc.patch`, `std-fs.patch`, `suffix.patch` are imported from
the MINGW-packages AUR (packages: `mingw-w64-clang`, `mingw-w64-gcc`). These patches are applied to the top-level directory of their respective archives.

## llvm patches:

- `compiler-rt-win32.patch` (Use pthread with non-Microsoft C)
- ~~`fix-static-libg++-clang.patch`~~ (no longer needed, but retained in upstream AUR for whatever reason)
- `libcxxabi-mingw32.patch` (use pthread with non-Microsoft C++)
- `libunwind-mingw32.patch` (use pthread with non-Microsoft C++)
- `llvm-win32-v7.patch` (LLVM v7.x: use ProPolice SSP on non-Microsoft C/Windows NT target, various Windows XP bits, and use [pseh](https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-libraries/pseh/) from ReactOS if llvm is compiled with GCC)
- `llvm-win32-v8.patch` (like v7, rebased on LLVM v8-pre RC3)
- `win32_misc.s` (requires a MASM386 v5.x+ compatible assembler)

## GCC/G++ patches:

- `pick-libc.patch` (override libc selection: default is Microsoft libc v6.1-7.0, this is used to pick libc v8+ or the new UCRT)
- `std-fs.patch` (enable `std::experimental::filesystem` for Windows NT targets)
- `suffix.patch` (some Pascal calling convention fix)
