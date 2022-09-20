// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
}

contract IUABTokenDistrubutor {
	IERC20 IUAB = IERC20(0xAd259e17436b4440B398De3DE99AC7A25eEfa399);

	address[] public owners;
	mapping(address => bool) isOwner;

	constructor(
		address[] memory _owners,
        address _iuabAddress	
	){
		require(_owners.length > 0, "there must be at least 1 owner");
        
        for (uint8 i = 0; i < _owners.length; i++) {
            require(_owners[i] != address(0), "owner can't be a 0 address");
            require(!isOwner[_owners[i]], "only unique owners");
            isOwner[_owners[i]] = true;
            owners.push(_owners[i]);
		}
		IUAB = IERC20(_iuabAddress);
	}

	modifier onlyOwner() {
        require(isOwner[msg.sender], "you're not a owner of the wallet");
        _;
    }

    function getToken(uint256 _ammount) external onlyOwner {
    	require(IUAB.balanceOf(address(this)) >= _ammount, "not enough tokens");
    	IUAB.transfer(msg.sender, _ammount);
    }
}