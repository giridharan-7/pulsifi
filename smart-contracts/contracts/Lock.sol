// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.8/tests/MockV3Aggregator.sol";

contract LiquidityPool {
    address public owner;
    AggregatorV3Interface public priceFeed;

    mapping(address => uint) public balances;
    uint256 public totalDeposits;
    uint256 public interestRate;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event InterestRateUpdated(uint256 newInterestRate);

    constructor(address _priceFeed) {
        owner = msg.sender;
        priceFeed = AggregatorV3Interface(_priceFeed);
        interestRate = 500;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the Owner");
        _;
    }

    function deposit () public payable{
        require(msg.value > 0, "Deposit more than 0");
        balances[msg.sender] += msg.value;
        totalDeposits += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw (uint256 amount) public{
        require(balances[msg.sender] >= amount, "Insufficient fund");
        balances[msg.sender] -= amount;
        totalDeposits -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    function updateInterestRate() public onlyOwner {
        (, int256 price,,,) = priceFeed.latestRoundData();
        require(price > 0, "Invalid price feed");

        if(price > 100000000){
            interestRate = 300;
        }else{
            interestRate = 500;
        }

        emit InterestRateUpdated(interestRate);
    }
}
