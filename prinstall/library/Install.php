<?php
    require_once '../../config.php';
    require_once '../../system/database/mysql.php';

    class Install {

        private $db;
        private $error;

        public function __construct() {
            $this->db = new MySQL(DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
        }

        public function step($name) {

            require_once '../library/steps/' . $name . '.php';
            $step = new $name($this);

            return $step->run();
        }

        public function query($sql) {
            return $this->db->query($sql);
        }

        public function queryFromZip($archive_name, $filename) {

            $path = DIR_PRINSTALL_DATA . $archive_name;

            $zip = new ZipArchive();

            if ($zip->open($path) !== true) {
                $this->setError('Не удается прочитать файл "' . $filename . '"');
                return false;
            }

            $this->query($zip->getFromName($filename));

            return true;
        }

        public function queryFromFile($filename) {

            $filename = DIR_PRINSTALL_DATA . $filename;

            if (!is_readable($filename) || !($sql = file_get_contents($filename))) {
                $this->setError('Не удается прочитать файл "' . $filename . '"');
                return false;
            }

            ini_set('pcre.backtrack_limit', 10240000);
            preg_match_all("#(.*);\s*$#Usm", $sql, $matches);

            if (isset($matches[1])) {

                foreach ($matches[1] as $query) {

                    $query = trim($query);

                    if ($query) {
                        $this->query($query);
                    }
                }
            }

            return true;
        }

        /**
         * @param mixed $error
         */
        public function setError($error) {

            $this->error = $error;
        }

        /**
         * @return mixed
         */
        public function getError() {

            return $this->error;
        }

    }