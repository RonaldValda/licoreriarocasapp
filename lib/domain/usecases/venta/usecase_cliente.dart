import 'package:licoreriarocasapp/data/repositories/venta/cliente_repository.dart';
import 'package:licoreriarocasapp/domain/entities/cliente.dart';

class UseCaseCliente{
  ClienteRepository clienteRepository=ClienteRepository();
  Future<Map<String,dynamic>> registrarCliente(Cliente cliente){
    return clienteRepository.registrarCliente(cliente);
  }
  Future<Map<String,dynamic>> modificarCliente(Cliente cliente){
    return clienteRepository.modificarCliente(cliente);
  }
  Future<Map<String,dynamic>> eliminarCliente(String id){
    return clienteRepository.eliminarCliente(id);
  }
  Future<Map<String,dynamic>> obtenerClientes(){
    return clienteRepository.obtenerClientes();
  }
  Future<Map<String,dynamic>> buscarCliente(String ciNit,String nombres){
    return clienteRepository.buscarCliente(ciNit,nombres);
  }
}