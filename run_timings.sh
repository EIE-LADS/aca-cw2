#!/bin/bash
NUM_PROCESSORS=`awk '/^processor/{n+=1}END{print n}' /proc/cpuinfo`
PROCESSOR=`cat /proc/cpuinfo | grep "model name" | head -n 1 | sed -r "s/.* (i[0-9\-]+).*/\1/"`
VERSIONS=(5 6 7)
NUM_ITERS=2
AVG=
echo "cpuinfo shows ${NUM_PROCESSORS}x${PROCESSOR} processors" 1>&2
FILE="results/${NUM_PROCESSORS}x${PROCESSOR}_`date +%d_%H_%M`.csv"

echo "processor, version, iteration, time" >> $FILE
for vers in "${VERSIONS[@]}"; do
    AVG=0
    for iter in `seq 1 $NUM_ITERS`; do
        echo "Running vers $vers iter $iter" 1>&2
        printf " ${NUM_PROCESSORS}x${PROCESSOR}, $vers, $iter, " >> $FILE
        TIME=$(ulimit -s 131072; make large-test VERS=$vers |& grep "raw" | sed -r "s/.*raw: (.*)/\1/")
    #    (ulimit -s 131072; make large-test VERS=$vers)
        echo $TIME >> $FILE
        AVG=$(echo "$AVG + $TIME" | bc)
    done
    AVG=$(echo "scale=4; $AVG / $NUM_ITERS" | bc)
    echo "---- Average for $vers over $NUM_ITERS: $AVG"
done

