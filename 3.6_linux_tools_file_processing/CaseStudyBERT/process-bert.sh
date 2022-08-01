for file in `ls -1 out*`
do
  node=`head -1 $file | awk '{print $1}'`
  card=`grep 'AIP (' $file | awk '{print $4}'`
  tstart=`grep TBEFORE $file | awk '{print $2}'`
  tend=`grep AFTER $file | awk '{print $2}'`
  corr=`grep 'Correct answers' $file | tail -1 | awk '{print $8}'`   # Last instance
  ach=`grep 'Achieved sentences' $file | tail -1 | awk '{print $3}'` # Last instance
  t=$(expr $tend - $tstart)                     # Do math to calculate tend - tstart
  echo $node $card $corr $ach $t
done
