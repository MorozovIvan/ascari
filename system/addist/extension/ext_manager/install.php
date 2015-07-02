<?php
#encode-me[fopo],encode-me[obfuscator]#
class ext_manager extends Model
{
    public $info = array(
        'hash'              =>  '%hash%',
        'version'           =>  '%version%',
        'link'              =>  '%link%',
    );
    
    public $fields = array();
    
    public $mods = array('%mods%');
    
    public $files = array('%files%');
    
    public function __construct($registry)
    {
        parent::__construct($registry);
    }
}
?>