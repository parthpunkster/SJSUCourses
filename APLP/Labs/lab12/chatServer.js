var net = require('net');
var eol = require('os').EOL;

var srvr = net.createServer();
var clientList = [];

srvr.on('connection', function(client) {
  client.name = client.remoteAddress + ':' + client.remotePort;
  client.write('Welcome, ' + client.name + eol);
  clientList.push(client);

// if 
//   client.on('data', function(data){
//     list(data,client);
//   });

  client.on('data', function(data) {
    if (data.toString() === '\\list\r\n'){
      list(client)
    }
    else if (data.toString().slice(0,7) === '\\rename')
    {
      rename(data,client)
    }
    else if (data.toString().slice(0,8) === '\\private')
    {
      // var tmp = data.toString().split(' ');
      // client.write(tmp[2])
      privateMsg(data,client)
    }
    else
    {
      broadcast(data,client)
    };
  });

});

function privateMsg(data,client)
{
  var tmp = data.toString().split(' ');
  // console.log(clientList.indexOf(tmp[1]))
  // client.write(clientList[1].name)
  // client.write(clientList[1].name)
  // t = tmp[1].trim();
  // console.log(t);
  // t.write(tmp[2]);

  for (var i  in clientList)
  {
    if (tmp[1] === clientList[i].name)
    {
      clientList[i].write(tmp[2]);
    }
  }
}

function list(client) {
  for (var i in clientList) {
    if (client !== clientList[i]){
      client.write(clientList[i].name + "\n");
    }
  }
} 

function rename(data,client)
{
  // clientList[client] = data.toString().slice(8)
  client.name = data.toString().slice(8).trim()
}

function broadcast(data, client) {
  for (var i in clientList) {
    if (client !== clientList[i]) {
      clientList[i].write(client.name + " says " + data);
    }
  }
}

srvr.listen(9000);


