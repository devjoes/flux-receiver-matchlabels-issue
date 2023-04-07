#!/bin/bash
for pid in $(cat ./pids); do
	echo $pid
done
kind delete cluster