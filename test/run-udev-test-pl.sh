#!/bin/sh

TESTSOURCEDIR=/usr/lib/systemd/tests
[[ -d "$TESTSOURCEDIR" ]] || exit 1

usage() {
    {
        echo "Usage: ${0##*/} [options]"
        echo
        echo "-h, --help                  print a help message and exit."
        echo "-t, --testdir               directory where the test should run (defaults to '/tmp/$(mktemp -d)'"
        echo "-n, --numdevs               number of devices to be created in virtual sysfs"
        echo
    } >&2
}

while (($# > 0)); do
    case $1 in
        -t | --testdir)
            TESTDIR="$2"
            shift
            ;;
        -n | --numdevs)
            NUMDEVS="$2"
            shift
            ;;
        -h | --help)
            usage
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *)
            usage
            exit 1
            ;;
    esac
    shift
done

[[ -n $TESTDIR ]] || TESTDIR=$(mktemp -d)

mkdir -p $TESTDIR/test

cd $TESTDIR

$TESTSOURCEDIR/test/sys-script.py $TESTDIR/test
if [ -n $NUMDEVS ]; then
    python3 $TESTSOURCEDIR/test/sd-script.py $TESTDIR/test $NUMDEVS
fi
$TESTSOURCEDIR/test/udev-test.pl $TESTDIR/test

echo "test directory was $TESTDIR"
