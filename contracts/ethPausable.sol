pragma solidity ^0.4.11;
import "./Ownable.sol";
/**
 * @title ethPausable
 */
contract ethPausable is Ownable {
  event ethPause();
  event ethUnpause();
  bool public ethpaused = true;
  modifier ethwhenNotPaused() {
    assert(ethpaused!=true);
    _;
  }
  modifier ethwhenPaused {
    assert(ethpaused==true);
    _;
  }
  function ethpause() onlyOwner ethwhenNotPaused returns (bool) {
    ethpaused = true;
    ethPause();
    return true;
  }
  function ethunpause() onlyOwner ethwhenPaused returns (bool) {
    ethpaused = false;
    ethUnpause();
    return true;
  }
}
