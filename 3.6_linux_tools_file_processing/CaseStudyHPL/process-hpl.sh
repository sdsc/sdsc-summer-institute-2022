echo 'node      time    P F'                  # Print header
for file in `ls output.hpl*`                  # Iterate over output files
do
  node=`head -1 $file`                        # Node name from first line
  t=`grep WR12R2R4 $file | awk '{print $6}'`  # Time from 6th field of WR12R2R4 line
  npass=`grep PASSED $file| wc -l`            # Number of passed tests
  nfail=`grep FAILED $file| wc -l`            # Number of failed tests
  echo $node $t $nfail $npass
done
