async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    const priceFeedAddress = "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419";
    const LiquidityPool = await ethers.getContractFactory("LiquidityPool");
    const liquidityPool = await LiquidityPool.deploy(priceFeedAddress);

    console.log("LiquidityPool deployed to:", liquidityPool);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
