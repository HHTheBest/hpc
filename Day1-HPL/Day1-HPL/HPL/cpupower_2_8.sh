#!/bin/bash
cpupower frequency-set -u 800MHz
cpupower frequency-set -d 800MHz
cpupower frequency-set -g powersave
for i in 0 1 2 3 16 17 18 19 20 21 22 23 36 37 38 39
{
  cpupower -c ${i} frequency-set -u 3900MHz
  cpupower -c ${i} frequency-set -d 3900MHz
  cpupower -c ${i} frequency-set -g performance
}
nvidia-smi -pm 1
nvidia-smi -pl 195
cat /proc/cpuinfo |grep MHz
