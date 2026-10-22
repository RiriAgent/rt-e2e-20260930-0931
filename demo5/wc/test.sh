#!/bin/sh
set -eu

script_dir=$(CDPATH= cd -P "$(dirname "$0")" && pwd)
script=$script_dir/wc.sh

# Keep the streams separate and compare complete output, including newlines.
tmp=${TMPDIR:-/tmp}/wc-test.$$
(umask 077 && mkdir "$tmp")
trap 'rm -rf "$tmp"' 0
trap 'exit 1' HUP INT TERM

assert_count() {
    flag=$1
    input=$2
    expected=$3
    status=0
    printf '%b' "$input" | "$script" "$flag" >"$tmp/out" 2>"$tmp/err" || status=$?
    printf '%s\n' "$expected" >"$tmp/expected"
    if [ "$status" -ne 0 ] || [ -s "$tmp/err" ] ||
        ! cmp -s "$tmp/expected" "$tmp/out"; then
        printf 'FAIL: %s: expected count %s and status 0, got status %s\n' \
            "$flag" "$expected" "$status" >&2
        exit 1
    fi
}

assert_count -l 'one two\nthree\n' 2
assert_count -w 'one two\nthree\n' 3
assert_count -c 'one two\nthree\n' 14
assert_count -l '' 0
assert_count -w '' 0
assert_count -c '' 0
assert_count -l 'no newline' 0
assert_count -w '  one\ttwo  \n' 2
assert_count -c 'no newline' 10

assert_usage() {
    status=0
    "$script" "$@" </dev/null >"$tmp/out" 2>"$tmp/err" || status=$?
    printf '%s\n' 'usage: wc.sh -l|-w|-c' >"$tmp/expected"
    if [ "$status" -ne 2 ] || [ -s "$tmp/out" ] ||
        ! cmp -s "$tmp/expected" "$tmp/err"; then
        printf 'FAIL: usage error (status %s)\n' "$status" >&2
        exit 1
    fi
}

assert_usage
assert_usage -x
assert_usage -l -w

printf '%s\n' ok
