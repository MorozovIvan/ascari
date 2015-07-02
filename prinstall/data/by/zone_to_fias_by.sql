CREATE TABLE IF NOT EXISTS `zone_to_fias` (
  `zone_id` int(11) NOT NULL,
  `fias_id` int(11) NOT NULL,
  UNIQUE KEY `zone_id` (`zone_id`),
  UNIQUE KEY `fias_id` (`fias_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `zone_to_fias` (`zone_id`, `fias_id`) VALUES
(337, 300001),
(338, 315044),
(339, 332264),
(340, 320256),
(341, 335981),
(342, 326921),
(343, 305874);