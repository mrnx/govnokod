
# This is a fix for InnoDB in MySQL >= 4.1.x
# It "suspends judgement" for fkey relationships until are tables are set.
SET FOREIGN_KEY_CHECKS = 0;

#-----------------------------------------------------------------------------
#-- copypasta
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `copypasta`;


CREATE TABLE `copypasta`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`copypasta_language_id` INTEGER,
	`copypasta` TEXT,
	`created_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `copypasta_FI_1` (`copypasta_language_id`),
	CONSTRAINT `copypasta_FK_1`
		FOREIGN KEY (`copypasta_language_id`)
		REFERENCES `copypasta_language` (`id`)
)Type=InnoDB;

#-----------------------------------------------------------------------------
#-- copypasta_language
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `copypasta_language`;


CREATE TABLE `copypasta_language`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(50),
	`position` INTEGER,
	PRIMARY KEY (`id`)
)Type=InnoDB;

# This restores the fkey checks, after having unset them earlier
SET FOREIGN_KEY_CHECKS = 1;
