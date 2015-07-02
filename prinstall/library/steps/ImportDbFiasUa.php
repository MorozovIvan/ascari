<?php

class ImportDbFiasUa extends Step {

    public function run() {

        if (isset($_GET['install_ua'])) {
            $this->install->queryFromFile('ua/zone_to_fias_ua.sql');
            $this->install->queryFromFile('ua/fias_ua.sql');
        }

        return !$this->install->getError();
    }
}
