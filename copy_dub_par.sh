#!/bin/bash
NUM_PROCESSORS=`awk '/^processor/{n+=1}END{print n}' /proc/cpuinfo`
PROCESSOR=`cat /proc/cpuinfo | grep "model name" | head -n 1 | sed -r "s/.* (i[0-9\-]+).*/\1/"`
VERSIONS=(5 '5-2' '5-3')
NUM_ITERS=5
EXP_NUM_PROCESSORS=$NUM_PROCESSORS
AVG=
echo "cpuinfo shows ${NUM_PROCESSORS}x${PROCESSOR} processors" 1>&2
FILE="/home/ubuntu/cpp/results/buffer/${NUM_PROCESSORS}x8124M_`date +%d_%H_%M`.csv"
# FILE="./results/${NUM_PROCESSORS}x${PROCESSOR}_`date +%d_%H_%M`.csv"
echo $FILE

echo "processor, version, num_threads, iteration, time" >> $FILE
for vers in "${VERSIONS[@]}"; do
    for proc in 1 4 8 16 24 36; do
        AVG=0
        for iter in `seq 1 $NUM_ITERS`; do
            echo "Running vers $vers iter $iter with $proc threads" 1>&2
            export ACA_NUM_THREADS=$proc
            printf " ${NUM_PROCESSORS}x${PROCESSOR}, $vers, $proc, $iter, " >> $FILE
            TIME=$(ulimit -s 131072; make large-test VERS=$vers |& grep "raw" | sed -r "s/.*raw: (.*)/\1/")
            # (ulimit -s 131072; make large-test VERS=$vers)
            echo $TIME >> $FILE
            AVG=$(echo "$AVG + $TIME" | bc)
        done
        AVG=$(echo "scale=4; $AVG / $NUM_ITERS" | bc)
        echo "---- Average for $vers over $NUM_ITERS: $AVG"
    done
done

