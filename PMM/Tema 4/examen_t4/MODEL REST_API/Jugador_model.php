<?php


class Jugador_model extends CI_Model
{
  public $id;
  public $nombre;
  public $posicion;
  public $fechaNacimiento;
  public $paisNacimiento;
  public $nacionalidad;
  public $rol;
  public $comentario;

  public function get_jugador($id)
  {
    $query =  $this->db->get_where('jugadores',array('id'=>$id));
  
    $fila = $query->custom_row_object(0, 'Jugador_model');
    //   if($fila == null){
    //       echo array("error"=>"el cliente no existe");
    //   }else
    if (isset($fila)) {
      $fila->id = intval($fila->id);
     
    }
    return $fila;
  }

  public function get_jugadores()
  {
    $query = $this->db->get('jugadores');
    $fila = $query->result();
    //parseamos la id a entero
    foreach($fila as $f){
        $f->id = intval($f->id);
    }
    return $fila;
  }

  public function limpiar_datos($data_sucia)
  {
    foreach ($data_sucia as $nombre_campo => $valor) {
      //comprueba cada cosa que se le pasa a la funcion...si existe esa propiedad en el modelo se le asigna el valor, si no, se elimina...
      if (property_exists('Jugador_model', $nombre_campo)) {
        $this->$nombre_campo = $valor;
      }
    }
    //por defecto siempre estará activo...
    // if ($this->activo == NULL) {
    //   $this->activo = 1;
    // }
    //se devuelve el Cliente_model
    return $this;
  }

  public function insert($jugador)
  {

      if ($this->db->insert('jugadores', $jugador)) {

        $respuesta = array(
          'err' => FALSE,
          'mensaje' => 'Registro insertado correctamente',
          'jugador_id' => $this->db->insert_id(),
        );
      } else {

        $respuesta = array(
          'err' => TRUE,
          'mensaje' => 'Error al insertar',
          'error' => $this->db->error_message(),
        );

        //$this->response($respuesta, Rest_Controller::HTTP_INTERNAL_SERVER_ERROR);
      }
    
    return $respuesta;
  }

 public function update()
  {
    
            //limpiamos el query bnuilder
            // $this->db->reset_query();
            // $jugador = $this->get_jugador($this->id);
            //¿Que pasa si no hemos seteado algunos datos?
            //$this->mantener_datos_no_actualizados($this, $ruta);
            //volvemos a resetear el query builder
            $this->db->reset_query();
            $this->db->where('id', $this->id);
            if ($this->db->update('jugadores', $this)) {
                //rutas actu
                $respuesta = array(
                    'err' => FALSE,
                    'mensaje' => 'Registro actualizado correctamente',
                    'rutas_id' => $this->id,
                );
            } else {
                //no se pudo insertarç
                $respuesta = array(
                    'err' => TRUE,
                    'mensaje' => 'Error al actualizar',
                    'error' => $this->db->error_message()
                );
            }
            return $respuesta;
        
  }

  public function delete($id_jugador){
    //comprobamos si existe el cliente
    $this -> db ->delete('jugadores', array('id' => $id_jugador));
   
}
}
