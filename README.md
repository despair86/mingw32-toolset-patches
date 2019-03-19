# patches for various components of mingw-w64 toolset

a lot of my internal/personal projects tend to have `nearly every Windows NT PC in existence` as a target. to wit, i have made a collection of patches over time, and are being released to support reproducible builds for https://github.com/loki-project/loki-network on Windows; this is part of the toolchain i have proposed for release engineering there. 

Incidentally, these patches mostly affect the 32-bit port, but some are generic enough that the 64-bit build is materially affected by the changes (i.e. physical image contents are different, but have no observable effect on a 64-bit build)

`fix-static-libg++-clang.patch`, `pick-libc.patch`, `std-fs.patch`, `suffix.patch` are imported from
the MINGW-packages AUR (packages: `mingw-w64-clang`, `mingw-w64-gcc`). These patches are applied to the top-level directory of their respective archives.

## llvm patches:

- `compiler-rt-win32.patch` (Use pthread with non-Microsoft C)
- ~~`fix-static-libg++-clang.patch`~~ (no longer needed, but retained in upstream AUR for whatever reason)
- `libcxxabi-mingw32.patch` (use pthread with non-Microsoft C++)
- `libunwind-mingw32.patch` (use pthread with non-Microsoft C++)
- `llvm-win32-v7.patch` (LLVM v7.x: use ProPolice SSP on non-Microsoft C/Windows NT target, various Windows XP bits, and use [pseh](https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-libraries/pseh/) from ReactOS if llvm is compiled with GCC)
- `llvm-v7-with-solaris.patch` - (Same as above, but with type casting fixes for floating-point functions. These should be harmless on other platforms. Also patches LLD v7. This patch may supersede the patch above.)
- `llvm-win32-v8.patch` (like v7, rebased on LLVM v8-pre RC3)
- `llvm-trunk-with-solaris.patch` (LLVM v8-v9 trunk with patches for a Solaris host. Assumes you are using a custom GCC or Clang paired with the GNU ld or gold, vendor provided GCC is paired with the brain-dead Oracle linker)
   - Note: This patch will be frequently rebased on SVN trunk
- `win32_misc.s` (requires a MASM386 v5.x+ compatible assembler)

## GCC/G++ patches:

All of these are patches on the GCC source tarball (i.e. with all frontends included, except D). Internally, I have abandoned GCC for LLVM, except for `libstdc++-v6` (Apple `libc++` is linked to the UCRT, which imposes a separate runtime deliverable.), so this section is mostly of public interest.
- `pick-libc.patch` (override libc selection: default is Microsoft libc v6.1-7.0, this is used to pick libc v8+ or the new UCRT)
- `std-fs.patch` (enable `std::experimental::filesystem` for Windows NT targets)
- `suffix.patch` (some Pascal calling convention fix)
- `libg++-win32.patch` (patch held over since g++ 5.x)
- `clang-inline-typeinfo-bug.patch` (See https://github.com/msys2/MINGW-packages/issues/1677. This bug remains in LLVM trunk as of 19-03-19)
- `gcc-8.3.0-dist.patch` (A patch which combines all of the above changes into a single patch rebased on GCC 8.3. Please continue to use the individual patches on older versions.)

## mingw-w64 runtime/CRT patches:

- `mingw-w64-v6.patch` Revert UCRT fix for `__mb_cur_max`/`__mb_cur_max_func()` (I do not impose extra runtime dep on UCRT), patch pthread to use reactos SEH, fix reactos DDK header
  - Note: PSEH only compiles with GCC! Use `-fno-ident` to avoid leaking multiple copies of the compiler ID string.
