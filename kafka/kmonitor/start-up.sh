#! /bin/bash
nohup java -Xms512M -Xmx512M -Xss1024K -XX:PermSize=256m -XX:MaxPermSize=512m -cp KafkaOffsetMonitor-assembly-0.2.0.jar com.quantifind.kafka.offsetapp.OffsetGetterWeb --zk PUSH-010:2181,PUSH-012:2181,PUSH-018:2181 --port 8092 --refresh 120.seconds  --retain 2.days > km.out &
