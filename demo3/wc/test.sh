#!/bin/sh
set -eu

script_dir=$(CDPATH= cd -P "$(dirname "$0")" && pwd)
script=$script_dir/wc.sh

assert_count() {
    flag=$1
    input=$2
    expected=$3
    actual=$(printf '%b' "$input" | "$script" "$flag")
    if [ "$actual" != "$expected" ]; then
        printf 'FAIL: %s: expected <%s>, got <%s>\n' "$flag" "$expected" "$actual" >&2
        exit 1
    fi
}

assert_count -l 'hello world\n' 1
assert_count -w 'hello world\n' 2
assert_count -c 'hello world\n' 12
assert_count -l '' 0
assert_count -w '' 0
assert_count -c '' 0
assert_count -l 'one two\n\nthree\n' 3
assert_count -w 'one two\n\nthree\n' 3
assert_count -c 'one two\n\nthree\n' 15
assert_count -l 'no newline' 0
assert_count -w '  one\ttwo  \n' 2
assert_count -c 'no newline' 10

# Keep stdout and stderr separate to check the usage-error contract.
tmp=${TMPDIR:-/tmp}/wc-test.$$
(umask 077 && mkdir "$tmp")
trap 'rm -rf "$tmp"' 0
trap 'exit 1' HUP INT TERM

assert_usage() {
    status=0
    "$script" "$@" </dev/null >"$tmp/out" 2>"$tmp/err" || status=$?
    if [ "$status" -ne 2 ] || [ -s "$tmp/out" ] ||
        [ "$(cat "$tmp/err")" != 'usage: wc.sh -l|-w|-c' ]; then
        printf 'FAIL: usage error (status %s)\n' "$status" >&2
        exit 1
    fi
}

assert_usage
assert_usage -x
assert_usage -l -w

printf '%s\n' ok
