#!bin/bash

for v in {1..8}
do
  for e in {1..28}
  do
    ./myapp $v $e >> result.txt
  done
done