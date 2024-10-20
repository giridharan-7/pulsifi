const { ethers } = require("hardhat");

async function interact() {
    const liquidityPoolAddress = "0x1f529327CCa6E172DbD5f6D7f1B046454d7f24cB";
    const LiquidityPool = await ethers.getContractFactory("LiquidityPool");
    const liquidityPool = await LiquidityPool.attach(liquidityPoolAddress);

    const [user, owner] = await ethers.getSigners();

    // Deposit
    // let tx = await liquidityPool.connect(user).deposit({ value: ethers.parseEther("0.000001") });
    // await tx.wait();
    // console.log("Deposited 1 ETH");

    // // Withdraw
    // tx = await liquidityPool.connect(user).withdraw(ethers.parseEther("0.0000001"));
    // await tx.wait();
    // console.log("Withdrew 0.5 ETH");

    // Update Interest Rate
    tx = await liquidityPool.connect(user).updateInterestRate();
    await tx.wait();
    console.log("Interest Rate Updated");
}

interact()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
