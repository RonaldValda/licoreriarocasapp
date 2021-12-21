import 'package:flutter/cupertino.dart';
import 'package:licoreriarocasapp/domain/entities/venta.dart';

class VentaProvider extends ChangeNotifier{
  Venta venta=Venta.vacio();
  Venta ventaCarrito=Venta.vacio();
  VentaProducto ventaProducto=VentaProducto.vacio();
  void setVenta(Venta venta,{bool notificar=true}){
    this.venta=venta;
    if(notificar) notifyListeners();
  }
  void setVentaProductos(List<VentaProducto> ventaProductos,{bool notificar=true}){
    this.venta.ventaProductos=ventaProductos;
    if(notificar) notifyListeners();
  }
  void addVentaProducto(VentaProducto ventaProducto,{bool notificar=true}){
    this.venta.ventaProductos.add(ventaProducto);
    venta.precioTotal+=ventaProducto.cantidad*ventaProducto.precioUnitario;
    if(notificar) notifyListeners();
  }
  void removeVentaProducto(VentaProducto ventaProducto,{bool notificar=true}){
    this.venta.ventaProductos.removeWhere((element) => element.id==ventaProducto.id);
    venta.precioTotal-=ventaProducto.cantidad*ventaProducto.precioUnitario;
    if(notificar) notifyListeners();
  }
  void setVentaCarrito(Venta venta,{bool notificar=true}){
    this.ventaCarrito=venta;
    if(notificar) notifyListeners();
  }
  void setVentaProductosCarrito(List<VentaProducto> ventaProductos,{bool notificar=true}){
    this.ventaCarrito.ventaProductos=ventaProductos;
    if(notificar) notifyListeners();
  }
  void addVentaProductoCarrito(VentaProducto ventaProducto,{bool notificar=true}){
    this.ventaCarrito.ventaProductos.add(ventaProducto);
    ventaCarrito.precioTotal+=ventaProducto.cantidad*ventaProducto.precioUnitario;
    if(notificar) notifyListeners();
  }
  void removeVentaProductoCarrito(VentaProducto ventaProducto,{bool notificar=true}){
    this.ventaCarrito.ventaProductos.removeWhere((element) => element.producto.id==ventaProducto.producto.id);
    ventaCarrito.precioTotal-=ventaProducto.cantidad*ventaProducto.precioUnitario;
    if(notificar) notifyListeners();
  }
  void setCantidadVentaProductoCarrito(VentaProducto ventaProducto,int nuevaCantidad,{bool notificar=true}){
    if(nuevaCantidad>=0){
      if(ventaProducto.cantidad==0&&nuevaCantidad>0){
        ventaProducto.cantidad=nuevaCantidad;
        this.ventaCarrito.ventaProductos.add(ventaProducto);
        this.ventaCarrito.ventaProductos.sort((a,b)=>a.producto.contenido.compareTo(b.producto.contenido));
      }else if(ventaProducto.cantidad>0&&nuevaCantidad==0){
        ventaProducto.cantidad=nuevaCantidad;
        this.ventaCarrito.ventaProductos.removeWhere((element) => element.producto.id==ventaProducto.producto.id);
      }else{
        ventaProducto.cantidad=nuevaCantidad;
      }
      ventaCarrito.precioTotal=0;
      ventaCarrito.ventaProductos.forEach((vp) { 
        ventaCarrito.precioTotal+=vp.precioUnitario*vp.cantidad;
      });
      if(notificar) notifyListeners();
    }
  }
  void incrementarCantidadVentaProductoCarrito(VentaProducto ventaProducto,{bool notificar=true}){
    if(this.ventaCarrito.ventaProductos.where((element) => element.producto.id==ventaProducto.producto.id).length==0){
      ventaProducto.cantidad++;
      this.ventaCarrito.ventaProductos.add(ventaProducto);
      this.ventaCarrito.ventaProductos.sort((a,b)=>a.producto.contenido.compareTo(b.producto.contenido));
    }else{
      ventaProducto.cantidad++;
    }
    ventaCarrito.precioTotal=0;
    ventaCarrito.ventaProductos.forEach((vp) { 
      ventaCarrito.precioTotal+=vp.precioUnitario*vp.cantidad;
    });
    if(notificar) notifyListeners();
  }
  void decrementarCantidadVentaProductoCarrito(VentaProducto ventaProducto,{bool notificar=true}){
    if(ventaProducto.cantidad>0){
      if(ventaProducto.cantidad-1==0){
        ventaProducto.cantidad--;
        this.ventaCarrito.ventaProductos.removeWhere((element) => element.producto.id==ventaProducto.producto.id);
      }else{
        ventaProducto.cantidad--;
      }
      ventaCarrito.precioTotal=0;
      ventaCarrito.ventaProductos.forEach((vp) { 
        ventaCarrito.precioTotal+=vp.precioUnitario*vp.cantidad;
      });
      if(notificar) notifyListeners();
    }
  }
  void setPrecioTotalCarrito(List<VentaProducto> ventaProductos){
    this.ventaCarrito.costoTotal=0.0;
    ventaProductos.forEach((element) { 
      this.ventaCarrito.precioTotal+=element.cantidad*element.precioUnitario;
    });
    notifyListeners();
  }
}