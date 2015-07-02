<?php
class addist_installer extends AddistModel
{
    public $info = array(
        'hash'              =>  'ace84896960d67fe987d471fcda564bb',
        'version'           =>  '%version%',
        'trial'             =>  '0',
    );
    
    public $fields = array(
        'customer_id'           =>  0,
        'token'                 =>  '',
        'customer'              =>  '',
        'email'                 =>  '',
        'last_refresh'          =>  '',
    );
    
    public $mods = array();
    
    public $files = array();
    
    public function __construct($registry)
    {
        parent::__construct($registry);
    }
}
?>