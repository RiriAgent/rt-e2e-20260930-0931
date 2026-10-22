# wc
Count lines, words and characters from stdin.

## Usage

Run these examples from the repository root. The output below each command is
the expected count.

Count lines:

```sh
printf 'one two\nthree\n' | demo5/wc/wc.sh -l
2
```

Count words:

```sh
printf 'one two\nthree\n' | demo5/wc/wc.sh -w
3
```

Count characters:

```sh
printf 'one two\nthree\n' | demo5/wc/wc.sh -c
14
```
