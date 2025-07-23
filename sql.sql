ALTER TABLE vrp_users ADD inventory longtext DEFAULT '[]';
ALTER TABLE vrp_users ADD weapons longtext DEFAULT '[]';

ALTER TABLE vrp_user_vehicles ADD trunk longtext DEFAULT '[]';
ALTER TABLE vrp_user_vehicles ADD glovebox longtext DEFAULT '[]';

CREATE TABLE `axr_inventory` (
  `id` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT 'chest',
  `items` longtext DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

