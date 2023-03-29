INSERT INTO `spotify`.`countries` (`Name`) VALUES ('Spain');
INSERT INTO `spotify`.`countries` (`Name`) VALUES ('Germany');
INSERT INTO `spotify`.`countries` (`Name`) VALUES ('USA');

INSERT INTO `spotify`.`users` (`Email`, `Password`, `Birthday`, `UserName`, `Gender`, `idCountry`, `type`) VALUES ('aaaa@email.com', '123456', '1990/04/05', 'aaaaa', 'm', '1', 'free');
INSERT INTO `spotify`.`users` (`Email`, `Password`, `Birthday`, `UserName`, `Gender`, `idCountry`, `type`) VALUES ('bbbb@email.com', '12345', '1980/01/01', 'bbbbb', 'f', '2', 'premium');
INSERT INTO `spotify`.`users` (`Email`, `Password`, `Birthday`, `UserName`, `Gender`, `idCountry`, `type`) VALUES ('cccc@email.com', '123456', '2000/01/02', 'ccccc', 'm', '3', 'premium');

INSERT INTO `spotify`.`subscriptions` (`idUser`, `renewalDate`, `startDate`) VALUES ('2', '2023/01/01', '2020/01/01');
INSERT INTO `spotify`.`subscriptions` (`idUser`, `renewalDate`, `startDate`) VALUES ('3', '2023/03/03', '2022/03/03');

INSERT INTO `spotify`.`paypals` (`payPalUserName`) VALUES ('aaaaabbbb');

INSERT INTO `spotify`.`creditcard` (`cardNumber`, `cardName`, `CreditCardcol`, `expiration`) VALUES ('777777777', 'aaaaaa', '546', '10/2025');

INSERT INTO `spotify`.`userpaymetods` (`name`, `idpaypal`, `iduser`) VALUES ('paypal', '1', '2');
INSERT INTO `spotify`.`userpaymetods` (`name`, `iduser`, `idCredicCard`) VALUES ('creditcard', '3', '777777777');

INSERT INTO `spotify`.`payments` (`idSuscription`, `payMetod`, `total`, `date`) VALUES ('1', '1', '50', '2021-01-01');
INSERT INTO `spotify`.`payments` (`idSuscription`, `payMetod`, `total`, `date`) VALUES ('1', '1', '50', '2022-01-01');
INSERT INTO `spotify`.`payments` (`idSuscription`, `payMetod`, `total`, `date`) VALUES ('2', '2', '50', '2023-03-03');

INSERT INTO `spotify`.`artist` (`Name`) VALUES ('Artist1');
INSERT INTO `spotify`.`artist` (`Name`) VALUES ('Artist2');
INSERT INTO `spotify`.`artist` (`Name`) VALUES ('Artist3');

INSERT INTO `spotify`.`album` (`title`, `idArtist`, `date`) VALUES ('album1', '1', '2020-01-01');
INSERT INTO `spotify`.`album` (`title`, `idArtist`, `date`) VALUES ('album2', '2', '2021-01-01');
INSERT INTO `spotify`.`album` (`title`, `idArtist`, `date`) VALUES ('album3', '3', '2022-01-01');

INSERT INTO `spotify`.`songs` (`title`, `length`, `playbacks`, `idAlbum`) VALUES ('song1', '5', '1', '1');
INSERT INTO `spotify`.`songs` (`title`, `length`, `playbacks`, `idAlbum`) VALUES ('song2', '4', '2', '1');
INSERT INTO `spotify`.`songs` (`title`, `length`, `playbacks`, `idAlbum`) VALUES ('song3', '4', '3', '1');
INSERT INTO `spotify`.`songs` (`title`, `length`, `playbacks`, `idAlbum`) VALUES ('song4', '2', '3', '2');
INSERT INTO `spotify`.`songs` (`title`, `length`, `playbacks`, `idAlbum`) VALUES ('song5', '2', '2', '2');
INSERT INTO `spotify`.`songs` (`title`, `length`, `playbacks`, `idAlbum`) VALUES ('song6', '2', '3', '2');
INSERT INTO `spotify`.`songs` (`title`, `length`, `playbacks`, `idAlbum`) VALUES ('song7', '3', '2', '3');
INSERT INTO `spotify`.`songs` (`title`, `length`, `playbacks`, `idAlbum`) VALUES ('song8', '3', '2', '3');
INSERT INTO `spotify`.`songs` (`title`, `length`, `playbacks`, `idAlbum`) VALUES ('song9', '3', '2', '3');

INSERT INTO `spotify`.`playlist` (`title`, `state`, `idUser`) VALUES ('list1', 'active', '1');
INSERT INTO `spotify`.`playlist` (`title`, `state`, `idUser`) VALUES ('list2', 'no active', '1');
INSERT INTO `spotify`.`playlist` (`title`, `state`, `idUser`) VALUES ('list3', 'active', '2');
INSERT INTO `spotify`.`playlist` (`title`, `state`, `idUser`) VALUES ('list4', 'active', '3');

INSERT INTO `spotify`.`sharedlist` (`idPlaylist`, `idUser`) VALUES ('1', '2');
INSERT INTO `spotify`.`sharedlist` (`idPlaylist`, `idUser`) VALUES ('3', '3');

INSERT INTO `spotify`.`playlistsong` (`idSong`, `idPlaylist`) VALUES ('1', '1');
INSERT INTO `spotify`.`playlistsong` (`idSong`, `idPlaylist`) VALUES ('2', '1');
INSERT INTO `spotify`.`playlistsong` (`idSong`, `idPlaylist`) VALUES ('4', '1');
INSERT INTO `spotify`.`playlistsong` (`idSong`, `idPlaylist`) VALUES ('6', '3');
INSERT INTO `spotify`.`playlistsong` (`idSong`, `idPlaylist`) VALUES ('4', '3');
INSERT INTO `spotify`.`playlistsong` (`idSong`, `idPlaylist`) VALUES ('9', '3');

INSERT INTO `spotify`.`sharelistsongs` (`idSongs`, `idUsers`, `date`, `idsharedlist`) VALUES ('9', '2', '2023-01-01', '1');
INSERT INTO `spotify`.`sharelistsongs` (`idSongs`, `idUsers`, `date`, `idsharedlist`) VALUES ('8', '2', '2023-01-01', '1');

