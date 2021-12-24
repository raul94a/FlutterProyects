<?php

require APPPATH . '/libraries/REST_Controller.php';
class Jugadores extends REST_Controller
{
    public function __construct()
    {

        parent::__construct();
        $this->load->database();
        $this->load->model('Jugador_model');
        $this->load->helper('utilidades');
    }

    //servicio GET
    public function jugador_get()
    {
        $id = $this->uri->segment(3);
        if (!isset($id)) {
            $respuesta = array(
                'err' => TRUE,
                'mensaje' => 'Debe indicar un parámetro'
            );
            $this->response($respuesta, REST_Controller::HTTP_BAD_REQUEST);
            return;
        }
        $ruta = $this->Jugador_model->get_jugador($id);
        if (!isset($ruta)) {
            $respuesta = array(
                'err' => TRUE,
                'mensaje' => 'jugador no encontrado',
                'jugador' => null
            );
            $this->response($respuesta, REST_Controller::HTTP_NOT_FOUND);
            return;
        }
        $this->response($ruta);
    }
    public function jugadores_get()
    {
        $rutas = $this->Jugador_model->get_jugadores();
        $this->response($rutas);
    }
    //servicio POST
    public function jugador_post()
    {
        //pillamos la data del post
        $data = $this->post();

        $ruta = $this->Jugador_model->limpiar_datos($data);

        $respuesta = $ruta->insert($ruta);
        if ($respuesta['err']) {
            $this->response($respuesta, REST_Controller::HTTP_BAD_REQUEST);
        } else {

            $this->response($respuesta);
        }
    }
    //servicio PUT
     public function jugador_put()
    {
        //VIENE DEL BODY    
            $data = $this->put();
      
            //BIEN VALIDADO
            $ruta = $this->Jugador_model->limpiar_datos($data);
            $respuesta = $ruta->update();
            if ($respuesta['err']) {
                $this->response($respuesta, REST_Controller::HTTP_BAD_REQUEST);
            } else {
                $this->response($respuesta);
            }
        // $this->response($respuesta);
    }
    //servicio DELETE
    public function jugador_delete()
    {
        $id = $this->uri->segment(3);
        $respuesta = $this->Jugador_model->delete($id);
        $this->response($respuesta);
    }
}
