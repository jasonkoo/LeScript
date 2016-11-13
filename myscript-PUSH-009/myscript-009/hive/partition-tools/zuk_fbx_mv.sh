#! /bin/bash
for thedate in `./dateloop 20150818 20151213`
do
  if hadoop fs -test -e /flume/zuk/feedbackx_new/thedate=$thedate ; then
    su - flume -c "hadoop fs -mv /flume/zuk/feedbackx_new/thedate=$thedate/000000_0 /flume/worldwide/feedbackx/$thedate/zuk_000000_0"
  fi
done
