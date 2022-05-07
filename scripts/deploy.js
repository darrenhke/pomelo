// scripts/deploy.js
async function main () {
    // We get the contract to deploy
    const Pomelo = await ethers.getContractFactory('Pomelo');
    console.log('Deploying Pomelo...');
    const pomelo = await Pomelo.deploy();
    await pomelo.deployed();
    console.log('Pomelo deployed to:', pomelo.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });