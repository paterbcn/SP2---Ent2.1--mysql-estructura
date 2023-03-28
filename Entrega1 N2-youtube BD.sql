CREATE SCHEMA IF NOT EXISTS `YoutubeClone` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci ;
CREATE TABLE IF NOT EXISTS `YoutubeClone`.`Countries` (
  `Id_countries` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_countries`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `YoutubeClone`.`users` (
  `Id_user` INT NOT NULL AUTO_INCREMENT,
  `User_name` VARCHAR(150) NOT NULL,
  `Email` VARCHAR(200) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Birthdate` DATE NOT NULL,
  `Gender` ENUM("m", "f") NOT NULL,
  `Id_country` INT NOT NULL,
  `Postal_code` INT NOT NULL,
  PRIMARY KEY (`Id_user`),
  INDEX `FK_user-country_idx` (`Id_country` ASC) VISIBLE,
  CONSTRAINT `FK_user-country`
    FOREIGN KEY (`Id_country`)
    REFERENCES `YoutubeClone`.`Countries` (`Id_countries`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CREATE TABLE IF NOT EXISTS `YoutubeClone`.`Videos` (
  `Id_Videos` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(150) NOT NULL,
  `Description` MEDIUMTEXT NULL,
  `Size` FLOAT NULL,
  `File_name` VARCHAR(150) NOT NULL,
  `Duration` FLOAT NULL,
  `Thumbnail` BLOB NULL,
  `Playbacks` INT NULL,
  `State` ENUM("Public", "Hidden", "Private") NOT NULL,
  `Id_user` INT NOT NULL,
  PRIMARY KEY (`Id_Videos`),
  INDEX `FK_video-users_idx` (`Id_user` ASC) VISIBLE,
  CONSTRAINT `FK_video-users`
    FOREIGN KEY (`Id_user`)
    REFERENCES `YoutubeClone`.`users` (`Id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `YoutubeClone`.`channels` (
  `idchannels` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Description` MEDIUMTEXT NULL,
  `Date` DATE NULL,
  `Id_user` INT NOT NULL,
  PRIMARY KEY (`idchannels`),
  INDEX `FK_Channels-Users_idx` (`Id_user` ASC) VISIBLE,
  CONSTRAINT `FK_Channels-Users`
    FOREIGN KEY (`Id_user`)
    REFERENCES `YoutubeClone`.`users` (`Id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `YoutubeClone`.`ChannelsSubcriptions` (
  `idChsub` INT NOT NULL AUTO_INCREMENT,
  `Id_subscriptor` INT NOT NULL,
  `Id_channel` INT NOT NULL,
  PRIMARY KEY (`idChsub`),
  INDEX `FK_ChannelSub-Userid_idx` (`Id_subscriptor` ASC) VISIBLE,
  INDEX `FK-ChannelSub-Channer_idx` (`Id_channel` ASC) VISIBLE,
  CONSTRAINT `FK_ChannelSub-Userid`
    FOREIGN KEY (`Id_subscriptor`)
    REFERENCES `YoutubeClone`.`users` (`Id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK-ChannelSub-Channer`
    FOREIGN KEY (`Id_channel`)
    REFERENCES `YoutubeClone`.`channels` (`idchannels`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `YoutubeClone`.`Playlist` (
  `Id_playlist` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Description` MEDIUMTEXT NOT NULL,
  `Date` DATE NOT NULL,
  `Id_user` INT NULL,
  `State` ENUM("public", "private") NOT NULL,
  PRIMARY KEY (`Id_playlist`),
  INDEX `FK_Playlist-user_idx` (`Id_user` ASC) VISIBLE,
  CONSTRAINT `FK_Playlist-user`
    FOREIGN KEY (`Id_user`)
    REFERENCES `YoutubeClone`.`users` (`Id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `YoutubeClone`.`PlaylistVideos` (
  `Id_pllisvid` INT NOT NULL AUTO_INCREMENT,
  `Id_user` INT NOT NULL,
  `Id_video` INT NOT NULL,
  PRIMARY KEY (`Id_pllisvid`),
  INDEX `FK_Playlistvid-video_idx` (`Id_user` ASC) VISIBLE,
  INDEX `FK_Playlistvid-playlist_idx` (`Id_video` ASC) VISIBLE,
  CONSTRAINT `FK_Playlistvid-video`
    FOREIGN KEY (`Id_user`)
    REFERENCES `YoutubeClone`.`Videos` (`Id_Videos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Playlistvid-playlist`
    FOREIGN KEY (`Id_video`)
    REFERENCES `YoutubeClone`.`Playlist` (`Id_playlist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `YoutubeClone`.`Video_vote` (
  `idVideo_vote` INT NOT NULL AUTO_INCREMENT,
  `Id_user` INT NOT NULL,
  `Vote` ENUM("like", "Dislike") NOT NULL,
  `Id_video` INT NOT NULL,
  `Date` DATETIME NOT NULL,
  PRIMARY KEY (`idVideo_vote`),
  INDEX `FK_VideoVo-user_idx` (`Id_user` ASC) VISIBLE,
  INDEX `FK_VideoVo-Video_idx` (`Id_video` ASC) VISIBLE,
  CONSTRAINT `FK_VideoVo-user`
    FOREIGN KEY (`Id_user`)
    REFERENCES `YoutubeClone`.`users` (`Id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_VideoVo-Video`
    FOREIGN KEY (`Id_video`)
    REFERENCES `YoutubeClone`.`Videos` (`Id_Videos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `YoutubeClone`.`Comments` (
  `Id_comments` INT NOT NULL,
  `Text` MEDIUMTEXT NOT NULL,
  `Date_time` DATETIME NULL,
  `Id_user` INT NULL,
  `Id_video` INT NOT NULL,
  PRIMARY KEY (`Id_comments`),
  INDEX `FK_comments-video_idx` (`Id_video` ASC) VISIBLE,
  INDEX `FK_comments-user_idx` (`Id_user` ASC) VISIBLE,
  CONSTRAINT `FK_comments-video`
    FOREIGN KEY (`Id_video`)
    REFERENCES `YoutubeClone`.`Videos` (`Id_Videos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_comments-user`
    FOREIGN KEY (`Id_user`)
    REFERENCES `YoutubeClone`.`users` (`Id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `YoutubeClone`.`CommentVote` (
  `id_commentVote` INT NOT NULL AUTO_INCREMENT,
  `Id_user` INT NOT NULL,
  `Vote` ENUM("like", "dislike") NOT NULL,
  `Id_comment` INT NOT NULL,
  PRIMARY KEY (`id_commentVote`),
  INDEX `FK-commetv-user_idx` (`Id_user` ASC) VISIBLE,
  INDEX `FK-commetsv-comments_idx` (`Id_comment` ASC) VISIBLE,
  CONSTRAINT `FK-commetv-user`
    FOREIGN KEY (`Id_user`)
    REFERENCES `YoutubeClone`.`users` (`Id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK-commetsv-comments`
    FOREIGN KEY (`Id_comment`)
    REFERENCES `YoutubeClone`.`Comments` (`Id_comments`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `YoutubeClone`.`Labels` (
  `Id_labels` INT NOT NULL,
  `Name` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`Id_labels`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `YoutubeClone`.`Video_Labels` (
  `Id_vidlab` INT NOT NULL,
  `Id_video` INT NOT NULL,
  `Id_label` INT NOT NULL,
  PRIMARY KEY (`Id_vidlab`),
  INDEX `FK_VideoLab-Video_idx` (`Id_video` ASC) VISIBLE,
  INDEX `FK_Videolab-Labels_idx` (`Id_label` ASC) VISIBLE,
  CONSTRAINT `FK_VideoLab-Video`
    FOREIGN KEY (`Id_video`)
    REFERENCES `YoutubeClone`.`Videos` (`Id_Videos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Videolab-Labels`
    FOREIGN KEY (`Id_label`)
    REFERENCES `YoutubeClone`.`Labels` (`Id_labels`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;












