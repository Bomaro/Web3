//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0 < 0.9.0;

contract Budget{
        event AddCusto(address recipient, uint custoId);
        event AddGanho(address recipient, uint ganhoId);
        event DeleteCusto(uint custoId, bool isDeleted);
        event DeleteGanho(uint ganhoId, bool isDeleted);

        struct Custo{
            uint id;
            string ano;
            string mes;
            string dia;
            string custo;
            string typename;
            string obsname;
            bool isDeleted;
        }
        struct Ganho{
            uint id;
            string ano;
            string mes;
            string dia;
            string ganho;
            string typename;
            string obsname;
            bool isDeleted;
        }
    Custo[] private custos;
    mapping(uint256 => address) custoToOwner;
    
    Ganho[] private ganhos;
    mapping(uint256 => address) ganhoToOwner;
    
    function addCusto(string memory ano,string memory mes,string memory dia, string memory custo,string memory typename,string memory obsname, bool isDeleted) external {
        uint custoId = custos.length;
        custos.push(Custo(custoId,ano,mes,dia,custo,typename,obsname,isDeleted));
        custoToOwner[custoId] = msg.sender;
        emit AddCusto(msg.sender, custoId);
    }
    
    function addGanho(string memory ano,string memory mes,string memory dia, string memory ganho,string memory typename,string memory obsname, bool isDeleted) external {
        uint ganhoId = ganhos.length;
        ganhos.push(Ganho(ganhoId,ano,mes,dia,ganho,typename,obsname,isDeleted));
        ganhoToOwner[ganhoId] = msg.sender;
        emit AddGanho(msg.sender, ganhoId);
    }

    function getMyCustos() external view returns (Custo[] memory){
        Custo[] memory temporary = new Custo[](custos.length);
        uint counter = 0;

        for (uint i=0; i<custos.length; i++){
            if(custoToOwner[i] == msg.sender && custos[i].isDeleted == false){
                temporary[counter] = custos[i];
                counter++;
            }
        }
        Custo[] memory result = new Custo[](counter);
        for (uint i=0; i<counter; i++){
            result[i] = temporary[i];
        }
        return result;
    }
    
    function getMyGanhos() external view returns (Ganho[] memory){
        Ganho[] memory temporary = new Ganho[](ganhos.length);
        uint counter = 0;

        for (uint i=0; i<ganhos.length; i++){
            if(ganhoToOwner[i] == msg.sender && ganhos[i].isDeleted == false){
                temporary[counter] = ganhos[i];
                counter++;
            }
        }
        Ganho[] memory result = new Ganho[](counter);
        for (uint i=0; i<counter; i++){
            result[i] = temporary[i];
        }
        return result;
    }

    function deleteCusto(uint custoId, bool isDeleted) external{
        if(custoToOwner[custoId] == msg.sender){
            custos[custoId].isDeleted = isDeleted;
            emit DeleteCusto(custoId, isDeleted);
        }
    }

     function deleteGanho(uint ganhoId, bool isDeleted) external{
        if(ganhoToOwner[ganhoId] == msg.sender){
            ganhos[ganhoId].isDeleted = isDeleted;
            emit DeleteGanho(ganhoId, isDeleted);
        }
    }
  
}