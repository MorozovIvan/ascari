<?php
    define('DIR_PRINSTALL', rtrim(dirname(__FILE__), '/') . '/');
    define('DIR_PRINSTALL_DATA', DIR_PRINSTALL . 'data/');

    $config['steps'] = array('ImportDbSetting', 'ImportDbCountryToFias', 'ImportDbFiasRu', 'ImportDbFiasUa', 'ImportDbFiasBy');