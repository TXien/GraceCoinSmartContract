var GraceCoin = artifacts.require("GraceCoin");

contract('GraceCoin', function(accounts) {
/*
  it("1.should assert true", function() {
    return  GraceCoin.deployed().then(function(instance){
     token = instance;
     return token.totalSupply.call();
    }).then(function(result){
     assert.equal(result.toNumber(), 8400000000000000, 'total supply is wrong');
    })
  });

   it("2.should assert true", function() {
     return  GraceCoin.deployed().then(function(instance){
      token = instance;
      return token.totalSupply.call();
     }).then(function(result){
      assert.equal(result.toNumber(), 8400000000000000, 'total supply is wrong');
     })
   });
*/

   it("3.should assert true", function() {
	return  GraceCoin.deployed().then(function(instance){
		console.log("contract:",instance.address)
		token = instance;
		return token.unpause();
	}).then(function(result){
		return token.transfer(accounts[1], 10000);
	}).then(function(result){
		console.log(result)
		return token.balanceOf.call(accounts[0]);
	}).then(function(result){
    		assert.equal(result.toNumber(), 6299999999999999, 'accounts[0] balance is wrong');
    		return token.balanceOf.call(accounts[1]);
   	}).then(function(result){
    		assert.equal(result.toNumber(), 1, 'accounts[1] balance is wrong');
   	})
});
});
