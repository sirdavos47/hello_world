// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TimeLockRewards is ERC20 {
    mapping(address => uint256) public lockStart;
    mapping(address => uint256) public lockedAmount;
    uint256 public rewardRate = 1 * 10**16; // 0.01 TLR per day

    constructor() ERC20("TimeLockReward", "TLR") {
        _mint(msg.sender, 1000000 * 10**18); // 1M tokens for you
    }

    // Lock ETH for a reward
    function lockETH(uint256 daysLocked) external payable {
        require(msg.value > 0, "Send some ETH!");
        require(daysLocked > 0, "Pick a lock period!");
        lockStart[msg.sender] = block.timestamp;
        lockedAmount[msg.sender] = msg.value;
    }

    // Unlock ETH and get TLR reward
    function unlockETH() external {
        require(lockedAmount[msg.sender] > 0, "Nothing locked!");
        uint256 timeLocked = (block.timestamp - lockStart[msg.sender]) / 1 days;
        require(timeLocked > 0, "Too soon!");
        
        uint256 reward = timeLocked * rewardRate;
        _mint(msg.sender, reward); // Reward TLR
        uint256 amount = lockedAmount[msg.sender];
        lockedAmount[msg.sender] = 0;
        payable(msg.sender).transfer(amount); // Return ETH
    }
}