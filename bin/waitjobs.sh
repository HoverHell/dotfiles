FAIL=0
for job in `jobs -p`
do
echo $job
    wait $job || let "FAIL+=1"
done
echo "($0) waitjobs result: $FAIL"
