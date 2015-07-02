<?php

class ImportDbFiasRu extends Step {

    public function run() {

        if (isset($_GET['install_ru']) && $_GET['install_ru'] != 'none') {

            $this->install->queryFromFile('ru/zone_to_fias_ru.sql');
            $this->install->queryFromFile('ru/fias_level_lt6.sql');

            if ($_GET['install_ru'] == 'all') {
                $this->install->queryFromFile('ru/fias_level_6_1.sql');
                $this->install->queryFromFile('ru/fias_level_6_2.sql');
                $this->install->queryFromFile('ru/fias_level_6_3.sql');
                $this->install->queryFromFile('ru/fias_level_6_4.sql');
                $this->install->queryFromFile('ru/fias_level_6_5.sql');
                $this->install->queryFromFile('ru/fias_level_6_6.sql');
                $this->install->queryFromFile('ru/fias_level_6_7.sql');
            }
        }

        return !$this->install->getError();
    }
}
