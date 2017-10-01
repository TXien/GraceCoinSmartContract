pragma solidity ^0.4.11;


import "./Ownable.sol";


/**
 * @title Pausable
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 */
contract ethPausable is Ownable {



  event ethPause();
  event ethUnpause();

  bool public ethpaused = true;


  /**
   * @dev modifier to allow actions only when the contract IS paused
   */
  modifier ethwhenNotPaused() {
    assert(ethpaused!=true);
    _;
  }

  /**
   * @dev modifier to allow actions only when the contract IS NOT paused
   */
  modifier ethwhenPaused {
    assert(ethpaused==true);
    _;
  }

  /**
   * @dev called by the owner to pause, triggers stopped state
   */
  function ethpause() onlyOwner ethwhenNotPaused returns (bool) {
    ethpaused = true;
    ethPause();
    return true;
  }

  /**
   * @dev called by the owner to unpause, returns to normal state
   */
  function ethunpause() onlyOwner ethwhenPaused returns (bool) {
    ethpaused = false;
    ethUnpause();
    return true;
  }
}
