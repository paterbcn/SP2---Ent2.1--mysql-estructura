CREATE SCHEMA IF NOT EXISTS `Spotify` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci ;
CREATE TABLE IF NOT EXISTS `Spotify`.`Countries` (
  `idCountry` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NULL,
  PRIMARY KEY (`idCountry`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`Users` (
  `idUsers` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(150) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Birthday` DATE NOT NULL,
  `UserName` VARCHAR(150) NOT NULL,
  `Gender` VARCHAR(45) NULL,
  `idCountry` INT NOT NULL,
  `type` ENUM("free", "premium") NOT NULL,
  PRIMARY KEY (`idUsers`),
  INDEX `FK_user-country_idx` (`idCountry` ASC) VISIBLE,
  CONSTRAINT `FK_user-country`
    FOREIGN KEY (`idCountry`)
    REFERENCES `Spotify`.`Countries` (`idCountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`Subscriptions` (
  `idSubscriptions` INT NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  `renewalDate` DATE NULL,
  `startDate` DATE NULL,
  PRIMARY KEY (`idSubscriptions`),
  INDEX `FK_subscription-user_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `FK_subscription-user`
    FOREIGN KEY (`idUser`)
    REFERENCES `Spotify`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`Paypals` (
  `idPaypals` INT NOT NULL AUTO_INCREMENT,
  `payPalUserName` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idPaypals`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`CreditCard` (
  `cardNumber` INT NOT NULL,
  `cardName` VARCHAR(45) NULL,
  `CreditCardcol` VARCHAR(45) NOT NULL,
  `expiration` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cardNumber`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`userPaymetods` (
  `iduserPaymetods` INT NOT NULL AUTO_INCREMENT,
  `name` ENUM("paypal", "creditcard") NOT NULL,
  `idpaypal` INT NULL,
  `iduser` INT NOT NULL,
  `idCredicCard` INT NULL,
  PRIMARY KEY (`iduserPaymetods`),
  INDEX `FK_paid-metods_idx` (`iduser` ASC) VISIBLE,
  INDEX `FK_paymet-paypal_idx` (`idpaypal` ASC) VISIBLE,
  INDEX `FK_paymet-cc_idx` (`idCredicCard` ASC) VISIBLE,
  CONSTRAINT `FK_paid-metods`
    FOREIGN KEY (`iduser`)
    REFERENCES `Spotify`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_paymet-paypal`
    FOREIGN KEY (`idpaypal`)
    REFERENCES `Spotify`.`Paypals` (`idPaypals`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_paymet-cc`
    FOREIGN KEY (`idCredicCard`)
    REFERENCES `Spotify`.`CreditCard` (`cardNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`Payments` (
  `idPayMetod` INT NOT NULL AUTO_INCREMENT,
  `idSuscription` INT NOT NULL,
  `payMetod` INT NOT NULL,
  `total` FLOAT NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`idPayMetod`),
  INDEX `FK_payments-subs_idx` (`idSuscription` ASC) VISIBLE,
  INDEX `FK_payments-usermet_idx` (`payMetod` ASC) VISIBLE,
  CONSTRAINT `FK_payments-subs`
    FOREIGN KEY (`idSuscription`)
    REFERENCES `Spotify`.`Subscriptions` (`idSubscriptions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_payments-usermet`
    FOREIGN KEY (`payMetod`)
    REFERENCES `Spotify`.`userPaymetods` (`iduserPaymetods`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`Artist` (
  `idArtist` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NOT NULL,
  `photo` BLOB NULL,
  PRIMARY KEY (`idArtist`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`Album` (
  `idAlbum` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `idArtist` INT NOT NULL,
  `date` DATE NOT NULL,
  `cover` BLOB NULL,
  PRIMARY KEY (`idAlbum`),
  INDEX `FK-album-artist_idx` (`idArtist` ASC) VISIBLE,
  CONSTRAINT `FK-album-artist`
    FOREIGN KEY (`idArtist`)
    REFERENCES `Spotify`.`Artist` (`idArtist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`Songs` (
  `idSongs` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `length` FLOAT NOT NULL,
  `playbacks` INT NOT NULL,
  `idAlbum` INT NOT NULL,
  `file` LONGBLOB NULL,
  PRIMARY KEY (`idSongs`),
  INDEX `FK-song-album_idx` (`idAlbum` ASC) VISIBLE,
  CONSTRAINT `FK-song-album`
    FOREIGN KEY (`idAlbum`)
    REFERENCES `Spotify`.`Album` (`idAlbum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`Playlist` (
  `idPlaylist` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `state` ENUM("active", "no active") NULL,
  `idUser` INT NULL,
  PRIMARY KEY (`idPlaylist`),
  INDEX `FK_playlist-user_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `FK_playlist-user`
    FOREIGN KEY (`idUser`)
    REFERENCES `Spotify`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`SharedList` (
  `idSharedList` INT NOT NULL AUTO_INCREMENT,
  `idPlaylist` INT NOT NULL,
  `idUser` INT NOT NULL,
  PRIMARY KEY (`idSharedList`),
  INDEX `FK_sharedlist-user_idx` (`idUser` ASC) VISIBLE,
  INDEX `FK_sharedlist-list_idx` (`idPlaylist` ASC) VISIBLE,
  CONSTRAINT `FK_sharedlist-user`
    FOREIGN KEY (`idUser`)
    REFERENCES `Spotify`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_sharedlist-list`
    FOREIGN KEY (`idPlaylist`)
    REFERENCES `Spotify`.`Playlist` (`idPlaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`PlaylistSong` (
  `idPlaylistSong` INT NOT NULL AUTO_INCREMENT,
  `idSong` INT NOT NULL,
  `idPlaylist` INT NOT NULL,
  PRIMARY KEY (`idPlaylistSong`),
  INDEX `FK-playlistsong-playlist_idx` (`idSong` ASC) VISIBLE,
  INDEX `FK_playsong-playlist_idx` (`idPlaylist` ASC) VISIBLE,
  CONSTRAINT `FK_playsong-playlist`
    FOREIGN KEY (`idPlaylist`)
    REFERENCES `Spotify`.`Playlist` (`idPlaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK-playlistsong-playlist`
    FOREIGN KEY (`idSong`)
    REFERENCES `Spotify`.`Songs` (`idSongs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Spotify`.`Sharelistsongs` (
  `idSharelistsongs` INT NOT NULL AUTO_INCREMENT,
  `idSongs` INT NOT NULL,
  `idUsers` INT NOT NULL,
  `date` DATE NOT NULL,
  `idsharedlist` INT NOT NULL,
  PRIMARY KEY (`idSharelistsongs`),
  INDEX `FK_sharelist-song_idx` (`idSongs` ASC) VISIBLE,
  INDEX `FK_sharedlists-sharel_idx` (`idsharedlist` ASC) VISIBLE,
  INDEX `FK_sharedlists-user_idx` (`idUsers` ASC) VISIBLE,
  CONSTRAINT `FK_sharelist-song`
    FOREIGN KEY (`idSongs`)
    REFERENCES `Spotify`.`Songs` (`idSongs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_sharedlists-sharel`
    FOREIGN KEY (`idsharedlist`)
    REFERENCES `Spotify`.`SharedList` (`idSharedList`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_sharedlists-user`
    FOREIGN KEY (`idUsers`)
    REFERENCES `Spotify`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;









