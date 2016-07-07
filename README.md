# Test AUFS issue [docker/docker24309](https://github.com/docker/docker/issues/24309) (without Docker)

```
$ sudo ./test.sh
[INFO] Using mount point /tmp/mnt24309
[INFO] find case01
case01
case01/rev2
case01/rev2/x
case01/rev2/x/.wh..wh..opq
case01/rev1
case01/rev1/x
case01/rev1/x/a
case01/rev0
case01/rev0/x
case01/rev0/x/a
case01/rev0/this_is_aufs
[INFO] find case02
case02
case02/rev2
case02/rev2/x
case02/rev2/x/.wh..wh..opq
case02/rev1
case02/rev1/x
case02/rev1/x/a
case02/rev1/x/.wh..wh..opq
case02/rev0
case02/rev0/x
case02/rev0/x/a
case02/rev0/this_is_aufs
[INFO] diff between case01 and case02
+ diff -r case01 case02
Only in case02/rev1/x: .wh..wh..opq
+ true
+ set +x
[INFO] Running case01
+ mount -t aufs -o br:case01/rev2=ro+wh:case01/rev1=ro+wh:case01/rev0=ro+wh none /tmp/mnt24309
+ '[' -f /tmp/mnt24309/x/a ']'
+ umount /tmp/mnt24309
+ set +x
[INFO] PASS: case01

[INFO] Running case02 (reported in https://github.com/docker/docker/issues/24309 )
+ mount -t aufs -o br:case02/rev2=ro+wh:case02/rev1=ro+wh:case02/rev0=ro+wh none /tmp/mnt24309
+ '[' -f /tmp/mnt24309/x/a ']'
+ ERROR 'TEST FAIL: /x/a should not exist'
+ echo -e '\e[101m\e[97m[ERROR]\e[49m\e[39m TEST FAIL: /x/a should not exist'
[ERROR] TEST FAIL: /x/a should not exist
+ exit 1
```
