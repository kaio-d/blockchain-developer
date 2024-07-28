pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Mon is ERC721{
	
	struct Pokemon {
		string name;
		uint level;
		string img;
	}	
	
	Pokemon[] public pokemons;
	address public gameOwner;

	constructor () ERC721 ("Mon", "PKD"){
		gameOwner = msg.sender;
    } 	

    modifier onlyOwnerOf(uint _monsterId){
	    require(ownerOf(_monsterId) == msg.sender, "Apenas o dono pode batalhar com esse Pokemon");
	    _;
    }   

    function battle(uint _attackingMon, uint _defendingMon) public onlyOwnerOf(_attackingMon){
        Pokemon storage attacker = pokemons[_attackingMon];
        Pokemon storage defender = pokemons[_defendingMon];

        if(attacker.level >= defender.level){
            attacker.level += 2;
            defender.level += 1;
        } else {
            attacker.level += 1;
            defender.level +=2;
        }
    }

    function createNewMon(string memory _name, address _to, string memory _img) public {
        require(msg.sender == gameOwner, "Apenas o dono do jogo pode criar novos Mons");
        uint id = pokemons.length;
        pokemons.push(Pokemon(_name, 1, _img));
        _safeMint(_to, id);
    }

}