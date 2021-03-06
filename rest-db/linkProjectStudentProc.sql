USE [BD16185]
GO
/****** Object:  StoredProcedure [BD16185].[linkProjectStudent]    Script Date: 22/03/2018 11:18:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create procedure [BD16185].[linkProjectStudent]
	-- Add the parameters for the stored procedure here
	@ProjectId int,
	@StudentId int
as
begin
	DECLARE @ErrorMessage varchar(2047);
	if not exists (select * from ProjectStudent where StudentId = @StudentId)
		if ((select count(Id) from ProjectStudent where ProjectId = @ProjectId) < 3)
			if exists (select * from Student where RA = @StudentId)
				if exists (select * from Project where id = @ProjectId)
					insert into ProjectStudent values (@ProjectId, @StudentId);
				else
					SET @ErrorMessage = 'Project does not exist.';
			else
				SET @ErrorMessage = 'Student does not exist.';
		else
			SET @ErrorMessage = 'Too many students on this project.';
	else
		SET @ErrorMessage = 'Student is already working on a project.';

	IF @ErrorMessage IS NOT NULL
    RAISERROR(@ErrorMessage, 16, 1);
end