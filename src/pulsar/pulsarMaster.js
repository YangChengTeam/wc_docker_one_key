const fork = require('child_process').fork;
const fs = require('fs')

process.title = 'node-master'

const workers = {};

// 读取消费者端配置文件 
let consumerData = fs.readFileSync('consumer_config.json', 'utf-8')

// 读取生产者端配置文件
let producerData = fs.readFileSync('producer_config.json', 'utf-8')


// console.log('data', typeof (data))

//一个订阅只能被一个主题订阅，而一个主题可以订阅多个订阅

// 通过fork进程创建 消费者进程
const createConsumer = (messageObj) => {

    // console.log('createWorker1', dataMsg)
    // let consumer = fork('consumer.js')
    let consumer = fork('consumer.js')
    consumer.on('message', function (message) {
        if (message.act === 'pulsarMsg') {
            consumer.send(message)
        } else if (message.act === 'suicide') {
            start()
        }
    })

    consumer.on('exit', function (code, signal) {
        console.log('worker process exited, code: %s signal: %s', code, signal);
        delete workers[consumer.pid];
    });

    consumer.send(messageObj);

    workers[consumer.pid] = consumer;

    console.log('consumer process created, pid: %s ppid: %s', consumer.pid, process.pid);

    // worker1.send(dataMsg);
}



function start() {
    if (consumerData) {
        consumerData = JSON.parse(consumerData)
        // console.log('data', data)
        consumerData.forEach(item => {
            let consumers = item.cousumers
            consumers.forEach(consumer => {
               
                consumer.serviceUrl = item.serviceUrl
                consumer.token = item.token
                // console.log('item', item,consumer.to_pulsar)
                let producerName = consumer.to_pulsar.producer_name //创建生产者的key
                let producerTopic = consumer.to_pulsar.producer_topic //转发到生产者的topic
                if (producerData) {
                   let newProducerData = JSON.parse(producerData)
                    // console.log('producerData',producerData,producerName=='txy1')
                    let producers = newProducerData[producerName]
                    
                    producers.forEach(producer => {
                       
                        producer.producers.forEach(pd => {
                            if (producerTopic == pd.topic) {
                                pd.serviceUrl = producer.serviceUrl
                                pd.token = producer.token
                                let message = {
                                    consumerObj: consumer,
                                    producerObj: pd
                                }
                                createConsumer(message)
                                console.log('message', message)
                            }
                        })

                    })

                }


            })

        })


    }
}


start()


process.once('SIGINT', close.bind(this, 'SIGINT')); // kill(2) Ctrl-C
process.once('SIGQUIT', close.bind(this, 'SIGQUIT')); // kill(3) Ctrl-
process.once('SIGTERM', close.bind(this, 'SIGTERM')); // kill(15) default
process.once('exit', close.bind(this));

function close(code) {
    console.log('进程退出！', code);

    if (code !== 0) {
        for (let pid in workers) {
            console.log('master process exited, kill worker pid: ', pid);
            workers[pid].kill('SIGINT');
        }
    }

    process.exit(0);
}
