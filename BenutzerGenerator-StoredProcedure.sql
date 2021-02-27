USE [master]
GO
/****** Object:  StoredProcedure [dbo].[Metin_BenutzerGenerator]    Script Date: 28.02.2021 00:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER              PROCEDURE [dbo].[Metin_BenutzerGenerator]
(	
	@inUserId		decimal(11,0)
	--	
	,@inBenutzerKennung char(80)                                                                                           
	,@inPassWort char(40)                                                                                                                                                                                      
	,@inBenutzerName char(40)                                                                                              
	,@inUserEMail varchar(255)                                                                                            
	,@inUserTelefon varchar(255)                                                                        
	,@inANSFId decimal(11,0) 
                                                                                                                                                                                                                                                                                                                                                                                  
	,@inUGRPId decimal(11,0)  
	--
	,@outInfo		nvarchar(4000) output
	,@outMeldung	nvarchar(4000) output
	,@outResult		decimal(38,0) output 
)
AS

DECLARE	@StartZeit datetime
SET 	@StartZeit = GetDate()
----------------------------------------------
DECLARE @parNL char(2)
SET @parNL = CHAR(13) + char(10)
----------------------------------------------
DECLARE	@Modul decimal(11,0)
DECLARE @parLogLevel decimal(4)
DECLARE @parModulName nvarchar(128)
--
-- ************************************************************************************************
-- Deklarationsteil der lokalen Variablen
--*************************************************************************************************
----------------------------------------------*
-- Parameter Programmsteuerung
----------------------------------------------*
DECLARE	@flag		INT
-----------------------
----------------------------------------------*
-- deklaration werte aus der tabelle _USER    
----------------------------------------------*
DECLARE @parUSERUSERId decimal(11,0)
DECLARE @parUSERBenutzerKennung char(40)
DECLARE @parUSERPassWort char(40)
DECLARE @parUSERBenutzerName char(80)
DECLARE @parUSERZeitMarkeErstellung datetime
SET @parUSERZeitMarkeErstellung = GETDATE()
--
DECLARE @parInBenutzerKennung char(40)                                                                                          
DECLARE @parInPassWort char(40)                                                                                                   
DECLARE @parInPersonalNummer decimal(11)                                                                                          
DECLARE @parInBenutzerName char(80)                                                                                               
DECLARE @parInUserEMail varchar(255)                                                                                              
DECLARE @parInUserTelefon varchar(255)                                                                                           
DECLARE @parInLoeschKennZeichen char(1)                                                                                                                                                                                 
DECLARE @parInANSFId decimal(11)   
DECLARE @parInUSERId decimal(11)  
DECLARE @parInArt char(40)                                                                                                                                                                                             
DECLARE @parInUGRPId decimal(11)
Declare @parInMANDId decimal(11)
----------------------------------------------*
-- Sonstige Variablen
----------------------------------------------*
DECLARE @parAnzahlBenutzer int = 0
DECLARE @RESULT INT  = 0

----------------------------------------------*
-- [deklaration werte aus der tabelle _Anschriften]
----------------------------------------------*
Declare @parInName1 varchar (255)
		,@parInName2 varchar (255)
		,@parInName3 varchar (255)
		,@parInStrasse varchar(255)
		,@parInLand char(80)
		,@parInPLZ char(10)
----------------------------------------------*

-- ************************************************************************************************
--									BEGINn des Hauptteils
-- ************************************************************************************************


SET @flag = 0
----------------------------------------
-- InitialISierung der Ausgabeparameter
----------------------------------´-----
-- 
SET @outInfo = ''
SET @outMeldung = ''
SET @outResult = 0
-----------------------------------------------------------------------------------------*
---- Default Werte für @inUserId
-----------------------------------------------------------------------------------------*
IF @inUserId = 0
	BEGIN
	SET @inUserId = 1
END
---
-----------------------------------------------------------------------------------------*
---- wir prüfen, ob es den Benutzer in _USER gibt, und er nicht gelöscht ISt
-----------------------------------------------------------------------------------------*
IF @flag = 0
BEGIN
	BEGIN TRY
		SELECT 
			@parUSERUSERId = USERId -- decimal(11,0)
			,@parUSERBenutzerKennung = BenutzerKennung -- char(40)
			,@parUSERPassWort = BenutzerKennung -- char(40)
			,@parUSERBenutzerName = BenutzerName -- char(80)
			,@parUSERZeitMarkeErstellung = ZeitMarkeErstellung -- decimal(11,0)
		FROM   [master].[dbo].[_USER]
		WITH   (NOLOCK)
		WHERE  USERId = @inUSERId
		---
	END TRY
	---
	BEGIN CATCH
		---
		SET @flag				= @flag + 1024
		Set @outResult			= 5030				-- Farbe rot
		Set @outMeldung			= LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! 5030 [Fehler bei der ZuweISung der Variablen]'							+ '; '
		---
	END CATCH
		
END
-----------------------------------------------------------------------------------------*
---- Variablen Werte Zuweisen
-----------------------------------------------------------------------------------------*
IF @flag = 0
BEGIN
	BEGIN TRY
		-----
		IF NOT @inBenutzerKennung IS NULL
		and @inBenutzerKennung <> ''
		BEGIN
				SET                     @parInBenutzerKennung = @inBenutzerKennung
		END
		---
		IF NOT @inPassWort IS NULL
		and @inPassWort <> ''
		BEGIN
				SET						@parInPassWort = @inPassWort
		END
		---
		IF NOT @InBenutzerName IS NULL
		and @inBenutzerName <> ''
		BEGIN
				SET						@parInBenutzerName = @inBenutzerName
		END
		---
		IF NOT @InUserEMail IS NULL
		and @InUserEMail <> ''
		BEGIN
				SET						@parInUserEMail = @inUserEMail
		END
		---
		IF NOT @InUserTelefon IS NULL
		and @InUserTelefon <> ''
		BEGIN
				SET						@parInUserTelefon = @inUserTelefon
		END
		---
		IF NOT @InANSFId IS NULL
		and @inANSFId <> '0'
		BEGIN
				SET						@parInANSFId = @inANSFId
		END
		---
		IF NOT @inUserId IS NULL
		and @inUserId <> '0'
		BEGIN
				SET						@parInUSERId = @inUserId
		END
		---
		IF NOT @InUGRPId IS NULL
		and @inUGRPId <> '0'
		BEGIN
				SET						@parInUGRPId = @inUGRPId
		END
		---
	END TRY
	---
	BEGIN CATCH
		---
		SET @flag				= @flag + 1024
		Set @outResult			= 5040				-- Farbe rot
		Set @outMeldung			= LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! 5040 [Fehler bei der ZuweISung der Variablen]'							+ '; '
		---
	END CATCH
END
---
-----------------------------------------------------------------------------------------*
---- PRÜFE OB BENUTZER VORHANDEN IST
-----------------------------------------------------------------------------------------*
IF @flag = 0
BEGIN
	BEGIN TRY
		---
		------------------------------------------
		--  BenutzerNamen prüfen ob Benutzer vorhanden IST
		------------------------------------------
		SET @RESULT = 0
		SET @RESULT = (SELECT  COUNT(*) 
						FROM _USER
						WITH (NOLOCK)
						WHERE BenutzerName = @inBenutzerName)
		---------------------------------------------
		IF @RESULT > 0
		BEGIN
			PRINT 'ACHTUNG!!! BENUTZERNAME VORHANDEN!'
			SELECT * FROM _USER
			WITH(NOLOCK)
			WHERE  BenutzerName = @inBenutzerName
		END
		---
		SET @RESULT = 0
		SET @RESULT = (SELECT  COUNT(*) 
						FROM _USER
						WITH (NOLOCK)
						WHERE BenutzerName = @inBenutzerName)
		---------------------------------------------
		IF @RESULT = 0
		BEGIN
			PRINT 'ACHTUNG!!! BENUTZERNAME NICH VORHANDEN!'
			SELECT * FROM _USER
			WITH(NOLOCK)
			WHERE  BenutzerName = @inBenutzerName
		END
		---
		------------------------------------------
		--  PRÜFE OB BENUTZERKENNUNG VORHANDEN IST
		------------------------------------------	
		SET @RESULT = 0
		SET @RESULT = (SELECT  COUNT(*)
						FROM _USER
						WITH (NOLOCK)
						WHERE BenutzerKennung = @inBenutzerKennung)
		---------------------------------------------
		IF @RESULT > 0
		BEGIN
			PRINT 'ACHTUNG!!! BENUTZERKENNUNG VORHANDEN!'
			SELECT  * FROM _USER
			WITH (NOLOCK)
			WHERE BenutzerKennung = @inBenutzerKennung
		END
		---
		SET @RESULT = 0
		SET @RESULT = (SELECT  COUNT(*)
						FROM _USER
						WITH (NOLOCK)
						WHERE BenutzerKennung = @inBenutzerKennung)
		---------------------------------------------
		IF @RESULT = 0
		BEGIN
			PRINT 'BENUTZERKENNUNG NICHT VORHANDEN!'
			SELECT  * FROM _USER
			WITH (NOLOCK)
			WHERE BenutzerKennung = @inBenutzerKennung
		END
		---
	END TRY
	---
	BEGIN CATCH
		---
		SET @flag				= @flag + 1024
		Set @outResult			= 5050				-- Farbe rot
		Set @outMeldung			= LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! 5050 [Fehler beim prüfen ob der Benutzer vorhanden ISt]]'							+ '; '
		---
	END CATCH
END
---
-----------------------------------------------------------------------------------------*
---- INSERT Benutzer in _USER
-----------------------------------------------------------------------------------------*	
IF @flag = 0
BEGIN
	BEGIN TRY
		---
		IF @RESULT = 0
		BEGIN
		---
			INSERT INTO _USER(BenutzerKennung, PassWort, BenutzerName, UserEmail, UserTelefon, ZeitMarkeErstellung)       
			VALUES (@inBenutzerKennung, @inPassWort, @inBenutzerName,@inUserEMail,@inUserTelefon,GETDATE())                                                                                                                                                                                                                                                                                                                                                                                                                                  
			--- 
		------------------------------------------
		---- UserId auf die ID der tabelle _USER initialisieren
		------------------------------------------
			set @inUserId = (select UserID
							 from _USER 
							 where BenutzerKennung = @inBenutzerKennung)
		END
		ELSE
		BEGIN
		---
		set @flag				= @flag + 1024
		Set @outResult			= 5055				-- Farbe rot
		Set @outMeldung			= LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! 5055 [Dieser Benutzer Existiert Bereits ]]'							+ '; '
		---
		END
		---
	END TRY
		---
	BEGIN CATCH
		---
		set @flag				= @flag + 1024
		Set @outResult			= 5060				-- Farbe rot
		Set @outMeldung			= LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! 5060 [Fehler beim insert zur _USER Tabelle ]]'							+ '; '
		---
	END CATCH
END		
---       
-----------------------------------------------------------------------------------------*
--- Befehl zum anlegen der Zuordnung von AnschrIFt zu Benutzer in _User2ANSF                                                              
--- hier die entsprechENDe AnschrIFten ID (_AnschriftenId) aus _Anschriften eingeben
-----------------------------------------------------------------------------------------*		
IF @flag = 0
BEGIN
---
	 
	---
	BEGIN TRY
		IF @inUGRPId <> '24'
		BEGIN 
		
			INSERT INTO _User2ANSF(USERId, ANSFId,BenutzerKennung,ZeitMarkeErstellung)                                                                                
				VALUES (@inUSERId, @inANSFId,@inBenutzerKennung,GETDATE())     
			-----------------------------
			--  ErgebnIS anzeigen 
			-----------------------------	 
			SELECT USERId, ANSFId 
			FROM _User2ANSF 
			WITH(NOLOCK)
			WHERE (USERId = @inUSERId)   
		END
		---
	END TRY
		---
	BEGIN CATCH
		---
		SET @flag				= @flag + 1024
		Set @outResult			= 5070				-- Farbe rot
		Set @outMeldung			= LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! 5070 [Fehler beim Befehl zum anlegen der Zuordnung von AnschrIFt zu Benutzer in _User2ANSF]]'							+ '; '
		---
	END CATCH
END	
--
-----------------------------------------------------------------------------------------*
-- Befehl zum anlegen der Zuordnung von AnschrIFt zu Benutzer in _USER2ANSF
-----------------------------------------------------------------------------------------*	
IF @flag = 0
BEGIN
	BEGIN TRY
		INSERT INTO _USER2UGRP(USERId, UGRPId,ZeitMarkeErstellung)                                                                                     
			VALUES (@inUSERId, @inUGRPId,GETDATE());                                                                                                
        ---
		-----------------------------
		-- Berechtigunen1
		-----------------------------
		IF @inUGRPId = '24'
		BEGIN
			INSERT INTO _USER2UGRP(USERId, UGRPId,ZeitMarkeErstellung)
				VALUES (@inUSERId, '30',GETDATE())
			INSERT INTO _USER2UGRP(USERId, UGRPId,ZeitMarkeErstellung)                                                                                  
				VALUES (@inUSERId, '32',GETDATE()) 
			INSERT INTO _USER2UGRP(USERId, UGRPId,ZeitMarkeErstellung)                                                                                  
				VALUES (@inUSERId, '33',GETDATE())
			INSERT INTO _USER2UGRP(USERId, UGRPId,ZeitMarkeErstellung)                                                                                  
				VALUES (@inUSERId, '50',GETDATE())
		END
		---
		-----------------------------
		-- Berechtigunen2 
		-----------------------------
		IF @inUGRPId = '66' or @inUGRPId = '67'                                                                              
		BEGIN
			INSERT INTO _USER2UGRP(USERId, UGRPId,ZeitMarkeErstellung)                                                                                  
			VALUES (@inUSERId, '143', GETDATE())
		END
        ---
		-------------------------------------
		--Berechtigunen3   
		-------------------------------------
		IF @inUGRPId = '77'
		BEGIN
			INSERT INTO _USER2UGRP(USERId, UGRPId, ZeitMarkeErstellung)
			VALUES (@inUSERId, '101',GETDATE())
		END
		---
		----------------------------------------------------------
		---Berechtigunen4
		----------------------------------------------------------
		IF @inUGRPId = '236'
		BEGIN
			INSERT INTO _USER2UGRP(USERId, UGRPId,ZeitMarkeErstellung)
			VALUES (@inUserId, 236,GETDATE())
		END
		---
		-----------------------------
		---Berechtigunen5
		-----------------------------
		IF @inUGRPId = '369'
		BEGIN
			INSERT INTO _USER2UGRP(USERId, UGRPId, ZeitMarkeErstellung)
			VALUES (@inUSERId, '373', GETDATE())
		END
		---
		-----------------------------
		---Berechtigunen6  
		-----------------------------
			SELECT USERId, UGRPId 
			FROM _USER2UGRP 
			WITH(NOLOCK) 
			WHERE (USERId = @inUSERId) 
		---
	END TRY
		---
	BEGIN CATCH
		---
		SET @flag				= @flag + 1024
		Set @outResult			= 5080				-- Farbe rot
		Set @outMeldung			= LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! 5080 [Fehler beim Befehl zum anlegen der Zuordnung von AnschrIFt zu Benutzer in _USER2UGRP]]'							+ '; '
		---
	END CATCH
END	
---
-----------------------------------------------------------------------------------------*
-- Wenn keine Fehler aufgetreten sind grün
-----------------------------------------------------------------------------------------*
IF	@flag = 0
and @outResult = 0
BEGIN
	SET @outResult		= 10				-- Farbe grün
	SET @outMeldung		= LTRIM(RTRIM(@outMeldung))		+ 'E R F O L G ! [Metin_BenutzerGenerator planmäßig beENDet]' + '; '
END
---
Return(@flag)
