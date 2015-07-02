<?php
    error_reporting(E_ALL);
    ini_set('display_errors', 'On');

    session_start();

    require_once '../config.php';
    require_once '../library/Install.php';
    require_once '../library/Step.php';

    $count_steps = count($config['steps']);

    if (empty($_SESSION['pr']['step'])) {
        $_SESSION['pr']['step'] = 0;
    }

    $step_number = $_SESSION['pr']['step'];
    $json = array();

    if ($step_number < $count_steps) {

        $install = new Install();

        if ($install->step($config['steps'][$step_number])) {
            $json['status'] = 'process';
            $json['percentage'] = ($step_number + 1) * floor(100 / $count_steps);
            $_SESSION['pr']['step']++;
        }
        else {
            $json['status'] = 'error';
            $json['text'] = $install->getError();
        }
    }
    else {
        $json['status'] = 'success';
        $json['text'] = 'Установка модуля успешно завершена<br>Удалите папку "prinstall" из корня сайта';
        unset($_SESSION['pr']);
    }

    if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest') {
        echo json_encode($json);
    }
    else {
        echo '<pre>';
        print_r($json);
    }
    die;