///SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
/**
    *@title Contrato ToDoList
    *@notice Contrato para organizar tareas
    *@author i3arba - 77 Innovation Labs
*/
contract ToDoList {
    struct Tarea{
        string descripcion;
        bool completado;
        uint256 timestamp;
    }
    Tarea[] private s_tareas;

    event ToDoList_TareaAgregada(Tarea tarea);
    event ToDoList_TareaCompletada(Tarea tarea);
    event ToDoList_TareaEliminada(string descripcion, uint256 timestamp);

    function agregarTarea(string memory _descripcion) external {
        Tarea memory nuevaTarea = Tarea({
            descripcion: _descripcion, completado: false, timestamp:block.timestamp
        });
        s_tareas.push(nuevaTarea);

        emit ToDoList_TareaAgregada(nuevaTarea);
    }

    function obtenerTarea(uint256 _index) external view returns(Tarea memory _tarea) {
        _tarea=s_tareas[_index];
        return _tarea;
    }

    function completarTarea(uint256 _index) external {
        s_tareas[_index].completado=true;
        emit ToDoList_TareaCompletada(s_tareas[_index]);
    }    

    function eliminarTarea(string memory _descripcion) external{
        uint256 arrayLength=s_tareas.length;
        for (uint256 i=0; i<arrayLength; i++){
            if(keccak256(abi.encodePacked(s_tareas[i].descripcion))==keccak256(abi.encodePacked(_descripcion))){
                s_tareas[i]=s_tareas[arrayLength-1];
                s_tareas.pop();

                emit ToDoList_TareaEliminada(_descripcion,block.timestamp);
                return;
            }
        }
    }
}