var Web3 = require('web3');
var web3 = new Web3();
web3.setProvider(new web3.providers.HttpProvider('http://'+"192.168.51.202"+':8545'));


var x = web3.eth.getTransaction("0xaba1cf787a04d25293b2477326ded0e20a876e611ae00eb0db51935b3594ab32")
//console.log(x)

console.log(x.input.substr(0,10))
console.log(x.input.substr(34,40))
console.log(parseInt(x.input.substr(74,64)))
