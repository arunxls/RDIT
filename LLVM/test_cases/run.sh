#!/bin/bash

export BD=~/Code/LLVM/llvm_cmake_build/bin;
rm *.bc test.log;
# pushd $BD/../; make all; popd
$BD/clang++ -O0 -g -emit-llvm -c test.cpp -o test.bc;

$BD/opt -tsan < test.bc -S -o temp.bc;
$BD/clang -O0 -emit-llvm -c print.c -o print.bc;
$BD/llvm-link temp.bc print.bc -o=combine.bc;
$BD/llvm-dis combine.bc;
$BD/llvm-dis test.bc;
$BD/lli combine.bc;

# for i in {0..100}
# do
#     $BD/lli combine.bc;
# done

./filter.pl;
