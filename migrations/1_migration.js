const IUABMultiSig = artifacts.require("IUABMultiSig");

module.exports = function(deployer){
    deployer.deploy(IUABMultiSig);
}
