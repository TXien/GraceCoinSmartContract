var Web3 = require('web3');
var web3 = new Web3();
web3.setProvider(new web3.providers.HttpProvider('http://'+"192.168.51.202"+':8545'));
var x = web3.eth.gasPrice;
console.log(x)

var abi = require('./build/contracts/GraceCoin.json');

//console.log(abi["abi"])

var CoursetroContract = web3.eth.contract(abi["abi"]);
var Coursetro = CoursetroContract.at('0xcbb08f2d53b404487d6d29a41605870d454aa6cc');

       Coursetro.balanceOf("0xe70c2ee30cbf71f92d6c3bc6153fa588046b84d7",function(error, result) {
           if (!error) {
		console.log(result)
           } else
                console.log(error);
       });
