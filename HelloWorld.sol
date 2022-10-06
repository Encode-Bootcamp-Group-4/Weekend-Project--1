// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract HelloWorld {
    string private text;
    address public temporaryOwner;
    address public masterOwner;

    constructor() {
        text = "Hello World";
        temporaryOwner = msg.sender;
        masterOwner = msg.sender;
    }

    function helloWorld() public view returns (string memory) {
        return text;
    }

    function setText(string calldata newText) public onlyOwner {
        text = newText;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        temporaryOwner = newOwner;
    }

    function revertTransferOwner() public onlyMasterOwner {
        require(temporaryOwner != masterOwner);
        temporaryOwner = masterOwner;
    }

    modifier onlyOwner()
    {
        require (msg.sender == temporaryOwner, "Caller is not the owner");
        _;
    }

    modifier onlyMasterOwner()
    {
        require (msg.sender == masterOwner, "Caller is not the owner");
        _;
    }
}