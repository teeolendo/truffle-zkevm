// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Coruscant {
  string public name = "Coruscant";
  string public symbol = "CRSN";
  uint256 public totalSupply = 100000000;
  
  // Mapping owner address to token count
  mapping(address => uint256) private _balances;
  
  // Mapping from token ID to owner address
  mapping(uint256 => address) private _owners;

  function balanceOf(address owner) public view returns (uint256) {
    require(owner != address(0), "ERC721: address zero is not a valid owner");
    return _balances[owner]; 
  }

  function ownerOf(uint256 tokenId) public view returns (address) {
    address owner = _ownerOf(tokenId);
    require(owner != address(0), "ERC721: invalid token ID");
    return owner;
  }

  function _ownerOf(uint256 tokenId) internal view returns (address) {
    return _owners[tokenId];
  }

  function mint(address to, uint256 tokenId) external {
    require(to != address(0), "ERC721: mint to the zero address");
    require(!_exists(tokenId), "ERC721: token already minted");

    _balances[to] += 1;

    _owners[tokenId] = to;
  }

  function _exists(uint256 tokenId) internal view virtual returns (bool) {
      return _ownerOf(tokenId) != address(0);
  }

  
}
