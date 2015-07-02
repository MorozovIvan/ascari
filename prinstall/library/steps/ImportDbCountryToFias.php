<?php

class ImportDbCountryToFias extends Step {

    public function run() {

        $this->install->query("DROP TABLE IF EXISTS `country_to_fias`");

        $this->install->query("CREATE TABLE IF NOT EXISTS `country_to_fias` (
                              `country_id` int(11) NOT NULL,
                              `fias_id` int(11) NOT NULL,
                              UNIQUE KEY `country_id` (`country_id`,`fias_id`)
                            ) ENGINE=InnoDB DEFAULT CHARSET=utf8");
        
        return $this->install
                ->query("INSERT INTO `country_to_fias` (`country_id`, `fias_id`) VALUES (20, 300000), (176, 202137), (220, 202138)");
    }
}
