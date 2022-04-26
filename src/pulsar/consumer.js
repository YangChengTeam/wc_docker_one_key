

const Pulsar = require('pulsar-client');

const { log, error } = require('./log.js')


async function createConsumer(serviceUrl, token, topic, subscription, subscriptionType, producerObj) {
   console.log(token);

  // Create a client
  let client = new Pulsar.Client({
    serviceUrl: serviceUrl,
    operationTimeoutSeconds: 30,
    authentication: new Pulsar.AuthenticationToken({
      token: token, //更换为密钥
    })
  })

  // Create a consumer
  let consumer = await client.subscribe({
    topic: topic,
    subscription: subscription,
    subscriptionType: subscriptionType,
    ackTimeoutMs: 10000,
  }).catch(console.error);


  let producerClient = new Pulsar.Client({
    serviceUrl: producerObj.serviceUrl, //更换为接入地址（控制台集群管理页完整复制）
    authentication: new Pulsar.AuthenticationToken({
      token: producerObj.token, //更换为密钥
    }),
  });
  // Create a producer
  let producer = await producerClient.createProducer({
    topic: producerObj.topic,
    // subscription: 'xiak-sub',
    // sendTimeoutMs: 30000,
    // batchingEnabled: true,
  }).catch(console.error);;

  if(!consumer){return}
  console.log("start work") 
  
  while (true) {
    try {
      // 等待接受消息 没有消息会阻塞
      const msg = await consumer.receive();

      let receiveData = msg.getData().toString()
      let messageId = msg.getMessageId().toString()
      let publishTime = msg.getPublishTimestamp()
       console.log("back data", msg.getData().toString(), msg.getPublishTimestamp())

      //收到消息后转发到腾讯云服务端
      try {

        try {
          producer.send({
            data: Buffer.from(receiveData),
          });
          await producer.flush().catch(console.error);
        } catch (err) {
          //发送消息失败后 再重新发送一遍
          try {
            producer.send({
              data: Buffer.from(receiveData),
            });
            await producer.flush().catch(console.error);;
          } catch (err) {

            let logs = {
              msg: receiveData,
              messageId: messageId,
              publishTime: publishTime,
              err: err
            }
            log(JSON.stringify(logs))
          }

        }
        console.log(`Sent message: ${msg}`);
        // }
        consumer.acknowledge(msg);
        console.log('consumer ok')
      } catch (err) {
        consumer.negativeAcknowledge(msg)
        console.log('err', err)
      }
    } catch (err) {
      console.log('e', err)

    }
  }

}




// 年月日，时分秒
function getFullTime() {
  let date = new Date(),//时间戳为10位需*1000，时间戳为13位的话不需乘1000
    Y = date.getFullYear() + '',
    M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1),
    D = (date.getDate() < 10 ? '0' + (date.getDate()) : date.getDate()),
    h = (date.getHours() < 10 ? '0' + (date.getHours()) : date.getHours()),
    m = (date.getMinutes() < 10 ? '0' + (date.getMinutes()) : date.getMinutes()),
    s = (date.getSeconds() < 10 ? '0' + (date.getSeconds()) : date.getSeconds());
  return Y + "-" + M + '-' + D + ' ' + h + ':' + m + ':' + s
}


let worker;
process.title = 'node-puslar-consumer'
process.on('message', function (message, sendHandle) {

  worker = sendHandle

  // console.log('message', message)

  let consumerObj = message.consumerObj

  let producerObj = message.producerObj


  createConsumer(consumerObj.serviceUrl, consumerObj.token, consumerObj.topic, consumerObj.subscription, consumerObj.subscriptionType, producerObj)

});

process.on('uncaughtException', function (err) {
  console.log('err', err);
  process.send({ act: 'suicide' });
  worker.close(function () {
    process.exit(1);
  })
})
