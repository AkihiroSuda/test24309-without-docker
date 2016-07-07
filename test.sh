#!/bin/sh
set -e #exit on an error

: ${MOUNT_POINT:=/tmp/mnt24309}

ERROR(){
    echo [ERROR] $@
}


INFO(){
    echo [INFO] $@
}

do_test() {
    case=$1
    set -x
    mount -t aufs -o br:$case/rev2=ro+wh:$case/rev1=ro+wh:$case/rev0=ro+wh none ${MOUNT_POINT}
    [ -f ${MOUNT_POINT}/x/a ] && { ERROR "TEST FAIL: /x/a should not exist" ; exit 1; }
    umount ${MOUNT_POINT}
    set +x
    INFO "PASS: $case\n"
}

[ $(id -u) = 0 ] || { ERROR "run as root"; exit 1; }

INFO "Using mount point ${MOUNT_POINT}"
[ -d ${MOUNT_POINT} ] || ( INFO "Creating ${MOUNT_POINT}"; mkdir -p ${MOUNT_POINT} )

INFO "find case01"
find case01

INFO "find case02"
find case02

INFO "diff between case01 and case02"
set -x
diff -r case01 case02 || true
set +x

INFO "Running case01"
do_test case01

INFO "Running case02 (reported in https://github.com/docker/docker/issues/24309 )"
do_test case02

