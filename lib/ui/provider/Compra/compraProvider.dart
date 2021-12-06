import 'package:flutter/cupertino.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';

class CompraProvider extends ChangeNotifier{
  Compra compra=Compra.vacio();
  Compra compraCarrito=Compra.vacio();
  CompraProducto compraProducto=CompraProducto.vacio();
  void setCompra(Compra compra,{bool notificar=true}){
    this.compra=compra;
    if(notificar) notifyListeners();
  }
  void setCompraProductos(List<CompraProducto> compraProductos,{bool notificar=true}){
    this.compra.compraProductos=compraProductos;
    if(notificar) notifyListeners();
  }
  void addCompraProducto(CompraProducto compraProducto,{bool notificar=true}){
    this.compra.compraProductos.add(compraProducto);
    compra.costoTotal+=compraProducto.cantidad*compraProducto.precioUnitario;
    if(notificar) notifyListeners();
  }
  void removeCompraProducto(CompraProducto compraProducto,{bool notificar=true}){
    this.compra.compraProductos.removeWhere((element) => element.id==compraProducto.id);
    compra.costoTotal-=compraProducto.cantidad*compraProducto.precioUnitario;
    if(notificar) notifyListeners();
  }
  void setCompraCarrito(Compra compra,{bool notificar=true}){
    if(notificar) notifyListeners();
  }
  void setCompraProductosCarrito(List<CompraProducto> compraProductos,{bool notificar=true}){
    this.compraCarrito.compraProductos=compraProductos;
    if(notificar) notifyListeners();
  }
  void addCompraProductoCarrito(CompraProducto compraProducto,{bool notificar=true}){
    this.compraCarrito.compraProductos.add(compraProducto);
    compraCarrito.costoTotal+=compraProducto.cantidad*compraProducto.precioUnitario;
    if(notificar) notifyListeners();
  }
  void removeCompraProductoCarrito(CompraProducto compraProducto,{bool notificar=true}){
    this.compraCarrito.compraProductos.removeWhere((element) => element.producto.id==compraProducto.producto.id);
    compraCarrito.costoTotal-=compraProducto.cantidad*compraProducto.precioUnitario;
    if(notificar) notifyListeners();
  }
  void setCostoTotalCarrito(List<CompraProducto> compraProductos){
    this.compraCarrito.costoTotal=0.0;
    compraProductos.forEach((element) { 
      this.compraCarrito.costoTotal+=element.cantidad*element.precioUnitario;
    });
    notifyListeners();
  }
  void notificar(){
    notifyListeners();
  }
}