var Web3 = require('web3');
var web3 = new Web3();
web3.setProvider(new web3.providers.HttpProvider('http://'+"192.168.51.202"+':8545'));
const EthereumTx = require('ethereumjs-tx')
const privateKey = Buffer.from('54dee1a12baaccb5589e062aa59bf72b95f689d260665770073bc095cc7c7e7c', 'hex')
var func = "0xa9059cbb000000000000000000000000"
var to = "0x2783ca61c6a2e5e1fecd5896f03603162ab10f35"
var amount = "2710"
var input = func+to.substr(2)+paddingLeft(amount,64);
//console.log(input)
function paddingLeft(str,lenght){
	if(str.length >= lenght)
	return str;
	else
	return paddingLeft("0" +str,lenght);
}
const txParams = {
  nonce: '0x09',
  gasPrice: '0x2540BE400', 
  gasLimit: '0x1A2104',
  to: '0xcbb08f2d53b404487d6d29a41605870d454aa6cc', 
  input: input,
  value: '0x00', 
  data: '0x7f7465737432000000000000000000000000000000000000000000000000000000600057',
  // EIP 155 chainId - mainnet: 1, ropsten: 3
}

const tx = new EthereumTx(txParams)
tx.sign(privateKey)
const serializedTx = tx.serialize()
console.log(serializedTx.toString('hex'))
//console.log(tx.toJSON())


web3.eth.sendRawTransaction("0x"+serializedTx.toString('hex'), function(err, hash) {
	if(err != null){
		console.log(err);
		//res.send("error");
		return ;
	}
	if (!err){
		console.log(hash);
		//res.send(hash.toString()); 
	}
});
