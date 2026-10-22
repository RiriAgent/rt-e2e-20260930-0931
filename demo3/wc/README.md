# wc
Count lines, words and characters from stdin.

## Usage

Run these examples from `demo3/wc`:

- Lines: `printf 'a b\n' | sh wc.sh -l` prints `1`.
- Words: `printf 'a b\n' | sh wc.sh -w` prints `2`.
- Characters: `printf 'a b\n' | sh wc.sh -c` prints `4`.
