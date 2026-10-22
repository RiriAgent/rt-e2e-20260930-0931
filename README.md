# rt-e2e-20260930-0931
omp-roundtable e2e fixture 20260930-0931

## Word counter

`demo2/wc/wc.sh` reads standard input. Use `-l` to count newline characters,
`-w` to count whitespace-separated words, or `-c` to count characters in the
current locale. Empty input returns `0`. Invalid or missing flags print usage
to standard error and exit with status 2.

Run the assertions with `sh demo2/wc/test.sh`; a successful run ends with `ok`.

## Demo 3 word counter

`demo3/wc/wc.sh` reads standard input using the same flags: `-l` counts newline
characters, `-w` counts whitespace-separated words, and `-c` counts characters
in the current locale. Empty input prints `0`; missing or unknown flags print
`usage: wc.sh -l|-w|-c` to standard error and exit with status 2.

Run `sh demo3/wc/test.sh` to check the counter; success ends with `ok`.
