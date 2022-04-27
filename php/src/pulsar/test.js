
const Pulsar = require('pulsar-client');

async function test(){
    const client = new Pulsar.Client({
        serviceUrl: 'pulsar://pulsar:6650',
        authentication: new Pulsar.AuthenticationToken({
            token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjbGllbnQifQ.vxcZ_1gvD6Nf-DRYYxwwPuW4dCkS1WVZxjg7FrRPePI", //更换为密钥
          })
      });
      
    const producer = await client.createProducer({
            topic: 'cmd/gateway/upload', // or 'my-tenant/my-namespace/my-topic' to specify topic's tenant and namespace 
      });
      
      await producer.send({
        data: Buffer.from("Hello, Pulsar"),
      });
      
    
}


test()