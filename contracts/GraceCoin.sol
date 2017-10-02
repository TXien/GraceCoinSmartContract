pragma solidity ^0.4.10;
import "./StandardToken.sol";
import "./SafeMath.sol";
import "./ethPausable.sol";

contract GraceCoin is StandardToken, SafeMath, ethPausable {
    string public constant name = "Grace Coin";
    string public constant symbol = "GRACE";
    uint256 public constant decimals = 8;
    string public version = "1.0";
    address public G2UFundDeposit;
    address public ETHFundDeposit;
    address public GraceFund;
    uint256 public constant G2Ufund = 6300*10000*10**decimals;
    uint256 public buyExchangeRate = 1*10**8; // per 1 ETH buy 1 Grace Coin  
    uint256 public sellExchangeRate = 1*10**8; // per 1 Grace Coin buy 1 ETH
    uint256 public constant ETHfund= 2100*10000*10**decimals;
    event LogRefund(address indexed _to, uint256 _value);
    event CreateBAT(address indexed _to, uint256 _value);
    function GraceCoin()
    {
      G2UFundDeposit = 0xf03d707298c78c4504ba7da5aedf52f18e7b7d95;
      ETHFundDeposit = 0xfd9af334d2428a56f1a96fa45c37f6b89ec6a307;
      totalSupply = G2Ufund+ETHfund;
      balances[G2UFundDeposit] = G2Ufund;
      balances[ETHFundDeposit] = ETHfund;
      CreateBAT(G2UFundDeposit, G2Ufund);
    }
    function setBuyExchangeRate(uint rate) returns(uint){
        assert(msg.sender==owner);
        buyExchangeRate = rate;
        return rate;
    }
    function setSellExchangeRate(uint rate) returns(uint){
        assert(msg.sender==owner);
        sellExchangeRate = rate;
        return rate;
    }
    function buyCoins() ethwhenNotPaused payable external {
        uint256 tokens = safeMult(msg.value, buyExchangeRate)/(10**18); 
        assert(balances[ETHFundDeposit]>=tokens);
        balances[ETHFundDeposit] -= tokens;
        balances[msg.sender] += tokens;
        Transfer(ETHFundDeposit, msg.sender, tokens);
    }
    function sellCoins(uint G2Uamount) ethwhenNotPaused payable external {
        assert(balances[msg.sender] >= G2Uamount);
        uint256 etherAmount = safeMult(G2Uamount,sellExchangeRate)*100;
        assert(etherAmount <= this.balance);
        msg.sender.transfer(etherAmount);
        balances[msg.sender] = safeSubtract(balances[msg.sender],G2Uamount);
        Transfer(msg.sender, ETHFundDeposit, G2Uamount);
    }
    function getBalance() constant returns(uint){
        return this.balance;  
    }
    function getEther(uint balancesNum){
        assert(msg.sender == G2UFundDeposit);
        assert(balancesNum <= this.balance);
        G2UFundDeposit.transfer(balancesNum);
    }
    function putEther() payable returns(bool){
        return true;
    }
    function graceTransfer(address _to, uint256 _value) returns (bool success) {
      assert(msg.sender==G2UFundDeposit||msg.sender==ETHFundDeposit||msg.sender==owner);
      if (balances[msg.sender] >= _value && _value > 0) {
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
      } else {
        return false;
      }
    }

}
