<?php

class ImportDbFiasBy extends Step {

    public function run() {

        if (isset($_GET['install_by'])) {
            $this->install->queryFromFile('by/zone_to_fias_by.sql');
            $this->install->queryFromFile('by/fias_by.sql');
        }

        return !$this->install->getError();
    }
}
